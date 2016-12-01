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
--! @brief Top level for single-MAROC eval board simple-design. No White Rabbit\n
--! \n
--
--! @author David Cussans , David.Cussans@bristol.ac.uk
--
--! @date 6/10/2016
--
--! @version v0.1
--
--! @details
--! Includes Maroc IPBus slaves and IPBus core.
--! LEDs:
--! LED(2) - IPBus clocks locked. ( should be on )
--! LED(3) - One Hz heart-beat    ( should strobe at 1Hz)
--! LED(4) - LOS for IPBus SFP    ( should be off )
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
      BUILD_SIMULATED_ETHERNET : integer := 0 --! set to 1 to build with simulated Ethernet interface using Modelsim FLI
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
      pll25dac_sclk_o  : out std_logic := '0';
      pll25dac_din_o   : out std_logic := '0';
      pll25dac1_sync_n_o : out std_logic := '1';
      pll25dac2_sync_n_o : out std_logic := '1';

      -- I2C bus
      fpga_scl_b : inout std_logic;
      fpga_sda_b : inout std_logic;
      
      one_wire_b : inout std_logic;      -- 1-Wire interface to DS18B20

      -------------------------------------------------------------------------
      -- SFP pins.
      -------------------------------------------------------------------------

      sfp_txp_o : out std_logic;
      sfp_txn_o : out std_logic;

      sfp_rxp_i : in std_logic;
      sfp_rxn_i : in std_logic;

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

      sata_txp_o : out std_logic;
      sata_txn_o : out std_logic;

      sata_rxp_i : in std_logic;
      sata_rxn_i : in std_logic;

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
      OR_I: in STD_LOGIC_VECTOR(2 downto 1);
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

  --! I2C signals from white rabbit core.
  signal wrc_scl_o : std_logic := '1'; --! By default, don't drive from WRC.
  signal wrc_scl_i : std_logic := '1'; --! ... ie. set high.
  signal wrc_sda_o : std_logic;
  signal wrc_sda_i : std_logic;

  --! I2C signals from IPBus.
  signal ipb_scl_o : std_logic := '1'; --! By default, don't drive from IPBus
  signal ipb_scl_i : std_logic := '1'; --! ... ie. set high.
  signal ipb_sda_o : std_logic;
  signal ipb_sda_i : std_logic;

  signal sfp_scl_o : std_logic_vector(1 downto 0) := ( others => '0' );
  signal sfp_scl_i : std_logic_vector(1 downto 0);
  signal sfp_sda_o : std_logic_vector(1 downto 0);
  signal sfp_sda_i : std_logic_vector(1 downto 0);

  --! White Rabbit Signals
  signal dio       : std_logic_vector(3 downto 0);

  signal dac_hpll_load_p1 : std_logic;
  signal dac_dpll_load_p1 : std_logic;
  signal dac_hpll_data    : std_logic_vector(15 downto 0);
  signal dac_dpll_data    : std_logic_vector(15 downto 0);

  signal pps     : std_logic;
  signal pps_led : std_logic;

  signal phy_tx_data      : std_logic_vector(7 downto 0);
  signal phy_tx_k         : std_logic;
--  signal phy_tx_k         : std_logic_vector(1 downto 0);
  signal phy_tx_disparity : std_logic;
  signal phy_tx_enc_err   : std_logic;
  signal phy_rx_data      : std_logic_vector(7 downto 0);
  signal phy_rx_rbclk     : std_logic;
  signal phy_rx_k         : std_logic;
--  signal phy_rx_k         : std_logic_vector(1 downto 0);
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

  constant c_NMAROC_SLAVES     : integer := 6;
  -- expansion IO block has one IPBus slave. I2C has another
  constant c_NSLAVES : positive := c_NMAROC_SLAVES+2;   -- number of IPBus slaves in system
  signal s_ipb_clk : std_logic;
  signal s_ipb_wbus : ipb_wbus_array(c_NSLAVES-1 downto 0);
  signal s_ipb_rbus : ipb_rbus_array(c_NSLAVES-1 downto 0);
  signal s_ipb_rst : std_logic := '0';

  signal s_phy_rstb : std_logic;
  signal s_clk_logic_xtal : std_logic;

  -- Signals that used to be connected at the top level...
  signal uart_rxd , uart_txd  :  std_logic;

  -- FIXME Move to separate process
  
  signal s_ADC_DAV_d1, s_ADC_DAV_d2: STD_LOGIC;
  signal s_OUT_ADC_d1, s_OUT_ADC_d2:  STD_LOGIC;

  attribute shreg_extract : string; -- Don't want synchronizer registers optimized to SRL16
  attribute shreg_extract of s_ADC_DAV_d1: signal is "no";
  attribute shreg_extract of s_ADC_DAV_d2: signal is "no";
  attribute shreg_extract of s_OUT_ADC_d1: signal is "no";
  attribute shreg_extract of s_OUT_ADC_d2: signal is "no";

  -- trigger on GPIO connector
  signal s_gpio_trigger: STD_LOGIC;
  
begin

  -- Leave the White Rabit SFP I2C bus and the one-wire bus floating.
  sfp_mod_def1_b(0) <= '1';
  sfp_mod_def2_b(0) <= '1';
  one_wire_b <= '1';
  
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
  -- Active high reset
  ------------------------------------------------------------------------------

  --process(clk_sys)
  --begin
  --  if rising_edge(clk_sys) then
  --    led_divider <= led_divider + 1;
  --  end if;
  --end process;

  -- Drive I2C lines.  
  fpga_scl_b <= '0' when  ((ipb_scl_o = '0') ) else 'Z';
  fpga_sda_b <= '0' when ((ipb_sda_o = '0' )) else 'Z';
  ipb_scl_i  <= fpga_scl_b;
  ipb_sda_i  <= fpga_sda_b;  


  cmp_clk_sys_buf : BUFG
    port map (
      O => clk_sys,
      I => pllout_clk_sys);

  cmp_clk_dmtd_buf : BUFG
    port map (
      O => clk_dmtd,
      I => pllout_clk_dmtd);

  si57x_oe_o <= '1';  


  -------------------------------------------------------------------------
  -- Instantiate MAROC interface
  -------------------------------------------------------------------------

  -- FIXME - s_ipb_rst should be connected to something sensible...

  -- BODGE BODGE
  p_register_adc_data: process (s_ipb_clk) is
  begin  -- process p_register_data
    if falling_edge(s_ipb_clk) then  -- falling clock edge
      s_ADC_DAV_d1 <= ADC_DAV_I;
      s_OUT_ADC_d1 <= OUT_ADC_I;
    end if;
    if rising_edge(s_ipb_clk) then  -- rising clock edge
      s_ADC_DAV_d2 <= s_ADC_DAV_d1;
      s_OUT_ADC_d2 <= s_OUT_ADC_d1;
    end if;
  end process p_register_adc_data;
  -- BODGE BODGE - put down in MAROC interface

  
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
      gpio_Trigger_i => s_gpio_trigger,
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
      ADC_DAV_I => s_ADC_DAV_d2 , -- ADC_DAV_I,
      OUT_ADC_I => s_OUT_ADC_d2 , -- OUT_ADC_I,
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

  -- N.B. connect any GPIO disconnected, unused gpio pins to '0' to stop them being optimized away
  gpio(0) <= ADC_DAV_I; 
  gpio(1) <= OUT_ADC_I;
  gpio(2) <= s_ADC_DAV_d1;
  gpio(3) <= s_OUT_ADC_d1;
  gpio(4) <= si57x_clk;
  gpio(5) <= '0';
--  gpio(6) <= uart_txd;
--  uart_rxd <= gpio(7);
  gpio(6) <= s_globaltrig_from_fpga;
--  gpio(6) <= '0';
  s_gpio_trigger <= gpio(7);

  
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

  sfp_rate_select_b(0) <= '1'; --! Connect high for full rate.
  sfp_rate_select_b(1) <= '1';
  
  -----------------------------------------------------------------------------
  -- IPBus interface
  -----------------------------------------------------------------------------

  IPBusInterface_inst : entity work.IPBusInterfaceGTP
    GENERIC MAP (
      NUM_EXT_SLAVES => c_NMAROC_SLAVES+2, --! Total number of IPBus slave busses = number in MAROC plus one for External IO
      BUILD_SIMULATED_ETHERNET => BUILD_SIMULATED_ETHERNET
      )
    PORT MAP (
		
      -- dedicated clock to GTP tile.
      gtp_clkp	=> fpga_pll_ref_clk_123_p_i,
      gtp_clkn	=> fpga_pll_ref_clk_123_n_i,
		  
      -- Serial I/O to GTP on Spartan-6
      gtp_txp	        => sfp_txp_o,
      gtp_txn	        => sfp_txn_o,
      gtp_rxp	        => sfp_rxp_i,
      gtp_rxn	        => sfp_rxn_i,
      sfp_los	        => sfp_los_i(1),

      -- SFP control lines.
      sfp_scl_o   => sfp_scl_o(1),
      sfp_scl_i   => sfp_scl_i(1),
      sfp_sda_o   => sfp_sda_o(1),
      sfp_sda_i   => sfp_sda_i(1),
      sfp_det_i   => sfp_mod_def0_b(1),
      
      -- SATA connector
      gtp_aux_txp	        => sata_txp_o,
      gtp_aux_txn	        => sata_txn_o,
      gtp_aux_rxp	        => sata_rxp_i,
      gtp_aux_rxn	        => sata_rxn_i,
 
      ipbr_i           => s_ipb_rbus,
      sysclk_i         => clk_125m_pllref,
      clocks_locked_o  => leds_o(2),
      pkt_rx_led_o     => leds_o(1),
      pkt_tx_led_o     => leds_o(0),

      ipb_clk_o        => s_ipb_clk,
      ipb_rst_o        => s_ipb_rst,
      ipbw_o           => s_ipb_wbus,
      onehz_o          => leds_o(3),
      phy_rstb_o       => s_phy_rstb,
      dip_switch_i     => dip_switch_i,
      clk_logic_xtal_o => s_clk_logic_xtal
      );

  leds_o(4) <=  sfp_los_i(1);

  -- Tidy up....
  -- Left over signals from White Rabbit
  --leds_o(0) <= '0';
  --leds_o(1) <= '0';
  sfp_tx_disable_o(0) <= '0';
  
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
      ipbus_wbus_i  => s_ipb_wbus(c_NMAROC_SLAVES),
      ipbus_rbus_o  => s_ipb_rbus(c_NMAROC_SLAVES),

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

  -----------------------------------------------------------------------------
  --  I2C master
  -----------------------------------------------------------------------------
  i2cMaster_inst: entity work.i2c_master
      PORT MAP (
         i2c_scl_i     => ipb_scl_i,
         i2c_sda_i     => ipb_sda_i,
         ipbus_clk_i   => s_ipb_clk,
         ipbus_i       => s_ipb_wbus(c_NMAROC_SLAVES+1),
         ipbus_reset_i => s_ipb_rst,
         i2c_scl_enb_o => ipb_scl_o,
         i2c_sda_enb_o => ipb_sda_o,
         ipbus_o       => s_ipb_rbus(c_NMAROC_SLAVES+1)
      );
  
end rtl;


