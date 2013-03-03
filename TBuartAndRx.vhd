--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:31:45 02/27/2013
-- Design Name:   
-- Module Name:   C:/Xilinx/usr/workspace/uart/TBuartAndRx.vhd
-- Project Name:  uart
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: bstctr_top
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
 --! @brief Test bench for BST with uart  
ENTITY TBuartAndRx IS
END TBuartAndRx;
 
ARCHITECTURE behavior OF TBuartAndRx IS 
 
    --! Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT bstctr_top
    PORT(
         clk : IN  std_logic;--! clock
         reset : IN  std_logic;
         board_tms1 : OUT  std_logic;
         board_tck1 : OUT  std_logic;
         board_tdi1 : OUT  std_logic;
         board_tdo1 : IN  std_logic;
         board_tms2 : OUT  std_logic;
         board_tck2 : OUT  std_logic;
         board_tdi2 : OUT  std_logic;
         board_tdo2 : IN  std_logic;
         error_out : OUT  std_logic;
         rx : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal board_tdo1 : std_logic := '0';
   signal board_tdo2 : std_logic := '0';
   signal rx : std_logic := '0';

 	--Outputs
   signal board_tms1 : std_logic;
   signal board_tck1 : std_logic;
   signal board_tdi1 : std_logic;
   signal board_tms2 : std_logic;
   signal board_tck2 : std_logic;
   signal board_tdi2 : std_logic;
   signal error_out : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: bstctr_top PORT MAP (
          clk => clk,
          reset => reset,
          board_tms1 => board_tms1,
          board_tck1 => board_tck1,
          board_tdi1 => board_tdi1,
          board_tdo1 => board_tdo1,
          board_tms2 => board_tms2,
          board_tck2 => board_tck2,
          board_tdi2 => board_tdi2,
          board_tdo2 => board_tdo2,
          error_out => error_out,
          rx => rx
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   -- stim_proc: process
   -- begin		
      --hold reset state for 100 ns.
      -- wait for 100 ns;	

      -- wait for clk_period*10;

      --insert stimulus here 

      -- wait;
   -- end process;
   --new stim proc
   stim_proc: process
   begin		
		reset <= '1';
		rx <= '1';
		wait for clk_period/2;
		wait for clk_period*2;
		reset <= '0';
		
		-- ":" (3AH: 00111010B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;
		
		-- "1" (31H: 00110001B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;	
		
		-- "8" (38H: 00111000B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;
		
		-- "0" (30H: 00110000B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;	

		-- "0" (30H: 00110000B)		
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;	
	
		-- "3" (33H: 00110011B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;			
		
		-- "0" (30H: 00110000B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;		
		
		
		-- "0" (30H: 00110000B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;			
		
		
		-- "0" (30H: 00110000B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;	
		
		-- "A" (41H: 01000001B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;	
		
		-- "1" (30H: 00110001B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;	
		
		-- "A" (41H: 01000001B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;	
		
		-- "E" (45H: 01000101B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;	
		
		-- "A" (41H: 01000001B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;	
		
		-- "F" (45H: 01000110B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;	
		
		-- "A" (41H: 01000001B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;	
		
		-- "F" (45H: 01000110B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;	
		
		-- "A" (41H: 01000001B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;	
		
		-- "E" (45H: 01000101B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;	
		
		-- "A" (41H: 01000001B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;	
		
		-- "E" (45H: 01000101B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;	
								
		-- "A" (41H: 01000001B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;	
		
		-- "4" (34H: 00110100B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;	
		
		-- "1" (31H: 00110001B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;		
				
		-- "0" (30H: 00110000B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;		
								
		-- "0" (30H: 00110000B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;		
										
		-- "0" (30H: 00110000B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;		
		
		-- "0" (30H: 00110000B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;		
				
		-- "0" (30H: 00110000B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;		
				
		-- "8" (38H: 00111000B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;		
						
		-- "1" (30H: 00110001B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;		
				
		-- "8" (38H: 00111000B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;		
						
		-- "1" (30H: 00110001B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;		
								
		-- "F" (46H: 01000110B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;	
		
		-- "F" (46H: 01000110B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;	
								
		-- "F" (46H: 01000110B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;	
		
		-- "F" (46H: 01000110B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;	
						
		-- "A" (41H: 01000001B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;	
		
		-- "F" (46H: 01000110B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;	
														
		-- "A" (41H: 01000001B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;	
		
		-- "F" (46H: 01000110B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;	
																		
		-- "A" (41H: 01000001B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;	
		
		-- "E" (45H: 01000101B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;	
																		
		-- "A" (41H: 01000001B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;	
		
		-- "E" (45H: 01000101B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;	
																				
		-- "A" (41H: 01000001B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;	
		
		-- "3" (33H: 00110011B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;	
		
		-- "1" (31H: 00110001B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;	
							
		-- "2" (32H: 00110010B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;	
																																	
		-- "5" (35H: 00110101B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;		
																																	
		-- "5" (35H: 00110101B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;		
				
		-- "0" (30H: 00110000B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;		
				
		-- "0" (30H: 00110000B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;		
						
		-- "0" (30H: 00110000B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;		
						
		-- "0" (30H: 00110000B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;		
				
		-- "A" (41H: 01000001B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;	

		-- "F" (46H: 01000110B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;	
		
		-- "8" (38H: 00111000B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;	

		-- "8" (38H: 00111000B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;				

-- New break from this point --
		
		-- ":" (3AH: 00111010B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;
		
		-- "0" (30H: 00110000B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;
		
		-- "3" (33H: 00110011B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;
		
		-- "0" (30H: 00110000B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;
		
		-- "0" (30H: 00110000B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;
		
		-- "4" (34H: 00110100B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;	
				
		-- "8" (38H: 00111000B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;	
				
		-- "0" (30H: 00110000B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;	
		
		-- "0" (30H: 00110000B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;
		
		-- "5" (35H: 00110101B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;	
		
		-- "0" (30H: 00110000B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;		
		
		-- "4" (34H: 00110100B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;	
		
		-- "F" (46H: 01000110B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;
		
		-- "4" (34H: 00110100B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;	
				
		-- "5" (35H: 00110101B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;	
		
		-- "D" (44H: 01000100B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;	
				
		-- "1" (31H: 00110001B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;		
		
		-- ":" (3AH: 00111010B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;
		
		-- "0" (30H: 00110000B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;
		
		-- "0" (30H: 00110000B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;
		
		-- "0" (30H: 00110000B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;
		
		-- "0" (30H: 00110000B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;
		
		-- "0" (30H: 00110000B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;	
		
		-- "0" (30H: 00110000B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;
		
		-- "0" (30H: 00110000B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;	
		
		-- "1" (31H: 00110001B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;		
		
		-- "F" (46H: 01000110B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;	
		
		-- "F" (46H: 01000110B)
		rx <= '0'; -- start bit
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';
		wait for clk_period*163*16;
		rx <= '0';
		wait for clk_period*163*16;
		rx <= '1';	-- stop bit
		wait for clk_period*163*16;
		
   end process;

END;
