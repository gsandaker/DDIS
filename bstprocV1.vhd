-------------------------------------------------------------------------------------
--! @file 
--! @brief DDIS3010 BST processor  (supporting SELTAP1/2, RST, TMS0/1, NTCK, SHF, SHFCP, EOP)
--! @author GJB
-------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

--! @brief The actual processor entity of this BST
--! @details bstprocV1 controls the states based on 
--! the instruction on dbus (databus)
entity bstprocV1 is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;--! Test reset
           abus : out  STD_LOGIC_VECTOR (7 downto 0);--! address bus
           dbus : in  STD_LOGIC_VECTOR (7 downto 0);--!data bus
           board_tms : out  STD_LOGIC;--! Test mode state
           board_tck : out  STD_LOGIC;--! Test clock
           board_tdi : out  STD_LOGIC;--! test data in
           board_tdo : in  STD_LOGIC;--! Test data out
		   tap : out STD_LOGIC_VECTOR(1 downto 0);--! Test Access Port
		   ready :in STD_LOGIC;
		   error_out : out STD_LOGIC
		   );
end bstprocV1;  

--! Architecture
architecture Behavioral of bstprocV1 is
constant TMS0: unsigned(7 downto 0) := "10101110"; --! AEH
constant TMS1: unsigned(7 downto 0) := "10101111"; --! AFH
constant NTCK: unsigned(7 downto 0) := "10100101"; --! A5H
constant RST: unsigned(7 downto 0) := "10100001"; --! A1H
constant SHF: unsigned(7 downto 0) := "10100011"; --! A3H
constant SHFCP: unsigned(7 downto 0) := "10100100"; --! A4H
constant SELTAP1: unsigned(7 downto 0) := "10110001"; --! B1H
constant SELTAP2: unsigned(7 downto 0) := "10110010"; --! B2H
constant EOP: unsigned(7 downto 0) := "01000101"; --! 45H

signal ir_reg,ir_next: unsigned(7 downto 0);--! Instruction register
signal pc_reg, pc_next: unsigned(7 downto 0);--! Pogram counter
signal cnt_reg,cnt_next: unsigned(7 downto 0);--! Counter register
signal ibyte_cnt_reg, ibyte_cnt_next: unsigned(7 downto 0);
signal rbits_cnt_reg, rbits_cnt_next: unsigned(2 downto 0);
signal offset: unsigned(7 downto 0);
signal ser_reg, ser_next: std_logic_vector(7 downto 0);--! Serializer
signal exp_reg, exp_next: std_logic_vector(7 downto 0);--! Expected
signal mask_reg, mask_next: std_logic_vector(7 downto 0);--! Mask
signal exp_ptr_reg, exp_ptr_next: unsigned(7 downto 0);--! Pointer
signal ser_ptr_reg, ser_ptr_next: unsigned(7 downto 0);--! Pointer
signal mask_ptr_reg, mask_ptr_next: unsigned(7 downto 0);--! Pointer
signal tap1_reg, tap1_next, tap2_reg, tap2_next: std_logic;
signal error_flag_reg, error_flag_next : std_logic;

--! all possible states
type state_type is (
				init, all_0, all_1,
				tms0_2, tms0_3, tms1_2, tms1_3, 
				ntck_2, ntck_3, ntck_4, 
				rst_2, rst_3, rst_4,
				shf_2, shf_2a, shf_3, 
				shf_4, shf_4a, shf_4b, shf_4c, shf_4d,
				shf_5, shf_5a, shf_5b,
				shfcp_2, shfcp_2a, shfcp_3, shfcp_3a, shfcp_3b,
				shfcp_3a0, shfcp_3b0,--shfcp_3b1, shfcp_3b2,
				shfcp_4, shfcp_4a, shfcp_4b, shfcp_4c, shfcp_4d, 
				shfcp_5, shfcp_5a, shfcp_5b,
				seltap1_2, seltap2_2
					);
signal state_reg, state_next: state_type;

begin

--! state register section
process (clk,reset)
begin
	if (reset='1') then
		state_reg <= init;
		ir_reg <= (others=>'0');
		pc_reg <= (others=>'0');
		cnt_reg <= (others=>'0');
		ibyte_cnt_reg <= (others=>'0');
		rbits_cnt_reg <= (others=>'0');
		ser_reg <= (others=>'0');
		exp_reg <= (others=>'0');
		mask_reg <= (others=>'0');
		exp_ptr_reg <= (others=>'0');
		ser_ptr_reg <= (others=>'0');
		mask_ptr_reg <= (others=>'0');
		tap1_reg <= '1';
		tap2_reg <= '0';
		tap(0) <= tap1_reg;
		tap(1) <= tap2_reg;
		error_flag_reg <= '0';
		
	elsif (clk'event and clk='1') then
		state_reg <= state_next;
		ir_reg <= ir_next;
		pc_reg <= pc_next;
		cnt_reg <= cnt_next;
		ibyte_cnt_reg <= ibyte_cnt_next;
		rbits_cnt_reg <= rbits_cnt_next;
		ser_reg <= ser_next;
		exp_reg <= exp_next;
		mask_reg <= mask_next;
		ser_ptr_reg <= ser_ptr_next;
		exp_ptr_reg <= exp_ptr_next;
		mask_ptr_reg <= mask_ptr_next;
		tap1_reg <= tap1_next;
		tap2_reg <= tap2_next;
		tap(0) <= tap1_reg;
		tap(1) <= tap2_reg;
		error_flag_reg <= error_flag_next;
	end if;
end process;

--! next state and outputs section
process(state_reg,ir_reg,pc_reg,cnt_reg,ibyte_cnt_reg,rbits_cnt_reg,
		ser_reg, exp_reg, mask_reg, exp_ptr_reg, ser_ptr_reg, mask_ptr_reg, 
		tap1_reg, tap2_reg, error_flag_reg, offset, ready, dbus)
begin
state_next <= state_reg;
ir_next <= ir_reg; 
pc_next <= pc_reg;
cnt_next <= cnt_reg;
ibyte_cnt_next <= ibyte_cnt_reg;
rbits_cnt_next <= rbits_cnt_reg;
ser_next <= ser_reg;
board_tms <= '1';
board_tck <= '0';
board_tdi <= '0';
tap1_next <= tap1_reg;
tap2_next <= tap2_reg;
exp_next <= exp_reg;
mask_next <= mask_reg;
ser_ptr_next <= ser_ptr_reg;
mask_ptr_next <= mask_ptr_reg;
exp_ptr_next <= exp_ptr_reg;
error_flag_next <= error_flag_reg;

--! defines what happens in each state
case state_reg is 
	when init =>
		if (ready = '1') then
			state_next <= all_1; --state_next <= all_0;
		else
			state_next <= init;
		end if;
	when all_0 =>
		ir_next <= unsigned(dbus);
		pc_next <= pc_reg+1;
		state_next <= all_1;
	when all_1 =>
		if (ir_reg = SELTAP1) then
			state_next <= seltap1_2;
		elsif (ir_reg = SELTAP2) then
			state_next <= seltap2_2;
		elsif (ir_reg = TMS0) then
			state_next <= tms0_2;
		elsif (ir_reg = TMS1) then
			state_next <= tms1_2;
		elsif (ir_reg = NTCK) then
			state_next <= ntck_2;
		elsif (ir_reg = RST) then
			state_next <= rst_2;
		elsif (ir_reg = SHF) then
			state_next <= shf_2;
		elsif (ir_reg = SHFCP) then
			state_next <= shfcp_2;
		elsif (ir_reg = EOP) then
			state_next <= all_1;
		else
			state_next <= all_0;
		end if;
											--! TMS0
	when tms0_2 =>
		board_tms <= '0';
		state_next <= tms0_3;
	when tms0_3 =>
		board_tms <= '0';
		board_tck <= '1';
		state_next <= all_0;
											--! TMS1		
	when tms1_2 =>
		state_next <= tms1_3;
	when tms1_3 =>
		board_tck <= '1';
		state_next <= all_0;
											--! NTCK
	when ntck_2 =>
		cnt_next <= unsigned(dbus);
		pc_next <= pc_reg+1;
		if (unsigned(dbus) = 0) then
			state_next <= all_0;
		else
			state_next <= ntck_3;
		end if;
	when ntck_3 =>
		board_tms <= '0';
		state_next <= ntck_4;
	when ntck_4 =>
		board_tms <= '0';
		board_tck <= '1';
		cnt_next <= cnt_reg-1;
		if (cnt_reg = 1) then
			state_next <= all_0;
		else
			state_next <= ntck_3;
		end if;
											--! RST
	when rst_2 =>
		cnt_next <= "00000101";
		state_next <= rst_3;
	when rst_3 =>
		board_tms <= '1';
		state_next <= rst_4;
	when rst_4 =>
		board_tms <= '1';
		board_tck <= '1';
		cnt_next <= cnt_reg-1;
		if (cnt_reg = 1) then
			state_next <= all_0;
		else
			state_next <= rst_3;
		end if;
											--! SHF
	when shf_2 =>
		ibyte_cnt_next <= unsigned("000" & dbus(7 downto 3));
		rbits_cnt_next <= unsigned(dbus(2 downto 0));
		pc_next <= pc_reg+1;
		if (unsigned(dbus) = 0) then
			state_next <= all_0;
		else
			state_next <= shf_2a;
		end if;
	when shf_2a =>
		state_next <= shf_3;
	when shf_3 =>
		pc_next <= pc_reg+1;
		ser_next <= dbus;
		board_tms <= '0';
		if ((ibyte_cnt_reg=1 and rbits_cnt_reg=0) or (ibyte_cnt_reg=0)) then
			state_next <= shf_4;
			if (rbits_cnt_reg=0) then
				cnt_next <= "00001000";
			else
				cnt_next <= resize(rbits_cnt_reg,8);
			end if;
		else
			state_next <= shf_5;
			cnt_next <= "00001000";
		end if;
	when shf_4 =>
		board_tms <= '0';
		if (cnt_reg = 1) then
			state_next <= shf_4a;
		else
			state_next <= shf_4c;
		end if;
	when shf_4a =>
		board_tdi <= ser_reg(7);
		state_next <= shf_4b;
	when shf_4b =>
		board_tdi <= ser_reg(7);
		board_tck <= '1';
		state_next <= all_0;
	when shf_4c =>
		board_tdi <= ser_reg(7);
		board_tms <= '0';
		cnt_next <= cnt_reg-1;
		state_next <= shf_4d;
	when shf_4d =>
		board_tdi <= ser_reg(7);
		board_tms <= '0';
		board_tck <= '1';
		ser_next <= ser_reg(6 downto 0) & '0';
		state_next <= shf_4;	
	when shf_5=>
		board_tms <= '0';
		if (cnt_reg = 0) then
			ibyte_cnt_next <= ibyte_cnt_reg-1;
			state_next <= shf_3;
		else
			state_next <= shf_5a;
		end if;
	when shf_5a =>
		board_tdi <= ser_reg(7);
		board_tms <= '0';
		cnt_next <= cnt_reg-1;
		state_next <= shf_5b;
	when shf_5b =>
		board_tdi <= ser_reg(7);
		board_tms <= '0';
		board_tck <= '1';
		ser_next <= ser_reg(6 downto 0) & '0';
		state_next <= shf_5;	
											--! SHFCP
	when shfcp_2 =>
		ibyte_cnt_next <= unsigned("000" & dbus(7 downto 3));
		rbits_cnt_next <= unsigned(dbus(2 downto 0));
		pc_next <= pc_reg+1;
		--board_tms <= '0'; 
		if (unsigned(dbus) = 0) then
			state_next <= all_0;
		else
			state_next <= shfcp_2a;
			if (unsigned(dbus(2 downto 0)) = 0) then
				offset <= unsigned("000"& dbus(7 downto 3));
			else 
				offset <= unsigned("000"& dbus(7 downto 3))+1;
			end if;
		end if;
	when shfcp_2a =>
		board_tms <= '0';-------------
		state_next <= shfcp_3;
	when shfcp_3 =>
		ser_ptr_next <= pc_reg;
		exp_ptr_next <= pc_reg + resize(offset, 8);
		mask_ptr_next <= pc_reg + resize(offset, 8) + resize(offset, 8);
		ser_next <= dbus;
		pc_next <= pc_reg + resize(offset, 8);
		board_tms <= '0';
		state_next <= shfcp_3a0;
	when shfcp_3a0 =>	
		board_tms <= '0';			--- added an empty "delay" state
		state_next <= shfcp_3a;
	when shfcp_3a =>
		exp_next <= dbus;
		pc_next <= mask_ptr_next;
		board_tms <= '0';
		state_next <= shfcp_3b0;
	when shfcp_3b0 =>
		board_tms <= '0';			--- added an empty "delay" state
		state_next <= shfcp_3b;	
	when shfcp_3b =>
		mask_next <= dbus;
		pc_next <= ser_ptr_reg+1;
		board_tms <= '0';
		if ((ibyte_cnt_reg=1 and rbits_cnt_reg=0) or (ibyte_cnt_reg=0)) then
			state_next <= shfcp_4;
			if (rbits_cnt_reg=0) then
				cnt_next <= "00001000";
				--state_next <= shfcp_3b1;	--- added an empty "delay" state
			else
				cnt_next <= resize(rbits_cnt_reg,8);
				--state_next <= shfcp_3b1;	--- added an empty "delay" state
			end if;
		else
			state_next <= shfcp_5;    ---state_next <= shfcp_3b2;		--- added an empty "delay" state
			cnt_next <= "00001000";
		end if;
	--when shfcp_3b1 =>
		--board_tms <= '0';
		--state_next <= shfcp_4;
	--when shfcp_3b2 =>
		--board_tms <= '0';
		--state_next <= shfcp_5;
	when shfcp_4 =>
		board_tms <= '0';
		if (cnt_reg=1) then
			state_next <= shfcp_4a;
		else
			state_next <= shfcp_4c;
		end if;
	when shfcp_4a =>
		board_tdi <= ser_reg(7);
		state_next <= shfcp_4b;
	when shfcp_4b =>
		board_tdi <= ser_reg(7);
		board_tck <= '1';
		ser_next <= ser_reg(6 downto 0) & '0';
		exp_next <= exp_reg(6 downto 0) & '0';
		mask_next <= mask_reg(6 downto 0) & '0';
		if((mask_reg(7) and (exp_reg(7) xor board_tdo)) = '1') then
			error_flag_next <= '1';
		end if;
		state_next <= all_0;
	when shfcp_4c =>
		cnt_next <= cnt_reg-1;
		board_tdi <= ser_reg(7);
		board_tms <= '0';
		state_next <= shfcp_4d;
	when shfcp_4d =>
		board_tdi <= ser_reg(7);
		board_tms <= '0';
		board_tck <= '1';
		ser_next <= ser_reg(6 downto 0) & '0';
		exp_next <= exp_reg(6 downto 0) & '0';
		mask_next <= mask_reg(6 downto 0) & '0';
		if((mask_reg(7) and (exp_reg(7) xor board_tdo)) = '1') then
			error_flag_next <= '1';
		end if;
		state_next <= shfcp_4;
	when shfcp_5  =>
		board_tms <= '0';
		if (cnt_reg=0) then
			state_next <= shfcp_3;
			ibyte_cnt_next <= ibyte_cnt_reg-1;
		else
			state_next <= shfcp_5a;
		end if;
	when shfcp_5a =>
		cnt_next <= cnt_reg-1;
		board_tdi <= ser_reg(7);
		board_tms <= '0';
		state_next <= shfcp_5b;
	when shfcp_5b =>
		board_tdi <= ser_reg(7);
		board_tms <= '0';
		board_tck <= '1';
		ser_next <= ser_reg(6 downto 0) & '0';
		exp_next <= exp_reg(6 downto 0) & '0';
		mask_next <= mask_reg(6 downto 0) & '0';
		if((mask_reg(7) and (exp_reg(7) xor board_tdo)) = '1') then
			error_flag_next <= '1';
		end if;
		state_next <= shfcp_5;
													--! SELTAP1
	when seltap1_2 =>
		tap1_next <= '1';
		tap2_next <= '0';
		state_next <= all_0;
													--! SELTAP2
	when seltap2_2 =>
		tap2_next <= '1';
		tap1_next <= '0';
		state_next <= all_0;
		
end case;
end process;

abus <= std_logic_vector(pc_reg);
error_out <= error_flag_reg;
end Behavioral;

