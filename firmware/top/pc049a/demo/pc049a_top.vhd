
--=============================================================================
--! @file pc049a_top.vhd
--=============================================================================
--
-------------------------------------------------------------------------------
-- --
-- University of Bristol, High Energy Physics Group.
-- --
------------------------------------------------------------------------------- --
-- VHDL Architecture work. pc049a_top.rtl
--
--! @brief Top level for single-MAROC eval board demo-design\n
--! \n
--
--! @author David Cussans , David.Cussans@bristol.ac.uk
--
--! @date 1/5/2014
--
--! @version v0.1
--
--! @details
--! Includes white-rabbit core, and IPBus core.
--!
--! <b>Dependencies:</b>\n
--!
--! <b>References:</b>\n
--!
--! <b>Modified by:</b>\n
--! Author: 
-------------------------------------------------------------------------------
--! \n\n<b>Last changes:</b>\n
-------------------------------------------------------------------------------
--! @todo <next thing to do> \n
--! <another thing to do> \n
--
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

-- Packages for White Rabbit
use work.gencores_pkg.all;
use work.wrcore_pkg.all;
use work.wr_fabric_pkg.all;
use work.wr_xilinx_pkg.all;
use work.etherbone_pkg.all;

-- Packages for IPBus
LIBRARY work;
USE work.ipbus.all;
USE work.emac_hostbus_decl.all;

library UNISIM;
use UNISIM.vcomponents.all;

library work;
use work.wishbone_pkg.all;


entity pc049a_top is
  generic
    (
      TAR_ADDR_WDTH : integer := 13     -- not used for this project
      );
  port
    (
      -- Global ports
      clk_20m_vcxo_i : in std_logic;    -- 20MHz VCXO clock

      clk_125m_pllref_p_i , clk_125m_pllref_n_i : in std_logic;  -- 125 MHz PLL reference

      fpga_pll_ref_clk_101_p_i , fpga_pll_ref_clk_101_n_i : in std_logic;  -- Dedicated clock for Xilinx GTP transceiver

      fpga_pll_ref_clk_123_p_i , fpga_pll_ref_clk_123_n_i : in std_logic;  -- Dedicated clock for Xilinx GTP transceiver

      si57x_clk_p_i , si57x_clk_n_i : in std_logic ; -- clock from si570 programmable oscillator. Default = 100MHz
      si57x_oe_o : out std_logic := '1'; -- Chip enable for SI570

      
      -- General Purpose Interface
      GPIO : inout std_logic_vector(7 downto 0);
  
      -- Push buttons
      button1_i : in std_logic := 'H';
      button2_i : in std_logic := 'H';

      -- LEDs and DIP switch
      leds_o : out std_logic_vector(4 downto 0);
      dip_switch_i : in std_logic_vector(3 downto 0);

      -- SPI interface for DACs that tune VCXO frequencies 
      pll25dac_sclk_o  : out std_logic;
      pll25dac_din_o   : out std_logic;
      -- dac_clr_n_o : out std_logic; -- not used.
      pll25dac1_sync_n_o : out std_logic;
      pll25dac2_sync_n_o : out std_logic;

      -- I2C bus
      fpga_scl_b : inout std_logic;
      fpga_sda_b : inout std_logic;
      
      one_wire_b : inout std_logic;      -- 1-Wire interface to DS18B20

      -------------------------------------------------------------------------
      -- SFP pins. White Rabbit=0 , IPBus=1
      -------------------------------------------------------------------------

      sfp_txp_o : out std_logic_vector(1 downto 0);
      sfp_txn_o : out std_logic_vector(1 downto 0);

      sfp_rxp_i : in std_logic_vector(1 downto 0);
      sfp_rxn_i : in std_logic_vector(1 downto 0);

      sfp_mod_def0_b    : in    std_logic_vector(1 downto 0);  -- sfp detect
      sfp_mod_def1_b    : inout std_logic_vector(1 downto 0);  -- scl
      sfp_mod_def2_b    : inout std_logic_vector(1 downto 0);  -- sda
      sfp_rate_select_b : inout std_logic_vector(1 downto 0);
      sfp_tx_fault_i    : in    std_logic_vector(1 downto 0);
      sfp_tx_disable_o  : out   std_logic_vector(1 downto 0);
      sfp_los_i         : in    std_logic_vector(1 downto 0);

     -------------------------------------------------------------------------
      -- eSATA pins. White Rabbit=0 , IPBus=1
      -------------------------------------------------------------------------

      sata_txp_o : out std_logic_vector(1 downto 0);
      sata_txn_o : out std_logic_vector(1 downto 0);

      sata_rxp_i : in std_logic_vector(1 downto 0);
      sata_rxn_i : in std_logic_vector(1 downto 0);

      -----------------------------------------
      --UART
      -----------------------------------------
      -- uart_rxd_i : in  std_logic;
      -- uart_txd_o : out std_logic;

      -----------------------------------------
      -- MAROC connections
      -----------------------------------------
      CK_40M_P_O,CK_40M_N_O : out STD_LOGIC;

      HOLD2_O: out STD_LOGIC;
      HOLD1_O: out STD_LOGIC;
      OR_I: in STD_LOGIC_VECTOR(1 downto 0);
      MAROC_TRIGGER_I: in std_logic_vector(63 downto 0);
      EN_OTAQ_O: out STD_LOGIC;
      CTEST_O: out STD_LOGIC_VECTOR(5 downto 0); -- 4-bit R/2R DAC
      ADC_DAV_I: in STD_LOGIC;
      OUT_ADC_I: in STD_LOGIC;
      START_ADC_N_O: out STD_LOGIC;
      RST_ADC_N_O: out STD_LOGIC;
      RST_SC_N_O: out STD_LOGIC;
      Q_SC_I: in STD_LOGIC;
      D_SC_O: out STD_LOGIC;
      RST_R_N_O: out STD_LOGIC;
      Q_R_I: in STD_LOGIC;
      D_R_O: out STD_LOGIC;
      CK_R_O: out STD_LOGIC;
      CK_SC_O: out STD_LOGIC;

      -----------------------------------------
      -- Expansion Connectors
      -----------------------------------------
      -- fixed direction for now....
      
      -- Data on left connector
      lvds_left_data_p_b, lvds_left_data_n_b:  out std_logic_vector(15 downto 0);
      lvds_left_clk_p_b,lvds_left_clk_n_b: in std_logic;

      -- Data on right connector
      lvds_right_data_p_b,lvds_right_data_n_b:  out std_logic_vector(15 downto 0);
      lvds_right_clk_p_b,lvds_right_clk_n_b: in std_logic;

      -- Global trigger lines
      lvds_globaltrig_from_fpga_p_o: out std_logic;
      lvds_globaltrig_from_fpga_n_o: out std_logic;
      enable_globaltrig_drive_o: out std_logic;
      lvds_globaltrig_to_fpga_p_i: in std_logic;
      lvds_globaltrig_to_fpga_n_i: in std_logic;

      -- "OR trigger" lines
      lvds_otrig_from_fpga_p_o: out std_logic;
      lvds_otrig_from_fpga_n_o: out std_logic;
      lvds_otrig_to_fpga_p_i: in std_logic;
      lvds_otrig_to_fpga_n_i: in std_logic;

      -- Global clock lines
      lvds_gclk_from_fpga_p_o: out std_logic;
      lvds_gclk_from_fpga_n_o: out std_logic;
      enable_gclk_drive_o: out std_logic;
      lvds_gclk_to_fpga_p_i: in std_logic;
      lvds_gclk_to_fpga_n_i: in std_logic

      -- Daughter-board SPI lines
      --dboard_miso_p_i : in std_logic;
      --dboard_miso_n_i : in std_logic;
      --dboard_sclk_p_o : out std_logic;
      --dboard_sclk_n_o : out std_logic;
      --dboard_mosi_p_o : out std_logic;
      --dboard_mosi_n_o : out std_logic;            
      --dboard_ssn_p_o : out std_logic;
      --dboard_ssn_n_o : out std_logic      
      
      );

end pc049a_top;

architecture rtl of pc049a_top is

  ------------------------------------------------------------------------------
  -- Components declaration
  ------------------------------------------------------------------------------

  component spec_reset_gen
    port (
      clk_sys_i        : in  std_logic;
      rst_button_n_a_i : in  std_logic;
      rst_n_o          : out std_logic);
  end component;

 
  ------------------------------------------------------------------------------
  -- Constants declaration
  ------------------------------------------------------------------------------
  constant c_BAR0_APERTURE     : integer := 20;
  constant c_CSR_WB_SLAVES_NB  : integer := 1;
  constant c_DMA_WB_SLAVES_NB  : integer := 1;
  constant c_DMA_WB_ADDR_WIDTH : integer := 26;

  ------------------------------------------------------------------------------
  -- Signals declaration
  ------------------------------------------------------------------------------

  signal  s_globaltrig_to_fpga, s_globaltrig_from_fpga : std_logic;
  signal  s_otrig_to_fpga , s_otrig_from_fpga : std_logic;
  signal  s_gclk_to_fpga , s_gclk_from_fpga : std_logic;

  -- signals for daugher-board SPI over LVDS connections.
  signal  s_dboard_mosi, s_dboard_ssn,s_dboard_sclk, s_dboard_miso : std_logic;
    
  -- Dedicated clock for GTP transceiver
  signal gtp_dedicated_clk : std_logic_vector(1 downto 0);

  -- P2L colck PLL status
  signal p2l_pll_locked : std_logic;

  -- Reset
  signal rst_a : std_logic;

  -- DMA wishbone bus
  --signal dma_adr     : std_logic_vector(31 downto 0);
  --signal dma_dat_i   : std_logic_vector((32*c_DMA_WB_SLAVES_NB)-1 downto 0);
  --signal dma_dat_o   : std_logic_vector(31 downto 0);
  --signal dma_sel     : std_logic_vector(3 downto 0);
  --signal dma_cyc     : std_logic;  --_vector(c_DMA_WB_SLAVES_NB-1 downto 0);
  --signal dma_stb     : std_logic;
  --signal dma_we      : std_logic;
  --signal dma_ack     : std_logic;  --_vector(c_DMA_WB_SLAVES_NB-1 downto 0);
  --signal dma_stall   : std_logic;  --_vector(c_DMA_WB_SLAVES_NB-1 downto 0);
  signal ram_we      : std_logic_vector(0 downto 0);
  signal ddr_dma_adr : std_logic_vector(29 downto 0);


  -- SPI
  signal spi_slave_select : std_logic_vector(7 downto 0);


  signal pllout_clk_sys       : std_logic;
  signal pllout_clk_dmtd      : std_logic;
  signal pllout_clk_fb_pllref : std_logic;
  signal pllout_clk_fb_dmtd   : std_logic;

  signal si57x_clk        : std_logic;
  signal clk_20m_vcxo_buf : std_logic;
  signal clk_125m_pllref  : std_logic;
  signal clk_sys          : std_logic;
  signal clk_dmtd         : std_logic;
  signal dac_rst_n        : std_logic;
  signal led_divider      : unsigned(23 downto 0);

  signal wrc_scl_o : std_logic;
  signal wrc_scl_i : std_logic;
  signal wrc_sda_o : std_logic;
  signal wrc_sda_i : std_logic;

  signal sfp_scl_o : std_logic_vector(1 downto 0);
  signal sfp_scl_i : std_logic_vector(1 downto 0);
  signal sfp_sda_o : std_logic_vector(1 downto 0);
  signal sfp_sda_i : std_logic_vector(1 downto 0);
  
  signal dio       : std_logic_vector(3 downto 0);

  signal dac_hpll_load_p1 : std_logic;
  signal dac_dpll_load_p1 : std_logic;
  signal dac_hpll_data    : std_logic_vector(15 downto 0);
  signal dac_dpll_data    : std_logic_vector(15 downto 0);

  signal pps     : std_logic;
  signal pps_led : std_logic;

  signal phy_tx_data      : std_logic_vector(7 downto 0);
  signal phy_tx_k         : std_logic;
  signal phy_tx_disparity : std_logic;
  signal phy_tx_enc_err   : std_logic;
  signal phy_rx_data      : std_logic_vector(7 downto 0);
  signal phy_rx_rbclk     : std_logic;
  signal phy_rx_k         : std_logic;
  signal phy_rx_enc_err   : std_logic;
  signal phy_rx_bitslide  : std_logic_vector(3 downto 0);
  signal phy_rst          : std_logic;
  signal phy_loopen       : std_logic;

  signal dio_in  : std_logic_vector(4 downto 0);
  signal dio_out : std_logic_vector(4 downto 0);
  signal dio_clk : std_logic;

  signal local_reset_n  : std_logic;
  signal button1_synced : std_logic_vector(2 downto 0);

  signal genum_wb_out    : t_wishbone_master_out;
  signal genum_wb_in     : t_wishbone_master_in;
  signal genum_csr_ack_i : std_logic;

  signal wrc_slave_i : t_wishbone_slave_in;
  signal wrc_slave_o : t_wishbone_slave_out;

  signal owr_en : std_logic_vector(1 downto 0);
  signal owr_i  : std_logic_vector(1 downto 0);

  signal wb_adr : std_logic_vector(31 downto 0);  --c_BAR0_APERTURE-priv_log2_ceil(c_CSR_WB_SLAVES_NB+1)-1 downto 0);

  signal etherbone_rst_n   : std_logic;
  signal etherbone_src_out : t_wrf_source_out;
  signal etherbone_src_in  : t_wrf_source_in;
  signal etherbone_snk_out : t_wrf_sink_out;
  signal etherbone_snk_in  : t_wrf_sink_in;
  signal etherbone_wb_out  : t_wishbone_master_out;
  signal etherbone_wb_in   : t_wishbone_master_in;
  signal etherbone_cfg_in  : t_wishbone_slave_in;
  signal etherbone_cfg_out : t_wishbone_slave_out;

  constant c_NMAROC_SLAVES     : integer := 5;
  -- expansion IO block has one IPBus slave.
  constant c_NSLAVES : positive := c_NMAROC_SLAVES+1;   -- number of IPBus slaves in system
  signal s_ipb_clk : std_logic;
  signal s_ipb_wbus : ipb_wbus_array(c_NSLAVES-1 downto 0);
  signal s_ipb_rbus : ipb_rbus_array(c_NSLAVES-1 downto 0);
  signal s_ipb_rst : std_logic := '0';

  signal s_phy_rstb : std_logic;
  signal s_clk_logic_xtal : std_logic;

  -- Signals that used to be connected at the top level...
  signal uart_rxd , uart_txd  :  std_logic;

  --signal dboard_miso_p_i :  std_logic;
  --signal dboard_miso_n_i :  std_logic;
  --signal dboard_sclk_p_o :  std_logic;
  --signal dboard_sclk_n_o :  std_logic;
  --signal dboard_mosi_p_o :  std_logic;
  --signal dboard_mosi_n_o :  std_logic;            
  --signal dboard_ssn_p_o  :  std_logic;
  --signal dboard_ssn_n_o  :  std_logic;
--

begin

  cmp_sys_clk_pll : PLL_BASE
    generic map (
      BANDWIDTH          => "OPTIMIZED",
      CLK_FEEDBACK       => "CLKFBOUT",
      COMPENSATION       => "INTERNAL",
      DIVCLK_DIVIDE      => 1,
      CLKFBOUT_MULT      => 8,
      CLKFBOUT_PHASE     => 0.000,
      CLKOUT0_DIVIDE     => 16,         -- 62.5 MHz
      CLKOUT0_PHASE      => 0.000,
      CLKOUT0_DUTY_CYCLE => 0.500,
      CLKOUT1_DIVIDE     => 16,         -- 125 MHz
      CLKOUT1_PHASE      => 0.000,
      CLKOUT1_DUTY_CYCLE => 0.500,
      CLKOUT2_DIVIDE     => 16,
      CLKOUT2_PHASE      => 0.000,
      CLKOUT2_DUTY_CYCLE => 0.500,
      CLKIN_PERIOD       => 8.0,
      REF_JITTER         => 0.016)
    port map (
      CLKFBOUT => pllout_clk_fb_pllref,
      CLKOUT0  => pllout_clk_sys,
      CLKOUT1  => open,
      CLKOUT2  => open,
      CLKOUT3  => open,
      CLKOUT4  => open,
      CLKOUT5  => open,
      LOCKED   => open,
      RST      => '0',
      CLKFBIN  => pllout_clk_fb_pllref,
      CLKIN    => clk_125m_pllref);

  cmp_dmtd_clk_pll : PLL_BASE
    generic map (
      BANDWIDTH          => "OPTIMIZED",
      CLK_FEEDBACK       => "CLKFBOUT",
      COMPENSATION       => "INTERNAL",
      DIVCLK_DIVIDE      => 1,
      CLKFBOUT_MULT      => 50,
      CLKFBOUT_PHASE     => 0.000,
      CLKOUT0_DIVIDE     => 16,         -- 62.5 MHz
      CLKOUT0_PHASE      => 0.000,
      CLKOUT0_DUTY_CYCLE => 0.500,
      CLKOUT1_DIVIDE     => 16,         -- 62.5 MHz
      CLKOUT1_PHASE      => 0.000,
      CLKOUT1_DUTY_CYCLE => 0.500,
      CLKOUT2_DIVIDE     => 8,
      CLKOUT2_PHASE      => 0.000,
      CLKOUT2_DUTY_CYCLE => 0.500,
      CLKIN_PERIOD       => 50.0,
      REF_JITTER         => 0.016)
    port map (
      CLKFBOUT => pllout_clk_fb_dmtd,
      CLKOUT0  => pllout_clk_dmtd,
      CLKOUT1  => open,
      CLKOUT2  => open,
      CLKOUT3  => open,
      CLKOUT4  => open,
      CLKOUT5  => open,
      LOCKED   => open,
      RST      => '0',
      CLKFBIN  => pllout_clk_fb_dmtd,
      CLKIN    => clk_20m_vcxo_buf);

  U_Reset_Gen : spec_reset_gen
    port map (
      clk_sys_i        => clk_sys,
      rst_button_n_a_i => button1_i,
      rst_n_o          => local_reset_n);

  cmp_clk_sys_buf : BUFG
    port map (
      O => clk_sys,
      I => pllout_clk_sys);

  cmp_clk_dmtd_buf : BUFG
    port map (
      O => clk_dmtd,
      I => pllout_clk_dmtd);

  cmp_clk_vcxo : BUFG
    port map (
      O => clk_20m_vcxo_buf,
      I => clk_20m_vcxo_i);


  cmp_pllrefclk_buf : IBUFGDS
    generic map (
      DIFF_TERM    => true,             -- Differential Termination
      IBUF_LOW_PWR => true,  -- Low power (TRUE) vs. performance (FALSE) setting for referenced I/O standards
      IOSTANDARD   => "DEFAULT")
    port map (
      O  => clk_125m_pllref,            -- Buffer output
      I  => clk_125m_pllref_p_i,  -- Diff_p buffer input (connect directly to top-level port)
      IB => clk_125m_pllref_n_i  -- Diff_n buffer input (connect directly to top-level port)
      );


  ------------------------------------------------------------------------------
  -- Dedicated clock for GTP used for WhiteRabbit
  ------------------------------------------------------------------------------
  cmp_gtp_dedicated_clk_buf0 : IBUFGDS
    generic map(
      DIFF_TERM    => true,
      IBUF_LOW_PWR => true,
      IOSTANDARD   => "DEFAULT")
    port map (
      O  => gtp_dedicated_clk(0),
      I  => fpga_pll_ref_clk_101_p_i,
      IB => fpga_pll_ref_clk_101_n_i
      );

  ------------------------------------------------------------------------------
  -- Active high reset
  ------------------------------------------------------------------------------

  process(clk_sys)
  begin
    if rising_edge(clk_sys) then
      led_divider <= led_divider + 1;
    end if;
  end process;

  fpga_scl_b <= '0' when wrc_scl_o = '0' else 'Z';
  fpga_sda_b <= '0' when wrc_sda_o = '0' else 'Z';
  wrc_scl_i  <= fpga_scl_b;
  wrc_sda_i  <= fpga_sda_b;

  -- SFP control signals for White-Rabit SFP
  sfp_mod_def1_b(0) <= '0' when sfp_scl_o(0) = '0' else 'Z';
  sfp_mod_def2_b(0) <= '0' when sfp_sda_o(0) = '0' else 'Z';
  sfp_scl_i(0)      <= sfp_mod_def1_b(0);
  sfp_sda_i(0)      <= sfp_mod_def2_b(0);
  sfp_tx_disable_o(0) <= '0';
  
  one_wire_b <= '0' when owr_en(0) = '1' else 'Z';
  owr_i(0)  <= one_wire_b;

  U_WR_CORE : xwr_core
    generic map (
      g_simulation                => 0,
      g_with_external_clock_input => true,
      --
      g_phys_uart                 => true,
      g_virtual_uart              => true,
      g_aux_clks                  => 1,
      g_ep_rxbuf_size             => 1024,
      g_dpram_initf               => "wrc.ram",
      g_dpram_size                => 90112/4,  --16384,
      g_interface_mode            => PIPELINED,
      g_address_granularity       => BYTE)
    port map (
      clk_sys_i  => clk_sys,
      clk_dmtd_i => clk_dmtd,
      clk_ref_i  => clk_125m_pllref,
      clk_aux_i  => (others => '0'),
      clk_ext_i  => dio_clk,
      pps_ext_i  => dio_in(3),
      rst_n_i    => local_reset_n,

      dac_hpll_load_p1_o => dac_hpll_load_p1,
      dac_hpll_data_o    => dac_hpll_data,
      dac_dpll_load_p1_o => dac_dpll_load_p1,
      dac_dpll_data_o    => dac_dpll_data,

      phy_ref_clk_i      => clk_125m_pllref,
      phy_tx_data_o      => phy_tx_data,
      phy_tx_k_o         => phy_tx_k,
      phy_tx_disparity_i => phy_tx_disparity,
      phy_tx_enc_err_i   => phy_tx_enc_err,
      phy_rx_data_i      => phy_rx_data,
      phy_rx_rbclk_i     => phy_rx_rbclk,
      phy_rx_k_i         => phy_rx_k,
      phy_rx_enc_err_i   => phy_rx_enc_err,
      phy_rx_bitslide_i  => phy_rx_bitslide,
      phy_rst_o          => phy_rst,
      phy_loopen_o       => phy_loopen,

      led_act_o   => leds_o(0),
      led_link_o  => leds_o(1),
      scl_o       => wrc_scl_o,
      scl_i       => wrc_scl_i,
      sda_o       => wrc_sda_o,
      sda_i       => wrc_sda_i,
      sfp_scl_o   => sfp_scl_o(0),
      sfp_scl_i   => sfp_scl_i(0),
      sfp_sda_o   => sfp_sda_o(0),
      sfp_sda_i   => sfp_sda_i(0),
      sfp_det_i   => sfp_mod_def0_b(0),
      btn1_i      => button1_i,
      btn2_i      => button2_i,

      uart_rxd_i => uart_rxd,
      uart_txd_o => uart_txd,

      owr_en_o => owr_en,
      owr_i    => owr_i,

      slave_i => wrc_slave_i,
      slave_o => wrc_slave_o,

      aux_master_o => etherbone_cfg_in,
      aux_master_i => etherbone_cfg_out,

      wrf_src_o => etherbone_snk_in,
      wrf_src_i => etherbone_snk_out,
      wrf_snk_o => etherbone_src_in,
      wrf_snk_i => etherbone_src_out,

      tm_dac_value_o       => open,
      tm_dac_wr_o          => open,
      tm_clk_aux_lock_en_i => (others=>'0'),
      tm_clk_aux_locked_o  => open,
      tm_time_valid_o      => open,
      tm_tai_o             => open,
      tm_cycles_o          => open,
      pps_p_o              => pps,
      pps_led_o            => pps_led,

      dio_o       => dio_out(4 downto 1),
      rst_aux_n_o => etherbone_rst_n
      );

  Etherbone : eb_slave_core
    generic map (
      g_sdb_address => x"0000000000030000")
    port map (
      clk_i       => clk_sys,
      nRst_i      => etherbone_rst_n,
      src_o       => etherbone_src_out,
      src_i       => etherbone_src_in,
      snk_o       => etherbone_snk_out,
      snk_i       => etherbone_snk_in,
      cfg_slave_o => etherbone_cfg_out,
      cfg_slave_i => etherbone_cfg_in,
      master_o    => etherbone_wb_out,
      master_i    => etherbone_wb_in);

  ---------------------
  masterbar : xwb_crossbar
    generic map (
      g_num_masters => 2,
      g_num_slaves  => 1,
      g_registered  => false,
      g_address     => (0 => x"00000000"),
      g_mask        => (0 => x"00000000"))
    port map (
      clk_sys_i   => clk_sys,
      rst_n_i     => local_reset_n,
      slave_i(0)  => genum_wb_out,
      slave_i(1)  => etherbone_wb_out,
      slave_o(0)  => genum_wb_in,
      slave_o(1)  => etherbone_wb_in,
      master_i(0) => wrc_slave_o,
      master_o(0) => wrc_slave_i);

  ---------------------

  U_GTP : wr_gtp_phy_spartan6
    generic map (
      g_enable_ch0 => 0,
      g_enable_ch1 => 1,
      g_simulation => 0)
    port map (
      gtp_clk_i => gtp_dedicated_clk(0),

      ch0_ref_clk_i      => clk_125m_pllref,
      ch0_tx_data_i      => x"00",
      ch0_tx_k_i         => '0',
      ch0_tx_disparity_o => open,
      ch0_tx_enc_err_o   => open,
      ch0_rx_rbclk_o     => open,
      ch0_rx_data_o      => open,
      ch0_rx_k_o         => open,
      ch0_rx_enc_err_o   => open,
      ch0_rx_bitslide_o  => open,
      ch0_rst_i          => '1',
      ch0_loopen_i       => '0',

      ch1_ref_clk_i      => clk_125m_pllref,
      ch1_tx_data_i      => phy_tx_data,
      ch1_tx_k_i         => phy_tx_k,
      ch1_tx_disparity_o => phy_tx_disparity,
      ch1_tx_enc_err_o   => phy_tx_enc_err,
      ch1_rx_data_o      => phy_rx_data,
      ch1_rx_rbclk_o     => phy_rx_rbclk,
      ch1_rx_k_o         => phy_rx_k,
      ch1_rx_enc_err_o   => phy_rx_enc_err,
      ch1_rx_bitslide_o  => phy_rx_bitslide,
      ch1_rst_i          => phy_rst,
      ch1_loopen_i       => phy_loopen,
		
		-- Connections to GTP tile. 0 = sata connector, 1 = SFP
      pad_txn0_o         => sata_txp_o(0),
      pad_txp0_o         => sata_txn_o(0),
      pad_rxn0_i         => sata_rxp_i(0),
      pad_rxp0_i         => sata_rxn_i(0),
      pad_txn1_o         => sfp_txn_o(0),
      pad_txp1_o         => sfp_txp_o(0),
      pad_rxn1_i         => sfp_rxn_i(0),
      pad_rxp1_i         => sfp_rxp_i(0)
      );

  

  
  U_DAC_ARB : spec_serial_dac_arb
    generic map (
      g_invert_sclk    => false,
      g_num_extra_bits => 8)

    port map (
      clk_i   => clk_sys,
      rst_n_i => local_reset_n,

      val1_i  => dac_dpll_data,
      load1_i => dac_dpll_load_p1,

      val2_i  => dac_hpll_data,
      load2_i => dac_hpll_load_p1,

      dac_cs_n_o(0) => pll25dac1_sync_n_o,
      dac_cs_n_o(1) => pll25dac2_sync_n_o,
      dac_clr_n_o   => open, -- Not used 
      dac_sclk_o    => pll25dac_sclk_o,
      dac_din_o     => pll25dac_din_o);


  U_Extend_PPS : gc_extend_pulse
    generic map (
      g_width => 10000000)
    port map (
      clk_i      => clk_125m_pllref,
      rst_n_i    => local_reset_n,
      pulse_i    => pps_led,
      extended_o => leds_o(4) );


  si57x_oe_o <= '1';  


  -------------------------------------------------------------------------
  -- Instantiate MAROC interface
  -------------------------------------------------------------------------

  -- FIXME - s_ipb_rst should be connected to something sensible...
  
    maroc: entity work.marocInterface 
    generic map (
      g_NSLAVES => c_NMAROC_SLAVES)  -- number of IPBus slaves inside the maroc interface.
    port map (
      -- Interface to IPBus
      ipb_clk_i => s_ipb_clk,
      ipb_in  => s_ipb_wbus(c_NMAROC_SLAVES-1 downto 0),
      ipb_out => s_ipb_rbus(c_NMAROC_SLAVES-1 downto 0),
      rst_i => s_ipb_rst,
      
    -- fast clock
      clk_fast_i => clk_125m_pllref,
      
    -- Trigger signals
      external_Trigger_i => s_globaltrig_to_fpga,
      trigger_o => s_globaltrig_from_fpga,
    
      -- Pins connected to MAROC
      CK_40M_P_O => CK_40M_P_O,
      CK_40M_N_O => CK_40M_N_O,
      HOLD2_O => HOLD2_O,
      HOLD1_O =>  HOLD1_O,
      OR_I => OR_I,
      MAROC_TRIGGER_I => MAROC_TRIGGER_I,
      EN_OTAQ_O =>  EN_OTAQ_O,
      CTEST_O =>  CTEST_O,
      ADC_DAV_I => ADC_DAV_I,
      OUT_ADC_I => OUT_ADC_I,
      START_ADC_N_O => START_ADC_N_O,
      RST_ADC_N_O => RST_ADC_N_O,
      RST_SC_N_O => RST_SC_N_O,
      Q_SC_I => Q_SC_I,
      D_SC_O =>  D_SC_O,
      RST_R_N_O => RST_R_N_O,
      Q_R_I =>  Q_R_I,
      D_R_O => D_R_O,
      CK_R_O => CK_R_O,
      CK_SC_O => CK_SC_O
      );

  -----------------------------------------
  -- Differential Buffers
  -----------------------------------------

  -- For global (bussed) trigger
  gtrig_ibuf : IBUFDS
      generic map (
        DIFF_TERM => true)
      port map (
        O  => s_globaltrig_to_fpga,
        I  => lvds_globaltrig_to_fpga_p_i,
        IB => lvds_globaltrig_to_fpga_n_i
        );

    gtrig_obuf : OBUFDS
      port map (
        I  => s_globaltrig_from_fpga,
        O  => lvds_globaltrig_from_fpga_p_o,
        OB => lvds_globaltrig_from_fpga_n_o
        );


  -- For "Or trigger" - input is "ORed" with local trigger then sent on
  otrig_ibuf : IBUFDS
      generic map (
        DIFF_TERM => true)
      port map (
        O  => s_otrig_to_fpga,
        I  => lvds_otrig_to_fpga_p_i,
        IB => lvds_otrig_to_fpga_n_i
        );

    otrig_obuf : OBUFDS
      port map (
        I  => s_otrig_from_fpga,
        O  => lvds_otrig_from_fpga_p_o,
        OB => lvds_otrig_from_fpga_n_o
        );

  -- Differential Buffers for bussed clock
  gclk_ibuf : IBUFGDS
      generic map (
        DIFF_TERM => true)
      port map (
        O  => s_gclk_to_fpga,
        I  => lvds_gclk_to_fpga_p_i,
        IB => lvds_gclk_to_fpga_n_i
        );

    gclk_obuf : OBUFDS
      port map (
        I  => s_gclk_from_fpga,
        O  => lvds_gclk_from_fpga_p_o,
        OB => lvds_gclk_from_fpga_n_o
        );

  
  -- FIXME - dummy bodge for now, connect input to output
  p_register_data: process (s_gclk_to_fpga) is
  begin  -- process p_register_data
    if rising_edge(s_gclk_to_fpga) then
      s_otrig_from_fpga <= s_otrig_to_fpga;
      s_gclk_from_fpga <= s_otrig_to_fpga;
    end if;
  end process p_register_data;
  


  --FIXME this doesn't make much sense but drive to global clock and trigger 
  enable_gclk_drive_o <= '1';
  enable_globaltrig_drive_o <= '1';

  --
  -- Differential buffers to Daughter-board SPI connection
  --dboard_mosi_obuf : OBUFDS
  --  port map (
  --    I  => s_dboard_mosi,
  --    O  => dboard_mosi_p_o,
  --    OB => dboard_mosi_n_o
  --    );

  --dboard_ssn_obuf : OBUFDS
  --  port map (
  --    I  => s_dboard_ssn,
  --    O  => dboard_ssn_p_o,
  --    OB => dboard_ssn_n_o
  --    );

  --dboard_sclk_obuf : OBUFDS
  --  port map (
  --    I  => s_dboard_sclk,
  --    O  => dboard_sclk_p_o,
  --    OB => dboard_sclk_n_o
  --    );

  --dboard_miso_ibuf : IBUFDS
  --    generic map (
  --      DIFF_TERM => true)
  --    port map (
  --      O  => s_dboard_miso,
  --      I  => dboard_miso_p_i,
  --      IB => dboard_miso_n_i
  --      );

  -- FIXME dummy wiring to stop buffers being optimized away.
  --s_dboard_mosi <= s_dboard_miso;
  --s_dboard_ssn <= s_dboard_miso;
  --s_dboard_sclk <= s_dboard_miso;

  -- FIXME - loop dip_switches to gpio to stop GPIO being optimized away
  gpio(3 downto 0) <= dip_switch_i;
  gpio(4) <= si57x_clk;
  gpio(5) <= '0';
  gpio(6) <= uart_txd;
  uart_rxd <= gpio(7);
  
  -- FIXME - buffer input clock signal to avoid optimiziation
  cmp_si57x_buffer : IBUFGDS
    generic map(
      DIFF_TERM    => true,
      IBUF_LOW_PWR => true,
      IOSTANDARD   => "DEFAULT")
    port map (
      O  => si57x_clk,
      I  => si57x_clk_p_i ,
      IB => si57x_clk_n_i 
      );

  -- FIXME - connnect input to output to avoid optimization.
  sfp_rate_select_b <= sfp_los_i or sfp_tx_fault_i;
  -----------------------------------------------------------------------------
  -- IPBus interface
  -----------------------------------------------------------------------------

  IPBusInterface_inst : entity work.IPBusInterfaceGTP
    GENERIC MAP (
      NUM_EXT_SLAVES => 6
      )
    PORT MAP (
		
      -- dedicated clock to GTP tile.
      gtp_clkp	=> fpga_pll_ref_clk_123_p_i,
      gtp_clkn	=> fpga_pll_ref_clk_123_n_i,
		  
      -- Serial I/O to GTP on Spartan-6
      gtp_txp	        => sfp_txp_o(1),
      gtp_txn	        => sfp_txn_o(1),
      gtp_rxp	        => sfp_rxp_i(1),
      gtp_rxn	        => sfp_rxn_i(1),
      sfp_los	        => sfp_los_i(1),

      -- SFP control lines.
      sfp_scl_o   => sfp_scl_o(1),
      sfp_scl_i   => sfp_scl_i(1),
      sfp_sda_o   => sfp_sda_o(1),
      sfp_sda_i   => sfp_sda_i(1),
      sfp_det_i   => sfp_mod_def0_b(1),
      
      -- SATA connector
      gtp_aux_txp	        => sata_txp_o(1),
      gtp_aux_txn	        => sata_txn_o(1),
      gtp_aux_rxp	        => sata_rxp_i(1),
      gtp_aux_rxn	        => sata_rxn_i(1),
 
      ipbr_i           => s_ipb_rbus,
      sysclk_i         => clk_125m_pllref,
      clocks_locked_o  => leds_o(2),

      ipb_clk_o        => s_ipb_clk,
      ipb_rst_o        => s_ipb_rst,
      ipbw_o           => s_ipb_wbus,
      onehz_o          => leds_o(3),
      phy_rstb_o       => s_phy_rstb,
      dip_switch_i     => dip_switch_i,
      clk_logic_xtal_o => s_clk_logic_xtal
      );

  -- SFP control signals for IPBus SFP
  sfp_mod_def1_b(1) <= '0' when sfp_scl_o(1) = '0' else 'Z';
  sfp_mod_def2_b(1) <= '0' when sfp_sda_o(1) = '0' else 'Z';
  sfp_scl_i(1)      <= sfp_mod_def1_b(1);
  sfp_sda_i(1)      <= sfp_mod_def2_b(1);
  sfp_tx_disable_o(1) <= '0';
  
  -----------------------------------------------------------------------------
  --  expansionIO_inst :
  -----------------------------------------------------------------------------
  ExpansionIO_inst : entity work.ExpansionIO
    port map (
      -- IPBus
      ipbus_clk_i   => s_ipb_clk,
      ipbus_reset_i => s_ipb_rst,
      ipbus_wbus_i  => s_ipb_wbus(5),
      ipbus_rbus_o  => s_ipb_rbus(5),

      -- Data....
      lvds_left_data_p_b => lvds_left_data_p_b,
      lvds_left_data_n_b => lvds_left_data_n_b,
      lvds_left_clk_p_b =>  lvds_left_clk_p_b,
      lvds_left_clk_n_b =>  lvds_left_clk_n_b,
      lvds_right_data_p_b => lvds_right_data_p_b ,
      lvds_right_data_n_b => lvds_right_data_n_b ,
      lvds_right_clk_p_b =>  lvds_right_clk_p_b,
      lvds_right_clk_n_b =>  lvds_right_clk_n_b
      );

  
  
end rtl;


