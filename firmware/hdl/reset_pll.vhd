----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:40:57 05/21/2013 
-- Design Name: 
-- Module Name:    reset_pll - rtl 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity reset_pll is
  generic (
    g_RESET_SR_LENGTH : positive := 32
    );
  Port (
    ipbus_clk_i : in  STD_LOGIC; --! IPBus clock.
    pll_clk_i : in  STD_LOGIC;   --! Clock that is fed into the PLL
    ipbus_rst_i : in  STD_LOGIC; --! Reset line coming from IPBus pulser. Rising edge active.
    pll_rst_o : out  STD_LOGIC   --! reset line to PLL, on pll_clk_i domain
    );
end reset_pll;

architecture rtl of reset_pll is

  signal  s_rst_ipbusclk_sr, s_rst_pllclk_sr : std_logic_vector( g_RESET_SR_LENGTH-1 downto 0) := ( others => '0');
  signal s_rst_ipbusclk : std_logic := '0';
  signal s_rst_pllclk,  s_rst_pllclk_d1 , s_rst_pllclk_rising : std_logic := '0';
begin

  -- When ipbus_rst_i goes high, load a  register with ones and shift out.
  -- In IPBus clock domain
  p_ipbus_rst: process (ipbus_clk_i)
  begin  -- process p_ipbus_rst
    if rising_edge(ipbus_clk_i) then
      if ipbus_rst_i='1' then
        s_rst_ipbusclk_sr <= ( others => '1');
      else
        s_rst_ipbusclk <= s_rst_ipbusclk_sr(0);
        s_rst_ipbusclk_sr <= '0' & s_rst_ipbusclk_sr(s_rst_ipbusclk_sr'left downto 1);
      end if;
    end if;
  end process p_ipbus_rst;

  -- Find rising edge of s_rst_ipbus, then load a register and shift out as PLL
  -- reset signal.
  p_pll_rst: process (pll_clk_i)
  begin  -- process p_pll_rst
    if rising_edge(pll_clk_i) then
      
      s_rst_pllclk <= s_rst_ipbusclk;
      s_rst_pllclk_d1 <= s_rst_pllclk;
      s_rst_pllclk_rising <= '1' when  ((s_rst_pllclk='1') and (s_rst_pllclk_d1='0')) else '0';
      
      if s_rst_pllclk_rising='1' then
        s_rst_pllclk_sr <= ( others => '1');
      else
        pll_rst_o <= s_rst_pllclk_sr(0);
        s_rst_pllclk_sr <= '0' & s_rst_pllclk_sr(s_rst_pllclk_sr'left downto 1);
      end if;
    end if;
  end process p_pll_rst;
end rtl;

