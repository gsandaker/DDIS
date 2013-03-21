----------------------------------------------------------------------------------
--! @file
--! @brief DDIS130123a top level file connecting the BST processor and 
--! the ROM program memory
--! @author GJB
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

--! @brief Top module for the BST controller
--! @details The top module instantiates the other entites.
--! It also containes an adress MUX and a tap DEMUX 
entity bstctr_top is
    Port ( 
		   finfin :out std_logic;
		   pushb : in STD_LOGIC;--! stepbutton
    	   --clk : in  STD_LOGIC;--!clock
		   clock : in std_logic;
           reset : in  STD_LOGIC;--! reset
           board_tms1 : out  STD_LOGIC;--! TMS at TAP1
           board_tck1 : out  STD_LOGIC;--! TCK at TAP1
           board_tdi1 : out  STD_LOGIC;--! TDI at TAP1
           board_tdo1 : in  STD_LOGIC;--! TDO at TAP1
		   -- board_tms2 : out  STD_LOGIC;--! TMS at TAP2
           -- board_tck2 : out  STD_LOGIC;--! TCK at TAP2
           -- board_tdi2 : out  STD_LOGIC;--! TDI at TAP2
           -- board_tdo2 : in  STD_LOGIC;--! TDO at TAP2
		   error_out  : out STD_LOGIC;
		   rx : in STD_LOGIC--! Recieved serial signal
		   );
end bstctr_top;

--! @brief This architcture instantiates the other components
architecture Behavioral of bstctr_top is
	signal ab: STD_LOGIC_VECTOR (7 downto 0);
	signal ab1: STD_LOGIC_VECTOR (7 downto 0);
	signal ab2: STD_LOGIC_VECTOR (7 downto 0);
	signal db1: STD_LOGIC_VECTOR (7 downto 0);
	signal db2: STD_LOGIC_VECTOR (7 downto 0);
	signal tap : STD_LOGIC_VECTOR(1 downto 0);
	signal board_tms : STD_LOGIC;
	signal board_tck : STD_LOGIC;
	signal board_tdi : STD_LOGIC;
	signal board_tdo : STD_LOGIC;
	signal we : STD_LOGIC;
	signal ready : STD_LOGIC;
	signal ASCII_char : STD_LOGIC_VECTOR (7 downto 0);
	signal ASCII_char_available : STD_LOGIC;
	signal s_tick : STD_LOGIC;
	signal db_tick : std_logic;
	signal db_level : std_logic;
	constant lys : std_logic:='0';
	signal clk : std_logic;

begin
	
	finfin <= lys;
	
	--! Debouncer for pushbutton
	bouncy_unit: entity work.debounce(exp_fsmd_arch)
		port map (clk => clk, reset => reset,
		sw => pushb, db_level => db_level, db_tick => db_tick
		);
	--! Uart reciever
	uart_unit: entity work.uart_rx(arch)
		port map( 
			clk => clk, reset => reset,
			rx => rx, s_tick => s_tick,
			rx_done_tick => ASCII_char_available,
			dout => ASCII_char
		);
	--! Mod 163
	-- mod163:	entity work.mod_m_counter(arch)	
		-- port map(
			-- clk => clk, reset => reset,
			-- max_tick => s_tick
		-- );
	--! blah
	modBlah: entity work.mod_m_counter(arch)	
		port map(
			clk => clock, reset => reset,
			max_tick => clk
		);
	--! Processor
	proc_unit: entity work.bstprocV1(Behavioral)	
		port map( clk => clk, reset => reset, 
				 abus => ab1, dbus => db2,
				 board_tms => board_tms, board_tck => board_tck,
				 board_tdi => board_tdi, board_tdo => board_tdo,
				 tap(1) => tap(1), tap(0) => tap(0),
				 ready => ready, error_out => error_out,--,
				 push => db_tick
		);
	--! Hex decoder
	-- decode_unit: entity work.inthex(arch)
		-- port map ( clk => clk, we => we, ready => ready, 
					-- addr => ab2, dout => db1, reset => reset,
					-- ASCII_char_available => ASCII_char_available,
					-- ASCII_char => ASCII_char
		-- );
	--! Synchronized memory, single port RAM	
	ram_unit: entity work.ram_1p_sync(arch)	
		port map( 
			clk => clk,
			we => we,
			addr => ab,
			din => db1,
			dout => db2
		);
		
	--! addr_mux
	with ready select ab <=
		ab1 when '1', ab2 when others;
		
	board_tdo <= board_tdo1;
	board_tms1 <= board_tms;
	board_tck1 <= board_tck;
	board_tdi1 <= board_tdi;
	--! tap_demux
	-- with tap (1 downto 0) select board_tdo <= 
		-- board_tdo1 when "01", 
		-- board_tdo2 when "10", 
		-- '0' when others;	
	-- with tap (1 downto 0) select board_tms1 <= 
		-- board_tms when "10", '1' when others;
	-- with tap (1 downto 0) select board_tck1 <= 
		-- board_tck when "10", '0' when others;					
	-- with tap (1 downto 0) select board_tdi1 <= 
		-- board_tdi when "10", '0' when others;					
	-- with tap (1 downto 0) select board_tms2 <=
		-- board_tms when "01", '1' when others;
	-- with tap (1 downto 0) select board_tck2 <=
		-- board_tck when "01", '0' when others;					
	-- with tap (1 downto 0) select board_tdi2 <=
		-- board_tdi when "01", '0' when others;					

end Behavioral;

