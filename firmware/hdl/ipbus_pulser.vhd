-- Produces a single cycle pulse on one or more bits. Write only.
--
-- generic addr_width defines number of significant address bits
--
-- David Cussans, December 2012

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.ipbus.all;

entity ipbus_pulser is
  generic(g_ipbus_data_width : natural := 32);
  port(
    clk: in STD_LOGIC;
    ipbus_in: in ipb_wbus;
    ipbus_out: out ipb_rbus;
    q: out STD_LOGIC_VECTOR(g_ipbus_data_width-1 downto 0)
    );
	
end ipbus_pulser;

architecture rtl of ipbus_pulser is

  signal reg: std_logic_vector(g_ipbus_data_width-1 downto 0);
  signal ack: std_logic;

begin

  process(clk)
  begin
    if rising_edge(clk) then
      reg <= ( others => '0');
      if ipbus_in.ipb_strobe='1' and ipbus_in.ipb_write='1' then
        reg <= ipbus_in.ipb_wdata;      -- register is set high for one cycle
                                        -- then returns low.
      end if;
      
      ipbus_out.ipb_rdata <= reg;
      ack <= ipbus_in.ipb_strobe and not ack;
      
    end if;
  end process;
	
  ipbus_out.ipb_ack <= ack;
  ipbus_out.ipb_err <= '0';

  q <= reg;
  
end rtl;
