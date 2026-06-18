gui_open_window Wave
gui_list_select -id Hier.1 { glbl demo_tb }
gui_sg_create PCS_PMA_group
gui_list_add_group -id Wave.1 {PCS_PMA_group}

gui_list_add_divider -id Wave.1 -after PCS_PMA_group { System_Signals0 }
gui_list_add_divider -id Wave.1 -after PCS_PMA_group { Rx_Stimulus0 }
gui_list_add_divider -id Wave.1 -after PCS_PMA_group { Tx_Monitor0 }
gui_list_add_divider -id Wave.1 -after PCS_PMA_group { Transceiver_Rx_Signals0 }
gui_list_add_divider -id Wave.1 -after PCS_PMA_group { Transceiver_Tx_Signals0 }
gui_list_add_divider -id Wave.1 -after PCS_PMA_group { Rx_GMII_Signals0 }
gui_list_add_divider -id Wave.1 -after PCS_PMA_group { Tx_GMII_Signals0 }
gui_list_add_divider -id Wave.1 -after PCS_PMA_group { Management_Signals0 }
gui_list_add_divider -id Wave.1 -after PCS_PMA_group { Core_Inst_0 }
gui_list_add_divider -id Wave.1 -after PCS_PMA_group { System_Signals }
gui_list_add -id Wave.1 -after System_Signals {{demo_tb.brefclk_p} {demo_tb.brefclk_n}}
gui_list_add -id Wave.1 -after System_Signals0 {demo_tb.signal_detect0}
gui_list_add -id Wave.1 -after Management_Signals0 {{demo_tb.dut.configuration_vector0}}
gui_list_add -id Wave.1 -after Management_Signals0 {{demo_tb.status_vector0}}
gui_list_add -id Wave.1 -after Tx_GMII_Signals0 {{demo_tb.gmii_txd0} {demo_tb.gmii_tx_en0} {demo_tb.gmii_tx_er0}}
gui_list_add -id Wave.1 -after Rx_GMII_Signals0 {{demo_tb.gmii_rxd0} {demo_tb.gmii_rx_dv0} {demo_tb.gmii_rx_er0}}
gui_list_add -id Wave.1 -after Transceiver_Tx_Signals0 {{demo_tb.txp0} {demo_tb.txn0}}
gui_list_add -id Wave.1 -after Transceiver_Rx_Signals0 {{demo_tb.rxp0} {demo_tb.rxn0}}
gui_list_add -id Wave.1 -after Tx_Monitor0 {{demo_tb.stimulus_0.mon_tx_clk} {demo_tb.stimulus_0.tx_pdata} {demo_tb.stimulus_0.tx_is_k} {demo_tb.stimulus_0.bitclock}}
gui_list_add -id Wave.1 -after Rx_Stimulus0 {{demo_tb.stimulus_0.stim_rx_clk} {demo_tb.stimulus_0.rx_even} {demo_tb.stimulus_0.rx_pdata} {demo_tb.stimulus_0.rx_is_k} {demo_tb.stimulus_0.rx_rundisp_pos}}
gui_list_add -id Wave.1 -after Test_semaphores {{demo_tb.configuration_finished}}
gui_list_add -id Wave.1 -after Test_semaphores {{demo_tb.tx_monitor_finished0} {demo_tb.rx_monitor_finished0}}
gui_list_add -id Wave.1 -after Test_semaphores {{demo_tb.simulation_finished}}
gui_zoom -window Wave.1 -full

