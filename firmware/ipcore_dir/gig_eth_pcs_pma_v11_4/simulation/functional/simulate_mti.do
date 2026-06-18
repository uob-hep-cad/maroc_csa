vlib work
vmap work work

echo "Compiling Core Simulation Models"
vlog -work work ../../../gig_eth_pcs_pma_v11_4.v

echo "Compiling Example Design"
vlog -work work \
../../example_design/gig_eth_pcs_pma_v11_4_sync_block.v \
../../example_design/gig_eth_pcs_pma_v11_4_reset_sync.v \
../../example_design/transceiver/gig_eth_pcs_pma_v11_4_s6_gtpwizard_tile.v \
../../example_design/transceiver/gig_eth_pcs_pma_v11_4_s6_gtpwizard.v \
../../example_design/transceiver/gig_eth_pcs_pma_v11_4_transceiver_A.v \
../../example_design/gig_eth_pcs_pma_v11_4_tx_elastic_buffer.v \
../../example_design/gig_eth_pcs_pma_v11_4_block.v \
../../example_design/gig_eth_pcs_pma_v11_4_example_design.v

echo "Compiling Test Bench"
vlog -work work -novopt ../stimulus_tb.v ../demo_tb.v

echo "Starting simulation"
vsim -voptargs="+acc" -L unisims_ver -L secureip -t ps work.demo_tb work.glbl
do wave_mti.do
run -all

