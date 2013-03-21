----------------------------------------------------------------------------------
--! @file
--! @brief DDIS3010 INT HEX Decoder V2
--! @author GJB
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

--! @brief Intel-Hex decoder
--! @details The intHex decoder is the "serializer" for the BSTprocessor
entity inthex is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           addr : out  STD_LOGIC_VECTOR (7 downto 0);
           dout : out  STD_LOGIC_VECTOR (7 downto 0);
           ASCII_char : in  STD_LOGIC_VECTOR (7 downto 0); 
           ASCII_char_available : in  STD_LOGIC;
           we : out  STD_LOGIC;
           ready : out  STD_LOGIC);
end inthex;

--! @brief Architecture of inthex recieves serial input and serializes it
architecture arch of inthex is

signal addr_reg, addr_next: unsigned(7 downto 0);
signal m_reg, m_next: integer; 
signal hex_reg, hex_next: std_logic_vector(3 downto 0);
signal ready_reg, ready_next: std_logic;
signal digit_cnt_reg, digit_cnt_next: unsigned(7 downto 0);
signal new_byte_reg, new_byte_next: std_logic_vector(7 downto 0);
signal we_reg, we_next: std_logic; 

type state_type is (s00, s01, s02, s03, s04, s05, s06, 
					s07, s08, s09, s10, s11, s12, s13
					);
signal state_reg, state_next: state_type;

begin
--! state register section
process (clk,reset)
begin
	if (reset='1') then
		addr_reg <= (others=>'0');
		m_reg <= 0;
		hex_reg <= (others=>'0');
		ready_reg <= '0'; 
		digit_cnt_reg <= (others=>'0');
		new_byte_reg <= (others=>'0');
		we_reg <= '0';
				
	elsif (clk'event and clk='1') then
		state_reg <= state_next;
		addr_reg <= addr_next;
		m_reg <= m_next;
		hex_reg <= hex_next;
		ready_reg <= ready_next;
		digit_cnt_reg <= digit_cnt_next;
		new_byte_reg <= new_byte_next;
		we_reg <= we_next;
	end if;
end process;

--! next state and outputs section
process(state_reg, addr_reg, m_reg, hex_reg, 
		ready_reg, digit_cnt_reg, new_byte_reg, we_reg, ASCII_char_available)
begin
	state_next <= state_reg;
	addr_next <= addr_reg;
	m_next <= m_reg;
	hex_next <= hex_reg;
	ready_next <= ready_reg;
	digit_cnt_next <= digit_cnt_reg;
	new_byte_next <= new_byte_reg;
	we_next <= we_reg;

case state_reg is
	when s00 =>
		addr_next <= (others=>'0');
		m_next <= 0;
		state_next <= s01;
	when s01 =>
		if ( ASCII_char_available = '1' ) then
			if (ASCII_char(7 downto 4)="0011") then 
				hex_next <= ASCII_char(3 downto 0);
				state_next <= s02;
			else
				hex_next <= std_logic_vector("1001"+unsigned(ASCII_char(3 downto 0)));--
				state_next <= s02;
			end if;
		else
			state_next <= s01;
		end if;
	when s02 =>
		if (m_reg=0) then
			
			if (ASCII_char(7 downto 0)="00111010") then ---- ASCII char ':' - 3AH
				m_next <= 1;
				state_next <= s01;
			else
				state_next <= s01;
			end if;
		else
			state_next <= s03;
		end if;
	when s03 =>
		if (m_reg=1) then
			m_next <= 2;
			digit_cnt_next <= unsigned(hex_reg) & digit_cnt_reg(3 downto 0);
			state_next <= s01;
		else
			state_next <= s04;
		end if;
	when s04 =>
		if (m_reg=2) then
			m_next <= 3;
			digit_cnt_next <= digit_cnt_reg(7 downto 4) & unsigned(hex_reg);
			state_next <= s01;
		else
			state_next <= s05;
		end if;
	when s05 =>
		if (m_reg=3) then
			m_next <= 4;
			state_next <= s01;
		else
			state_next <= s06;
		end if;
	when s06 =>
		if (m_reg=4) then
			m_next <= 5;
			state_next <= s01;
		else
			state_next <= s07;
		end if;
	when s07 =>
		if (m_reg=5) then
			m_next <= 6;
			state_next <= s01;
		else
			state_next <= s08;
		end if;
	when s08 =>
		if (m_reg=6) then
			m_next <= 7;
			state_next <= s01;
		else
			state_next <= s09;
		end if;
	when s09 =>
		if (m_reg=7) then
			m_next <= 8;
			state_next <= s01;
		else
			state_next <= s10;
		end if;
	when s10 =>
		if (m_reg=8) then
			if (ASCII_char(7 downto 0)="00110001") then 
				m_next <= 0; 
				ready_next <= '1';
				state_next <= s00;
			else
				m_next <= 9;
				state_next <= s01;
			end if;
		else
			state_next <= s11;
		end if;
	when s11 =>
		if (m_reg=9) then
			m_next <= 10;
			new_byte_next(7 downto 4) <= hex_reg; 
			state_next <= s01;
		else
			state_next <= s12;
		end if;
	when s12 =>
		if (m_reg=10) then
			
			digit_cnt_next <= digit_cnt_next-1;
			new_byte_next <= new_byte_reg(7 downto 4) & hex_reg; 
			we_next <= '1';
			if (digit_cnt_reg=1) then
				m_next <= 0;
				state_next <= s13;
			else
				m_next <= 9;
				state_next <= s13;
			end if;
		else
			state_next <= s01;
		end if;
	when s13 =>
			we_next <= '0';
			addr_next <= addr_reg+1;
			state_next <= s01;
end case;

end process;
	addr <= std_logic_vector(addr_reg);
	dout <= std_logic_vector(new_byte_reg);
	we <= we_reg;
	ready <= ready_reg;
end arch;

