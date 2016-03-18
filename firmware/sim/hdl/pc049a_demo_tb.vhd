-- Test bench for pc049a_top firmware for single MAROC Evaluation board.
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity pc049a_top_tb is
end;

architecture bench of pc049a_top_tb is

  signal clk_20m_vcxo_i: std_logic := '0' ;
  signal clk_125m_pllref_p_i , clk_125m_pllref_n_i: std_logic := '0';
  signal fpga_pll_ref_clk_101_p_i , fpga_pll_ref_clk_101_n_i: std_logic := '0';
  signal fpga_pll_ref_clk_123_p_i , fpga_pll_ref_clk_123_n_i: std_logic := '0';
  signal si57x_clk_p_i , si57x_clk_n_i: std_logic := '0';
  signal si57x_oe_o: std_logic := '1';
  signal GPIO: std_logic_vector(7 downto 0);
  signal button1_i: std_logic := 'H';
  signal button2_i: std_logic := 'H';
  signal leds_o: std_logic_vector(4 downto 0);
  signal dip_switch_i: std_logic_vector(3 downto 0);
  signal pll25dac_sclk_o: std_logic := '0';
  signal pll25dac_din_o: std_logic := '0';
  signal pll25dac1_sync_n_o: std_logic := '1';
  signal pll25dac2_sync_n_o: std_logic := '1';
  signal fpga_scl_b: std_logic;
  signal fpga_sda_b: std_logic;
  signal one_wire_b: std_logic;
  signal sfp_txp_o: std_logic_vector(1 downto 0);
  signal sfp_txn_o: std_logic_vector(1 downto 0);
  signal sfp_rxp_i: std_logic_vector(1 downto 0);
  signal sfp_rxn_i: std_logic_vector(1 downto 0);
  signal sfp_mod_def0_b: std_logic_vector(1 downto 0);
  signal sfp_mod_def1_b: std_logic_vector(1 downto 0);
  signal sfp_mod_def2_b: std_logic_vector(1 downto 0);
  signal sfp_rate_select_b: std_logic_vector(1 downto 0);
  signal sfp_tx_fault_i: std_logic_vector(1 downto 0);
  signal sfp_tx_disable_o: std_logic_vector(1 downto 0);
  signal sfp_los_i: std_logic_vector(1 downto 0);
  signal sata_txp_o: std_logic_vector(1 downto 0);
  signal sata_txn_o: std_logic_vector(1 downto 0);
  signal sata_rxp_i: std_logic_vector(1 downto 0);
  signal sata_rxn_i: std_logic_vector(1 downto 0);
  signal CK_40M_P_O,CK_40M_N_O: STD_LOGIC;
  signal HOLD2_O: STD_LOGIC;
  signal HOLD1_O: STD_LOGIC;
  signal OR_I: STD_LOGIC_VECTOR(1 downto 0);
  signal MAROC_TRIGGER_I: std_logic_vector(63 downto 0);
  signal EN_OTAQ_O: STD_LOGIC;
  signal CTEST_O: STD_LOGIC_VECTOR(5 downto 0);
  signal ADC_DAV_I: STD_LOGIC;
  signal OUT_ADC_I: STD_LOGIC;
  signal START_ADC_N_O: STD_LOGIC;
  signal RST_ADC_N_O: STD_LOGIC;
  signal RST_SC_N_O: STD_LOGIC;
  signal Q_SC_I: STD_LOGIC;
  signal D_SC_O: STD_LOGIC;
  signal RST_R_N_O: STD_LOGIC;
  signal Q_R_I: STD_LOGIC;
  signal D_R_O: STD_LOGIC;
  signal CK_R_O: STD_LOGIC;
  signal CK_SC_O: STD_LOGIC;
  signal lvds_left_data_p_b, lvds_left_data_n_b: std_logic_vector(15 downto 0);
  signal lvds_left_clk_p_b,lvds_left_clk_n_b: std_logic;
  signal lvds_right_data_p_b,lvds_right_data_n_b: std_logic_vector(15 downto 0);
  signal lvds_right_clk_p_b,lvds_right_clk_n_b: std_logic;
  signal lvds_globaltrig_from_fpga_p_o: std_logic;
  signal lvds_globaltrig_from_fpga_n_o: std_logic;
  signal enable_globaltrig_drive_o: std_logic;
  signal lvds_globaltrig_to_fpga_p_i: std_logic;
  signal lvds_globaltrig_to_fpga_n_i: std_logic;
  signal lvds_otrig_from_fpga_p_o: std_logic;
  signal lvds_otrig_from_fpga_n_o: std_logic;
  signal lvds_otrig_to_fpga_p_i: std_logic;
  signal lvds_otrig_to_fpga_n_i: std_logic;
  signal lvds_gclk_from_fpga_p_o: std_logic;
  signal lvds_gclk_from_fpga_n_o: std_logic;
  signal enable_gclk_drive_o: std_logic;
  signal lvds_gclk_to_fpga_p_i: std_logic;
  signal lvds_gclk_to_fpga_n_i: std_logic ;

begin

  dip_switch_i <= "0001"; -- Set address to 192.168.200.16
  
  uut: entity work.pc049a_top
    generic map ( BUILD_WHITERABBIT             => 0,
                  BUILD_SIMULATED_ETHERNET      => 1 )
                     port map ( clk_20m_vcxo_i                => clk_20m_vcxo_i,
                                clk_125m_pllref_p_i           => clk_125m_pllref_p_i,
                                clk_125m_pllref_n_i           => clk_125m_pllref_n_i,
                                fpga_pll_ref_clk_101_p_i      => fpga_pll_ref_clk_101_p_i,
                                fpga_pll_ref_clk_101_n_i      => fpga_pll_ref_clk_101_n_i,
                                fpga_pll_ref_clk_123_p_i      => fpga_pll_ref_clk_123_p_i,
                                fpga_pll_ref_clk_123_n_i      => fpga_pll_ref_clk_123_n_i,
                                si57x_clk_p_i                 => si57x_clk_p_i,
                                si57x_clk_n_i                 => si57x_clk_n_i,
                                si57x_oe_o                    => si57x_oe_o,
                                GPIO                          => GPIO,
                                button1_i                     => button1_i,
                                button2_i                     => button2_i,
                                leds_o                        => leds_o,
                                dip_switch_i                  => dip_switch_i,
                                pll25dac_sclk_o               => pll25dac_sclk_o,
                                pll25dac_din_o                => pll25dac_din_o,
                                pll25dac1_sync_n_o            => pll25dac1_sync_n_o,
                                pll25dac2_sync_n_o            => pll25dac2_sync_n_o,
                                fpga_scl_b                    => fpga_scl_b,
                                fpga_sda_b                    => fpga_sda_b,
                                one_wire_b                    => one_wire_b,
                                sfp_txp_o                     => sfp_txp_o,
                                sfp_txn_o                     => sfp_txn_o,
                                sfp_rxp_i                     => sfp_rxp_i,
                                sfp_rxn_i                     => sfp_rxn_i,
                                sfp_mod_def0_b                => sfp_mod_def0_b,
                                sfp_mod_def1_b                => sfp_mod_def1_b,
                                sfp_mod_def2_b                => sfp_mod_def2_b,
                                sfp_rate_select_b             => sfp_rate_select_b,
                                sfp_tx_fault_i                => sfp_tx_fault_i,
                                sfp_tx_disable_o              => sfp_tx_disable_o,
                                sfp_los_i                     => sfp_los_i,
                                sata_txp_o                    => sata_txp_o,
                                sata_txn_o                    => sata_txn_o,
                                sata_rxp_i                    => sata_rxp_i,
                                sata_rxn_i                    => sata_rxn_i,
                                CK_40M_P_O                    => CK_40M_P_O,
                                CK_40M_N_O                    => CK_40M_N_O,
                                HOLD2_O                       => HOLD2_O,
                                HOLD1_O                       => HOLD1_O,
                                OR_I                          => OR_I,
                                MAROC_TRIGGER_I               => MAROC_TRIGGER_I,
                                EN_OTAQ_O                     => EN_OTAQ_O,
                                CTEST_O                       => CTEST_O,
                                ADC_DAV_I                     => ADC_DAV_I,
                                OUT_ADC_I                     => OUT_ADC_I,
                                START_ADC_N_O                 => START_ADC_N_O,
                                RST_ADC_N_O                   => RST_ADC_N_O,
                                RST_SC_N_O                    => RST_SC_N_O,
                                Q_SC_I                        => Q_SC_I,
                                D_SC_O                        => D_SC_O,
                                RST_R_N_O                     => RST_R_N_O,
                                Q_R_I                         => Q_R_I,
                                D_R_O                         => D_R_O,
                                CK_R_O                        => CK_R_O,
                                CK_SC_O                       => CK_SC_O,
                                lvds_left_data_p_b            => lvds_left_data_p_b,
                                lvds_left_data_n_b            => lvds_left_data_n_b,
                                lvds_left_clk_p_b             => lvds_left_clk_p_b,
                                lvds_left_clk_n_b             => lvds_left_clk_n_b,
                                lvds_right_data_p_b           => lvds_right_data_p_b,
                                lvds_right_data_n_b           => lvds_right_data_n_b,
                                lvds_right_clk_p_b            => lvds_right_clk_p_b,
                                lvds_right_clk_n_b            => lvds_right_clk_n_b,
                                lvds_globaltrig_from_fpga_p_o => lvds_globaltrig_from_fpga_p_o,
                                lvds_globaltrig_from_fpga_n_o => lvds_globaltrig_from_fpga_n_o,
                                enable_globaltrig_drive_o     => enable_globaltrig_drive_o,
                                lvds_globaltrig_to_fpga_p_i   => lvds_globaltrig_to_fpga_p_i,
                                lvds_globaltrig_to_fpga_n_i   => lvds_globaltrig_to_fpga_n_i,
                                lvds_otrig_from_fpga_p_o      => lvds_otrig_from_fpga_p_o,
                                lvds_otrig_from_fpga_n_o      => lvds_otrig_from_fpga_n_o,
                                lvds_otrig_to_fpga_p_i        => lvds_otrig_to_fpga_p_i,
                                lvds_otrig_to_fpga_n_i        => lvds_otrig_to_fpga_n_i,
                                lvds_gclk_from_fpga_p_o       => lvds_gclk_from_fpga_p_o,
                                lvds_gclk_from_fpga_n_o       => lvds_gclk_from_fpga_n_o,
                                enable_gclk_drive_o           => enable_gclk_drive_o,
                                lvds_gclk_to_fpga_p_i         => lvds_gclk_to_fpga_p_i,
                                lvds_gclk_to_fpga_n_i         => lvds_gclk_to_fpga_n_i );

  -- dummy MAROC ADC
  dummyADC: entity work.dummyMarocADC
    port map (
      clk_i => CK_40M_P_O,
      reset_n_i => RST_ADC_N_O,
      startadc_n_i => START_ADC_N_O,
      adc_dav_o  => ADC_DAV_I ,
      adc_data_o => OUT_ADC_I
      );
    
  --clocks
  clk_20m_vcxo_i <= not clk_20m_vcxo_i after 25 ns;
  clk_125m_pllref_p_i <= not clk_125m_pllref_p_i after 4 ns;
  clk_125m_pllref_n_i <= not clk_125m_pllref_p_i;

  fpga_pll_ref_clk_101_p_i <= not fpga_pll_ref_clk_101_p_i after 4 ns;
  fpga_pll_ref_clk_101_n_i <= not fpga_pll_ref_clk_101_p_i;

  fpga_pll_ref_clk_123_p_i <= not fpga_pll_ref_clk_123_p_i after 4 ns;
  fpga_pll_ref_clk_123_n_i <= not fpga_pll_ref_clk_123_p_i;

  si57x_clk_p_i <= not si57x_clk_p_i after 4 ns;
  si57x_clk_n_i <= not si57x_clk_p_i;
  

  stimulus: process
  begin
  
    -- Put initialisation code here


    -- Put test bench stimulus code here

    wait;
  end process;


end;
  
