--! @file fallingEdgeDetect_rtl
--! @brief Detects the falling edge of an incoming signal and produces a single cycle pulse

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fallingEdgeDetect is
  
  port (
    clk_i   : in  std_logic;            -- ! falling edge active clock
    level_i : in  std_logic;            -- ! Level
    pulse_o : out std_logic);  -- ! Pulses high for one clock cycle when level_i goes from high to low

end entity fallingEdgeDetect;

architecture rtl of fallingEdgeDetect is

  signal level_d1 , level_d2 : std_logic := '0';  -- delayed version of input
  signal pulse , pulse_d1 : std_logic := '0'; -- register output.
                                         
begin  -- architecture rtl

  p_levelDetect: process (clk_i) is
  begin  -- process p_levelDetect
    if rising_edge(clk_i) then  -- rising clock edge
     level_d1 <=  level_i;
     level_d2 <=  level_d1;
     if (( level_d2 = '1' ) and ( level_d1 = '0')) then
       pulse <= '1';
     else
       pulse <= '0';
     end if;

     pulse_d1 <= pulse;
     pulse_o <= pulse_d1;
    end if;
  end process p_levelDetect;

end architecture rtl;
