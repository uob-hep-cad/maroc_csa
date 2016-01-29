--! @file
--! @brief IPBus interface to a number of counters.
--! @details Read - contents of counter , write - reset
--! @author David Cussans
--! Institute: University of Bristol
--! @date May 2015
--
--! Modifications:
--
library ieee;
use ieee.std_logic_1164.all;

use ieee.numeric_std.all;

use work.ipbus.all;
use work.ipbus_reg_types.all;

entity ipbusCounters is
  generic (
    g_DATAWIDTH  : integer := 32;  --! Width of word
    g_ADDRWIDTH  : integer := 6    --! number of counters = 2^g_ADDRWIDTH
    );                               
  port (
    counter_clk_i  : in std_logic;           --! rising edge active
    triggers_i     : in std_logic_vector( (2**g_ADDRWIDTH)-1 downto 0);

    -- IPBus for read-port
    ipb_clk_i : in std_logic;
    reset_i : in std_logic;
    ipbus_i  : in  ipb_wbus;
    ipbus_o : out ipb_rbus

    ); 
end ipbusCounters;

architecture rtl of ipbusCounters is

--  type t_counterArray is array(natural range <>) of std_logic_vector(g_DATAWIDTH-1 downto 0);
--  signal s_counters , s_counters_ipb : t_counterArray( (2**g_ADDRWIDTH)-1 downto 0) := ( others => ( others => '0'));  -- registers to store counters

  signal s_counters , s_counters_ipb : ipb_reg_v( (2**g_ADDRWIDTH)-1 downto 0) := ( others => ( others => '0'));  -- registers to store counters
  signal s_resetLines : std_logic_vector( (2**g_ADDRWIDTH)-1 downto 0) := ( others => '0');  --! Take high to reset counter
  signal s_risingEdge : std_logic_vector( triggers_i'range) := ( others => '0');  -- pulses high for one clock cycle on rising edge of triggers_i
  signal s_counterIndex : integer := 0;
  signal s_ipbus_ack : std_logic := '0';  -- ! Acknowledge for IPBus strobe
  
begin

  gen_counters: for i_counter in 0 to (2**g_ADDRWIDTH)-1 generate

    -- Look for rising edge on input lines
    inst_edge_detect: entity work.risingEdgeDetect
      port map (
        clk_i   => counter_clk_i,
        level_i => triggers_i(i_counter),
        pulse_o => s_risingEdge(i_counter)
        );
      
    inst_counter: entity work.counterWithReset      
      generic map (
        g_COUNTER_WIDTH => g_DATAWIDTH)
      port map (
        clock_i  => counter_clk_i,
        reset_i  => s_resetLines(i_counter),
        enable_i => s_risingEdge(i_counter),
        result_o => s_counters(i_counter)
        );

  end generate gen_counters;

  -- Cross from counter clock to IPBus clock domain
  inst_sync_reg: entity work.synchronizeRegisters
    generic map (
      g_NUM_REGISTERS => 2**g_ADDRWIDTH)
    port map (
      clk_input_i  => counter_clk_i,
      data_i       => s_counters,
      data_o       => s_counters_ipb,
      clk_output_i => ipb_clk_i);


    
  -- Put the relevant counter onto the IPBus read port
  s_counterIndex  <= to_integer(unsigned(ipbus_i.ipb_addr(g_ADDRWIDTH-1 downto 0)));
  ipbus_o.ipb_rdata <= s_counters_ipb(s_counterIndex);
  
  p_ipbusWrite: process (ipb_clk_i) is
  begin  -- process p_ipbusWrite
    if rising_edge(ipb_clk_i) then
      if (ipbus_i.ipb_strobe = '1' and ipbus_i.ipb_write = '1') then
        s_resetLines( s_counterIndex ) <= '1' ;
      else
        s_resetLines <= ( others =>'0' );
      end if;
      
      s_ipbus_ack <= ipbus_i.ipb_strobe and not s_ipbus_ack;
       
    end if;       
  end process p_ipbusWrite;

  ipbus_o.ipb_ack <= s_ipbus_ack;
  ipbus_o.ipb_err <= '0';
  
end rtl;
