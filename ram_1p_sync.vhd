----------------------------------------------------------------------------------
--! @file
--! @brief Modified from Listing 11.1
--! @details Single-port RAM with synchronous read
--! @author GJB
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram_1p_sync is
   generic(
      ADDR_WIDTH: integer:=8;
      DATA_WIDTH: integer:=8
   );
   port(
      clk: in std_logic;
      we: in std_logic;
      addr: in std_logic_vector(ADDR_WIDTH-1 downto 0);
      din: in std_logic_vector(DATA_WIDTH-1 downto 0);
      dout: out std_logic_vector(DATA_WIDTH-1 downto 0)
    );
end ram_1p_sync;

architecture arch of ram_1p_sync is
	type ram_type is array (2**ADDR_WIDTH-1 downto 0)
        of std_logic_vector (DATA_WIDTH-1 downto 0);
	signal addr_reg: std_logic_vector(ADDR_WIDTH-1 downto 0);
	
	
	signal ram: ram_type:=(
		"10100001",  -- RST
		"10101110",  -- TMS0
		"10101111",  -- TMS1
		"10101111",  -- TMS1
		"10101110",  -- TMS0
		"10101110",  -- TMS0
		"10100100",  -- SHFCP 
		"00010010",  -- 18D
		"00110011",  -- 33H
		"00110011",  -- 33H
		"00110011",  -- 33H
		"10000001",	 -- 81
		"10000001",	 -- 81
		"00000000",	 -- dont care
		"11111111",	 -- mask FF
		"11111111",	 -- mask FF
		"00000000",	 -- mask 00
		"10101111",  -- TMS1
		"10101111",  -- TMS1		
		"10101110",  -- TMS0
		"10101110",  -- TMS0
		"10100011",  -- SHF [ 8,00 ] 
		"00010000",  -- 8
		"00000000",  -- 0
		"10101111",  -- TMS1	
		"00000000",  -- NOP
		"00000000",  -- NOP		
		"00000000",  -- NOP
		"00000000",  -- NOP		
		"00000000",  -- NOP
		"00000000",  -- NOP		
		"00000000"   -- NOP
	);
   
begin
   process (clk)
   begin
      if (clk'event and clk = '1') then
         if (we='1') then
            ram(to_integer(unsigned(addr))) <= din;
            end if;
        addr_reg <= addr;
      end if;
   end process;
   dout <= ram(to_integer(unsigned(addr_reg)));
end arch;