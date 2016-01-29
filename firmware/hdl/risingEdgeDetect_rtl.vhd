--! @file risingEdgeDetect_rtl
--! @brief Detects the rising edge of an incoming signal and produces a single cycle pulse

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity risingEdgeDetect is
  
  port (
    clk_i   : in  std_logic;            -- ! rising edge active clock
    level_i : in  std_logic;            -- ! Level
    pulse_o : out std_logic);  -- ! Pulses high for one clock cycle when level_i goes from low to high

end entity risingEdgeDetect;

architecture rtl of risingEdgeDetect is

  signal level_d1 , level_d2 , level_p1 , level_p2 : std_logic := '0';  -- delayed version of input
  
begin  -- architecture rtl

  p_levelDetect: process (clk_i) is
  begin  -- process p_levelDetect
    if rising_edge(clk_i) then  -- rising clock edge

      -- extra register stages
      level_p1 <=  level_i;
      level_p2 <=  level_p1;
      
     level_d1 <=  level_p2;
     --level_d1 <=  level_i;

      level_d2 <=  level_d1;
      
     if (( level_d2 = '0' ) and ( level_d1 = '1')) then
       pulse_o <= '1';
     else
       pulse_o <= '0';
     end if;
    end if;
  end process p_levelDetect;

end architecture rtl;
