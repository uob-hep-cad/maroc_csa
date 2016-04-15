--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:47:25 04/04/2016
-- Design Name:   
-- Module Name:   /projects/HEP_Instrumentation/cad/designs/uob-hep-pc049a/trunk/firmware/sim/hdl/marocTimeStampMux_tb.vhd
-- Project Name:  pc049a_top_demo
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: marocTimeStampMux
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
 
ENTITY marocTimeStampMux_tb IS
END marocTimeStampMux_tb;
 
ARCHITECTURE behavior OF marocTimeStampMux_tb IS 
 
   --Inputs
   signal clk_i : std_logic := '0';
   signal upstream_data_i : std_logic_vector(31 downto 0) := (others => '0');
   signal upstream_data_present_i : std_logic := '0';
   signal input_data_i : std_logic_vector(31 downto 0) := (others => '0');
   signal input_data_present_i : std_logic := '0';

 	--Outputs
   signal read_upstream_data_o : std_logic;
   signal read_input_data_o : std_logic;
   signal downstream_data_o : std_logic_vector(31 downto 0);
   signal downstream_data_present_o : std_logic;

   -- Clock period definitions
   constant clk_i_period : time := 10 ns;

   signal s_input_data , s_upstream_data : std_logic_vector(31 downto 0) := ( others => '0');
   signal s_upstream_fifo_empty , s_input_fifo_empty , s_input_fifo_write , s_upstream_fifo_write : std_logic := '0';

   constant c_NCYCLES : positive := 1000;
   constant c_UPSTREAM_INTERVAL : positive :=  20;
   constant c_INPUT_INTERVAL : positive :=  30;
   
     
BEGIN
 
    cmp_inputFIFO : entity work.timeStampFIFO      
      port map (
        clk   => clk_i,
        srst  => '0',
        din   => s_input_data,
        wr_en => s_input_fifo_write,
        rd_en => read_input_data_o,
        dout  => input_data_i,
        full  => open,
        valid => input_data_present_i,
        empty => open
        );
    -- input_data_present_i <= not s_input_fifo_empty;

    cmp_upstreamFIFO : entity work.timeStampFIFO      
      port map (
        clk   => clk_i,
        srst  => '0',
        din   => s_upstream_data,
        wr_en => s_upstream_fifo_write,
        rd_en => read_upstream_data_o,
        dout  => upstream_data_i,
        full  => open,
        valid => upstream_data_present_i,
        empty => open
        );
    -- upstream_data_present_i <= not s_upstream_fifo_empty;
    
   cmp_mux: entity work.marocTimeStampMux PORT MAP (
          clk_i => clk_i,
          upstream_data_i => upstream_data_i,
          upstream_data_present_i => upstream_data_present_i,
          read_upstream_data_o => read_upstream_data_o,
          input_data_i => input_data_i,
          input_data_present_i => input_data_present_i,
          read_input_data_o => read_input_data_o,
          downstream_data_o => downstream_data_o,
          downstream_data_present_o => downstream_data_present_o
        );

   -- Clock process definitions
   clk_i_process :process
   begin
		clk_i <= '0';
		wait for clk_i_period/2;
		clk_i <= '1';
		wait for clk_i_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_i_period*10;

      for cycle in 1 to c_NCYCLES loop
        wait until rising_edge(clk_i);

        if cycle mod c_UPSTREAM_INTERVAL = 0 then
          s_upstream_data <= std_logic_vector( to_unsigned( cycle  + 1000 , 32 ));
          s_upstream_fifo_write <= '1';
        elsif cycle mod c_UPSTREAM_INTERVAL = 1 then
          s_upstream_data <= std_logic_vector( to_unsigned( cycle  + 2000 , 32 ));
          s_upstream_fifo_write <= '1';
        else
          s_upstream_data <= ( others => '0');
          s_upstream_fifo_write <= '0';
        end if;


        if cycle mod c_INPUT_INTERVAL = 0 then
          s_input_data <= std_logic_vector( to_unsigned( cycle , 32 ));
          s_input_fifo_write <= '1';
        else
          s_input_data <= ( others => '0');
          s_input_fifo_write <= '0';
        end if;

        
      end loop;

      wait;
   end process;

END;
