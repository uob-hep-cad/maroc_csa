#!/bin/sh
mkdir work

echo "Compiling Core Simulation Models"
ncvlog -work work ../../../gig_eth_pcs_pma_v11_4.v

echo "Compiling Example Design"
ncvlog -work work \
../../example_design/gig_eth_pcs_pma_v11_4_sync_block.v \
../../example_design/gig_eth_pcs_pma_v11_4_reset_sync.v \
../../example_design/transceiver/gig_eth_pcs_pma_v11_4_s6_gtpwizard_tile.v \
../../example_design/transceiver/gig_eth_pcs_pma_v11_4_s6_gtpwizard.v \
../../example_design/transceiver/gig_eth_pcs_pma_v11_4_transceiver_A.v \
../../example_design/gig_eth_pcs_pma_v11_4_tx_elastic_buffer.v \
../../example_design/gig_eth_pcs_pma_v11_4_block.v \
../../example_design/gig_eth_pcs_pma_v11_4_example_design.v

echo "Compiling Test Bench"
ncvlog -work work ../stimulus_tb.v ../demo_tb.v

echo "Elaborating design"
ncelab -access +rw work.demo_tb glbl

echo "Starting simulation"
ncsim -gui work.demo_tb -input @"simvision -input wave_ncsim.sv"
