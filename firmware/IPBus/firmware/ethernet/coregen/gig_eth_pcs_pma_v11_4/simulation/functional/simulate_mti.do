vlib work
vmap work work

echo "Compiling Core Simulation Models"
vcom -work work ../../../gig_eth_pcs_pma_v11_4.vhd

echo "Compiling Example Design"
vcom -2008 -work work \
../../example_design/gig_eth_pcs_pma_v11_4_sync_block.vhd \
../../example_design/gig_eth_pcs_pma_v11_4_reset_sync.vhd \
../../example_design/transceiver/gig_eth_pcs_pma_v11_4_s6_gtpwizard_tile.vhd \
../../example_design/transceiver/gig_eth_pcs_pma_v11_4_s6_gtpwizard.vhd \
../../example_design/transceiver/gig_eth_pcs_pma_v11_4_transceiver_A.vhd \
../../example_design/gig_eth_pcs_pma_v11_4_tx_elastic_buffer.vhd \
../../example_design/gig_eth_pcs_pma_v11_4_block.vhd \
../../example_design/gig_eth_pcs_pma_v11_4_example_design.vhd

echo "Compiling Test Bench"
vcom -work work -novopt ../stimulus_tb.vhd ../demo_tb.vhd

echo "Starting simulation"
vsim -voptargs="+acc" -t ps work.demo_tb
do wave_mti.do
run -all

