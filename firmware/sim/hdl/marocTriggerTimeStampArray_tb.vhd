--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:16:11 04/01/2016
-- Design Name:   
-- Module Name:   /projects/HEP_Instrumentation/cad/designs/uob-hep-pc049a/trunk/firmware/sim/hdl/marocTriggerTimeStamp_tb.vhd
-- Project Name:  pc049a_top_demo
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: marocTriggerTimeStamp
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
USE ieee.numeric_std.ALL;
 
ENTITY marocTriggerTimeStampArray_tb IS
END marocTriggerTimeStampArray_tb;
 
ARCHITECTURE behavior OF marocTriggerTimeStampArray_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)

  constant c_COARSE_TS_WIDTH : positive := 24;  -- number of bits from coarse timestamp
  constant c_NUM_CHANNELS : positive := 64;  -- number of maroc channels
  
    --COMPONENT marocTriggerTimeStamp
    --PORT(
    --     clk_i : IN  std_logic;
    --     clk_fast_i : IN  std_logic;
    --     trigger_i : IN  std_logic;
    --     timestamp_i : IN  std_logic_vector(c_COARSE_TS_WIDTH-1 downto 0);
    --     trigger_o : OUT  std_logic;
    --     timestamp_data_o : OUT  std_logic_vector(31 downto 0);
    --     timestamp_data_ready_o : OUT  std_logic
    --    );
    --END COMPONENT;
    

   --Inputs
  signal clk_i : std_logic := '0';
  signal clk_fast_i : std_logic := '0';
  signal s_triggers : std_logic_vector(c_NUM_CHANNELS-1 downto 0) := (others => '0');
  signal timestamp_i : std_logic_vector(c_COARSE_TS_WIDTH-1 downto 0) := (others => '0');
  signal timestamp_unsigned : unsigned(c_COARSE_TS_WIDTH-1 downto 0) :=  (others => '0');
                                                               
  --Outputs
   signal trigger_o : std_logic;
   signal timestamp_data_o : std_logic_vector(31 downto 0);
   signal timestamp_data_ready_o : std_logic;

  signal s_triggers_fastclk , s_triggers_slowclk : std_logic_vector(c_NUM_CHANNELS-1 downto 0) := ( others => '0');
                                               
   -- Clock period definitions
   constant clk_i_period : time := 32 ns;
   constant clk_fast_i_period : time := 8 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
  uut: entity work.marocTriggerTimeStampArray
    PORT MAP (
          clk_i => clk_i,
          clk_fast_i => clk_fast_i,
          triggers_i => s_triggers,
          timestamp_i => timestamp_i,
          triggers_fastclk_o => s_triggers_fastclk,
          triggers_slowclk_o => s_triggers_slowclk,
          
          timestamp_data_o => timestamp_data_o,
          timestamp_data_ready_o => timestamp_data_ready_o
        );

   -- Clock process definitions
   clk_i_process :process
   begin
		clk_i <= '0';
		wait for clk_i_period/2;
		clk_i <= '1';
		wait for clk_i_period/2;
   end process;
 
   clk_fast_i_process :process
   begin
		clk_fast_i <= '0';
		wait for clk_fast_i_period/2;
		clk_fast_i <= '1';
		wait for clk_fast_i_period/2;
   end process;

   counter_process: process (clk_i) is
   begin  -- process counter_process
     if rising_edge(clk_i) then
       timestamp_unsigned <=  timestamp_unsigned + 1;
       timestamp_i <= std_logic_vector(timestamp_unsigned);
     end if;
   end process counter_process;

   -- Stimulus process
   stim_proc: process
   begin
     s_triggers <= ( others => '0');
     
      -- hold reset state for 100 ns.
      wait for 100 ns;	

     for pulse in 0 to 10 loop

       wait for clk_i_period*10.7;
       s_triggers(0) <= '1';

       wait for clk_i_period * 0.7;
       s_triggers(0) <= '0';
       
     end loop;  -- pulse

        
      wait;
   end process;

END;
