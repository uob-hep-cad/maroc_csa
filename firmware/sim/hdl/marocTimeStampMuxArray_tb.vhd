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

use work.maroc.all;

ENTITY marocTimeStampMuxArray_tb IS
END marocTimeStampMuxArray_tb;
 
ARCHITECTURE behavior OF marocTimeStampMuxArray_tb IS 
 
  constant c_NUM_CHANNELS : positive := 64;  -- number of maroc channels
  constant c_BUSWIDTH : positive := 32;
  constant c_NCYCLES : positive := 1000;
  constant c_UPSTREAM_INTERVAL : positive :=  20;
  constant c_INPUT_INTERVAL : positive :=  30;
      

   --Inputs
  signal clk_i : std_logic := '0';

  -- Clock period definitions
  constant clk_i_period : time := 32 ns;

  signal s_data_to_fifo : t_timeStampArray(c_NUM_CHANNELS-1 downto 0)         := ( others => (others => '0')); 
  signal s_data : t_timeStampArray(c_NUM_CHANNELS-1 downto 0)         := ( others => (others => '0')); 
  signal s_data_present : std_logic_vector(c_NUM_CHANNELS-1 downto 0) := ( others => '0'); --! High if data present
  signal s_read_data,s_fifo_write,s_fifo_data_present : std_logic_vector(c_NUM_CHANNELS-1 downto 0)   := ( others => '0'); --! Take high to read data

  signal s_data_o : std_logic_vector(c_BUSWIDTH-1 downto 0)         := ( others => '0'); --! Downstream data. Stays at state of last valid data.
  signal s_data_present_o : std_logic                               := '0'; --! High if data present

BEGIN

  uut: entity work.marocTimeStampMuxArray
  generic map (
    g_NCHANNELS => c_NUM_CHANNELS,
    g_BUSWIDTH  => c_BUSWIDTH
    )
  port map (
    clk_i => clk_i,
    data_i  => s_data,
    data_present_i => s_fifo_data_present,
    read_data_o => s_read_data ,
    data_o  => s_data_o,
    data_present_o => s_data_present_o 
    );  

  gen_fifo: for Nfifo in 0 to c_NUM_CHANNELS-1 generate

    cmp_inputFIFO : entity work.timeStampFIFO      
      port map (
        clk   => clk_i,
        srst  => '0',
        din   => s_data_to_fifo(Nfifo),
        wr_en => s_fifo_write(Nfifo),
        rd_en => s_read_data(Nfifo),
        dout  => s_data(Nfifo),
        full  => open,
        valid => s_fifo_data_present(Nfifo),
        empty => open
        );
  end generate gen_fifo;
  
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
          s_data_to_fifo(0) <= std_logic_vector( to_unsigned( cycle  + 1000 , 32 ));
          s_fifo_write(0) <= '1';
        elsif cycle mod c_UPSTREAM_INTERVAL = 1 then
          s_data_to_fifo(0) <= std_logic_vector( to_unsigned( cycle  + 2000 , 32 ));
          s_fifo_write(0) <= '1';
        else
          s_data_to_fifo(0) <= ( others => '0');
          s_fifo_write(0) <= '0';
        end if;


        if cycle mod c_INPUT_INTERVAL = 0 then
          s_data_to_fifo(63) <= std_logic_vector( to_unsigned( cycle , 32 ));
          s_fifo_write(63) <= '1';
        else
          s_data_to_fifo(63) <= ( others => '0');
          s_fifo_write(63) <= '0';
        end if;

        
      end loop;

      wait;
   end process;

END;
