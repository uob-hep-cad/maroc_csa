--=============================================================================
--! @file stretchPulse_rtl.vhd
--=============================================================================
--
-------------------------------------------------------------------------------
-- --
-- University of Bristol, High Energy Physics Group.
-- --
------------------------------------------------------------------------------- --
-- VHDL Architecture fmc_mTLU_lib.triggerLogic.rtl
--
--! @brief Takes a pulse on input, stretches it and delays it.
--
-------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity stretchPulse is
  
  generic (
    g_PARAM_WIDTH : positive := 5);  --! number of bits in parameters (width,  delay)

  port (
    clk_i        : in  std_logic;       --! Active high
    pulse_i      : in  std_logic;       --! Active high
    pulseWidth_i : in  std_logic_vector(g_PARAM_WIDTH-1 downto 0);  --! Minimum pulse width ( in clock cycles )
    
    pulse_o      : out std_logic       --! delayed and stretched

    );      

end entity stretchPulse;

-- For now just delay the pulse.
architecture rtl of stretchPulse is

  signal s_stretchSR : std_logic_vector( (2**g_PARAM_WIDTH) -1 downto 0) := ( others => '0' );  -- --! Shift register to generate delay

begin  -- architecture rtl

  --! Stretch pulse. the output pulse is always at least as long as the input pulse
  p_stretchPulse: process (clk_i , pulse_i) is
  begin  -- process p_stretchPulse
    if rising_edge(clk_i) then
      if pulse_i = '1' then
        s_stretchSR <= ( others => '1' ) ;
        pulse_o <= pulse_i ;
      else
        s_stretchSR <= s_stretchSR( (s_stretchSR'left -1) downto 0 ) & '0';
        pulse_o <= s_stretchSR( to_integer(unsigned(pulseWidth_i)) );
      end if;

    end if;
  end process p_stretchPulse;

end architecture rtl;

