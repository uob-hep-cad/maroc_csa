--=============================================================================
--! @file marocTriggerTimeStamp_rtl.vhd
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
-- unit name: marocTriggerTimeStamp_rtl (marocTriggerTimeStamp / rtl)
--
--! @brief accepts an input from maroc trigger line and outputs a single cycle
--! pulse synchronized to slow clock.

--! @author David Cussans , David.Cussans@bristol.ac.uk
--
--! @date 30\3\2016
--
--! @version v0.1
--
--! @details
--!
--! <b>Dependencies:</b>\n
--! Instantiates marocTriggerTimeStampFSM
--!
--! <b>References:</b>\n
--! referenced by marocTriggerTimeStamp \n
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
entity marocTriggerTimeStamp is
  
  generic (
    g_BUSWIDTH   : positive := 32;   --! IPBUS data width
    g_IDENTWIDTH : positive := 6;    --! number of bits in channel identifier
    g_IDENT      : integer := 0; --! identifier to add to data
    g_FINEBITWIDTH : positive := 2; --! Number of fine time-stamp bits. Input is DDR on clk_fast . i.e. 4 x clk_i --> 2 bits
    g_TRIGGERWIDTH : positive := 4 --! width of trigger out ( in units of fast
                                    --clock
    );      

  port (
    clk_i       : in  std_logic;        --! slow clock ( normally IPBus clock 31.25 MHz)
    clk_fast_i  : in  std_logic;        --! fast clock ( 4 x slow clock . e.g 125MHz)
    trigger_i   : in  std_logic;        --! trigger from MAROC
    timestamp_i : in  std_logic_vector( (g_BUSWIDTH - (g_IDENTWIDTH + g_FINEBITWIDTH))-1 downto 0);  -- time-stamp that will be combined with fine-grain bits
    trigger_o   : out std_logic;  --! pulses high g_TRIGGERWIDTH cycles of fast clock
    timestamp_data_o : out std_logic_vector(g_BUSWIDTH-1 downto 0); --! ident-code + coarse-bits + fine-bits
    timestamp_data_ready_o : out std_logic --! High if there is timestamp data
    );  

end entity marocTriggerTimeStamp;

architecture rtl of marocTriggerTimeStamp is

  signal s_trigger_in , s_trigger_d1 : std_logic := '0';
  attribute shreg_extract : string; -- Don't want synchronizer registers optimized to SRL16
  attribute shreg_extract of s_trigger_in: signal is "no";
  attribute shreg_extract of s_trigger_d1: signal is "no";

  signal s_trigger_sr : std_logic_vector(2*(2**g_FINEBITWIDTH)-1 downto 0) := ( others => '0');  --! Shift register to transfer from fast to slow clock.  for fast clk = 4 * clk then length =  2*(2**2) = 8 bits.
  signal s_trigger_sr_d1 , s_trigger_sr_d2 : std_logic_vector( s_trigger_sr'range ) := ( others => '0');  -- ! Transfer to slow clock
  attribute shreg_extract of s_trigger_sr_d1: signal is "no";
  attribute shreg_extract of s_trigger_sr_d2: signal is "no";

  signal s_fineTimeStamp : std_logic_vector(g_FINEBITWIDTH-1 downto 0) := ( others => '0');
  signal s_triggerfound ,s_triggerfound_d1 : std_logic := '0';  -- ! Goes high for one cycle of clk_i if rising edge detected

  signal s_triggerData : std_logic_vector(g_BUSWIDTH-1 downto 0) := ( others => '0');

  constant c_PARAM_WIDTH : integer := 4;  -- width of pulse stretch parameter
  
begin  -- architecture rtl

  -- purpose: registers trigger from MAROC onto fast clock
  -- type   : combinational
  -- inputs : clk_fast_i
  -- outputs: s_trigger_in
  p_triggerIn: process (clk_fast_i) is
  begin  -- process p_triggerIn
    if rising_edge(clk_fast_i) then
      s_trigger_d1 <= trigger_i;
      s_trigger_in <= s_trigger_d1;
      s_trigger_sr <= s_trigger_sr( (s_trigger_sr'left -1) downto 0 ) & s_trigger_in; -- LSB is the most recent
    end if;
  end process p_triggerIn;

  -- stretch the incoming pulse ( now stretched onto fast clock domain ). 
  cmp_stretchFastPulse: entity work.stretchPulse
    generic map (
      g_PARAM_WIDTH => c_PARAM_WIDTH)  --! number of bits in parameters (width,  delay)
    port map (
      clk_i        => clk_fast_i,
      pulse_i      => s_trigger_in,
      pulseWidth_i => std_logic_vector(to_unsigned(g_TRIGGERWIDTH,c_PARAM_WIDTH)),
   
      pulse_o      => trigger_o
      );
  
  -- purpose: moves trigger shift register to slow clock domain
  -- type   : combinational
  -- inputs : clk_i 
  -- outputs: s_trigger_sr_d2
  p_crossToSlow: process (clk_i ) is
  begin  -- process p_crossToSlow
    if rising_edge(clk_i) then
      s_trigger_sr_d1 <= s_trigger_sr;
      s_trigger_sr_d2 <= s_trigger_sr_d1;
    end if;
  end process p_crossToSlow;

  -- purpose: decodes shift register to fine timestamp bits
  -- type   : combinational
  -- inputs : clk_i
  -- outputs: s_fineTimeStamp
  p_decodeFineTimeStamp: process (clk_i) is
  begin  -- process p_decodeFineTimeStamp
    if rising_edge(clk_i) then
      -- LSB of shift reg is most recent. So sample with edge closest to MSB is
      -- the oldest , so should have the lowest timestamp.
      if    std_match(s_trigger_sr_d2,"0011----") then
        s_fineTimeStamp <= "00"; 
        s_triggerFound <= '1';
      elsif std_match(s_trigger_sr_d2,"-0011---") then
        s_fineTimeStamp <= "01";
        s_triggerFound <= '1';
      elsif std_match(s_trigger_sr_d2,"--0011--") then
        s_fineTimeStamp <= "10";
        s_triggerFound <= '1';
      elsif std_match(s_trigger_sr_d2,"---0011-") then
        s_fineTimeStamp <= "11";
        s_triggerFound <= '1';
      else
        s_fineTimeStamp <= "00";
        s_triggerFound <= '0';
      end if;
    end if;
  end process p_decodeFineTimeStamp;

  -- purpose: combines data with ident and outputs
  -- type   : combinational
  -- inputs : clk_i
  -- outputs: timestamp_data_o
  p_outputData: process (clk_i) is
  begin  -- process p_outputData
    if rising_edge(clk_i) then

      if s_triggerFound = '1' then
        s_triggerData <= std_logic_vector(to_unsigned(g_IDENT,g_IDENTWIDTH)) & timestamp_i & s_fineTimeStamp;
      else
        s_triggerData <= ( others => '0');
      end if;

      s_triggerFound_d1 <= s_triggerFound;
      timestamp_data_ready_o <= s_triggerFound_d1;
      
      timestamp_data_o <= s_triggerData ;

    end if;
  end process p_outputData;
  
end architecture rtl;
