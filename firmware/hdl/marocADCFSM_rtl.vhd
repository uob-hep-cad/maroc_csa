--=============================================================================
--! @file marocADCFSM_rtl.vhd
--=============================================================================
--! Standard library
library IEEE;
--! Standard packages
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;
--! Specific packages
--use work.XXX.ALL;
-------------------------------------------------------------------------------
-- --
-- University of Bristol, High Energy Physics Group.
-- --
------------------------------------------------------------------------------- --
-- unit name: marocADCFSM (marocADCFSM / rtl)
--
--! @brief State machine to produce control signals for marocADC
--
--! @author David Cussans , David.Cussans@bristol.ac.uk
--
--! @date 23\12\2011
--
--! @version v0.1
--
--! @details
--!
--! <b>Dependencies:</b>\n
--! None
--!
--! <b>References:</b>\n
--! referenced by marocShiftREG \n
--!
--! <b>Modified by:</b>\n
--! Author: 
-------------------------------------------------------------------------------
--! \n\n<b>Last changes:</b>\n
--! 17/Mar/2012   DGC    Specify an initial value for s_state and s_next_state \n
--! 17/Jul/2013   DGC    Replace SHIFTINGIN state with WAIT_FOR_DAV_HIGH and \n
--!                      WAIT_FOR_DAV_LOW states
-------------------------------------------------------------------------------
--! @todo <next thing to do> \n
--! <another thing to do> \n
--
---------------------------------------------------------------------------------

--============================================================================
--! Entity declaration for marocADCFSM
--============================================================================
entity marocADCFSM is

    port (
      clk_system_i      : in std_logic;  --! Rising edge active
      rst_i             : in std_logic;  --! Take high to reset state machine.
      start_p_i         : in std_logic;  --! Pulse high to start conversion
      adc_dav_i         : in std_logic;  --! "Transmitting data" signal from MAROC
      reset_sr_o        : out std_logic;  --! reset ADC and internal shift reg.
      start_adc_n_o     : out std_logic;  --! Goes low during conversion.
      end_of_sequence_o : out std_logic;  --! Goes high for one clock cycle immediately after DAV goes low
      status_o          : out std_logic --! Zero when FSM is idle , one otherwise
      );        
end marocADCFSM;

--============================================================================
--! architecture declaration
--============================================================================
architecture rtl of marocADCFSM is

  --! Define an enumerated type corresponding to FSM states
  type t_state_type is (IDLE , RESETTING , WAIT_FOR_DAV_HIGH , WAIT_FOR_DAV_LOW , END_OF_READOUT );
  signal s_state , s_next_state : t_state_type := IDLE ;

  signal s_end_of_sequence , s_status , s_start_adc_n, s_reset_sr: std_logic := '0';
  
--============================================================================
-- architecture begin
--============================================================================ 
begin  -- rtl

  
  --==========================================================================
  --! Process: Register that holds the current state of the FSM
  --! read: clk_system_i , rst_i
  --! write: s_state
  --==========================================================================
  p_state_register: process (clk_system_i , rst_i , s_state , s_next_state )
  begin  -- process state_register
    if rising_edge(clk_system_i) then
      if ( rst_i = '1') then
        s_state <= IDLE;
      else
        s_state <= s_next_state;
      end if;

      end_of_sequence_o <= s_end_of_sequence;
      status_o <= s_status;
      start_adc_n_o <= s_start_adc_n;
      reset_sr_o <= s_reset_sr;
      
    end if;
  end process p_state_register;

  --==========================================================================
  --! Process: state logic - controls s_next_state based on current state and inputs
  --! read: clk_system_i , rst_i , s_state , 
  --! write: s_next_state
  --==========================================================================
  p_state_logic: process (s_state , s_next_state , start_p_i , adc_dav_i )
  begin  -- process p_state_logic
    case s_state is
      
      when IDLE =>
        if ( start_p_i = '1' ) then
          s_next_state <= RESETTING;
        else
          s_next_state <= IDLE;
        end if;

      when RESETTING =>
        s_next_state <=  WAIT_FOR_DAV_HIGH ;

      when WAIT_FOR_DAV_HIGH =>
        if (adc_dav_i = '1') then
          s_next_state <= WAIT_FOR_DAV_LOW;
        else
          s_next_state <= WAIT_FOR_DAV_HIGH;
        end if;

      when WAIT_FOR_DAV_LOW =>
        if (adc_dav_i = '0') then
          s_next_state <= END_OF_READOUT;
        else
          s_next_state <= WAIT_FOR_DAV_LOW;
        end if;

      when END_OF_READOUT =>
        s_next_state <= IDLE;
        
      when others =>
        s_next_state <= IDLE;
        
    end case;
  end process p_state_logic;
  
  --==========================================================================
  --! Set output signals on basis of state
  --==========================================================================
  
  --! reset goes high-when state=resetting
  s_reset_sr  <= '1' when s_state = RESETTING else '0';  

  --! start_adc_n_o goes low during conversion
  s_start_adc_n  <= '0' when (s_state = WAIT_FOR_DAV_HIGH) or (s_state = WAIT_FOR_DAV_LOW )  else '1';
 
  s_status <= '0' when s_state = IDLE else '1';

  s_end_of_sequence <= '1' when s_state = END_OF_READOUT else '0';
  
end rtl;
--============================================================================
-- architecture end
--============================================================================
