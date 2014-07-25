--
-- Dummy block for data I/O
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use ieee.numeric_std.all;

-- Packages for IPBus
LIBRARY work;
USE work.ipbus.all;

library UNISIM;
use UNISIM.vcomponents.all;

entity ExpansionIO is
  generic (
    g_NEXPANSION_BITS : positive := 16);
  port (

    -- IPBus
    ipbus_clk_i: in STD_LOGIC;
    ipbus_reset_i: in STD_LOGIC;
    ipbus_wbus_i: in ipb_wbus;
    ipbus_rbus_o: out ipb_rbus;

    -- Data....
    lvds_left_data_p_b, lvds_left_data_n_b : out std_logic_vector(g_NEXPANSION_BITS-1 downto 0);
    lvds_left_clk_p_b, lvds_left_clk_n_b   : in std_logic; -- clock for data on left hand I/O

    lvds_right_data_p_b, lvds_right_data_n_b : out std_logic_vector(g_NEXPANSION_BITS-1 downto 0);
    lvds_right_clk_p_b, lvds_right_clk_n_b   : in std_logic -- clock for data on left hand I/O

    );  

end entity ExpansionIO;

architecture rtl of ExpansionIO is

  signal s_spydata, s_ctrl_reg: std_logic_vector(31 downto 0);
  signal s_data_direction : std_logic := '0';  -- 1 = left to right ( left rx,
                                               -- right tx ),
                                               -- 0 = right to left ( right rx
                                               -- left tx )

  signal s_left_counter , s_right_counter : unsigned( g_NEXPANSION_BITS-1 downto 0) := ( others => '0');
  
  signal s_data_right_from_connector ,
    s_data_right_to_connector ,
    s_data_left_from_connector ,
    s_data_left_to_connector ,
    s_data_r1 , s_data_r2 , s_data_r3: std_logic_vector(g_NEXPANSION_BITS-1 downto 0);
  
  signal s_right_clk_from_connector,
    s_right_clk_to_connector,
    s_left_clk_from_connector,
    s_left_clk_to_connector , s_data_clk : std_logic;
  
begin  -- architecture rtl

  controlReg: entity work.ipbus_ctrlreg
    port map(
      clk => ipbus_clk_i,
      reset => ipbus_reset_i,
      ipbus_in => ipbus_wbus_i,
      ipbus_out => ipbus_rbus_o,
      d => s_spydata,
      q => s_ctrl_reg
      );
  
  s_data_direction <= s_ctrl_reg(0);

  --
  gen_iobuf: for dataBit in 0 to g_NEXPANSION_BITS-1 generate

    cmp_IOBUFDS_left : OBUFDS
      generic map (
        IOSTANDARD => "DEFAULT"
        )
      port map (
        O  => lvds_left_data_p_b(dataBit), -- Diff_p inout (connect directly to top-level port)
        OB => lvds_left_data_n_b(dataBit), -- Diff_n inout (connect directly to top-level port)
        I   => s_data_left_to_connector(dataBit) -- Buffer input
        );

    cmp_IOBUFDS_right : OBUFDS
      generic map (
        IOSTANDARD => "DEFAULT"
        )
      port map (
        O  => lvds_right_data_p_b(dataBit), -- Diff_p inout (connect directly to top-level port)
        OB => lvds_right_data_n_b(dataBit), -- Diff_n inout (connect directly to top-level port)
        I   => s_data_right_to_connector(dataBit) -- Buffer input
        );
    
  end generate gen_iobuf;


  cmp_IOBUFDS_left_clk :  IBUFGDS
      generic map (
        IOSTANDARD => "DEFAULT",
        DIFF_TERM => TRUE
        )
      port map (
        O   => s_left_clk_from_connector, -- Buffer output
        I  => lvds_left_clk_p_b, -- Diff_p inout (connect directly to top-level port)
        IB => lvds_left_clk_n_b -- Diff_n inout (connect directly to top-level port)
        );

    cmp_IOBUFDS_right_clk :  IBUFGDS
      generic map (
        IOSTANDARD => "DEFAULT",
        DIFF_TERM => TRUE
        )
      port map (
        O   => s_right_clk_from_connector, -- Buffer output
        I  => lvds_right_clk_p_b, -- Diff_p inout (connect directly to top-level port)
        IB => lvds_right_clk_n_b -- Diff_n inout (connect directly to top-level port)
        );
  

  -- purpose: output counter
  -- type   : combinational
  -- inputs : s_left_clk_from_connector
  -- outputs: 
  p_register_left_data: process (s_left_clk_from_connector) is
  begin  -- process p_register_data

    if rising_edge(s_left_clk_from_connector) then

      s_left_counter <= s_left_counter + 1;
      s_data_left_to_connector <= std_logic_vector(s_left_counter);
            
    end if;

  end process p_register_left_data;

    -- purpose: output counter
  -- type   : combinational
  -- inputs : s_left_clk_from_connector
  -- outputs: 
  p_register_right_data: process (s_right_clk_from_connector) is
  begin  -- process p_register_data

    if rising_edge(s_right_clk_from_connector) then

      s_right_counter <= s_right_counter + 1;
      s_data_right_to_connector <= std_logic_vector(s_right_counter);
            
    end if;

  end process p_register_right_data;
  
  
end architecture rtl;
