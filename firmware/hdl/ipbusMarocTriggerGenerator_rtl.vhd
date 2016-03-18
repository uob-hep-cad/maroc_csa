--=============================================================================
--! @file ipbusMarocTriggerGenerator_rtl.vhd
--=============================================================================
--! Standard library
library IEEE;
--! Standard packages
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;
--! Package containing type definition and constants for MAROC interface
use work.maroc.ALL;
--! Package containing type definition and constants for IPBUS
use work.ipbus.all;

-------------------------------------------------------------------------------
-- --
-- University of Bristol, High Energy Physics Group.
-- --
------------------------------------------------------------------------------- --
-- unit name: ipbusMarocTriggerGenerator_rtl (ipbusMarocTriggerGenerator / rtl)
--
--! @brief Interfaces between IPBus and Maroc TriggerGenerator
--
--! @details
--! Addresses ( with respect to base address)\n
--! 0x00 : Status register. Writing 1 to bit-0 resets trigger and timestamp counters\n
--! 0x01 : Manual trigger register. Write 1 to bit 0 to cause internal trigger\n
--! 0x02 : HOLD1 delay. 5 bits, 5ns ticks\n
--! 0x03 : HOLD2 delay. 5 bits, 5ns ticks\n
--! 0x04 : Trigger select register. 4 bits.\n
--!        bit 0 = internal-trigger , 1 = external-trigger\n, bit2 = or1 , bit3=or2\n
--! 0x05 : Conversion counter - read = number of ADC conversions since last reset.\n
--! 0x06 : Timestamp - read = number of clock cycles since last reset
--
--! @author David Cussans , David.Cussans@bristol.ac.uk
--
--! @date 21\1\2012
--
--! @version v0.1
--!
--!
--! <b>Dependencies:</b>\n
--! Instantiates marocTriggerGenerator
--!
--! <b>References:</b>\n
--! referenced by slaves \n
--!
--! <b>Modified by:</b>\n
--! Author: 
-------------------------------------------------------------------------------
--! \n\n<b>Last changes:</b>\n
--! 9/March/2012 DGC Adding trigger counter and timestamp\n
-------------------------------------------------------------------------------
--! @todo <next thing to do> \n
--! <another thing to do> \n
--
---------------------------------------------------------------------------------
--


entity ipbusMarocTriggerGenerator is
  generic(
    g_BUSWIDTH    : positive := 32
    );
  port(
    clk_i        : in STD_LOGIC;
    reset_i      : in STD_LOGIC;
    ipbus_i      : in ipb_wbus;
    ipbus_o      : out ipb_rbus;

    logic_reset_i : in STD_LOGIC;       --! Reset logic signal. High for one
        
    -- Signals to MAROC and ADC controller
    adcConversionEnd_i : in std_logic;
    adcConversionStart_o : out std_logic;
    triggerNumber_o   : out std_logic_vector(g_BUSWIDTH-1 downto 0);
    timeStamp_o       : out std_logic_vector(g_BUSWIDTH-1 downto 0);

    clk_fast_i         : in std_logic;
    externalTrigger_a_i: in std_logic;
    externalTrigger_o: out std_logic;
    or1_a_i            : in std_logic;
    or2_a_i            : in std_logic;
    hold1_o            : out std_logic;
    hold2_o            : out std_logic;

    CTEST_O: out STD_LOGIC_VECTOR(5 downto 0) -- 4-bit R/2R DAC
    );
	
end ipbusMarocTriggerGenerator;

architecture rtl of ipbusMarocTriggerGenerator is

  signal s_internalTrigger_p ,s_internalTrigger_p_d1 : std_logic;
  signal s_triggerSourceSelect : std_logic_vector(3 downto 0) := (others => '0');
  signal s_hold1Delay  ,  s_hold2Delay : std_logic_vector(4 downto 0);

  signal s_ack: std_logic;

  signal s_counter_reset , s_counter_reset_ipb , s_counter_reset_ipb_d1: std_logic;
  signal s_conversion_counter : std_logic_vector(g_BUSWIDTH-1 downto 0) := (others => '0');
  signal s_timeStamp : std_logic_vector(g_BUSWIDTH-1 downto 0) := (others => '0');

  signal s_adcConversionStart : std_logic;  -- internal coopy of adcConversionStart_o
  
begin

  -- read/write to registers storing data to/from MAROC and to control reg.
  p_addressDecode: process(clk_i)
  begin
    if rising_edge(clk_i) then

      case ipbus_i.ipb_addr(2 downto 0) is

        when "000" =>                  -- status register
          ipbus_o.ipb_rdata(0) <= '0' ;  --dummy for now
          
        when "010" =>                   -- hold1 delay
          ipbus_o.ipb_rdata(s_hold1Delay'range) <= s_hold1Delay ;
          ipbus_o.ipb_rdata(g_BUSWIDTH-1 downto s_hold1Delay'high+1)
            <= (others => '0');                 
                 
        when "011" =>                    -- hold2 delay
          ipbus_o.ipb_rdata(s_hold2Delay'range) <= s_hold2Delay ;
          ipbus_o.ipb_rdata(g_BUSWIDTH-1 downto s_hold2Delay'high+1)
            <= (others => '0');                 
                      
        when "100" =>                   -- triger source select
          ipbus_o.ipb_rdata(s_triggerSourceSelect'range)
            <= s_triggerSourceSelect ;
          ipbus_o.ipb_rdata(g_BUSWIDTH-1 downto s_triggerSourceSelect'high+1)
            <= (others => '0');

        when "101" =>
          ipbus_o.ipb_rdata <= s_conversion_counter;

        when "110" =>
          ipbus_o.ipb_rdata <= s_conversion_counter;
          
        when others => null;

      end case;

      -- Handle writing
      if ipbus_i.ipb_strobe='1' and ipbus_i.ipb_write='1' then
        case ipbus_i.ipb_addr(2 downto 0) is

          when "010" =>                   -- hold1 delay
            s_hold1Delay <= ipbus_i.ipb_wdata(s_hold1Delay'range);
                 
          when "011" =>                  -- hold2 delay
            s_hold2Delay <= ipbus_i.ipb_wdata(s_hold2Delay'range);                      
          when "100" =>                  -- triger source select
            s_triggerSourceSelect <=
              ipbus_i.ipb_wdata(s_triggerSourceSelect'range);                                    
          when others => null;

        end case;
      end if;
         
      s_ack <= ipbus_i.ipb_strobe and not s_ack;
    end if;
  end process;                          -- p_addressDecode
  

  --! purpose: Controls state of s_internalTrigger
  --! inputs : clk_i , ipbus_i 
  --! outputs: 
  p_internalTrigger: process (clk_i , ipbus_i )
  begin  -- process p_internalTrigger
    if rising_edge(clk_i) then

      if ipbus_i.ipb_strobe='1' and ipbus_i.ipb_write='1' and
        ipbus_i.ipb_addr(2 downto 0)="001"
      then
        s_internalTrigger_p <= ipbus_i.ipb_wdata(0) ;
        ctest_o <= ipbus_i.ipb_wdata(6 downto 1);
      else
        s_internalTrigger_p <= '0';
        ctest_o <= ( others => '0');
      end if;

      s_internalTrigger_p_d1 <= s_internalTrigger_p;
      
    end if;
  end process p_internalTrigger;

  --! purpose: Controls state of s_counter_reset
  --! inputs : clk_i , ipbus_i 
  --! outputs: 
  p_resetCounter: process (clk_i , ipbus_i )
  begin  -- process p_resetCounter
    if rising_edge(clk_i) then

      if ipbus_i.ipb_strobe='1' and ipbus_i.ipb_write='1' and
        ipbus_i.ipb_addr(2 downto 0)="000"
      then
        s_counter_reset_ipb <= ipbus_i.ipb_wdata(0) ;
      else
        s_counter_reset_ipb <= '0';
      end if;
    end if;
	 s_counter_reset_ipb_d1 <= s_counter_reset_ipb; -- Extra register to ease routing.
  end process p_resetCounter;

  ipbus_o.ipb_ack <= s_ack;
  ipbus_o.ipb_err <= '0';

  s_counter_reset <= s_counter_reset_ipb_d1 or logic_reset_i or reset_i;
                     
  -- Instantiate the TriggerGenerator
  cmp_TriggerGeneratorInterface: entity work.marocTriggerGenerator
    generic map (
      g_BUSWIDTH => g_BUSWIDTH)
    port map (
      adcConversionEnd_i   => adcConversionEnd_i,
      clk_fast_i           => clk_fast_i,
      clk_sys_i            => clk_i,
      reset_i              => s_counter_reset,
--      conversion_counter_o => s_conversion_counter,
      externalTrigger_a_i  => externalTrigger_a_i ,
      internalTrigger_i    => s_internalTrigger_p_d1,
      triggerSourceSelect_i=> s_triggerSourceSelect,
      hold1Delay_i         => s_hold1Delay,
      hold2Delay_i         => s_hold2Delay,
      or1_a_i              => or1_a_i,
      or2_a_i              => or2_a_i,
      adcConversionStart_o => s_adcConversionStart,
      externalTrigger_o    => externalTrigger_o,
      hold1_o              => hold1_o,
      hold2_o              => hold2_o
      );

  adcConversionStart_o <= s_adcConversionStart;
  
  --! For now just count conversions, not triggers....
  triggerNumber_o <= s_conversion_counter;

  timeStamp_o <= s_TimeStamp;

  --! Instantiate a counter for ADC conversions.
  cmp_triggerCounter : entity work.counterWithReset
    generic map (
      g_COUNTER_WIDTH => g_BUSWIDTH)
    port map (
      clock_i  => clk_i,
      reset_i  => s_counter_reset,
      enable_i => s_adcConversionStart,
      result_o => s_conversion_counter );

    --! Instantiate a counter for ADC conversions.
  cmp_timeStamp : entity work.counterWithReset
    generic map (
      g_COUNTER_WIDTH => g_BUSWIDTH)
    port map (
      clock_i  => clk_i,
      reset_i  => s_counter_reset,
      enable_i => '1',
      result_o => s_timeStamp );
  
end rtl;
