--=============================================================================
--! @file marocTriggerGenerator_rtl.vhd
--=============================================================================
--! Standard library
library IEEE;
--! Standard packages
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

--! Xilinx primitives
LIBRARY UNISIM;
USE UNISIM.vcomponents.all;

-------------------------------------------------------------------------------
-- --
-- University of Bristol, High Energy Physics Group.
-- --
------------------------------------------------------------------------------- --
-- unit name: marocTriggerGenerator (marocTriggerGenerator / rtl)
--
--! @brief Takes asynchronous trigger signals, registers them onto clk_fast_i
--! and outputs an externalTrigger_o signal. 
--
--! @author David Cussans , David.Cussans@bristol.ac.uk
--
--! @date 19\Jan\2011
--
--! @version v0.1
--
--! @details
--! externalTrigger_i , or1_i , or2_i are the incoming trigger signals.
--! Setting the appropriate bit in triggerSourceSelect_i allows that trigger to contribute
--! bit0 - internalTrigger_i
--! bit1 - externalTrigger_i
--! bit2 - or1_i
--! bit3 - or2_i
--! Delays trigger by hold1Delay_i cycles of clk_fast_i and then asserts hold1.
--! Delays hold1 by hold2Delay_i cycles of clk_fast_i then asserts hold2
--! After asserting hold2 outputs a pulse on adcStartConversion_o , last for single cycle of clk_sys_i
--! When the ADC controller signals end of conversion by pulsing adcConversionEnd_i
--high then
--! hold1,hold2 are deasserted.
--!
--! <b>Dependencies:</b>\n
--! Instantiates marocTriggerGeneratorFSM
--!
--! <b>References:</b>\n
--! referenced by ipBusMarocTriggerGenerator \n
--!
--! <b>Modified by:</b>\n
--! Author: 
-------------------------------------------------------------------------------
--! \n\n<b>Last changes:</b>\n
--! <date> <initials> <log>\n
--! <extended description>
-------------------------------------------------------------------------------
--! @todo <next thing to do> \n
--! <another thing to do> \n
--
---------------------------------------------------------------------------------

--============================================================================
--! Entity declaration for marocShiftReg
--============================================================================

ENTITY marocTriggerGenerator IS
  generic (
    g_BUSWIDTH : integer := 32);
   PORT( 
      adcConversionEnd_i   : IN     std_logic;                      --! end of conversion signal from ADC controller. Goes high for one clock, Sync with rising edge of clk_sys_i
      clk_fast_i           : IN     std_logic;                      --! Fast clock used to register and delay trigger signals
      clk_sys_i            : IN     std_logic;                      --! system clock used for adcConversionEnd_o , adcConversionStart_i
      reset_i              : in     std_logic;                       --! Active high. Resets s_preDelayHold and counter value
--      conversion_counter_o : out    std_logic_vector( g_BUSWIDTH-1 downto 0); --! Number of ADC conversions since last reset. Wraps round at full scale.
      externalTrigger_a_i  : IN     std_logic;                      --! External trigger ( routed to an FPGA input pin). Async
      internalTrigger_i    : IN     std_logic;                      --! Internal trigger ( from IPBus slave). Sync with clk_sys_i, but assume async w.r.t. clk_fast_i 
      triggerSourceSelect_i : IN    std_logic_vector(3 downto 0);   --! 4-bit mask to select which trigger inputs are active.
                                                                    --! bit0 = internal , bit1 = external , bit2 = or1 , bit3 = or2
      hold1Delay_i         : IN     std_logic_vector (4 DOWNTO 0);  --! Number of clocks of clk_fast_i to between input trigger and HOLD1 output
      hold2Delay_i         : IN     std_logic_vector (4 DOWNTO 0);  --! Number of clocks of clk_fast_i to between input trigger and HOLD2 output
      or1_a_i              : IN     std_logic;                      --! OR1 output from MAROC. Async
      or2_a_i              : IN     std_logic;                      --! OR2 output from MAROC. Async
      adcConversionStart_o : OUT    std_logic;                      --! start of conversion signal to ADC controller. Sync with rising edge of clk_sys_i
      externalTrigger_o    : OUT    std_logic;                      --! Trigger output. Sync with rising edge of clk_fast_i
      hold1_o              : OUT    std_logic;                      --! HOLD1 output to MAROC. Sync with rising edge clk_fast_i
      hold2_o              : OUT    std_logic                       --! HOLD2 output to MAROC. Sync with rising edge clk_fast_i
   );

-- Declarations

END marocTriggerGenerator ;

--
ARCHITECTURE rtl OF marocTriggerGenerator IS

      signal s_or1_d1 : std_logic;       -- ! OR1 signal delayed by one-clock of clk_fast_i
      signal s_or1_d2 : std_logic;             --!
      
      signal s_or2_d1 : std_logic;             --!
      signal s_or2_d2 : std_logic;             --!

      signal s_externalTrigger_d1 : std_logic;             --!
      signal s_externalTrigger_d2 : std_logic;             --!

      signal s_internalTrigger_d1 : std_logic;             --!
      signal s_internalTrigger_d2 : std_logic;             --!

      signal s_hold1 : std_logic;             --!

      --! hold1,hold2 are active low. This signal gets put through a delay.
      signal s_preDelayHold  : std_logic := '1';             
                                                             
      
      signal s_trig : std_logic;             --! trigger generated from input trigers
      signal s_trig_d1 : std_logic;             --! s_trig clocked onto clk_fast
      signal s_trig_d2 : std_logic;             --! 

      signal s_adcConversionEnd_d1 : std_logic;  -- ! Conversion end signal, registered onto fast clock
      signal s_adcConversionEnd_d2 : std_logic;  -- ! Conversion end signal, registered onto fast clock

      signal s_adcConversionStart : std_logic;  --! Local copy since can't read
                                                --from output port...
      signal s_hold1_d1 : std_logic;  --! 
      signal s_hold1_d2 : std_logic;  --! 
      signal s_hold1_d3 : std_logic;  --! 

BEGIN

  --! purpose: Registers async signals onto fast clock to supress meta-stability
  --! type   : sequential
  --! inputs : clk_fast_i
  --! outputs: 
  p_RegisterSignals: process (clk_fast_i)
  begin  -- process p_RegisterSignals

    if rising_edge(clk_fast_i) then

      s_or1_d1 <= or1_a_i;
      s_or1_d2 <= s_or1_d1;
      
      s_or2_d1 <= or2_a_i;
      s_or2_d2 <= s_or2_d1;

      s_externalTrigger_d1 <= externalTrigger_a_i;
      s_externalTrigger_d2 <= s_externalTrigger_d1 ;

      s_internalTrigger_d1 <= internalTrigger_i;
      s_internalTrigger_d2 <= s_internalTrigger_d1 ;

      s_trig_d1 <= s_trig;
      s_trig_d2 <= s_trig_d1;

      s_adcConversionEnd_d1 <= adcConversionEnd_i;
      s_adcConversionEnd_d2 <= s_adcConversionEnd_d1;

    end if;
    
  end process p_RegisterSignals;

  --! Form a trigger from the input signals
  s_trig <=   ( s_internalTrigger_d2 and triggerSourceSelect_i(0) ) OR
              ( s_externalTrigger_d2 and triggerSourceSelect_i(1) ) OR
              ( s_or1_d2 and triggerSourceSelect_i(2) ) OR
              ( s_or2_d2 and triggerSourceSelect_i(3) ) ;

  --! Copy the trigger to the output trigger signal
  externalTrigger_o <= s_trig_d2;
  
  --! purpose: Clocked RS-FlipFlop (in clk_fast_i). Sets s_hold high when s_trig_d2 goes high. Sets s_hold low when s_adcConversionEnd_d2 goes high.
  --! type   : sequential
  --! inputs : clk_fast_i , s_adcConversionEnd_d2 , s_trig_d2 , reset_i
  --! outputs: s_hold
  p_RSFlipFlop: process (clk_fast_i , s_adcConversionEnd_d2 , s_trig_d2 , reset_i)
  begin  -- process p_RSFlipFlop

    if rising_edge(clk_fast_i) then
      if (reset_i = '1') then
        s_preDelayHold <= '1';
      elsif s_adcConversionEnd_d2 = '1' then
        s_preDelayHold <= '1';
      elsif s_trig_d2 = '1' then
        s_preDelayHold <= '0';
      else
        s_preDelayHold <= s_preDelayHold;
      end if;
    end if;
  end process p_RSFlipFlop;


-- -- -- --

  --! Delay trigger by up to 32 clock cycles then output to hold1 pin
  cmp_delayHold1 : SRLC32E
    generic map (
      INIT => X"00000000")
    port map (
      Q => s_hold1, -- SRL data output 
      Q31 => open, -- SRL cascade output pin 
      A => hold1Delay_i, -- 5-bit shift depth select input 
      CE => '1', -- Clock enable input 
      CLK => clk_fast_i, -- Clock input 
      D => s_preDelayHold -- SRL data input
      ); -- End of SRLC32E_inst instantiation

  hold1_o <= s_hold1;
  
  --! Delay HOLD1 signal by up to 32 (fast) clock cycles then output to hold2
  cmp_delayHold2 : SRLC32E
    generic map (
      INIT => X"00000000")
    port map (
      Q => hold2_o, -- SRL data output 
      Q31 => open, -- SRL cascade output pin 
      A => hold2Delay_i, -- 5-bit shift depth select input 
      CE => '1', -- Clock enable input 
      CLK => clk_fast_i, -- Clock input 
      D => s_hold1 -- SRL data input
      ); -- End of SRLC32E_inst instantiation

  
  -- purpose: registers s_hold1 onto system (slow) clock and detect rising edge to form adcConversionStart_o
  -- type   : sequential
  -- inputs : clk_sys_i,  s_hold1
  -- outputs: adcConversionStart_o
  p_GenerateADCStart: process (clk_sys_i, s_hold1)
  begin  -- process p_GenerateADCStart
    if rising_edge(clk_sys_i) then  -- rising clock edge
      
      s_hold1_d1 <= s_hold1;
      s_hold1_d2 <= s_hold1_d1;
      s_hold1_d3 <= s_hold1_d2;

      s_adcConversionStart <= (not s_hold1_d2) and s_hold1_d3 ;
    end if;
  end process p_GenerateADCStart;

  adcConversionStart_o <= s_adcConversionStart;  
  
END ARCHITECTURE rtl;

