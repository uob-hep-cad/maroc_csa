--=============================================================================
--! @file marocTriggerTimeStampArray_rtl.vhd
--=============================================================================
--! Standard library
library IEEE;
--! Standard packages
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;
--! Package containing type definition and constants for MAROC interface
--use work.maroc.ALL;
--! Package containing type definition and constants for IPBUS
--use work.ipbus.all;

--! Use UNISIM for Xilix primitives
Library UNISIM;
use UNISIM.vcomponents.all;


-------------------------------------------------------------------------------
-- --
-- University of Bristol, High Energy Physics Group.
-- --
------------------------------------------------------------------------------- --
-- unit name: marocTriggerTimeStampArray_rtl (marocTriggerTimeStampArray / rtl)
--
--! @brief Array of marocTriggerTimeStamp entities with FIFO buffers on each output
--! fed into a multiplexer
--
--! @author David Cussans , David.Cussans@bristol.ac.uk
--
--! @date 30\3\2016
--
--! @version v0.1
--
--! @details
--!
--! <b>Dependencies:</b>\n
--! Instantiates marocTriggerTimeStamp
--!
--! <b>References:</b>\n
--!
--! <b>Modified by:</b>\n
--! Author: 
-------------------------------------------------------------------------------
--! \n\n<b>Last changes:</b>\n
--! 
-------------------------------------------------------------------------------
--! @todo 
--
---------------------------------------------------------------------------------
entity marocTriggerTimeStampArray is
  
  generic (
    g_BUSWIDTH       : positive := 32;   --! IPBUS data width
    g_NUM_CHANNELS   : positive := 64;
    g_IDENTWIDTH     : positive := 6;
    g_FINEBITWIDTH   : positive := 2
    );      

  port (
    clk_i       : in  std_logic;        --! slow clock ( normally IPBus clock 31.25 MHz)
    clk_fast_i  : in  std_logic;        --! fast clock ( 4 x slow clock . e.g 125MHz)
    triggers_i   : in  std_logic_vector(g_NUM_CHANNELS-1 downto 0);        --! triggers from MAROC
    timestamp_i : in  std_logic_vector( (g_BUSWIDTH - (g_IDENTWIDTH + g_FINEBITWIDTH))-1 downto 0);  --! time-stamp that will be combined with fine-grain bits
    triggers_fastclk_o   : out std_logic_vector(g_NUM_CHANNELS-1 downto 0);--! retimed maroc triggers, pulses high g_TRIGGERWIDTH cycles of fast clock
    triggers_slowclk_o   : out std_logic_vector(g_NUM_CHANNELS-1 downto 0);--! maroc triggers, pulses high single cycle of slow clock
    timestamp_data_o : out std_logic_vector(g_BUSWIDTH-1 downto 0); --! ident-code + coarse-bits + fine-bits
    timestamp_data_ready_o : out std_logic --! High if there is timestamp data
    );  

end entity marocTriggerTimeStampArray;

architecture rtl of marocTriggerTimeStampArray is

  signal s_timestamp_data_ready , s_timeStampFIFO_empty , s_timeStampFIFO_rd_en: std_logic_vector(g_NUM_CHANNELS-1 downto 0) := ( others => '0' );  -- pulses high for one cycle of slow clock for each trigger
  
  type   t_triggerTimeArray is array(natural range <>) of std_logic_vector(g_BUSWIDTH-1 downto 0) ;
  signal s_timestamp_data , s_timestampFIFO_out : t_triggerTimeArray(g_NUM_CHANNELS-1 downto 0) := ( others => ( others => '0'));
  
begin  -- architecture rtl

  gen_timestamparray: for v_marocChannel in 0 to g_NUM_CHANNELS-1 generate

    -- instantiate component to shift trigger onto internal clock domain
    -- and produce a time-stamp
    cmp_timestamp: entity work.marocTriggerTimeStamp
        generic map (
          g_IDENT => v_marocChannel)
        PORT MAP (
          clk_i => clk_i,
          clk_fast_i => clk_fast_i,
          trigger_i => triggers_i(v_marocChannel),
          timestamp_i => timestamp_i,
          trigger_o => triggers_fastclk_o(v_marocChannel),
          timestamp_data_o => s_timestamp_data(v_marocChannel),
          timestamp_data_ready_o => s_timestamp_data_ready(v_marocChannel)
          );

    triggers_slowclk_o <= s_timestamp_data_ready;
    
    cmp_timestampFIFO : entity work.timeStampFIFO      
      port map (
        clk   => clk_i,
        srst  => '0',
        din   => s_timestamp_data(v_marocChannel),
        wr_en => s_timestamp_data_ready(v_marocChannel),
        rd_en => s_timeStampFIFO_rd_en(v_marocChannel),
        dout  => s_timestampFIFO_out(v_marocChannel),
        full  => open,
        empty => s_timeStampFIFO_empty(v_marocChannel)
        );
      
  end generate gen_timestamparray;


  
end architecture rtl;
