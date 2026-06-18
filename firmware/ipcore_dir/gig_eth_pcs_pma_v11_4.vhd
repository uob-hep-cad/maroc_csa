--------------------------------------------------------------------------------
-- Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor: Xilinx
-- \   \   \/     Version: P.20131013
--  \   \         Application: netgen
--  /   /         Filename: gig_eth_pcs_pma_v11_4.vhd
-- /___/   /\     Timestamp: Wed Apr 30 11:28:26 2014
-- \   \  /  \ 
--  \___\/\___\
--             
-- Command	: -w -sim -ofmt vhdl /projects/HEP_Instrumentation/cad/designs/uob-hep-pc049a/trunk/firmware/work/ipcore_dir/tmp/_cg/gig_eth_pcs_pma_v11_4.ngc /projects/HEP_Instrumentation/cad/designs/uob-hep-pc049a/trunk/firmware/work/ipcore_dir/tmp/_cg/gig_eth_pcs_pma_v11_4.vhd 
-- Device	: 6slx45tfgg484-3
-- Input file	: /projects/HEP_Instrumentation/cad/designs/uob-hep-pc049a/trunk/firmware/work/ipcore_dir/tmp/_cg/gig_eth_pcs_pma_v11_4.ngc
-- Output file	: /projects/HEP_Instrumentation/cad/designs/uob-hep-pc049a/trunk/firmware/work/ipcore_dir/tmp/_cg/gig_eth_pcs_pma_v11_4.vhd
-- # of Entities	: 1
-- Design Name	: gig_eth_pcs_pma_v11_4
-- Xilinx	: /software/CAD/Xilinx/14.7_64b/14.7/ISE_DS/ISE/
--             
-- Purpose:    
--     This VHDL netlist is a verification model and uses simulation 
--     primitives which may not represent the true implementation of the 
--     device, however the netlist is functionally correct and should not 
--     be modified. This file cannot be synthesized and should only be used 
--     with supported simulation tools.
--             
-- Reference:  
--     Command Line Tools User Guide, Chapter 23
--     Synthesis and Simulation Design Guide, Chapter 6
--             
--------------------------------------------------------------------------------


-- synthesis translate_off
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
use UNISIM.VPKG.ALL;

entity gig_eth_pcs_pma_v11_4 is
  port (
    reset : in STD_LOGIC := 'X'; 
    signal_detect : in STD_LOGIC := 'X'; 
    userclk : in STD_LOGIC := 'X'; 
    userclk2 : in STD_LOGIC := 'X'; 
    dcm_locked : in STD_LOGIC := 'X'; 
    rxchariscomma : in STD_LOGIC := 'X'; 
    rxcharisk : in STD_LOGIC := 'X'; 
    rxdisperr : in STD_LOGIC := 'X'; 
    rxnotintable : in STD_LOGIC := 'X'; 
    rxrundisp : in STD_LOGIC := 'X'; 
    txbuferr : in STD_LOGIC := 'X'; 
    gmii_tx_en : in STD_LOGIC := 'X'; 
    gmii_tx_er : in STD_LOGIC := 'X'; 
    mgt_rx_reset : out STD_LOGIC; 
    mgt_tx_reset : out STD_LOGIC; 
    powerdown : out STD_LOGIC; 
    txchardispmode : out STD_LOGIC; 
    txchardispval : out STD_LOGIC; 
    txcharisk : out STD_LOGIC; 
    enablealign : out STD_LOGIC; 
    gmii_rx_dv : out STD_LOGIC; 
    gmii_rx_er : out STD_LOGIC; 
    gmii_isolate : out STD_LOGIC; 
    rxbufstatus : in STD_LOGIC_VECTOR ( 1 downto 0 ); 
    rxclkcorcnt : in STD_LOGIC_VECTOR ( 2 downto 0 ); 
    rxdata : in STD_LOGIC_VECTOR ( 7 downto 0 ); 
    gmii_txd : in STD_LOGIC_VECTOR ( 7 downto 0 ); 
    configuration_vector : in STD_LOGIC_VECTOR ( 4 downto 0 ); 
    txdata : out STD_LOGIC_VECTOR ( 7 downto 0 ); 
    gmii_rxd : out STD_LOGIC_VECTOR ( 7 downto 0 ); 
    status_vector : out STD_LOGIC_VECTOR ( 15 downto 0 ) 
  );
end gig_eth_pcs_pma_v11_4;

architecture STRUCTURE of gig_eth_pcs_pma_v11_4 is
  signal U0_xst_options_gpcs_pma_inst_SYNC_SIGNAL_DETECT_data_in : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RXNOTINTABLE_REG_51 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RXDISPERR_REG_52 : STD_LOGIC; 
  signal NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_RECEIVER_RX_INVALID : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_RUDI_I_54 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_RUDI_C_55 : STD_LOGIC; 
  signal NlwRenamedSignal_U0_xst_options_gpcs_pma_inst_STATUS_VECTOR_0 : STD_LOGIC; 
  signal NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_RX_RESET_INT : STD_LOGIC; 
  signal NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_TX_RESET_INT : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TXCHARDISPMODE_60 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TXCHARDISPVAL_61 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TXCHARISK_62 : STD_LOGIC; 
  signal NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_ENCOMMAALIGN : STD_LOGIC; 
  signal NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_RECEIVER_RX_DV : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_RX_ER_65 : STD_LOGIC; 
  signal N0 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RX_RST_SM_FSM_FFd1_68 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RX_RST_SM_FSM_FFd2_69 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RX_RST_SM_FSM_FFd3_70 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RX_RST_SM_FSM_FFd4_71 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RX_RST_SM_FSM_FFd1_In : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RX_RST_SM_FSM_FFd2_In : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RX_RST_SM_FSM_FFd3_In : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TX_RST_SM_FSM_FFd1_75 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TX_RST_SM_FSM_FFd2_76 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TX_RST_SM_FSM_FFd3_77 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TX_RST_SM_FSM_FFd4_78 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TX_RST_SM_FSM_FFd1_In : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TX_RST_SM_FSM_FFd2_In : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TX_RST_SM_FSM_FFd3_In : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_SYNC_SIGNAL_DETECT_data_sync1 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_SRESET_PIPE_PWR_14_o_MUX_1_o : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RESET_INT_RXBUFSTATUS_INT_1_OR_116_o : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RESET_INT_TXBUFERR_INT_OR_115_o : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TXCHARDISPVAL_INT_GND_14_o_MUX_194_o : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TXCHARDISPMODE_INT_TXEVEN_MUX_193_o : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TXCHARISK_INT_TXEVEN_MUX_192_o : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TXDATA_INT_7_GND_14_o_mux_30_OUT_0_Q : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TXDATA_INT_7_GND_14_o_mux_30_OUT_1_Q : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TXDATA_INT_7_GND_14_o_mux_30_OUT_2_Q : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TXDATA_INT_7_GND_14_o_mux_30_OUT_3_Q : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TXDATA_INT_7_GND_14_o_mux_30_OUT_4_Q : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TXDATA_INT_7_GND_14_o_mux_30_OUT_5_Q : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TXDATA_INT_7_GND_14_o_mux_30_OUT_6_Q : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TXDATA_INT_7_GND_14_o_mux_30_OUT_7_Q : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RXNOTINTABLE_GND_14_o_MUX_182_o : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RXDISPERR_GND_14_o_MUX_183_o : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RXCHARISK_TXCHARISK_INT_MUX_185_o : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RXCHARISCOMMA_TXCHARISK_INT_MUX_186_o : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RX_RST_SM_3_GND_14_o_Mux_17_o : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TX_RST_SM_3_GND_14_o_Mux_13_o : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TXBUFERR_INT_103 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RXNOTINTABLE_INT_108 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RXDISPERR_INT_109 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RXCHARISK_INT_118 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RXCHARISCOMMA_INT_119 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_SRESET_121 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_SRESET_PIPE_122 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_SYNC_STATUS_123 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_EVEN_124 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RXNOTINTABLE_SRL : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RXDISPERR_SRL : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RESET_INT_PIPE_127 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RESET_INT_128 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_SIGNAL_DETECT_REG : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_DCM_LOCKED_SOFT_RESET_OR_2_o : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXCHARDISPVAL_131 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXCHARDISPMODE_132 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXCHARISK_133 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RXDATA_7_TXDATA_INT_7_mux_20_OUT_0_Q : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RXDATA_7_TXDATA_INT_7_mux_20_OUT_1_Q : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RXDATA_7_TXDATA_INT_7_mux_20_OUT_2_Q : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RXDATA_7_TXDATA_INT_7_mux_20_OUT_3_Q : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RXDATA_7_TXDATA_INT_7_mux_20_OUT_4_Q : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RXDATA_7_TXDATA_INT_7_mux_20_OUT_5_Q : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RXDATA_7_TXDATA_INT_7_mux_20_OUT_6_Q : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RXDATA_7_TXDATA_INT_7_mux_20_OUT_7_Q : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RXCLKCORCNT_2_GND_14_o_mux_22_OUT_0_Q : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RXCLKCORCNT_2_GND_14_o_mux_22_OUT_1_Q : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RXCLKCORCNT_2_GND_14_o_mux_22_OUT_2_Q : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RXBUFSTATUS_1_GND_14_o_mux_21_OUT_1_Q : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_Mmux_PWR_17_o_CONFIG_DATA_7_mux_21_OUT511 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_Mram_CODE_GRP_CNT_1_GND_21_o_Mux_5_o : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_CNT_1_TX_CONFIG_15_wide_mux_4_OUT_7_Q : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_DISP5 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_TX_EN_TRIGGER_T_OR_14_o : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_TX_EN_EVEN_AND_8_o : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_TX_PACKET_CODE_GRP_CNT_1_MUX_73_o : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRPISK_GND_21_o_MUX_79_o : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_PWR_17_o_CONFIG_DATA_7_mux_21_OUT_0_Q : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_PWR_17_o_CONFIG_DATA_7_mux_21_OUT_1_Q : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_PWR_17_o_CONFIG_DATA_7_mux_21_OUT_2_Q : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_PWR_17_o_CONFIG_DATA_7_mux_21_OUT_3_Q : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_PWR_17_o_CONFIG_DATA_7_mux_21_OUT_4_Q : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_PWR_17_o_CONFIG_DATA_7_mux_21_OUT_5_Q : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_PWR_17_o_CONFIG_DATA_7_mux_21_OUT_6_Q : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_PWR_17_o_CONFIG_DATA_7_mux_21_OUT_7_Q : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_SYNC_DISPARITY_EVEN_AND_42_o : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_7_GND_21_o_mux_24_OUT_0_Q : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_7_GND_21_o_mux_24_OUT_1_Q : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_7_GND_21_o_mux_24_OUT_2_Q : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_7_GND_21_o_mux_24_OUT_3_Q : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_7_GND_21_o_mux_24_OUT_4_Q : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_7_GND_21_o_mux_24_OUT_5_Q : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_7_GND_21_o_mux_24_OUT_6_Q : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_7_GND_21_o_mux_24_OUT_7_Q : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_DISPARITY_183 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_V_184 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_R_185 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_TX_PACKET_186 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_XMIT_CONFIG_INT_187 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_C1_OR_C2_188 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRPISK_190 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_SYNC_DISPARITY_191 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_TRIGGER_T_192 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_T_193 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_TRIGGER_S_194 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_S_195 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_TX_ER_REG1_208 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_TX_EN_REG1_209 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd4_In1_0 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd1_219 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd2_220 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd3_221 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd4_222 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd4_In2_223 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd1_In2 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd2_In2 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd3_In3 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_n0103_inv : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_GOOD_CGS_1_PWR_19_o_equal_19_o : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_GOOD_CGS_1_GND_23_o_mux_30_OUT_0_Q : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_GOOD_CGS_1_GND_23_o_mux_30_OUT_1_Q : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_CGBAD : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_SIGNAL_DETECT_REG_234 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_K27p7_RXFIFO_ERR_AND_111_o1_235 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_NIT_POS_FALSE_NIT_NEG_OR_108_o_0 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_C_REG2_237 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_K28p5_REG1_D21p5_AND_116_o_norst : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_IDLE_REG_1_IDLE_REG_2_OR_114_o : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_RX_CONFIG_VALID_REG_0_RX_CONFIG_VALID_REG_3_OR_113_o : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_C_REG1_C_REG3_OR_59_o_241 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_I_REG_T_REG2_OR_64_o : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_D0p0_243 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_DATA_POS_RXNOTINTABLE_AND_203_o : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_EXTEND_REG1_ISOLATE_AND_182_o_245 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_EXTEND_REG3_EXT_ILLEGAL_K_REG2_OR_83_o : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_EOP_EXTEND_OR_65_o : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_RXDATA_REG5_7_GND_24_o_mux_9_OUT_0_Q : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_RXDATA_REG5_7_GND_24_o_mux_9_OUT_1_Q : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_RXDATA_REG5_7_GND_24_o_mux_9_OUT_2_Q : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_RXDATA_REG5_7_GND_24_o_mux_9_OUT_3_Q : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_RXDATA_REG5_7_GND_24_o_mux_9_OUT_4_Q : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_RXDATA_REG5_7_GND_24_o_mux_9_OUT_5_Q : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_RXDATA_REG5_7_GND_24_o_mux_9_OUT_6_Q : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_RXDATA_REG5_7_GND_24_o_mux_9_OUT_7_Q : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_RXCHARISK_REG1_K28p5_REG1_AND_167_o : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_S_WAIT_FOR_K_AND_144_o : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_SYNC_STATUS_C_REG1_AND_125_o_258 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_EVEN_RXCHARISK_AND_115_o_259 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_K28p5_REG1_EVEN_AND_127_o : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_K28p5 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_RXDATA_7_RXNOTINTABLE_AND_211_o : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_K23p7 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_K27p7_RXFIFO_ERR_AND_111_o : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_K29p7 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_RXFIFO_ERR_RXDISPERR_OR_36_o : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_RESET_SYNC_STATUS_OR_51_o : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_EXTEND_268 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_RECEIVE_269 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_CARRIER_270 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_WAIT_FOR_K_271 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_NIT_279 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_K_280 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_DATA_281 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_EXT_ILLEGAL_K_REG2_282 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_EXT_ILLEGAL_K_REG1_283 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_EXT_ILLEGAL_K_284 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_EXTEND_ERR_285 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_ILLEGAL_K_REG2_286 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_ILLEGAL_K_REG1_287 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_ILLEGAL_K_288 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_RX_DATA_ERROR_289 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_EOP_REG1_290 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_EOP_291 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_SOP_292 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_FROM_RX_CX_293 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_CARRIER_REG3_295 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_SYNC_STATUS_REG_296 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_RX_CONFIG_VALID_INT_297 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_CGBAD_REG3_298 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_CGBAD_299 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_R_300 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_EXTEND_REG3_309 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_EXTEND_REG1_310 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_SOP_REG3_311 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_SOP_REG2_312 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_CARRIER_REG2 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_C_HDR_REMOVED_REG_314 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_CGBAD_REG2 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_RXCHARISK_REG1_316 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_C_REG3_317 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_C_REG1_318 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_I_REG_319 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_R_REG1_320 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_T_REG2_321 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_T_REG1_322 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_D0p0_REG_323 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_K28p5_REG1_324 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_C_325 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_I_326 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_T_327 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_S_328 : STD_LOGIC; 
  signal N2 : STD_LOGIC; 
  signal N6 : STD_LOGIC; 
  signal N8 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_TX_EN_REG1_XMIT_DATA_INT_AND_20_o1_332 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_TX_EN_REG1_XMIT_DATA_INT_AND_20_o2_333 : STD_LOGIC; 
  signal N10 : STD_LOGIC; 
  signal N12 : STD_LOGIC; 
  signal N18 : STD_LOGIC; 
  signal N22 : STD_LOGIC; 
  signal N24 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_D21p5_D2p2_OR_38_o : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_D21p5_D2p2_OR_38_o1_340 : STD_LOGIC; 
  signal N26 : STD_LOGIC; 
  signal N28 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_NIT_POS_FALSE_NIT_NEG_OR_108_o1 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_NIT_POS_FALSE_NIT_NEG_OR_108_o12_344 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_NIT_POS_FALSE_NIT_NEG_OR_108_o13_345 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_I_REG_T_REG2_OR_64_o1_346 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_T_REG2_R_REG1_OR_79_o1_347 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_T_REG2_R_REG1_OR_79_o2_348 : STD_LOGIC; 
  signal N30 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_V_glue_set_350 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_TX_PACKET_glue_set_351 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_R_glue_set_352 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_DISPARITY_glue_rst_353 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_EVEN_glue_set_354 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_RECEIVE_glue_set_355 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_RX_INVALID_glue_set_356 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_RX_DV_glue_set_357 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_EXTEND_glue_set_358 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_CARRIER_glue_set_359 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_WAIT_FOR_K_glue_set_360 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_C1_OR_C2_rstpot_361 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_XMIT_CONFIG_INT_rstpot_362 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RX_RST_SM_FSM_FFd4_rstpot_363 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TX_RST_SM_FSM_FFd4_rstpot_364 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRPISK_rstpot_365 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXCHARDISPVAL_rstpot_366 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_TRIGGER_T_rstpot_367 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_S_rstpot_368 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_CONFIG_DATA_0_rstpot_369 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_C_HDR_REMOVED_REG_rstpot_370 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_C_rstpot_371 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_EXT_ILLEGAL_K_rstpot_372 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_RX_DATA_ERROR_rstpot_373 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_ENCOMMAALIGN_rstpot_374 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_SYNC_STATUS_rstpot_375 : STD_LOGIC; 
  signal N32 : STD_LOGIC; 
  signal N33 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_NIT_rstpot_378 : STD_LOGIC; 
  signal N39 : STD_LOGIC; 
  signal N43 : STD_LOGIC; 
  signal N44 : STD_LOGIC; 
  signal N46 : STD_LOGIC; 
  signal N48 : STD_LOGIC; 
  signal N68 : STD_LOGIC; 
  signal N70 : STD_LOGIC; 
  signal N76 : STD_LOGIC; 
  signal N78 : STD_LOGIC; 
  signal N80 : STD_LOGIC; 
  signal N82 : STD_LOGIC; 
  signal N84 : STD_LOGIC; 
  signal N86 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_MGT_RX_RESET_INT_1_392 : STD_LOGIC; 
  signal N88 : STD_LOGIC; 
  signal N89 : STD_LOGIC; 
  signal N90 : STD_LOGIC; 
  signal N91 : STD_LOGIC; 
  signal N92 : STD_LOGIC; 
  signal N93 : STD_LOGIC; 
  signal N94 : STD_LOGIC; 
  signal N95 : STD_LOGIC; 
  signal N96 : STD_LOGIC; 
  signal N97 : STD_LOGIC; 
  signal N98 : STD_LOGIC; 
  signal N99 : STD_LOGIC; 
  signal N100 : STD_LOGIC; 
  signal N101 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_Mshreg_STATUS_VECTOR_0_407 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_RXDATA_REG5_7_408 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_RXDATA_REG5_6_409 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_RXDATA_REG5_5_410 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_RXDATA_REG5_2_411 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_RXDATA_REG5_4_412 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_RXDATA_REG5_3_413 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_EXTEND_REG3_414 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_RXDATA_REG5_1_415 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_RXDATA_REG5_0_416 : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_SOP_REG2_417 : STD_LOGIC; 
  signal NLW_U0_xst_options_gpcs_pma_inst_Mshreg_STATUS_VECTOR_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_RXDATA_REG5_7_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_RXDATA_REG5_6_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_RXDATA_REG5_5_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_RXDATA_REG5_2_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_RXDATA_REG5_4_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_RXDATA_REG5_3_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_EXTEND_REG3_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_RXDATA_REG5_1_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_RXDATA_REG5_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_CGBAD_REG2_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_SOP_REG2_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_FALSE_CARRIER_REG2_Q15_UNCONNECTED : STD_LOGIC; 
  signal U0_xst_options_gpcs_pma_inst_TXDATA : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_RXD : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG : STD_LOGIC_VECTOR ( 3 downto 2 ); 
  signal U0_xst_options_gpcs_pma_inst_RXCLKCORCNT_INT : STD_LOGIC_VECTOR ( 2 downto 0 ); 
  signal U0_xst_options_gpcs_pma_inst_RXBUFSTATUS_INT : STD_LOGIC_VECTOR ( 1 downto 1 ); 
  signal U0_xst_options_gpcs_pma_inst_RXDATA_INT : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG : STD_LOGIC_VECTOR ( 1 downto 1 ); 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_CNT : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXDATA : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_Result : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_n0234 : STD_LOGIC_VECTOR ( 1 downto 1 ); 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_CONFIG_DATA : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXD_REG1 : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_GOOD_CGS : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_IDLE_REG : STD_LOGIC_VECTOR ( 2 downto 0 ); 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_RX_CONFIG_VALID_REG : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal NlwRenamedSig_OI_status_vector : STD_LOGIC_VECTOR ( 7 downto 7 ); 
  signal U0_xst_options_gpcs_pma_inst_RECEIVER_RXDATA_REG5 : STD_LOGIC_VECTOR ( 7 downto 0 ); 
begin
  U0_xst_options_gpcs_pma_inst_SYNC_SIGNAL_DETECT_data_in <= signal_detect;
  txdata(7) <= U0_xst_options_gpcs_pma_inst_TXDATA(7);
  txdata(6) <= U0_xst_options_gpcs_pma_inst_TXDATA(6);
  txdata(5) <= U0_xst_options_gpcs_pma_inst_TXDATA(5);
  txdata(4) <= U0_xst_options_gpcs_pma_inst_TXDATA(4);
  txdata(3) <= U0_xst_options_gpcs_pma_inst_TXDATA(3);
  txdata(2) <= U0_xst_options_gpcs_pma_inst_TXDATA(2);
  txdata(1) <= U0_xst_options_gpcs_pma_inst_TXDATA(1);
  txdata(0) <= U0_xst_options_gpcs_pma_inst_TXDATA(0);
  gmii_rxd(7) <= U0_xst_options_gpcs_pma_inst_RECEIVER_RXD(7);
  gmii_rxd(6) <= U0_xst_options_gpcs_pma_inst_RECEIVER_RXD(6);
  gmii_rxd(5) <= U0_xst_options_gpcs_pma_inst_RECEIVER_RXD(5);
  gmii_rxd(4) <= U0_xst_options_gpcs_pma_inst_RECEIVER_RXD(4);
  gmii_rxd(3) <= U0_xst_options_gpcs_pma_inst_RECEIVER_RXD(3);
  gmii_rxd(2) <= U0_xst_options_gpcs_pma_inst_RECEIVER_RXD(2);
  gmii_rxd(1) <= U0_xst_options_gpcs_pma_inst_RECEIVER_RXD(1);
  gmii_rxd(0) <= U0_xst_options_gpcs_pma_inst_RECEIVER_RXD(0);
  status_vector(15) <= NlwRenamedSig_OI_status_vector(7);
  status_vector(14) <= NlwRenamedSig_OI_status_vector(7);
  status_vector(13) <= NlwRenamedSig_OI_status_vector(7);
  status_vector(12) <= NlwRenamedSig_OI_status_vector(7);
  status_vector(11) <= NlwRenamedSig_OI_status_vector(7);
  status_vector(10) <= NlwRenamedSig_OI_status_vector(7);
  status_vector(9) <= NlwRenamedSig_OI_status_vector(7);
  status_vector(8) <= NlwRenamedSig_OI_status_vector(7);
  status_vector(7) <= NlwRenamedSig_OI_status_vector(7);
  status_vector(6) <= U0_xst_options_gpcs_pma_inst_RXNOTINTABLE_REG_51;
  status_vector(5) <= U0_xst_options_gpcs_pma_inst_RXDISPERR_REG_52;
  status_vector(4) <= NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_RECEIVER_RX_INVALID;
  status_vector(3) <= U0_xst_options_gpcs_pma_inst_RECEIVER_RUDI_I_54;
  status_vector(2) <= U0_xst_options_gpcs_pma_inst_RECEIVER_RUDI_C_55;
  status_vector(1) <= NlwRenamedSignal_U0_xst_options_gpcs_pma_inst_STATUS_VECTOR_0;
  status_vector(0) <= NlwRenamedSignal_U0_xst_options_gpcs_pma_inst_STATUS_VECTOR_0;
  mgt_rx_reset <= NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_RX_RESET_INT;
  mgt_tx_reset <= NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_TX_RESET_INT;
  powerdown <= NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG(2);
  txchardispmode <= U0_xst_options_gpcs_pma_inst_TXCHARDISPMODE_60;
  txchardispval <= U0_xst_options_gpcs_pma_inst_TXCHARDISPVAL_61;
  txcharisk <= U0_xst_options_gpcs_pma_inst_TXCHARISK_62;
  enablealign <= NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_ENCOMMAALIGN;
  gmii_rx_dv <= NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_RECEIVER_RX_DV;
  gmii_rx_er <= U0_xst_options_gpcs_pma_inst_RECEIVER_RX_ER_65;
  gmii_isolate <= NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG(3);
  XST_VCC : VCC
    port map (
      P => N0
    );
  XST_GND : GND
    port map (
      G => NlwRenamedSig_OI_status_vector(7)
    );
  U0_xst_options_gpcs_pma_inst_DELAY_RXNOTINTABLE : SRL16
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => NlwRenamedSig_OI_status_vector(7),
      A1 => NlwRenamedSig_OI_status_vector(7),
      A2 => N0,
      A3 => NlwRenamedSig_OI_status_vector(7),
      CLK => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RXNOTINTABLE_INT_108,
      Q => U0_xst_options_gpcs_pma_inst_RXNOTINTABLE_SRL
    );
  U0_xst_options_gpcs_pma_inst_DELAY_RXDISPERR : SRL16
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => NlwRenamedSig_OI_status_vector(7),
      A1 => NlwRenamedSig_OI_status_vector(7),
      A2 => N0,
      A3 => NlwRenamedSig_OI_status_vector(7),
      CLK => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RXDISPERR_INT_109,
      Q => U0_xst_options_gpcs_pma_inst_RXDISPERR_SRL
    );
  U0_xst_options_gpcs_pma_inst_RX_RST_SM_FSM_FFd2 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RX_RST_SM_FSM_FFd2_In,
      R => U0_xst_options_gpcs_pma_inst_RESET_INT_RXBUFSTATUS_INT_1_OR_116_o,
      Q => U0_xst_options_gpcs_pma_inst_RX_RST_SM_FSM_FFd2_69
    );
  U0_xst_options_gpcs_pma_inst_RX_RST_SM_FSM_FFd3 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RX_RST_SM_FSM_FFd3_In,
      R => U0_xst_options_gpcs_pma_inst_RESET_INT_RXBUFSTATUS_INT_1_OR_116_o,
      Q => U0_xst_options_gpcs_pma_inst_RX_RST_SM_FSM_FFd3_70
    );
  U0_xst_options_gpcs_pma_inst_RX_RST_SM_FSM_FFd1 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RX_RST_SM_FSM_FFd1_In,
      R => U0_xst_options_gpcs_pma_inst_RESET_INT_RXBUFSTATUS_INT_1_OR_116_o,
      Q => U0_xst_options_gpcs_pma_inst_RX_RST_SM_FSM_FFd1_68
    );
  U0_xst_options_gpcs_pma_inst_TX_RST_SM_FSM_FFd1 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_TX_RST_SM_FSM_FFd1_In,
      R => U0_xst_options_gpcs_pma_inst_RESET_INT_TXBUFERR_INT_OR_115_o,
      Q => U0_xst_options_gpcs_pma_inst_TX_RST_SM_FSM_FFd1_75
    );
  U0_xst_options_gpcs_pma_inst_TX_RST_SM_FSM_FFd2 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_TX_RST_SM_FSM_FFd2_In,
      R => U0_xst_options_gpcs_pma_inst_RESET_INT_TXBUFERR_INT_OR_115_o,
      Q => U0_xst_options_gpcs_pma_inst_TX_RST_SM_FSM_FFd2_76
    );
  U0_xst_options_gpcs_pma_inst_TX_RST_SM_FSM_FFd3 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_TX_RST_SM_FSM_FFd3_In,
      R => U0_xst_options_gpcs_pma_inst_RESET_INT_TXBUFERR_INT_OR_115_o,
      Q => U0_xst_options_gpcs_pma_inst_TX_RST_SM_FSM_FFd3_77
    );
  U0_xst_options_gpcs_pma_inst_SYNC_SIGNAL_DETECT_data_sync : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_SYNC_SIGNAL_DETECT_data_in,
      Q => U0_xst_options_gpcs_pma_inst_SYNC_SIGNAL_DETECT_data_sync1
    );
  U0_xst_options_gpcs_pma_inst_SYNC_SIGNAL_DETECT_data_sync_reg : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_SYNC_SIGNAL_DETECT_data_sync1,
      Q => U0_xst_options_gpcs_pma_inst_SIGNAL_DETECT_REG
    );
  U0_xst_options_gpcs_pma_inst_RXNOTINTABLE_REG : FD
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RXNOTINTABLE_SRL,
      Q => U0_xst_options_gpcs_pma_inst_RXNOTINTABLE_REG_51
    );
  U0_xst_options_gpcs_pma_inst_RXDISPERR_REG : FD
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RXDISPERR_SRL,
      Q => U0_xst_options_gpcs_pma_inst_RXDISPERR_REG_52
    );
  U0_xst_options_gpcs_pma_inst_TXCHARDISPVAL : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_TXCHARDISPVAL_INT_GND_14_o_MUX_194_o,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_TX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_TXCHARDISPVAL_61
    );
  U0_xst_options_gpcs_pma_inst_TXCHARISK : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_TXCHARISK_INT_TXEVEN_MUX_192_o,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_TX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_TXCHARISK_62
    );
  U0_xst_options_gpcs_pma_inst_TXDATA_7 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_TXDATA_INT_7_GND_14_o_mux_30_OUT_7_Q,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_TX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_TXDATA(7)
    );
  U0_xst_options_gpcs_pma_inst_TXDATA_6 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_TXDATA_INT_7_GND_14_o_mux_30_OUT_6_Q,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_TX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_TXDATA(6)
    );
  U0_xst_options_gpcs_pma_inst_TXDATA_5 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_TXDATA_INT_7_GND_14_o_mux_30_OUT_5_Q,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_TX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_TXDATA(5)
    );
  U0_xst_options_gpcs_pma_inst_TXDATA_4 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_TXDATA_INT_7_GND_14_o_mux_30_OUT_4_Q,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_TX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_TXDATA(4)
    );
  U0_xst_options_gpcs_pma_inst_TXDATA_3 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_TXDATA_INT_7_GND_14_o_mux_30_OUT_3_Q,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_TX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_TXDATA(3)
    );
  U0_xst_options_gpcs_pma_inst_TXDATA_2 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_TXDATA_INT_7_GND_14_o_mux_30_OUT_2_Q,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_TX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_TXDATA(2)
    );
  U0_xst_options_gpcs_pma_inst_TXDATA_1 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_TXDATA_INT_7_GND_14_o_mux_30_OUT_1_Q,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_TX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_TXDATA(1)
    );
  U0_xst_options_gpcs_pma_inst_TXDATA_0 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_TXDATA_INT_7_GND_14_o_mux_30_OUT_0_Q,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_TX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_TXDATA(0)
    );
  U0_xst_options_gpcs_pma_inst_TXCHARDISPMODE : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_TXCHARDISPMODE_INT_TXEVEN_MUX_193_o,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_TX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_TXCHARDISPMODE_60
    );
  U0_xst_options_gpcs_pma_inst_RXCHARISK_INT : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RXCHARISK_TXCHARISK_INT_MUX_185_o,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_RX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_RXCHARISK_INT_118
    );
  U0_xst_options_gpcs_pma_inst_RXCHARISCOMMA_INT : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RXCHARISCOMMA_TXCHARISK_INT_MUX_186_o,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_RX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_RXCHARISCOMMA_INT_119
    );
  U0_xst_options_gpcs_pma_inst_RXDATA_INT_7 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RXDATA_7_TXDATA_INT_7_mux_20_OUT_7_Q,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_RX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_RXDATA_INT(7)
    );
  U0_xst_options_gpcs_pma_inst_RXDATA_INT_6 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RXDATA_7_TXDATA_INT_7_mux_20_OUT_6_Q,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_RX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_RXDATA_INT(6)
    );
  U0_xst_options_gpcs_pma_inst_RXDATA_INT_5 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RXDATA_7_TXDATA_INT_7_mux_20_OUT_5_Q,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_RX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_RXDATA_INT(5)
    );
  U0_xst_options_gpcs_pma_inst_RXDATA_INT_4 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RXDATA_7_TXDATA_INT_7_mux_20_OUT_4_Q,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_RX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_RXDATA_INT(4)
    );
  U0_xst_options_gpcs_pma_inst_RXDATA_INT_3 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RXDATA_7_TXDATA_INT_7_mux_20_OUT_3_Q,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_RX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_RXDATA_INT(3)
    );
  U0_xst_options_gpcs_pma_inst_RXDATA_INT_2 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RXDATA_7_TXDATA_INT_7_mux_20_OUT_2_Q,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_RX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_RXDATA_INT(2)
    );
  U0_xst_options_gpcs_pma_inst_RXDATA_INT_1 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RXDATA_7_TXDATA_INT_7_mux_20_OUT_1_Q,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_RX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_RXDATA_INT(1)
    );
  U0_xst_options_gpcs_pma_inst_RXDATA_INT_0 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RXDATA_7_TXDATA_INT_7_mux_20_OUT_0_Q,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_RX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_RXDATA_INT(0)
    );
  U0_xst_options_gpcs_pma_inst_RXBUFSTATUS_INT_1 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RXBUFSTATUS_1_GND_14_o_mux_21_OUT_1_Q,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_RX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_RXBUFSTATUS_INT(1)
    );
  U0_xst_options_gpcs_pma_inst_RXCLKCORCNT_INT_2 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RXCLKCORCNT_2_GND_14_o_mux_22_OUT_2_Q,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_RX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_RXCLKCORCNT_INT(2)
    );
  U0_xst_options_gpcs_pma_inst_RXCLKCORCNT_INT_1 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RXCLKCORCNT_2_GND_14_o_mux_22_OUT_1_Q,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_RX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_RXCLKCORCNT_INT(1)
    );
  U0_xst_options_gpcs_pma_inst_RXCLKCORCNT_INT_0 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RXCLKCORCNT_2_GND_14_o_mux_22_OUT_0_Q,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_RX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_RXCLKCORCNT_INT(0)
    );
  U0_xst_options_gpcs_pma_inst_RXNOTINTABLE_INT : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RXNOTINTABLE_GND_14_o_MUX_182_o,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_RX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_RXNOTINTABLE_INT_108
    );
  U0_xst_options_gpcs_pma_inst_RXDISPERR_INT : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RXDISPERR_GND_14_o_MUX_183_o,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_RX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_RXDISPERR_INT_109
    );
  U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG_3 : FDR
    port map (
      C => userclk2,
      D => configuration_vector(3),
      R => U0_xst_options_gpcs_pma_inst_SRESET_121,
      Q => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG(3)
    );
  U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG_2 : FDR
    port map (
      C => userclk2,
      D => configuration_vector(2),
      R => U0_xst_options_gpcs_pma_inst_SRESET_121,
      Q => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG(2)
    );
  U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG_1 : FDR
    port map (
      C => userclk2,
      D => configuration_vector(1),
      R => U0_xst_options_gpcs_pma_inst_SRESET_121,
      Q => U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG(1)
    );
  U0_xst_options_gpcs_pma_inst_SRESET : FD
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_SRESET_PIPE_PWR_14_o_MUX_1_o,
      Q => U0_xst_options_gpcs_pma_inst_SRESET_121
    );
  U0_xst_options_gpcs_pma_inst_TXBUFERR_INT : FDR
    port map (
      C => userclk2,
      D => txbuferr,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_TX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_TXBUFERR_INT_103
    );
  U0_xst_options_gpcs_pma_inst_SRESET_PIPE : FD
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RESET_INT_128,
      Q => U0_xst_options_gpcs_pma_inst_SRESET_PIPE_122
    );
  U0_xst_options_gpcs_pma_inst_MGT_RX_RESET_INT : FDS
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RX_RST_SM_3_GND_14_o_Mux_17_o,
      S => U0_xst_options_gpcs_pma_inst_RESET_INT_RXBUFSTATUS_INT_1_OR_116_o,
      Q => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_RX_RESET_INT
    );
  U0_xst_options_gpcs_pma_inst_MGT_TX_RESET_INT : FDS
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_TX_RST_SM_3_GND_14_o_Mux_13_o,
      S => U0_xst_options_gpcs_pma_inst_RESET_INT_TXBUFERR_INT_OR_115_o,
      Q => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_TX_RESET_INT
    );
  U0_xst_options_gpcs_pma_inst_RESET_INT : FDP
    port map (
      C => userclk,
      D => U0_xst_options_gpcs_pma_inst_RESET_INT_PIPE_127,
      PRE => U0_xst_options_gpcs_pma_inst_DCM_LOCKED_SOFT_RESET_OR_2_o,
      Q => U0_xst_options_gpcs_pma_inst_RESET_INT_128
    );
  U0_xst_options_gpcs_pma_inst_RESET_INT_PIPE : FDP
    port map (
      C => userclk,
      D => NlwRenamedSig_OI_status_vector(7),
      PRE => U0_xst_options_gpcs_pma_inst_DCM_LOCKED_SOFT_RESET_OR_2_o,
      Q => U0_xst_options_gpcs_pma_inst_RESET_INT_PIPE_127
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_CNT_1 : FDS
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_TRANSMITTER_Result(1),
      S => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_TX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_CNT(1)
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_CNT_0 : FDS
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_TRANSMITTER_Result(0),
      S => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_TX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_CNT(0)
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXDATA_7 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_7_GND_21_o_mux_24_OUT_7_Q,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_TX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXDATA(7)
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXDATA_6 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_7_GND_21_o_mux_24_OUT_6_Q,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_TX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXDATA(6)
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXDATA_5 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_7_GND_21_o_mux_24_OUT_5_Q,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_TX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXDATA(5)
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXDATA_4 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_7_GND_21_o_mux_24_OUT_4_Q,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_TX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXDATA(4)
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXDATA_3 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_7_GND_21_o_mux_24_OUT_3_Q,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_TX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXDATA(3)
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXDATA_2 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_7_GND_21_o_mux_24_OUT_2_Q,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_TX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXDATA(2)
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXDATA_1 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_7_GND_21_o_mux_24_OUT_1_Q,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_TX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXDATA(1)
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXDATA_0 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_7_GND_21_o_mux_24_OUT_0_Q,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_TX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXDATA(0)
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXCHARISK : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRPISK_GND_21_o_MUX_79_o,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_TX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXCHARISK_133
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_7 : FD
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_TRANSMITTER_PWR_17_o_CONFIG_DATA_7_mux_21_OUT_7_Q,
      Q => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP(7)
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_6 : FD
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_TRANSMITTER_PWR_17_o_CONFIG_DATA_7_mux_21_OUT_6_Q,
      Q => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP(6)
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_5 : FD
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_TRANSMITTER_PWR_17_o_CONFIG_DATA_7_mux_21_OUT_5_Q,
      Q => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP(5)
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_4 : FD
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_TRANSMITTER_PWR_17_o_CONFIG_DATA_7_mux_21_OUT_4_Q,
      Q => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP(4)
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_3 : FD
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_TRANSMITTER_PWR_17_o_CONFIG_DATA_7_mux_21_OUT_3_Q,
      Q => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP(3)
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_2 : FD
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_TRANSMITTER_PWR_17_o_CONFIG_DATA_7_mux_21_OUT_2_Q,
      Q => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP(2)
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_1 : FD
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_TRANSMITTER_PWR_17_o_CONFIG_DATA_7_mux_21_OUT_1_Q,
      Q => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP(1)
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_0 : FD
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_TRANSMITTER_PWR_17_o_CONFIG_DATA_7_mux_21_OUT_0_Q,
      Q => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP(0)
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_SYNC_DISPARITY : FD
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TX_PACKET_CODE_GRP_CNT_1_MUX_73_o,
      Q => U0_xst_options_gpcs_pma_inst_TRANSMITTER_SYNC_DISPARITY_191
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXCHARDISPMODE : FDS
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_TRANSMITTER_SYNC_DISPARITY_EVEN_AND_42_o,
      S => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_TX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXCHARDISPMODE_132
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_TRIGGER_S : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TX_EN_EVEN_AND_8_o,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_TX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TRIGGER_S_194
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_T : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TX_EN_TRIGGER_T_OR_14_o,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_TX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_TRANSMITTER_T_193
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_CONFIG_DATA_3 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_TRANSMITTER_Mram_CODE_GRP_CNT_1_GND_21_o_Mux_5_o,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_TX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CONFIG_DATA(3)
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_CONFIG_DATA_2 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_CNT_1_TX_CONFIG_15_wide_mux_4_OUT_7_Q,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_TX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CONFIG_DATA(2)
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_CONFIG_DATA_1 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_TRANSMITTER_n0234(1),
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_TX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CONFIG_DATA(1)
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_TX_ER_REG1 : FD
    port map (
      C => userclk2,
      D => gmii_tx_er,
      Q => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TX_ER_REG1_208
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_TX_EN_REG1 : FD
    port map (
      C => userclk2,
      D => gmii_tx_en,
      Q => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TX_EN_REG1_209
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXD_REG1_7 : FD
    port map (
      C => userclk2,
      D => gmii_txd(7),
      Q => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXD_REG1(7)
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXD_REG1_6 : FD
    port map (
      C => userclk2,
      D => gmii_txd(6),
      Q => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXD_REG1(6)
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXD_REG1_5 : FD
    port map (
      C => userclk2,
      D => gmii_txd(5),
      Q => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXD_REG1(5)
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXD_REG1_4 : FD
    port map (
      C => userclk2,
      D => gmii_txd(4),
      Q => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXD_REG1(4)
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXD_REG1_3 : FD
    port map (
      C => userclk2,
      D => gmii_txd(3),
      Q => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXD_REG1(3)
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXD_REG1_2 : FD
    port map (
      C => userclk2,
      D => gmii_txd(2),
      Q => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXD_REG1(2)
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXD_REG1_1 : FD
    port map (
      C => userclk2,
      D => gmii_txd(1),
      Q => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXD_REG1(1)
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXD_REG1_0 : FD
    port map (
      C => userclk2,
      D => gmii_txd(0),
      Q => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXD_REG1(0)
    );
  U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd1 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd1_In2,
      R => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd4_In1_0,
      Q => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd1_219
    );
  U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd2 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd2_In2,
      R => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd4_In1_0,
      Q => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd2_220
    );
  U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd4 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd4_In2_223,
      R => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd4_In1_0,
      Q => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd4_222
    );
  U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd3 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd3_In3,
      R => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd4_In1_0,
      Q => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd3_221
    );
  U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_GOOD_CGS_1 : FDRE
    port map (
      C => userclk2,
      CE => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_n0103_inv,
      D => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_GOOD_CGS_1_GND_23_o_mux_30_OUT_1_Q,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_RX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_GOOD_CGS(1)
    );
  U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_GOOD_CGS_0 : FDRE
    port map (
      C => userclk2,
      CE => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_n0103_inv,
      D => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_GOOD_CGS_1_GND_23_o_mux_30_OUT_0_Q,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_RX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_GOOD_CGS(0)
    );
  U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_SIGNAL_DETECT_REG : FD
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_SIGNAL_DETECT_REG,
      Q => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_SIGNAL_DETECT_REG_234
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_RXD_7 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_RXDATA_REG5_7_GND_24_o_mux_9_OUT_7_Q,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG(3),
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_RXD(7)
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_RXD_6 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_RXDATA_REG5_7_GND_24_o_mux_9_OUT_6_Q,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG(3),
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_RXD(6)
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_RXD_5 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_RXDATA_REG5_7_GND_24_o_mux_9_OUT_5_Q,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG(3),
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_RXD(5)
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_RXD_4 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_RXDATA_REG5_7_GND_24_o_mux_9_OUT_4_Q,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG(3),
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_RXD(4)
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_RXD_3 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_RXDATA_REG5_7_GND_24_o_mux_9_OUT_3_Q,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG(3),
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_RXD(3)
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_RXD_2 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_RXDATA_REG5_7_GND_24_o_mux_9_OUT_2_Q,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG(3),
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_RXD(2)
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_RXD_1 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_RXDATA_REG5_7_GND_24_o_mux_9_OUT_1_Q,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG(3),
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_RXD(1)
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_RXD_0 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_RXDATA_REG5_7_GND_24_o_mux_9_OUT_0_Q,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG(3),
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_RXD(0)
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_C_REG3 : FD
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_C_REG2_237,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_C_REG3_317
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_CARRIER_REG3 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_CARRIER_REG2,
      R => U0_xst_options_gpcs_pma_inst_RECEIVER_RESET_SYNC_STATUS_OR_51_o,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_CARRIER_REG3_295
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_CGBAD_REG3 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_CGBAD_REG2,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_RX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_CGBAD_REG3_298
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_SOP_REG3 : FD
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_SOP_REG2_312,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_SOP_REG3_311
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_C_REG2 : FD
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_C_REG1_318,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_C_REG2_237
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_IDLE_REG_2 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_IDLE_REG(1),
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_RX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_IDLE_REG(2)
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_IDLE_REG_1 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_IDLE_REG(0),
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_RX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_IDLE_REG(1)
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_IDLE_REG_0 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_I_REG_319,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_RX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_IDLE_REG(0)
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_EXT_ILLEGAL_K_REG2 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_EXT_ILLEGAL_K_REG1_283,
      R => U0_xst_options_gpcs_pma_inst_RECEIVER_RESET_SYNC_STATUS_OR_51_o,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_EXT_ILLEGAL_K_REG2_282
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_ILLEGAL_K_REG2 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_ILLEGAL_K_REG1_287,
      R => U0_xst_options_gpcs_pma_inst_RECEIVER_RESET_SYNC_STATUS_OR_51_o,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_ILLEGAL_K_REG2_286
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_C_REG1 : FD
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_C_325,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_C_REG1_318
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_T_REG2 : FD
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_T_REG1_322,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_T_REG2_321
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_RX_CONFIG_VALID_REG_3 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_RX_CONFIG_VALID_REG(2),
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_RX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_RX_CONFIG_VALID_REG(3)
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_RX_CONFIG_VALID_REG_2 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_RX_CONFIG_VALID_REG(1),
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_RX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_RX_CONFIG_VALID_REG(2)
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_RX_CONFIG_VALID_REG_1 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_RX_CONFIG_VALID_REG(0),
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_RX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_RX_CONFIG_VALID_REG(1)
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_RX_CONFIG_VALID_REG_0 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_RX_CONFIG_VALID_INT_297,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_RX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_RX_CONFIG_VALID_REG(0)
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_EXT_ILLEGAL_K_REG1 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_EXT_ILLEGAL_K_284,
      R => U0_xst_options_gpcs_pma_inst_RECEIVER_RESET_SYNC_STATUS_OR_51_o,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_EXT_ILLEGAL_K_REG1_283
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_ILLEGAL_K_REG1 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_ILLEGAL_K_288,
      R => U0_xst_options_gpcs_pma_inst_RECEIVER_RESET_SYNC_STATUS_OR_51_o,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_ILLEGAL_K_REG1_287
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_EXTEND_REG1 : FD
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_EXTEND_268,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_EXTEND_REG1_310
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_I_REG : FD
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_I_326,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_I_REG_319
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_R_REG1 : FD
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_R_300,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_R_REG1_320
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_T_REG1 : FD
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_T_327,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_T_REG1_322
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_RUDI_I : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_IDLE_REG_1_IDLE_REG_2_OR_114_o,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_RX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_RUDI_I_54
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_RUDI_C : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_RX_CONFIG_VALID_REG_0_RX_CONFIG_VALID_REG_3_OR_113_o,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_RX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_RUDI_C_55
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_K : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_RXDATA_7_RXNOTINTABLE_AND_211_o,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_RX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_K_280
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_DATA : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_DATA_POS_RXNOTINTABLE_AND_203_o,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_RX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_DATA_281
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_RX_ER : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_EXTEND_REG1_ISOLATE_AND_182_o_245,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_RX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_RX_ER_65
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_EXTEND_ERR : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_EXTEND_REG3_EXT_ILLEGAL_K_REG2_OR_83_o,
      R => U0_xst_options_gpcs_pma_inst_RECEIVER_RESET_SYNC_STATUS_OR_51_o,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_EXTEND_ERR_285
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_ILLEGAL_K : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_RXCHARISK_REG1_K28p5_REG1_AND_167_o,
      R => U0_xst_options_gpcs_pma_inst_RECEIVER_RESET_SYNC_STATUS_OR_51_o,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_ILLEGAL_K_288
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_EOP : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_I_REG_T_REG2_OR_64_o,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_RX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_EOP_291
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_SOP : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_S_WAIT_FOR_K_AND_144_o,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_RX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_SOP_292
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_EOP_REG1 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_EOP_EXTEND_OR_65_o,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_RX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_EOP_REG1_290
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_FROM_RX_CX : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_C_REG1_C_REG3_OR_59_o_241,
      R => U0_xst_options_gpcs_pma_inst_RECEIVER_RESET_SYNC_STATUS_OR_51_o,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_FROM_RX_CX_293
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_SYNC_STATUS_REG : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_SYNC_STATUS_123,
      R => U0_xst_options_gpcs_pma_inst_RECEIVER_RESET_SYNC_STATUS_OR_51_o,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_SYNC_STATUS_REG_296
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_RX_CONFIG_VALID_INT : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_SYNC_STATUS_C_REG1_AND_125_o_258,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_RX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_RX_CONFIG_VALID_INT_297
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_R : FD
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_K23p7,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_R_300
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_CGBAD : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_RXFIFO_ERR_RXDISPERR_OR_36_o,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_RX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_CGBAD_299
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_RXCHARISK_REG1 : FD
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RXCHARISK_INT_118,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_RXCHARISK_REG1_316
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_D0p0_REG : FD
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_D0p0_243,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_D0p0_REG_323
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_K28p5_REG1 : FD
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_K28p5,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_K28p5_REG1_324
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_I : FD
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_EVEN_RXCHARISK_AND_115_o_259,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_I_326
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_S : FD
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_K27p7_RXFIFO_ERR_AND_111_o,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_S_328
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_T : FD
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_K29p7,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_T_327
    );
  U0_xst_options_gpcs_pma_inst_TX_RST_SM_FSM_FFd2_In1 : LUT4
    generic map(
      INIT => X"EA6A"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_TX_RST_SM_FSM_FFd2_76,
      I1 => U0_xst_options_gpcs_pma_inst_TX_RST_SM_FSM_FFd4_78,
      I2 => U0_xst_options_gpcs_pma_inst_TX_RST_SM_FSM_FFd3_77,
      I3 => U0_xst_options_gpcs_pma_inst_TX_RST_SM_FSM_FFd1_75,
      O => U0_xst_options_gpcs_pma_inst_TX_RST_SM_FSM_FFd2_In
    );
  U0_xst_options_gpcs_pma_inst_RX_RST_SM_FSM_FFd2_In1 : LUT4
    generic map(
      INIT => X"EA6A"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RX_RST_SM_FSM_FFd2_69,
      I1 => U0_xst_options_gpcs_pma_inst_RX_RST_SM_FSM_FFd4_71,
      I2 => U0_xst_options_gpcs_pma_inst_RX_RST_SM_FSM_FFd3_70,
      I3 => U0_xst_options_gpcs_pma_inst_RX_RST_SM_FSM_FFd1_68,
      O => U0_xst_options_gpcs_pma_inst_RX_RST_SM_FSM_FFd2_In
    );
  U0_xst_options_gpcs_pma_inst_RX_RST_SM_FSM_FFd3_In1 : LUT4
    generic map(
      INIT => X"E666"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RX_RST_SM_FSM_FFd3_70,
      I1 => U0_xst_options_gpcs_pma_inst_RX_RST_SM_FSM_FFd4_71,
      I2 => U0_xst_options_gpcs_pma_inst_RX_RST_SM_FSM_FFd1_68,
      I3 => U0_xst_options_gpcs_pma_inst_RX_RST_SM_FSM_FFd2_69,
      O => U0_xst_options_gpcs_pma_inst_RX_RST_SM_FSM_FFd3_In
    );
  U0_xst_options_gpcs_pma_inst_TX_RST_SM_FSM_FFd3_In1 : LUT4
    generic map(
      INIT => X"E666"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_TX_RST_SM_FSM_FFd3_77,
      I1 => U0_xst_options_gpcs_pma_inst_TX_RST_SM_FSM_FFd4_78,
      I2 => U0_xst_options_gpcs_pma_inst_TX_RST_SM_FSM_FFd1_75,
      I3 => U0_xst_options_gpcs_pma_inst_TX_RST_SM_FSM_FFd2_76,
      O => U0_xst_options_gpcs_pma_inst_TX_RST_SM_FSM_FFd3_In
    );
  U0_xst_options_gpcs_pma_inst_Mmux_TXCHARDISPVAL_INT_GND_14_o_MUX_194_o11 : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG(1),
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXCHARDISPVAL_131,
      O => U0_xst_options_gpcs_pma_inst_TXCHARDISPVAL_INT_GND_14_o_MUX_194_o
    );
  U0_xst_options_gpcs_pma_inst_Mmux_TXCHARDISPMODE_INT_TXEVEN_MUX_193_o11 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG(1),
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXCHARDISPMODE_132,
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_CNT(0),
      O => U0_xst_options_gpcs_pma_inst_TXCHARDISPMODE_INT_TXEVEN_MUX_193_o
    );
  U0_xst_options_gpcs_pma_inst_Mmux_TXCHARISK_INT_TXEVEN_MUX_192_o11 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG(1),
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXCHARISK_133,
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_CNT(0),
      O => U0_xst_options_gpcs_pma_inst_TXCHARISK_INT_TXEVEN_MUX_192_o
    );
  U0_xst_options_gpcs_pma_inst_Mmux_TXDATA_INT_7_GND_14_o_mux_30_OUT11 : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG(1),
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXDATA(0),
      O => U0_xst_options_gpcs_pma_inst_TXDATA_INT_7_GND_14_o_mux_30_OUT_0_Q
    );
  U0_xst_options_gpcs_pma_inst_Mmux_TXDATA_INT_7_GND_14_o_mux_30_OUT21 : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG(1),
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXDATA(1),
      O => U0_xst_options_gpcs_pma_inst_TXDATA_INT_7_GND_14_o_mux_30_OUT_1_Q
    );
  U0_xst_options_gpcs_pma_inst_Mmux_TXDATA_INT_7_GND_14_o_mux_30_OUT31 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG(1),
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXDATA(2),
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_CNT(0),
      O => U0_xst_options_gpcs_pma_inst_TXDATA_INT_7_GND_14_o_mux_30_OUT_2_Q
    );
  U0_xst_options_gpcs_pma_inst_Mmux_TXDATA_INT_7_GND_14_o_mux_30_OUT41 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG(1),
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXDATA(3),
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_CNT(0),
      O => U0_xst_options_gpcs_pma_inst_TXDATA_INT_7_GND_14_o_mux_30_OUT_3_Q
    );
  U0_xst_options_gpcs_pma_inst_Mmux_TXDATA_INT_7_GND_14_o_mux_30_OUT51 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG(1),
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXDATA(4),
      O => U0_xst_options_gpcs_pma_inst_TXDATA_INT_7_GND_14_o_mux_30_OUT_4_Q
    );
  U0_xst_options_gpcs_pma_inst_Mmux_TXDATA_INT_7_GND_14_o_mux_30_OUT61 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG(1),
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXDATA(5),
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_CNT(0),
      O => U0_xst_options_gpcs_pma_inst_TXDATA_INT_7_GND_14_o_mux_30_OUT_5_Q
    );
  U0_xst_options_gpcs_pma_inst_Mmux_TXDATA_INT_7_GND_14_o_mux_30_OUT71 : LUT3
    generic map(
      INIT => X"4E"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG(1),
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXDATA(6),
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_CNT(0),
      O => U0_xst_options_gpcs_pma_inst_TXDATA_INT_7_GND_14_o_mux_30_OUT_6_Q
    );
  U0_xst_options_gpcs_pma_inst_Mmux_TXDATA_INT_7_GND_14_o_mux_30_OUT81 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG(1),
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXDATA(7),
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_CNT(0),
      O => U0_xst_options_gpcs_pma_inst_TXDATA_INT_7_GND_14_o_mux_30_OUT_7_Q
    );
  U0_xst_options_gpcs_pma_inst_Mmux_RXCHARISK_TXCHARISK_INT_MUX_185_o11 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG(1),
      I1 => rxcharisk,
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXCHARISK_133,
      O => U0_xst_options_gpcs_pma_inst_RXCHARISK_TXCHARISK_INT_MUX_185_o
    );
  U0_xst_options_gpcs_pma_inst_Mmux_RXCHARISCOMMA_TXCHARISK_INT_MUX_186_o11 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG(1),
      I1 => rxchariscomma,
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXCHARISK_133,
      O => U0_xst_options_gpcs_pma_inst_RXCHARISCOMMA_TXCHARISK_INT_MUX_186_o
    );
  U0_xst_options_gpcs_pma_inst_Mmux_RXDATA_7_TXDATA_INT_7_mux_20_OUT11 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG(1),
      I1 => rxdata(0),
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXDATA(0),
      O => U0_xst_options_gpcs_pma_inst_RXDATA_7_TXDATA_INT_7_mux_20_OUT_0_Q
    );
  U0_xst_options_gpcs_pma_inst_Mmux_RXDATA_7_TXDATA_INT_7_mux_20_OUT21 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG(1),
      I1 => rxdata(1),
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXDATA(1),
      O => U0_xst_options_gpcs_pma_inst_RXDATA_7_TXDATA_INT_7_mux_20_OUT_1_Q
    );
  U0_xst_options_gpcs_pma_inst_Mmux_RXDATA_7_TXDATA_INT_7_mux_20_OUT31 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG(1),
      I1 => rxdata(2),
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXDATA(2),
      O => U0_xst_options_gpcs_pma_inst_RXDATA_7_TXDATA_INT_7_mux_20_OUT_2_Q
    );
  U0_xst_options_gpcs_pma_inst_Mmux_RXDATA_7_TXDATA_INT_7_mux_20_OUT41 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG(1),
      I1 => rxdata(3),
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXDATA(3),
      O => U0_xst_options_gpcs_pma_inst_RXDATA_7_TXDATA_INT_7_mux_20_OUT_3_Q
    );
  U0_xst_options_gpcs_pma_inst_Mmux_RXDATA_7_TXDATA_INT_7_mux_20_OUT51 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG(1),
      I1 => rxdata(4),
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXDATA(4),
      O => U0_xst_options_gpcs_pma_inst_RXDATA_7_TXDATA_INT_7_mux_20_OUT_4_Q
    );
  U0_xst_options_gpcs_pma_inst_Mmux_RXDATA_7_TXDATA_INT_7_mux_20_OUT61 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG(1),
      I1 => rxdata(5),
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXDATA(5),
      O => U0_xst_options_gpcs_pma_inst_RXDATA_7_TXDATA_INT_7_mux_20_OUT_5_Q
    );
  U0_xst_options_gpcs_pma_inst_Mmux_RXDATA_7_TXDATA_INT_7_mux_20_OUT71 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG(1),
      I1 => rxdata(6),
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXDATA(6),
      O => U0_xst_options_gpcs_pma_inst_RXDATA_7_TXDATA_INT_7_mux_20_OUT_6_Q
    );
  U0_xst_options_gpcs_pma_inst_Mmux_RXDATA_7_TXDATA_INT_7_mux_20_OUT81 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG(1),
      I1 => rxdata(7),
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXDATA(7),
      O => U0_xst_options_gpcs_pma_inst_RXDATA_7_TXDATA_INT_7_mux_20_OUT_7_Q
    );
  U0_xst_options_gpcs_pma_inst_Mmux_SRESET_PIPE_PWR_14_o_MUX_1_o11 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RESET_INT_128,
      I1 => U0_xst_options_gpcs_pma_inst_SRESET_PIPE_122,
      O => U0_xst_options_gpcs_pma_inst_SRESET_PIPE_PWR_14_o_MUX_1_o
    );
  U0_xst_options_gpcs_pma_inst_Mmux_RXDISPERR_GND_14_o_MUX_183_o11 : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG(1),
      I1 => rxdisperr,
      O => U0_xst_options_gpcs_pma_inst_RXDISPERR_GND_14_o_MUX_183_o
    );
  U0_xst_options_gpcs_pma_inst_Mmux_RXNOTINTABLE_GND_14_o_MUX_182_o11 : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG(1),
      I1 => rxnotintable,
      O => U0_xst_options_gpcs_pma_inst_RXNOTINTABLE_GND_14_o_MUX_182_o
    );
  U0_xst_options_gpcs_pma_inst_Mmux_RXCLKCORCNT_2_GND_14_o_mux_22_OUT11 : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG(1),
      I1 => rxclkcorcnt(0),
      O => U0_xst_options_gpcs_pma_inst_RXCLKCORCNT_2_GND_14_o_mux_22_OUT_0_Q
    );
  U0_xst_options_gpcs_pma_inst_Mmux_RXCLKCORCNT_2_GND_14_o_mux_22_OUT21 : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG(1),
      I1 => rxclkcorcnt(1),
      O => U0_xst_options_gpcs_pma_inst_RXCLKCORCNT_2_GND_14_o_mux_22_OUT_1_Q
    );
  U0_xst_options_gpcs_pma_inst_Mmux_RXCLKCORCNT_2_GND_14_o_mux_22_OUT31 : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG(1),
      I1 => rxclkcorcnt(2),
      O => U0_xst_options_gpcs_pma_inst_RXCLKCORCNT_2_GND_14_o_mux_22_OUT_2_Q
    );
  U0_xst_options_gpcs_pma_inst_Mmux_RXBUFSTATUS_1_GND_14_o_mux_21_OUT21 : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG(1),
      I1 => rxbufstatus(1),
      O => U0_xst_options_gpcs_pma_inst_RXBUFSTATUS_1_GND_14_o_mux_21_OUT_1_Q
    );
  U0_xst_options_gpcs_pma_inst_RX_RST_SM_FSM_FFd1_In1 : LUT4
    generic map(
      INIT => X"FF80"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RX_RST_SM_FSM_FFd4_71,
      I1 => U0_xst_options_gpcs_pma_inst_RX_RST_SM_FSM_FFd3_70,
      I2 => U0_xst_options_gpcs_pma_inst_RX_RST_SM_FSM_FFd2_69,
      I3 => U0_xst_options_gpcs_pma_inst_RX_RST_SM_FSM_FFd1_68,
      O => U0_xst_options_gpcs_pma_inst_RX_RST_SM_FSM_FFd1_In
    );
  U0_xst_options_gpcs_pma_inst_RX_RST_SM_RX_RST_SM_3_GND_14_o_Mux_17_o1 : LUT4
    generic map(
      INIT => X"DFFF"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RX_RST_SM_FSM_FFd3_70,
      I1 => U0_xst_options_gpcs_pma_inst_RX_RST_SM_FSM_FFd4_71,
      I2 => U0_xst_options_gpcs_pma_inst_RX_RST_SM_FSM_FFd1_68,
      I3 => U0_xst_options_gpcs_pma_inst_RX_RST_SM_FSM_FFd2_69,
      O => U0_xst_options_gpcs_pma_inst_RX_RST_SM_3_GND_14_o_Mux_17_o
    );
  U0_xst_options_gpcs_pma_inst_TX_RST_SM_FSM_FFd1_In1 : LUT4
    generic map(
      INIT => X"FF80"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_TX_RST_SM_FSM_FFd4_78,
      I1 => U0_xst_options_gpcs_pma_inst_TX_RST_SM_FSM_FFd3_77,
      I2 => U0_xst_options_gpcs_pma_inst_TX_RST_SM_FSM_FFd2_76,
      I3 => U0_xst_options_gpcs_pma_inst_TX_RST_SM_FSM_FFd1_75,
      O => U0_xst_options_gpcs_pma_inst_TX_RST_SM_FSM_FFd1_In
    );
  U0_xst_options_gpcs_pma_inst_TX_RST_SM_TX_RST_SM_3_GND_14_o_Mux_13_o1 : LUT4
    generic map(
      INIT => X"DFFF"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_TX_RST_SM_FSM_FFd3_77,
      I1 => U0_xst_options_gpcs_pma_inst_TX_RST_SM_FSM_FFd4_78,
      I2 => U0_xst_options_gpcs_pma_inst_TX_RST_SM_FSM_FFd1_75,
      I3 => U0_xst_options_gpcs_pma_inst_TX_RST_SM_FSM_FFd2_76,
      O => U0_xst_options_gpcs_pma_inst_TX_RST_SM_3_GND_14_o_Mux_13_o
    );
  U0_xst_options_gpcs_pma_inst_RESET_INT_RXBUFSTATUS_INT_1_OR_116_o1 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RESET_INT_128,
      I1 => U0_xst_options_gpcs_pma_inst_RXBUFSTATUS_INT(1),
      O => U0_xst_options_gpcs_pma_inst_RESET_INT_RXBUFSTATUS_INT_1_OR_116_o
    );
  U0_xst_options_gpcs_pma_inst_RESET_INT_TXBUFERR_INT_OR_115_o1 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RESET_INT_128,
      I1 => U0_xst_options_gpcs_pma_inst_TXBUFERR_INT_103,
      O => U0_xst_options_gpcs_pma_inst_RESET_INT_TXBUFERR_INT_OR_115_o
    );
  U0_xst_options_gpcs_pma_inst_DCM_LOCKED_SOFT_RESET_OR_2_o1 : LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => reset,
      I1 => dcm_locked,
      O => U0_xst_options_gpcs_pma_inst_DCM_LOCKED_SOFT_RESET_OR_2_o
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_Mmux_PWR_17_o_CONFIG_DATA_7_mux_21_OUT51 : LUT4
    generic map(
      INIT => X"CFCA"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXD_REG1(4),
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CONFIG_DATA(2),
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_XMIT_CONFIG_INT_187,
      I3 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_Mmux_PWR_17_o_CONFIG_DATA_7_mux_21_OUT511,
      O => U0_xst_options_gpcs_pma_inst_TRANSMITTER_PWR_17_o_CONFIG_DATA_7_mux_21_OUT_4_Q
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_Mmux_PWR_17_o_CONFIG_DATA_7_mux_21_OUT61 : LUT4
    generic map(
      INIT => X"CFCA"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXD_REG1(5),
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CONFIG_DATA(2),
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_XMIT_CONFIG_INT_187,
      I3 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_Mmux_PWR_17_o_CONFIG_DATA_7_mux_21_OUT511,
      O => U0_xst_options_gpcs_pma_inst_TRANSMITTER_PWR_17_o_CONFIG_DATA_7_mux_21_OUT_5_Q
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_Mmux_PWR_17_o_CONFIG_DATA_7_mux_21_OUT81 : LUT4
    generic map(
      INIT => X"CFCA"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXD_REG1(7),
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CONFIG_DATA(2),
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_XMIT_CONFIG_INT_187,
      I3 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_Mmux_PWR_17_o_CONFIG_DATA_7_mux_21_OUT511,
      O => U0_xst_options_gpcs_pma_inst_TRANSMITTER_PWR_17_o_CONFIG_DATA_7_mux_21_OUT_7_Q
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_Mmux_PWR_17_o_CONFIG_DATA_7_mux_21_OUT5111 : LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFEFF"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_R_185,
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_V_184,
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_T_193,
      I3 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TX_PACKET_186,
      I4 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_S_195,
      I5 => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG(3),
      O => U0_xst_options_gpcs_pma_inst_TRANSMITTER_Mmux_PWR_17_o_CONFIG_DATA_7_mux_21_OUT511
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_DISP51 : LUT5
    generic map(
      INIT => X"E881811F"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP(3),
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP(4),
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP(1),
      I3 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP(2),
      I4 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP(0),
      O => U0_xst_options_gpcs_pma_inst_TRANSMITTER_DISP5
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_CNT_1_TX_CONFIG_15_wide_mux_4_OUT_7_1 : LUT3
    generic map(
      INIT => X"15"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_CNT(1),
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_C1_OR_C2_188,
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_CNT(0),
      O => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_CNT_1_TX_CONFIG_15_wide_mux_4_OUT_7_Q
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_TX_EN_TRIGGER_T_OR_14_o1 : LUT6
    generic map(
      INIT => X"FFFF444044404440"
    )
    port map (
      I0 => gmii_tx_en,
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TX_EN_REG1_209,
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_S_195,
      I3 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TX_PACKET_186,
      I4 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TRIGGER_T_192,
      I5 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_V_184,
      O => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TX_EN_TRIGGER_T_OR_14_o
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_Mcount_CODE_GRP_CNT_xor_1_11 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_CNT(1),
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_CNT(0),
      O => U0_xst_options_gpcs_pma_inst_TRANSMITTER_Result(1)
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_Mram_CODE_GRP_CNT_1_GND_21_o_Mux_5_o1 : LUT2
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_CNT(1),
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_CNT(0),
      O => U0_xst_options_gpcs_pma_inst_TRANSMITTER_Mram_CODE_GRP_CNT_1_GND_21_o_Mux_5_o
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_TX_EN_EVEN_AND_8_o1 : LUT4
    generic map(
      INIT => X"0040"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TX_ER_REG1_208,
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_CNT(0),
      I2 => gmii_tx_en,
      I3 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TX_EN_REG1_209,
      O => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TX_EN_EVEN_AND_8_o
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_SYNC_DISPARITY_EVEN_AND_42_o1 : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_CNT(0),
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_SYNC_DISPARITY_191,
      O => U0_xst_options_gpcs_pma_inst_TRANSMITTER_SYNC_DISPARITY_EVEN_AND_42_o
    );
  U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_Mmux_GOOD_CGS_1_GND_23_o_mux_30_OUT21 : LUT6
    generic map(
      INIT => X"0000577757770000"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd4_222,
      I1 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd1_219,
      I2 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd2_220,
      I3 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd3_221,
      I4 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_GOOD_CGS(0),
      I5 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_GOOD_CGS(1),
      O => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_GOOD_CGS_1_GND_23_o_mux_30_OUT_1_Q
    );
  U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_n0103_inv1 : LUT5
    generic map(
      INIT => X"A888FFFF"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd4_222,
      I1 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd1_219,
      I2 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd3_221,
      I3 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd2_220,
      I4 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_CGBAD,
      O => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_n0103_inv
    );
  U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_Mmux_GOOD_CGS_1_GND_23_o_mux_30_OUT11 : LUT5
    generic map(
      INIT => X"01115555"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_GOOD_CGS(0),
      I1 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd1_219,
      I2 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd3_221,
      I3 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd2_220,
      I4 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd4_222,
      O => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_GOOD_CGS_1_GND_23_o_mux_30_OUT_0_Q
    );
  U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd1_In21 : LUT6
    generic map(
      INIT => X"D8B0D8B0E8E0F8F0"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd4_222,
      I1 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd2_220,
      I2 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd1_219,
      I3 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd3_221,
      I4 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_GOOD_CGS_1_PWR_19_o_equal_19_o,
      I5 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_CGBAD,
      O => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd1_In2
    );
  U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd4_In1_01 : LUT3
    generic map(
      INIT => X"F1"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_SIGNAL_DETECT_REG_234,
      I1 => U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG(1),
      I2 => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_RX_RESET_INT,
      O => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd4_In1_0
    );
  U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_GOOD_CGS_1_PWR_19_o_equal_19_o_1_1 : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_GOOD_CGS(0),
      I1 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_GOOD_CGS(1),
      O => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_GOOD_CGS_1_PWR_19_o_equal_19_o
    );
  U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_CGBAD1 : LUT5
    generic map(
      INIT => X"FFFEFEFE"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RXBUFSTATUS_INT(1),
      I1 => U0_xst_options_gpcs_pma_inst_RXNOTINTABLE_INT_108,
      I2 => U0_xst_options_gpcs_pma_inst_RXDISPERR_INT_109,
      I3 => U0_xst_options_gpcs_pma_inst_RXCHARISCOMMA_INT_119,
      I4 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_EVEN_124,
      O => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_CGBAD
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_Mmux_RXDATA_REG5_7_GND_24_o_mux_9_OUT21 : LUT4
    generic map(
      INIT => X"5554"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RECEIVER_SOP_REG3_311,
      I1 => U0_xst_options_gpcs_pma_inst_RECEIVER_EXTEND_REG1_310,
      I2 => U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_CARRIER_REG3_295,
      I3 => U0_xst_options_gpcs_pma_inst_RECEIVER_RXDATA_REG5(1),
      O => U0_xst_options_gpcs_pma_inst_RECEIVER_RXDATA_REG5_7_GND_24_o_mux_9_OUT_1_Q
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_Mmux_RXDATA_REG5_7_GND_24_o_mux_9_OUT41 : LUT4
    generic map(
      INIT => X"5554"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RECEIVER_SOP_REG3_311,
      I1 => U0_xst_options_gpcs_pma_inst_RECEIVER_EXTEND_REG1_310,
      I2 => U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_CARRIER_REG3_295,
      I3 => U0_xst_options_gpcs_pma_inst_RECEIVER_RXDATA_REG5(3),
      O => U0_xst_options_gpcs_pma_inst_RECEIVER_RXDATA_REG5_7_GND_24_o_mux_9_OUT_3_Q
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_Mmux_RXDATA_REG5_7_GND_24_o_mux_9_OUT31 : LUT4
    generic map(
      INIT => X"FFFE"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RECEIVER_RXDATA_REG5(2),
      I1 => U0_xst_options_gpcs_pma_inst_RECEIVER_EXTEND_REG1_310,
      I2 => U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_CARRIER_REG3_295,
      I3 => U0_xst_options_gpcs_pma_inst_RECEIVER_SOP_REG3_311,
      O => U0_xst_options_gpcs_pma_inst_RECEIVER_RXDATA_REG5_7_GND_24_o_mux_9_OUT_2_Q
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_Mmux_RXDATA_REG5_7_GND_24_o_mux_9_OUT61 : LUT4
    generic map(
      INIT => X"0002"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RECEIVER_RXDATA_REG5(5),
      I1 => U0_xst_options_gpcs_pma_inst_RECEIVER_EXTEND_REG1_310,
      I2 => U0_xst_options_gpcs_pma_inst_RECEIVER_SOP_REG3_311,
      I3 => U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_CARRIER_REG3_295,
      O => U0_xst_options_gpcs_pma_inst_RECEIVER_RXDATA_REG5_7_GND_24_o_mux_9_OUT_5_Q
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_Mmux_RXDATA_REG5_7_GND_24_o_mux_9_OUT81 : LUT4
    generic map(
      INIT => X"0002"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RECEIVER_RXDATA_REG5(7),
      I1 => U0_xst_options_gpcs_pma_inst_RECEIVER_EXTEND_REG1_310,
      I2 => U0_xst_options_gpcs_pma_inst_RECEIVER_SOP_REG3_311,
      I3 => U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_CARRIER_REG3_295,
      O => U0_xst_options_gpcs_pma_inst_RECEIVER_RXDATA_REG5_7_GND_24_o_mux_9_OUT_7_Q
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_K29p71 : LUT4
    generic map(
      INIT => X"0800"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(2),
      I1 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(3),
      I2 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(1),
      I3 => U0_xst_options_gpcs_pma_inst_RECEIVER_K27p7_RXFIFO_ERR_AND_111_o1_235,
      O => U0_xst_options_gpcs_pma_inst_RECEIVER_K29p7
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_K27p7_RXFIFO_ERR_AND_111_o11 : LUT6
    generic map(
      INIT => X"8000000000000000"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(5),
      I1 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(0),
      I2 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(6),
      I3 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(7),
      I4 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(4),
      I5 => U0_xst_options_gpcs_pma_inst_RXCHARISK_INT_118,
      O => U0_xst_options_gpcs_pma_inst_RECEIVER_K27p7_RXFIFO_ERR_AND_111_o1_235
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_Mmux_RXDATA_REG5_7_GND_24_o_mux_9_OUT11 : LUT4
    generic map(
      INIT => X"FF54"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_CARRIER_REG3_295,
      I1 => U0_xst_options_gpcs_pma_inst_RECEIVER_EXTEND_REG1_310,
      I2 => U0_xst_options_gpcs_pma_inst_RECEIVER_RXDATA_REG5(0),
      I3 => U0_xst_options_gpcs_pma_inst_RECEIVER_SOP_REG3_311,
      O => U0_xst_options_gpcs_pma_inst_RECEIVER_RXDATA_REG5_7_GND_24_o_mux_9_OUT_0_Q
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_Mmux_RXDATA_REG5_7_GND_24_o_mux_9_OUT51 : LUT5
    generic map(
      INIT => X"FFFF4540"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_CARRIER_REG3_295,
      I1 => U0_xst_options_gpcs_pma_inst_RECEIVER_EXTEND_ERR_285,
      I2 => U0_xst_options_gpcs_pma_inst_RECEIVER_EXTEND_REG1_310,
      I3 => U0_xst_options_gpcs_pma_inst_RECEIVER_RXDATA_REG5(4),
      I4 => U0_xst_options_gpcs_pma_inst_RECEIVER_SOP_REG3_311,
      O => U0_xst_options_gpcs_pma_inst_RECEIVER_RXDATA_REG5_7_GND_24_o_mux_9_OUT_4_Q
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_S_WAIT_FOR_K_AND_144_o1 : LUT5
    generic map(
      INIT => X"08080800"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_SYNC_STATUS_123,
      I1 => U0_xst_options_gpcs_pma_inst_RECEIVER_S_328,
      I2 => U0_xst_options_gpcs_pma_inst_RECEIVER_WAIT_FOR_K_271,
      I3 => U0_xst_options_gpcs_pma_inst_RECEIVER_EXTEND_268,
      I4 => U0_xst_options_gpcs_pma_inst_RECEIVER_I_REG_319,
      O => U0_xst_options_gpcs_pma_inst_RECEIVER_S_WAIT_FOR_K_AND_144_o
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_K23p71 : LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(2),
      I1 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(3),
      I2 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(1),
      I3 => U0_xst_options_gpcs_pma_inst_RECEIVER_K27p7_RXFIFO_ERR_AND_111_o1_235,
      O => U0_xst_options_gpcs_pma_inst_RECEIVER_K23p7
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_K27p7_RXFIFO_ERR_AND_111_o1 : LUT5
    generic map(
      INIT => X"00200000"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(1),
      I1 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(2),
      I2 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(3),
      I3 => U0_xst_options_gpcs_pma_inst_RECEIVER_RXFIFO_ERR_RXDISPERR_OR_36_o,
      I4 => U0_xst_options_gpcs_pma_inst_RECEIVER_K27p7_RXFIFO_ERR_AND_111_o1_235,
      O => U0_xst_options_gpcs_pma_inst_RECEIVER_K27p7_RXFIFO_ERR_AND_111_o
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_Mmux_RXDATA_REG5_7_GND_24_o_mux_9_OUT71 : LUT4
    generic map(
      INIT => X"FF10"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_CARRIER_REG3_295,
      I1 => U0_xst_options_gpcs_pma_inst_RECEIVER_EXTEND_REG1_310,
      I2 => U0_xst_options_gpcs_pma_inst_RECEIVER_RXDATA_REG5(6),
      I3 => U0_xst_options_gpcs_pma_inst_RECEIVER_SOP_REG3_311,
      O => U0_xst_options_gpcs_pma_inst_RECEIVER_RXDATA_REG5_7_GND_24_o_mux_9_OUT_6_Q
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_IDLE_REG_1_IDLE_REG_2_OR_114_o1 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RECEIVER_IDLE_REG(1),
      I1 => U0_xst_options_gpcs_pma_inst_RECEIVER_IDLE_REG(2),
      O => U0_xst_options_gpcs_pma_inst_RECEIVER_IDLE_REG_1_IDLE_REG_2_OR_114_o
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_RX_CONFIG_VALID_REG_0_RX_CONFIG_VALID_REG_3_OR_113_o_0_1 : LUT4
    generic map(
      INIT => X"FFFE"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RECEIVER_RX_CONFIG_VALID_REG(0),
      I1 => U0_xst_options_gpcs_pma_inst_RECEIVER_RX_CONFIG_VALID_REG(1),
      I2 => U0_xst_options_gpcs_pma_inst_RECEIVER_RX_CONFIG_VALID_REG(2),
      I3 => U0_xst_options_gpcs_pma_inst_RECEIVER_RX_CONFIG_VALID_REG(3),
      O => U0_xst_options_gpcs_pma_inst_RECEIVER_RX_CONFIG_VALID_REG_0_RX_CONFIG_VALID_REG_3_OR_113_o
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_EXTEND_REG3_EXT_ILLEGAL_K_REG2_OR_83_o1 : LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RECEIVER_EXT_ILLEGAL_K_REG2_282,
      I1 => U0_xst_options_gpcs_pma_inst_RECEIVER_EXTEND_REG3_309,
      I2 => U0_xst_options_gpcs_pma_inst_RECEIVER_CGBAD_REG3_298,
      O => U0_xst_options_gpcs_pma_inst_RECEIVER_EXTEND_REG3_EXT_ILLEGAL_K_REG2_OR_83_o
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_EOP_EXTEND_OR_65_o1 : LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RECEIVER_EOP_291,
      I1 => U0_xst_options_gpcs_pma_inst_RECEIVER_EXTEND_268,
      I2 => U0_xst_options_gpcs_pma_inst_RECEIVER_EXTEND_REG1_310,
      O => U0_xst_options_gpcs_pma_inst_RECEIVER_EOP_EXTEND_OR_65_o
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_RXCHARISK_REG1_K28p5_REG1_AND_167_o1 : LUT4
    generic map(
      INIT => X"0002"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RECEIVER_RXCHARISK_REG1_316,
      I1 => U0_xst_options_gpcs_pma_inst_RECEIVER_K28p5_REG1_324,
      I2 => U0_xst_options_gpcs_pma_inst_RECEIVER_R_300,
      I3 => U0_xst_options_gpcs_pma_inst_RECEIVER_T_327,
      O => U0_xst_options_gpcs_pma_inst_RECEIVER_RXCHARISK_REG1_K28p5_REG1_AND_167_o
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_K28p5_REG1_EVEN_AND_127_o1 : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RECEIVER_K28p5_REG1_324,
      I1 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_EVEN_124,
      O => U0_xst_options_gpcs_pma_inst_RECEIVER_K28p5_REG1_EVEN_AND_127_o
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_RXFIFO_ERR_RXDISPERR_OR_36_o1 : LUT3
    generic map(
      INIT => X"FE"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RXBUFSTATUS_INT(1),
      I1 => U0_xst_options_gpcs_pma_inst_RXNOTINTABLE_INT_108,
      I2 => U0_xst_options_gpcs_pma_inst_RXDISPERR_INT_109,
      O => U0_xst_options_gpcs_pma_inst_RECEIVER_RXFIFO_ERR_RXDISPERR_OR_36_o
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_RESET_SYNC_STATUS_OR_51_o1 : LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_MGT_RX_RESET_INT_1_392,
      I1 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_SYNC_STATUS_123,
      O => U0_xst_options_gpcs_pma_inst_RECEIVER_RESET_SYNC_STATUS_OR_51_o
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_Mmux_PWR_17_o_CONFIG_DATA_7_mux_21_OUT3_SW0 : LUT4
    generic map(
      INIT => X"FFEF"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_R_185,
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_T_193,
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TX_PACKET_186,
      I3 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXD_REG1(2),
      O => N2
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_Mmux_PWR_17_o_CONFIG_DATA_7_mux_21_OUT3 : LUT6
    generic map(
      INIT => X"FFFFBBBA55551110"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_XMIT_CONFIG_INT_187,
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_S_195,
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_V_184,
      I3 => N2,
      I4 => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG(3),
      I5 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CONFIG_DATA(2),
      O => U0_xst_options_gpcs_pma_inst_TRANSMITTER_PWR_17_o_CONFIG_DATA_7_mux_21_OUT_2_Q
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_Mmux_PWR_17_o_CONFIG_DATA_7_mux_21_OUT4_SW0 : LUT4
    generic map(
      INIT => X"FF51"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_R_185,
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TX_PACKET_186,
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXD_REG1(3),
      I3 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_S_195,
      O => N6
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_Mmux_PWR_17_o_CONFIG_DATA_7_mux_21_OUT4 : LUT6
    generic map(
      INIT => X"FFFFFFFE55555554"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_XMIT_CONFIG_INT_187,
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_V_184,
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_T_193,
      I3 => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG(3),
      I4 => N6,
      I5 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CONFIG_DATA(3),
      O => U0_xst_options_gpcs_pma_inst_TRANSMITTER_PWR_17_o_CONFIG_DATA_7_mux_21_OUT_3_Q
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_Mmux_PWR_17_o_CONFIG_DATA_7_mux_21_OUT7_SW0 : LUT4
    generic map(
      INIT => X"FFEA"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_S_195,
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TX_PACKET_186,
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXD_REG1(6),
      I3 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_R_185,
      O => N8
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_Mmux_PWR_17_o_CONFIG_DATA_7_mux_21_OUT7 : LUT6
    generic map(
      INIT => X"DDDDDDDC11111110"
    )
    port map (
      I0 => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG(3),
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_XMIT_CONFIG_INT_187,
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_V_184,
      I3 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_T_193,
      I4 => N8,
      I5 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CONFIG_DATA(1),
      O => U0_xst_options_gpcs_pma_inst_TRANSMITTER_PWR_17_o_CONFIG_DATA_7_mux_21_OUT_6_Q
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_TX_EN_REG1_XMIT_DATA_INT_AND_20_o1 : LUT6
    generic map(
      INIT => X"FFFFFFFDFFFFFFFF"
    )
    port map (
      I0 => gmii_txd(3),
      I1 => gmii_txd(7),
      I2 => gmii_txd(4),
      I3 => gmii_txd(5),
      I4 => gmii_txd(6),
      I5 => gmii_txd(2),
      O => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TX_EN_REG1_XMIT_DATA_INT_AND_20_o1_332
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_TX_EN_REG1_XMIT_DATA_INT_AND_20_o2 : LUT6
    generic map(
      INIT => X"A8AAAAAA20222222"
    )
    port map (
      I0 => gmii_tx_er,
      I1 => gmii_tx_en,
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TX_EN_REG1_XMIT_DATA_INT_AND_20_o1_332,
      I3 => gmii_txd(0),
      I4 => gmii_txd(1),
      I5 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TX_PACKET_186,
      O => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TX_EN_REG1_XMIT_DATA_INT_AND_20_o2_333
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_Mmux_PWR_17_o_CONFIG_DATA_7_mux_21_OUT2_SW0 : LUT4
    generic map(
      INIT => X"5540"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_T_193,
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TX_PACKET_186,
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXD_REG1(1),
      I3 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_R_185,
      O => N10
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_Mmux_PWR_17_o_CONFIG_DATA_7_mux_21_OUT2 : LUT6
    generic map(
      INIT => X"DDDDDDDC11111110"
    )
    port map (
      I0 => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG(3),
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_XMIT_CONFIG_INT_187,
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_V_184,
      I3 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_S_195,
      I4 => N10,
      I5 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CONFIG_DATA(1),
      O => U0_xst_options_gpcs_pma_inst_TRANSMITTER_PWR_17_o_CONFIG_DATA_7_mux_21_OUT_1_Q
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_Mmux_PWR_17_o_CONFIG_DATA_7_mux_21_OUT1_SW0 : LUT4
    generic map(
      INIT => X"FFEA"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_T_193,
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TX_PACKET_186,
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXD_REG1(0),
      I3 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_R_185,
      O => N12
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_Mmux_PWR_17_o_CONFIG_DATA_7_mux_21_OUT1 : LUT6
    generic map(
      INIT => X"DCDDDCDC10111010"
    )
    port map (
      I0 => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG(3),
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_XMIT_CONFIG_INT_187,
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_S_195,
      I3 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_V_184,
      I4 => N12,
      I5 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CONFIG_DATA(0),
      O => U0_xst_options_gpcs_pma_inst_TRANSMITTER_PWR_17_o_CONFIG_DATA_7_mux_21_OUT_0_Q
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_EXTEND_REG1_ISOLATE_AND_182_o_SW0 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG(2),
      I1 => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG(3),
      O => N18
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_EXTEND_REG1_ISOLATE_AND_182_o : LUT6
    generic map(
      INIT => X"00000000FFFACCCC"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RECEIVER_RX_DATA_ERROR_289,
      I1 => U0_xst_options_gpcs_pma_inst_RECEIVER_RECEIVE_269,
      I2 => U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_CARRIER_REG3_295,
      I3 => U0_xst_options_gpcs_pma_inst_RECEIVER_EXTEND_REG1_310,
      I4 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_SYNC_STATUS_123,
      I5 => N18,
      O => U0_xst_options_gpcs_pma_inst_RECEIVER_EXTEND_REG1_ISOLATE_AND_182_o_245
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_EVEN_RXCHARISK_AND_115_o_SW0 : LUT4
    generic map(
      INIT => X"AAA8"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RECEIVER_I_REG_319,
      I1 => U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_NIT_279,
      I2 => U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_K_280,
      I3 => U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_DATA_281,
      O => N22
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_EVEN_RXCHARISK_AND_115_o : LUT6
    generic map(
      INIT => X"00000000A0A88088"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_EVEN_124,
      I1 => U0_xst_options_gpcs_pma_inst_RECEIVER_K28p5_REG1_324,
      I2 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_SYNC_STATUS_123,
      I3 => U0_xst_options_gpcs_pma_inst_RXCHARISK_INT_118,
      I4 => N22,
      I5 => U0_xst_options_gpcs_pma_inst_RECEIVER_K28p5_REG1_D21p5_AND_116_o_norst,
      O => U0_xst_options_gpcs_pma_inst_RECEIVER_EVEN_RXCHARISK_AND_115_o_259
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_K28p51_SW0 : LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(0),
      I1 => U0_xst_options_gpcs_pma_inst_RXCHARISK_INT_118,
      O => N24
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_D21p5_D2p2_OR_38_o1 : LUT6
    generic map(
      INIT => X"4000000000000000"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(6),
      I1 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(7),
      I2 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(0),
      I3 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(2),
      I4 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(4),
      I5 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(5),
      O => U0_xst_options_gpcs_pma_inst_RECEIVER_D21p5_D2p2_OR_38_o
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_D21p5_D2p2_OR_38_o2 : LUT6
    generic map(
      INIT => X"0000000200000000"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(6),
      I1 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(5),
      I2 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(4),
      I3 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(7),
      I4 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(2),
      I5 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(1),
      O => U0_xst_options_gpcs_pma_inst_RECEIVER_D21p5_D2p2_OR_38_o1_340
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_D21p5_D2p2_OR_38_o3 : LUT6
    generic map(
      INIT => X"0013001100030000"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(0),
      I1 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(3),
      I2 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(1),
      I3 => U0_xst_options_gpcs_pma_inst_RXCHARISK_INT_118,
      I4 => U0_xst_options_gpcs_pma_inst_RECEIVER_D21p5_D2p2_OR_38_o,
      I5 => U0_xst_options_gpcs_pma_inst_RECEIVER_D21p5_D2p2_OR_38_o1_340,
      O => U0_xst_options_gpcs_pma_inst_RECEIVER_K28p5_REG1_D21p5_AND_116_o_norst
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_D0p0_SW0 : LUT4
    generic map(
      INIT => X"FFFE"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(5),
      I1 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(4),
      I2 => U0_xst_options_gpcs_pma_inst_RXCHARISK_INT_118,
      I3 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(0),
      O => N26
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_D0p0 : LUT6
    generic map(
      INIT => X"0000000000000001"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(7),
      I1 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(3),
      I2 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(2),
      I3 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(1),
      I4 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(6),
      I5 => N26,
      O => U0_xst_options_gpcs_pma_inst_RECEIVER_D0p0_243
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_C_REG1_C_REG3_OR_59_o_SW0 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RECEIVER_C_REG1_318,
      I1 => U0_xst_options_gpcs_pma_inst_RECEIVER_C_REG2_237,
      O => N28
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_C_REG1_C_REG3_OR_59_o : LUT6
    generic map(
      INIT => X"FFFF8AAACEEE8AAA"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RECEIVER_C_REG3_317,
      I1 => U0_xst_options_gpcs_pma_inst_RECEIVER_CGBAD_299,
      I2 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_EVEN_124,
      I3 => U0_xst_options_gpcs_pma_inst_RECEIVER_K28p5_REG1_324,
      I4 => N28,
      I5 => U0_xst_options_gpcs_pma_inst_RECEIVER_RXCHARISK_REG1_316,
      O => U0_xst_options_gpcs_pma_inst_RECEIVER_C_REG1_C_REG3_OR_59_o_241
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_NIT_POS_FALSE_NIT_NEG_OR_108_o11 : LUT6
    generic map(
      INIT => X"FFBFFFFFBF3FFFFF"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RXDISPERR_INT_109,
      I1 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(6),
      I2 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(4),
      I3 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(7),
      I4 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(3),
      I5 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(1),
      O => U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_NIT_POS_FALSE_NIT_NEG_OR_108_o1
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_NIT_POS_FALSE_NIT_NEG_OR_108_o13 : LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(6),
      I1 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(4),
      I2 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(3),
      I3 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(2),
      I4 => U0_xst_options_gpcs_pma_inst_RXCHARISK_INT_118,
      O => U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_NIT_POS_FALSE_NIT_NEG_OR_108_o13_345
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_I_REG_T_REG2_OR_64_o1 : LUT5
    generic map(
      INIT => X"88888000"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RECEIVER_T_REG2_321,
      I1 => U0_xst_options_gpcs_pma_inst_RECEIVER_R_REG1_320,
      I2 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_EVEN_124,
      I3 => U0_xst_options_gpcs_pma_inst_RECEIVER_K28p5_REG1_324,
      I4 => U0_xst_options_gpcs_pma_inst_RECEIVER_R_300,
      O => U0_xst_options_gpcs_pma_inst_RECEIVER_I_REG_T_REG2_OR_64_o1_346
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_I_REG_T_REG2_OR_64_o2 : LUT6
    generic map(
      INIT => X"FFFFFF80FF80FF80"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RECEIVER_C_REG1_318,
      I1 => U0_xst_options_gpcs_pma_inst_RECEIVER_D0p0_REG_323,
      I2 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_EVEN_124,
      I3 => U0_xst_options_gpcs_pma_inst_RECEIVER_I_REG_T_REG2_OR_64_o1_346,
      I4 => U0_xst_options_gpcs_pma_inst_RECEIVER_I_REG_319,
      I5 => U0_xst_options_gpcs_pma_inst_RECEIVER_K28p5_REG1_324,
      O => U0_xst_options_gpcs_pma_inst_RECEIVER_I_REG_T_REG2_OR_64_o
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_T_REG2_R_REG1_OR_79_o1 : LUT4
    generic map(
      INIT => X"FFFE"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RECEIVER_I_REG_319,
      I1 => U0_xst_options_gpcs_pma_inst_RECEIVER_ILLEGAL_K_REG2_286,
      I2 => U0_xst_options_gpcs_pma_inst_RECEIVER_C_REG1_318,
      I3 => U0_xst_options_gpcs_pma_inst_RECEIVER_CGBAD_REG3_298,
      O => U0_xst_options_gpcs_pma_inst_RECEIVER_T_REG2_R_REG1_OR_79_o1_347
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_T_REG2_R_REG1_OR_79_o2 : LUT5
    generic map(
      INIT => X"54545554"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RECEIVER_R_REG1_320,
      I1 => U0_xst_options_gpcs_pma_inst_RECEIVER_T_REG2_321,
      I2 => U0_xst_options_gpcs_pma_inst_RECEIVER_K28p5_REG1_324,
      I3 => U0_xst_options_gpcs_pma_inst_RECEIVER_R_300,
      I4 => U0_xst_options_gpcs_pma_inst_RECEIVER_T_REG1_322,
      O => U0_xst_options_gpcs_pma_inst_RECEIVER_T_REG2_R_REG1_OR_79_o2_348
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_SYNC_STATUS_C_REG1_AND_125_o_SW0 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RECEIVER_RXCHARISK_REG1_316,
      I1 => U0_xst_options_gpcs_pma_inst_RECEIVER_CGBAD_299,
      O => N30
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_SYNC_STATUS_C_REG1_AND_125_o : LUT6
    generic map(
      INIT => X"0010001000100000"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RECEIVER_RXFIFO_ERR_RXDISPERR_OR_36_o,
      I1 => U0_xst_options_gpcs_pma_inst_RXCHARISK_INT_118,
      I2 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_SYNC_STATUS_123,
      I3 => N30,
      I4 => U0_xst_options_gpcs_pma_inst_RECEIVER_C_REG1_318,
      I5 => U0_xst_options_gpcs_pma_inst_RECEIVER_C_HDR_REMOVED_REG_314,
      O => U0_xst_options_gpcs_pma_inst_RECEIVER_SYNC_STATUS_C_REG1_AND_125_o_258
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_V : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_TRANSMITTER_V_glue_set_350,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_TX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_TRANSMITTER_V_184
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_TX_PACKET : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TX_PACKET_glue_set_351,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_TX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TX_PACKET_186
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_R : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_TRANSMITTER_R_glue_set_352,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_TX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_TRANSMITTER_R_185
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_DISPARITY : FDS
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_TRANSMITTER_DISPARITY_glue_rst_353,
      S => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_TX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_TRANSMITTER_DISPARITY_183
    );
  U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_EVEN : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_EVEN_glue_set_354,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_RX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_EVEN_124
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_RECEIVE : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_RECEIVE_glue_set_355,
      R => U0_xst_options_gpcs_pma_inst_RECEIVER_RESET_SYNC_STATUS_OR_51_o,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_RECEIVE_269
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_RX_INVALID : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_RX_INVALID_glue_set_356,
      R => U0_xst_options_gpcs_pma_inst_RECEIVER_RESET_SYNC_STATUS_OR_51_o,
      Q => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_RECEIVER_RX_INVALID
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_RX_DV : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_RX_DV_glue_set_357,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_RX_RESET_INT,
      Q => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_RECEIVER_RX_DV
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_EXTEND : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_EXTEND_glue_set_358,
      R => U0_xst_options_gpcs_pma_inst_RECEIVER_RESET_SYNC_STATUS_OR_51_o,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_EXTEND_268
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_CARRIER : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_CARRIER_glue_set_359,
      R => U0_xst_options_gpcs_pma_inst_RECEIVER_RESET_SYNC_STATUS_OR_51_o,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_CARRIER_270
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_WAIT_FOR_K : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_WAIT_FOR_K_glue_set_360,
      R => U0_xst_options_gpcs_pma_inst_RECEIVER_RESET_SYNC_STATUS_OR_51_o,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_WAIT_FOR_K_271
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_C1_OR_C2 : FDR
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_TRANSMITTER_C1_OR_C2_rstpot_361,
      R => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_TX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_TRANSMITTER_C1_OR_C2_188
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_XMIT_CONFIG_INT : FDS
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_TRANSMITTER_XMIT_CONFIG_INT_rstpot_362,
      S => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_TX_RESET_INT,
      Q => U0_xst_options_gpcs_pma_inst_TRANSMITTER_XMIT_CONFIG_INT_187
    );
  U0_xst_options_gpcs_pma_inst_RX_RST_SM_FSM_FFd4 : FD
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RX_RST_SM_FSM_FFd4_rstpot_363,
      Q => U0_xst_options_gpcs_pma_inst_RX_RST_SM_FSM_FFd4_71
    );
  U0_xst_options_gpcs_pma_inst_TX_RST_SM_FSM_FFd4 : FD
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_TX_RST_SM_FSM_FFd4_rstpot_364,
      Q => U0_xst_options_gpcs_pma_inst_TX_RST_SM_FSM_FFd4_78
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRPISK : FD
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRPISK_rstpot_365,
      Q => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRPISK_190
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXCHARDISPVAL : FD
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXCHARDISPVAL_rstpot_366,
      Q => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXCHARDISPVAL_131
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_TRIGGER_T : FD
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TRIGGER_T_rstpot_367,
      Q => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TRIGGER_T_192
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_S : FD
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_TRANSMITTER_S_rstpot_368,
      Q => U0_xst_options_gpcs_pma_inst_TRANSMITTER_S_195
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_CONFIG_DATA_0 : FD
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CONFIG_DATA_0_rstpot_369,
      Q => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CONFIG_DATA(0)
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_C_HDR_REMOVED_REG : FD
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_C_HDR_REMOVED_REG_rstpot_370,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_C_HDR_REMOVED_REG_314
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_C : FD
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_C_rstpot_371,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_C_325
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_EXT_ILLEGAL_K : FD
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_EXT_ILLEGAL_K_rstpot_372,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_EXT_ILLEGAL_K_284
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_RX_DATA_ERROR : FD
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_RX_DATA_ERROR_rstpot_373,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_RX_DATA_ERROR_289
    );
  U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_ENCOMMAALIGN : FD
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_ENCOMMAALIGN_rstpot_374,
      Q => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_ENCOMMAALIGN
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_NIT_POS_FALSE_NIT_NEG_OR_108_o12 : LUT6
    generic map(
      INIT => X"FEABFAAFFAAFEABF"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_MGT_RX_RESET_INT_1_392,
      I1 => U0_xst_options_gpcs_pma_inst_RXDISPERR_INT_109,
      I2 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(5),
      I3 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(0),
      I4 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(7),
      I5 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(1),
      O => U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_NIT_POS_FALSE_NIT_NEG_OR_108_o12_344
    );
  U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_SYNC_STATUS : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_SYNC_STATUS_rstpot_375,
      Q => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_SYNC_STATUS_123
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_NIT_POS_FALSE_NIT_NEG_OR_108_o14_SW0 : LUT3
    generic map(
      INIT => X"E8"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RXDISPERR_INT_109,
      I1 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(7),
      I2 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(1),
      O => N32
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_NIT_POS_FALSE_NIT_NEG_OR_108_o14_SW1 : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(2),
      I1 => U0_xst_options_gpcs_pma_inst_RXCHARISK_INT_118,
      O => N33
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_NIT_POS_FALSE_NIT_NEG_OR_108_o15 : LUT6
    generic map(
      INIT => X"FFFFFFFFFFBB5F1B"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(5),
      I1 => N32,
      I2 => N33,
      I3 => U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_NIT_POS_FALSE_NIT_NEG_OR_108_o13_345,
      I4 => U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_NIT_POS_FALSE_NIT_NEG_OR_108_o1,
      I5 => U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_NIT_POS_FALSE_NIT_NEG_OR_108_o12_344,
      O => U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_NIT_POS_FALSE_NIT_NEG_OR_108_o_0
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_NIT_rstpot : LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RXNOTINTABLE_INT_108,
      I1 => U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_NIT_POS_FALSE_NIT_NEG_OR_108_o_0,
      O => U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_NIT_rstpot_378
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_NIT : FD
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_NIT_rstpot_378,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_NIT_279
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_RX_DATA_ERROR_rstpot_SW0 : LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RECEIVER_R_300,
      I1 => U0_xst_options_gpcs_pma_inst_RECEIVER_T_REG2_321,
      O => N39
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_RX_DATA_ERROR_rstpot : LUT6
    generic map(
      INIT => X"00000000AAAAA0A2"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RECEIVER_RECEIVE_269,
      I1 => N39,
      I2 => U0_xst_options_gpcs_pma_inst_RECEIVER_T_REG2_R_REG1_OR_79_o1_347,
      I3 => U0_xst_options_gpcs_pma_inst_RECEIVER_K28p5_REG1_EVEN_AND_127_o,
      I4 => U0_xst_options_gpcs_pma_inst_RECEIVER_T_REG2_R_REG1_OR_79_o2_348,
      I5 => U0_xst_options_gpcs_pma_inst_RECEIVER_RESET_SYNC_STATUS_OR_51_o,
      O => U0_xst_options_gpcs_pma_inst_RECEIVER_RX_DATA_ERROR_rstpot_373
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_DATA_POS_RXNOTINTABLE_AND_203_o4_SW0 : LUT5
    generic map(
      INIT => X"E8FFFFFF"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(4),
      I1 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(3),
      I2 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(2),
      I3 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(1),
      I4 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(0),
      O => N43
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_DATA_POS_RXNOTINTABLE_AND_203_o4_SW1 : LUT5
    generic map(
      INIT => X"FFDFAFBF"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(0),
      I1 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(4),
      I2 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(2),
      I3 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(3),
      I4 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(1),
      O => N44
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_K28p51_SW1 : LUT4
    generic map(
      INIT => X"DFFF"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(4),
      I1 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(1),
      I2 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(3),
      I3 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(2),
      O => N46
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_RXDATA_7_RXNOTINTABLE_AND_211_o1 : LUT6
    generic map(
      INIT => X"0010000000000010"
    )
    port map (
      I0 => N24,
      I1 => U0_xst_options_gpcs_pma_inst_RXNOTINTABLE_INT_108,
      I2 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(7),
      I3 => N46,
      I4 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(5),
      I5 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(6),
      O => U0_xst_options_gpcs_pma_inst_RECEIVER_RXDATA_7_RXNOTINTABLE_AND_211_o
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_K28p51_SW2 : LUT3
    generic map(
      INIT => X"BF"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(1),
      I1 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(3),
      I2 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(2),
      O => N48
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_K28p52 : LUT6
    generic map(
      INIT => X"0000000004000000"
    )
    port map (
      I0 => N24,
      I1 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(7),
      I2 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(6),
      I3 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(5),
      I4 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(4),
      I5 => N48,
      O => U0_xst_options_gpcs_pma_inst_RECEIVER_K28p5
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_DATA_POS_RXNOTINTABLE_AND_203_o4_SW2 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RXCHARISK_INT_118,
      I1 => U0_xst_options_gpcs_pma_inst_RXNOTINTABLE_INT_108,
      O => N68
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_DATA_POS_RXNOTINTABLE_AND_203_o5 : LUT6
    generic map(
      INIT => X"0000000400200024"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(5),
      I1 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(6),
      I2 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(7),
      I3 => N68,
      I4 => N43,
      I5 => N44,
      O => U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_DATA_POS_RXNOTINTABLE_AND_203_o
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_D21p5_D2p2_OR_38_o3_SW0 : LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RXCHARISK_INT_118,
      I1 => U0_xst_options_gpcs_pma_inst_RECEIVER_K28p5_REG1_324,
      O => N70
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_C_rstpot : LUT6
    generic map(
      INIT => X"0013000300110000"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(0),
      I1 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(3),
      I2 => U0_xst_options_gpcs_pma_inst_RXDATA_INT(1),
      I3 => N70,
      I4 => U0_xst_options_gpcs_pma_inst_RECEIVER_D21p5_D2p2_OR_38_o1_340,
      I5 => U0_xst_options_gpcs_pma_inst_RECEIVER_D21p5_D2p2_OR_38_o,
      O => U0_xst_options_gpcs_pma_inst_RECEIVER_C_rstpot_371
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_C1_OR_C2_rstpot : LUT4
    generic map(
      INIT => X"6A2A"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_C1_OR_C2_188,
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_CNT(0),
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_CNT(1),
      I3 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_XMIT_CONFIG_INT_187,
      O => U0_xst_options_gpcs_pma_inst_TRANSMITTER_C1_OR_C2_rstpot_361
    );
  U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_EVEN_glue_set : LUT3
    generic map(
      INIT => X"2F"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RXCHARISCOMMA_INT_119,
      I1 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_SYNC_STATUS_123,
      I2 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_EVEN_124,
      O => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_EVEN_glue_set_354
    );
  U0_xst_options_gpcs_pma_inst_RX_RST_SM_FSM_FFd4_rstpot : LUT6
    generic map(
      INIT => X"0001010101010101"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RESET_INT_128,
      I1 => U0_xst_options_gpcs_pma_inst_RXBUFSTATUS_INT(1),
      I2 => U0_xst_options_gpcs_pma_inst_RX_RST_SM_FSM_FFd4_71,
      I3 => U0_xst_options_gpcs_pma_inst_RX_RST_SM_FSM_FFd2_69,
      I4 => U0_xst_options_gpcs_pma_inst_RX_RST_SM_FSM_FFd3_70,
      I5 => U0_xst_options_gpcs_pma_inst_RX_RST_SM_FSM_FFd1_68,
      O => U0_xst_options_gpcs_pma_inst_RX_RST_SM_FSM_FFd4_rstpot_363
    );
  U0_xst_options_gpcs_pma_inst_TX_RST_SM_FSM_FFd4_rstpot : LUT6
    generic map(
      INIT => X"0001010101010101"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RESET_INT_128,
      I1 => U0_xst_options_gpcs_pma_inst_TXBUFERR_INT_103,
      I2 => U0_xst_options_gpcs_pma_inst_TX_RST_SM_FSM_FFd4_78,
      I3 => U0_xst_options_gpcs_pma_inst_TX_RST_SM_FSM_FFd2_76,
      I4 => U0_xst_options_gpcs_pma_inst_TX_RST_SM_FSM_FFd3_77,
      I5 => U0_xst_options_gpcs_pma_inst_TX_RST_SM_FSM_FFd1_75,
      O => U0_xst_options_gpcs_pma_inst_TX_RST_SM_FSM_FFd4_rstpot_364
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_CONFIG_DATA_0_rstpot : LUT4
    generic map(
      INIT => X"0002"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_CNT(0),
      I1 => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_TX_RESET_INT,
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_C1_OR_C2_188,
      I3 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_CNT(1),
      O => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CONFIG_DATA_0_rstpot_369
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_WAIT_FOR_K_glue_set : LUT5
    generic map(
      INIT => X"2AFF2A2A"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RECEIVER_WAIT_FOR_K_271,
      I1 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_EVEN_124,
      I2 => U0_xst_options_gpcs_pma_inst_RECEIVER_K28p5_REG1_324,
      I3 => U0_xst_options_gpcs_pma_inst_RECEIVER_SYNC_STATUS_REG_296,
      I4 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_SYNC_STATUS_123,
      O => U0_xst_options_gpcs_pma_inst_RECEIVER_WAIT_FOR_K_glue_set_360
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_TX_PACKET_glue_set : LUT3
    generic map(
      INIT => X"BA"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_S_195,
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_T_193,
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TX_PACKET_186,
      O => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TX_PACKET_glue_set_351
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_RECEIVE_glue_set : LUT3
    generic map(
      INIT => X"BA"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RECEIVER_SOP_REG2_312,
      I1 => U0_xst_options_gpcs_pma_inst_RECEIVER_EOP_291,
      I2 => U0_xst_options_gpcs_pma_inst_RECEIVER_RECEIVE_269,
      O => U0_xst_options_gpcs_pma_inst_RECEIVER_RECEIVE_glue_set_355
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_RX_INVALID_glue_set : LUT3
    generic map(
      INIT => X"BA"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RECEIVER_FROM_RX_CX_293,
      I1 => U0_xst_options_gpcs_pma_inst_RECEIVER_K28p5_REG1_324,
      I2 => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_RECEIVER_RX_INVALID,
      O => U0_xst_options_gpcs_pma_inst_RECEIVER_RX_INVALID_glue_set_356
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_TRIGGER_T_rstpot : LUT3
    generic map(
      INIT => X"02"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TX_EN_REG1_209,
      I1 => gmii_tx_en,
      I2 => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_TX_RESET_INT,
      O => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TRIGGER_T_rstpot_367
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_C_HDR_REMOVED_REG_rstpot : LUT4
    generic map(
      INIT => X"0040"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RXCLKCORCNT_INT(1),
      I1 => U0_xst_options_gpcs_pma_inst_RECEIVER_C_REG2_237,
      I2 => U0_xst_options_gpcs_pma_inst_RXCLKCORCNT_INT(0),
      I3 => U0_xst_options_gpcs_pma_inst_RXCLKCORCNT_INT(2),
      O => U0_xst_options_gpcs_pma_inst_RECEIVER_C_HDR_REMOVED_REG_rstpot_370
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_R_glue_set : LUT5
    generic map(
      INIT => X"FFFF4440"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_S_195,
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_R_185,
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_CNT(0),
      I3 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TX_ER_REG1_208,
      I4 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_T_193,
      O => U0_xst_options_gpcs_pma_inst_TRANSMITTER_R_glue_set_352
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_RX_DV_glue_set_SW0 : LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RECEIVER_EOP_REG1_290,
      I1 => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_RECEIVER_RX_DV,
      O => N76
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_RX_DV_glue_set : LUT6
    generic map(
      INIT => X"0200FFFF0200AAAA"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_SYNC_STATUS_123,
      I1 => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG(3),
      I2 => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG(2),
      I3 => U0_xst_options_gpcs_pma_inst_RECEIVER_SOP_REG3_311,
      I4 => N76,
      I5 => U0_xst_options_gpcs_pma_inst_RECEIVER_RECEIVE_269,
      O => U0_xst_options_gpcs_pma_inst_RECEIVER_RX_DV_glue_set_357
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_CARRIER_glue_set_SW1 : LUT4
    generic map(
      INIT => X"FFDF"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RECEIVER_I_REG_319,
      I1 => U0_xst_options_gpcs_pma_inst_RECEIVER_S_328,
      I2 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_SYNC_STATUS_123,
      I3 => U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_NIT_279,
      O => N78
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_CARRIER_glue_set : LUT6
    generic map(
      INIT => X"44444445CCCCCCCD"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RECEIVER_K28p5_REG1_324,
      I1 => U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_CARRIER_270,
      I2 => N78,
      I3 => U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_DATA_281,
      I4 => U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_K_280,
      I5 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_EVEN_124,
      O => U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_CARRIER_glue_set_359
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_DISPARITY_glue_rst_SW1 : LUT3
    generic map(
      INIT => X"08"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_SYNC_DISPARITY_191,
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_CNT(0),
      I2 => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_TX_RESET_INT,
      O => N80
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_DISPARITY_glue_rst : LUT6
    generic map(
      INIT => X"00000000857A7A85"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP(5),
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP(7),
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP(6),
      I3 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_DISPARITY_183,
      I4 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_DISP5,
      I5 => N80,
      O => U0_xst_options_gpcs_pma_inst_TRANSMITTER_DISPARITY_glue_rst_353
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_EXTEND_glue_set_SW0 : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RECEIVER_RECEIVE_269,
      I1 => U0_xst_options_gpcs_pma_inst_RECEIVER_R_REG1_320,
      O => N82
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_EXTEND_glue_set : LUT6
    generic map(
      INIT => X"FFFF022202220222"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_RECEIVER_EXTEND_268,
      I1 => U0_xst_options_gpcs_pma_inst_RECEIVER_S_328,
      I2 => U0_xst_options_gpcs_pma_inst_RECEIVER_K28p5_REG1_324,
      I3 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_EVEN_124,
      I4 => N82,
      I5 => U0_xst_options_gpcs_pma_inst_RECEIVER_R_300,
      O => U0_xst_options_gpcs_pma_inst_RECEIVER_EXTEND_glue_set_358
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_V_glue_set_SW1 : LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TX_PACKET_186,
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TX_ER_REG1_208,
      O => N84
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_V_glue_set : LUT6
    generic map(
      INIT => X"FFFF445444544454"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_XMIT_CONFIG_INT_187,
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TX_EN_REG1_XMIT_DATA_INT_AND_20_o2_333,
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TX_EN_REG1_209,
      I3 => N84,
      I4 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_S_195,
      I5 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_V_184,
      O => U0_xst_options_gpcs_pma_inst_TRANSMITTER_V_glue_set_350
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRPISK_rstpot_SW0 : LUT4
    generic map(
      INIT => X"FFEF"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_V_184,
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_T_193,
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TX_PACKET_186,
      I3 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_S_195,
      O => N86
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRPISK_rstpot : LUT6
    generic map(
      INIT => X"5F5F0F0F5F5C0F0C"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_CNT(1),
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_R_185,
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_XMIT_CONFIG_INT_187,
      I3 => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG(3),
      I4 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_CNT(0),
      I5 => N86,
      O => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRPISK_rstpot_365
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_XMIT_CONFIG_INT_rstpot : LUT3
    generic map(
      INIT => X"A8"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_XMIT_CONFIG_INT_187,
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_CNT(0),
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_CNT(1),
      O => U0_xst_options_gpcs_pma_inst_TRANSMITTER_XMIT_CONFIG_INT_rstpot_362
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_Mmux_CODE_GRPISK_GND_21_o_MUX_79_o11 : LUT3
    generic map(
      INIT => X"2A"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRPISK_190,
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_SYNC_DISPARITY_191,
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_CNT(0),
      O => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRPISK_GND_21_o_MUX_79_o
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_Mmux_CODE_GRP_7_GND_21_o_mux_24_OUT11 : LUT4
    generic map(
      INIT => X"EA2A"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP(0),
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_SYNC_DISPARITY_191,
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_CNT(0),
      I3 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_DISPARITY_183,
      O => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_7_GND_21_o_mux_24_OUT_0_Q
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_Mmux_CODE_GRP_7_GND_21_o_mux_24_OUT21 : LUT3
    generic map(
      INIT => X"2A"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP(1),
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_SYNC_DISPARITY_191,
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_CNT(0),
      O => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_7_GND_21_o_mux_24_OUT_1_Q
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_Mmux_CODE_GRP_7_GND_21_o_mux_24_OUT31 : LUT4
    generic map(
      INIT => X"EA2A"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP(2),
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_SYNC_DISPARITY_191,
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_CNT(0),
      I3 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_DISPARITY_183,
      O => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_7_GND_21_o_mux_24_OUT_2_Q
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_Mmux_CODE_GRP_7_GND_21_o_mux_24_OUT41 : LUT3
    generic map(
      INIT => X"2A"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP(3),
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_SYNC_DISPARITY_191,
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_CNT(0),
      O => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_7_GND_21_o_mux_24_OUT_3_Q
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_Mmux_CODE_GRP_7_GND_21_o_mux_24_OUT51 : LUT4
    generic map(
      INIT => X"2AEA"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP(4),
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_SYNC_DISPARITY_191,
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_CNT(0),
      I3 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_DISPARITY_183,
      O => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_7_GND_21_o_mux_24_OUT_4_Q
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_Mmux_CODE_GRP_7_GND_21_o_mux_24_OUT61 : LUT3
    generic map(
      INIT => X"2A"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP(5),
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_SYNC_DISPARITY_191,
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_CNT(0),
      O => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_7_GND_21_o_mux_24_OUT_5_Q
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_Mmux_CODE_GRP_7_GND_21_o_mux_24_OUT71 : LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP(6),
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_SYNC_DISPARITY_191,
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_CNT(0),
      O => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_7_GND_21_o_mux_24_OUT_6_Q
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_Mmux_CODE_GRP_7_GND_21_o_mux_24_OUT81 : LUT4
    generic map(
      INIT => X"EA2A"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP(7),
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_SYNC_DISPARITY_191,
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_CNT(0),
      I3 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_DISPARITY_183,
      O => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_7_GND_21_o_mux_24_OUT_7_Q
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_n0234_1_1 : LUT3
    generic map(
      INIT => X"20"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_C1_OR_C2_188,
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_CNT(1),
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_CNT(0),
      O => U0_xst_options_gpcs_pma_inst_TRANSMITTER_n0234(1)
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXCHARDISPVAL_rstpot : LUT4
    generic map(
      INIT => X"0040"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_CNT(0),
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_DISPARITY_183,
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_SYNC_DISPARITY_191,
      I3 => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_TX_RESET_INT,
      O => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TXCHARDISPVAL_rstpot_366
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_EXT_ILLEGAL_K_rstpot : LUT6
    generic map(
      INIT => X"0000000000001000"
    )
    port map (
      I0 => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_RX_RESET_INT,
      I1 => U0_xst_options_gpcs_pma_inst_RECEIVER_K28p5_REG1_EVEN_AND_127_o,
      I2 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_SYNC_STATUS_123,
      I3 => U0_xst_options_gpcs_pma_inst_RECEIVER_EXTEND_REG1_310,
      I4 => U0_xst_options_gpcs_pma_inst_RECEIVER_R_300,
      I5 => U0_xst_options_gpcs_pma_inst_RECEIVER_S_328,
      O => U0_xst_options_gpcs_pma_inst_RECEIVER_EXT_ILLEGAL_K_rstpot_372
    );
  U0_xst_options_gpcs_pma_inst_MGT_RX_RESET_INT_1 : FDS
    port map (
      C => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RX_RST_SM_3_GND_14_o_Mux_17_o,
      S => U0_xst_options_gpcs_pma_inst_RESET_INT_RXBUFSTATUS_INT_1_OR_116_o,
      Q => U0_xst_options_gpcs_pma_inst_MGT_RX_RESET_INT_1_392
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_Mcount_CODE_GRP_CNT_xor_0_11_INV_0 : INV
    port map (
      I => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_CNT(0),
      O => U0_xst_options_gpcs_pma_inst_TRANSMITTER_Result(0)
    );
  U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_SYNC_STATUS_rstpot : MUXF7
    port map (
      I0 => N88,
      I1 => N89,
      S => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_CGBAD,
      O => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_SYNC_STATUS_rstpot_375
    );
  U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_SYNC_STATUS_rstpot_F : LUT6
    generic map(
      INIT => X"AAAAAAA8BABAAAA8"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_SYNC_STATUS_123,
      I1 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd3_221,
      I2 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd2_220,
      I3 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd1_219,
      I4 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd4_222,
      I5 => U0_xst_options_gpcs_pma_inst_RXCHARISK_INT_118,
      O => N88
    );
  U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_SYNC_STATUS_rstpot_G : LUT5
    generic map(
      INIT => X"222A22A8"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_SYNC_STATUS_123,
      I1 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd1_219,
      I2 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd4_222,
      I3 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd2_220,
      I4 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd3_221,
      O => N89
    );
  U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd4_In2 : MUXF7
    port map (
      I0 => N90,
      I1 => N91,
      S => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_CGBAD,
      O => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd4_In2_223
    );
  U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd4_In2_F : LUT6
    generic map(
      INIT => X"F0F4540400040404"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd4_222,
      I1 => U0_xst_options_gpcs_pma_inst_RXCHARISCOMMA_INT_119,
      I2 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd1_219,
      I3 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd3_221,
      I4 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd2_220,
      I5 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_GOOD_CGS_1_PWR_19_o_equal_19_o,
      O => N90
    );
  U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd4_In2_G : LUT5
    generic map(
      INIT => X"EC2BEC2A"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd1_219,
      I1 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd3_221,
      I2 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd4_222,
      I3 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd2_220,
      I4 => U0_xst_options_gpcs_pma_inst_RXCHARISCOMMA_INT_119,
      O => N91
    );
  U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd2_In22 : MUXF7
    port map (
      I0 => N92,
      I1 => N93,
      S => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_CGBAD,
      O => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd2_In2
    );
  U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd2_In22_F : LUT6
    generic map(
      INIT => X"F212E2A2F69AE6AA"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd2_220,
      I1 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd4_222,
      I2 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd1_219,
      I3 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd3_221,
      I4 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_GOOD_CGS_1_PWR_19_o_equal_19_o,
      I5 => U0_xst_options_gpcs_pma_inst_RXCHARISK_INT_118,
      O => N92
    );
  U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd2_In22_G : LUT3
    generic map(
      INIT => X"20"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd3_221,
      I1 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd4_222,
      I2 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd2_220,
      O => N93
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_Mmux_TX_PACKET_CODE_GRP_CNT_1_MUX_73_o11 : MUXF7
    port map (
      I0 => N94,
      I1 => N95,
      S => U0_xst_options_gpcs_pma_inst_TRANSMITTER_XMIT_CONFIG_INT_187,
      O => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TX_PACKET_CODE_GRP_CNT_1_MUX_73_o
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_Mmux_TX_PACKET_CODE_GRP_CNT_1_MUX_73_o11_F : LUT6
    generic map(
      INIT => X"FFFFFFFF00000001"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_S_195,
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_V_184,
      I2 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_T_193,
      I3 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_R_185,
      I4 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TX_PACKET_186,
      I5 => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_CONFIGURATION_VECTOR_REG(3),
      O => N94
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_Mmux_TX_PACKET_CODE_GRP_CNT_1_MUX_73_o11_G : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_CNT(1),
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_CNT(0),
      O => N95
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_S_rstpot : MUXF7
    port map (
      I0 => N96,
      I1 => N97,
      S => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TRIGGER_S_194,
      O => U0_xst_options_gpcs_pma_inst_TRANSMITTER_S_rstpot_368
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_S_rstpot_F : LUT6
    generic map(
      INIT => X"0010000000100010"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TX_EN_REG1_209,
      I1 => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_TX_RESET_INT,
      I2 => gmii_tx_en,
      I3 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_XMIT_CONFIG_INT_187,
      I4 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_TX_ER_REG1_208,
      I5 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_CODE_GRP_CNT(0),
      O => N96
    );
  U0_xst_options_gpcs_pma_inst_TRANSMITTER_S_rstpot_G : LUT2
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_MGT_TX_RESET_INT,
      I1 => U0_xst_options_gpcs_pma_inst_TRANSMITTER_XMIT_CONFIG_INT_187,
      O => N97
    );
  U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd3_In32 : MUXF7
    port map (
      I0 => N98,
      I1 => N99,
      S => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd4_222,
      O => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd3_In3
    );
  U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd3_In32_F : LUT6
    generic map(
      INIT => X"AA8AAB8AAA8AAA8A"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd3_221,
      I1 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd2_220,
      I2 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_CGBAD,
      I3 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd1_219,
      I4 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_GOOD_CGS(0),
      I5 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_GOOD_CGS(1),
      O => N98
    );
  U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd3_In32_G : LUT4
    generic map(
      INIT => X"5501"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd3_221,
      I1 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_CGBAD,
      I2 => U0_xst_options_gpcs_pma_inst_RXCHARISK_INT_118,
      I3 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd1_219,
      O => N99
    );
  U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_ENCOMMAALIGN_rstpot : MUXF7
    port map (
      I0 => N100,
      I1 => N101,
      S => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_CGBAD,
      O => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_ENCOMMAALIGN_rstpot_374
    );
  U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_ENCOMMAALIGN_rstpot_F : LUT6
    generic map(
      INIT => X"AAAAA2AAAAAAA2BB"
    )
    port map (
      I0 => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_ENCOMMAALIGN,
      I1 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd2_220,
      I2 => U0_xst_options_gpcs_pma_inst_RXCHARISK_INT_118,
      I3 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd4_222,
      I4 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd3_221,
      I5 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd1_219,
      O => N100
    );
  U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_ENCOMMAALIGN_rstpot_G : LUT5
    generic map(
      INIT => X"FFFFA889"
    )
    port map (
      I0 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd1_219,
      I1 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd2_220,
      I2 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd4_222,
      I3 => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_STATE_FSM_FFd3_221,
      I4 => NlwRenamedSig_OI_U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_ENCOMMAALIGN,
      O => N101
    );
  U0_xst_options_gpcs_pma_inst_Mshreg_STATUS_VECTOR_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => NlwRenamedSig_OI_status_vector(7),
      A1 => NlwRenamedSig_OI_status_vector(7),
      A2 => NlwRenamedSig_OI_status_vector(7),
      A3 => NlwRenamedSig_OI_status_vector(7),
      CE => N0,
      CLK => userclk2,
      D => U0_xst_options_gpcs_pma_inst_SYNCHRONISATION_SYNC_STATUS_123,
      Q => U0_xst_options_gpcs_pma_inst_Mshreg_STATUS_VECTOR_0_407,
      Q15 => NLW_U0_xst_options_gpcs_pma_inst_Mshreg_STATUS_VECTOR_0_Q15_UNCONNECTED
    );
  U0_xst_options_gpcs_pma_inst_STATUS_VECTOR_0 : FDE
    port map (
      C => userclk2,
      CE => N0,
      D => U0_xst_options_gpcs_pma_inst_Mshreg_STATUS_VECTOR_0_407,
      Q => NlwRenamedSignal_U0_xst_options_gpcs_pma_inst_STATUS_VECTOR_0
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_RXDATA_REG5_7 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => N0,
      A1 => N0,
      A2 => NlwRenamedSig_OI_status_vector(7),
      A3 => NlwRenamedSig_OI_status_vector(7),
      CE => N0,
      CLK => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RXDATA_INT(7),
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_RXDATA_REG5_7_408,
      Q15 => NLW_U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_RXDATA_REG5_7_Q15_UNCONNECTED
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_RXDATA_REG5_7 : FDE
    port map (
      C => userclk2,
      CE => N0,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_RXDATA_REG5_7_408,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_RXDATA_REG5(7)
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_RXDATA_REG5_6 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => N0,
      A1 => N0,
      A2 => NlwRenamedSig_OI_status_vector(7),
      A3 => NlwRenamedSig_OI_status_vector(7),
      CE => N0,
      CLK => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RXDATA_INT(6),
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_RXDATA_REG5_6_409,
      Q15 => NLW_U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_RXDATA_REG5_6_Q15_UNCONNECTED
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_RXDATA_REG5_6 : FDE
    port map (
      C => userclk2,
      CE => N0,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_RXDATA_REG5_6_409,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_RXDATA_REG5(6)
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_RXDATA_REG5_5 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => N0,
      A1 => N0,
      A2 => NlwRenamedSig_OI_status_vector(7),
      A3 => NlwRenamedSig_OI_status_vector(7),
      CE => N0,
      CLK => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RXDATA_INT(5),
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_RXDATA_REG5_5_410,
      Q15 => NLW_U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_RXDATA_REG5_5_Q15_UNCONNECTED
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_RXDATA_REG5_5 : FDE
    port map (
      C => userclk2,
      CE => N0,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_RXDATA_REG5_5_410,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_RXDATA_REG5(5)
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_RXDATA_REG5_2 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => N0,
      A1 => N0,
      A2 => NlwRenamedSig_OI_status_vector(7),
      A3 => NlwRenamedSig_OI_status_vector(7),
      CE => N0,
      CLK => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RXDATA_INT(2),
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_RXDATA_REG5_2_411,
      Q15 => NLW_U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_RXDATA_REG5_2_Q15_UNCONNECTED
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_RXDATA_REG5_2 : FDE
    port map (
      C => userclk2,
      CE => N0,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_RXDATA_REG5_2_411,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_RXDATA_REG5(2)
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_RXDATA_REG5_4 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => N0,
      A1 => N0,
      A2 => NlwRenamedSig_OI_status_vector(7),
      A3 => NlwRenamedSig_OI_status_vector(7),
      CE => N0,
      CLK => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RXDATA_INT(4),
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_RXDATA_REG5_4_412,
      Q15 => NLW_U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_RXDATA_REG5_4_Q15_UNCONNECTED
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_RXDATA_REG5_4 : FDE
    port map (
      C => userclk2,
      CE => N0,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_RXDATA_REG5_4_412,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_RXDATA_REG5(4)
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_RXDATA_REG5_3 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => N0,
      A1 => N0,
      A2 => NlwRenamedSig_OI_status_vector(7),
      A3 => NlwRenamedSig_OI_status_vector(7),
      CE => N0,
      CLK => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RXDATA_INT(3),
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_RXDATA_REG5_3_413,
      Q15 => NLW_U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_RXDATA_REG5_3_Q15_UNCONNECTED
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_RXDATA_REG5_3 : FDE
    port map (
      C => userclk2,
      CE => N0,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_RXDATA_REG5_3_413,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_RXDATA_REG5(3)
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_EXTEND_REG3 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => NlwRenamedSig_OI_status_vector(7),
      A1 => NlwRenamedSig_OI_status_vector(7),
      A2 => NlwRenamedSig_OI_status_vector(7),
      A3 => NlwRenamedSig_OI_status_vector(7),
      CE => N0,
      CLK => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_EXTEND_REG1_310,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_EXTEND_REG3_414,
      Q15 => NLW_U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_EXTEND_REG3_Q15_UNCONNECTED
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_EXTEND_REG3 : FDE
    port map (
      C => userclk2,
      CE => N0,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_EXTEND_REG3_414,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_EXTEND_REG3_309
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_RXDATA_REG5_1 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => N0,
      A1 => N0,
      A2 => NlwRenamedSig_OI_status_vector(7),
      A3 => NlwRenamedSig_OI_status_vector(7),
      CE => N0,
      CLK => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RXDATA_INT(1),
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_RXDATA_REG5_1_415,
      Q15 => NLW_U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_RXDATA_REG5_1_Q15_UNCONNECTED
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_RXDATA_REG5_1 : FDE
    port map (
      C => userclk2,
      CE => N0,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_RXDATA_REG5_1_415,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_RXDATA_REG5(1)
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_RXDATA_REG5_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => N0,
      A1 => N0,
      A2 => NlwRenamedSig_OI_status_vector(7),
      A3 => NlwRenamedSig_OI_status_vector(7),
      CE => N0,
      CLK => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RXDATA_INT(0),
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_RXDATA_REG5_0_416,
      Q15 => NLW_U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_RXDATA_REG5_0_Q15_UNCONNECTED
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_RXDATA_REG5_0 : FDE
    port map (
      C => userclk2,
      CE => N0,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_RXDATA_REG5_0_416,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_RXDATA_REG5(0)
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_CGBAD_REG2 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => N0,
      A1 => NlwRenamedSig_OI_status_vector(7),
      A2 => NlwRenamedSig_OI_status_vector(7),
      A3 => NlwRenamedSig_OI_status_vector(7),
      CE => N0,
      CLK => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_CGBAD_299,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_CGBAD_REG2,
      Q15 => NLW_U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_CGBAD_REG2_Q15_UNCONNECTED
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_SOP_REG2 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => NlwRenamedSig_OI_status_vector(7),
      A1 => NlwRenamedSig_OI_status_vector(7),
      A2 => NlwRenamedSig_OI_status_vector(7),
      A3 => NlwRenamedSig_OI_status_vector(7),
      CE => N0,
      CLK => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_SOP_292,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_SOP_REG2_417,
      Q15 => NLW_U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_SOP_REG2_Q15_UNCONNECTED
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_SOP_REG2 : FDE
    port map (
      C => userclk2,
      CE => N0,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_SOP_REG2_417,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_SOP_REG2_312
    );
  U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_FALSE_CARRIER_REG2 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => N0,
      A1 => NlwRenamedSig_OI_status_vector(7),
      A2 => NlwRenamedSig_OI_status_vector(7),
      A3 => NlwRenamedSig_OI_status_vector(7),
      CE => N0,
      CLK => userclk2,
      D => U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_CARRIER_270,
      Q => U0_xst_options_gpcs_pma_inst_RECEIVER_FALSE_CARRIER_REG2,
      Q15 => NLW_U0_xst_options_gpcs_pma_inst_RECEIVER_Mshreg_FALSE_CARRIER_REG2_Q15_UNCONNECTED
    );

end STRUCTURE;

-- synthesis translate_on
