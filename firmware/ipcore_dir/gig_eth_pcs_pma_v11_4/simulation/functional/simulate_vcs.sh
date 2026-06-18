#!/bin/sh

rm -rf simv* csrc DVEfiles AN.DB

echo "Compiling Core Simulation Models"
vlogan +v2k \
../../../gig_eth_pcs_pma_v11_4.v \
../../example_design/gig_eth_pcs_pma_v11_4_sync_block.v \
../../example_design/gig_eth_pcs_pma_v11_4_reset_sync.v \
../../example_design/transceiver/gig_eth_pcs_pma_v11_4_s6_gtpwizard_tile.v \
../../example_design/transceiver/gig_eth_pcs_pma_v11_4_s6_gtpwizard.v \
../../example_design/transceiver/gig_eth_pcs_pma_v11_4_transceiver_A.v \
../../example_design/gig_eth_pcs_pma_v11_4_tx_elastic_buffer.v \
../../example_design/gig_eth_pcs_pma_v11_4_block.v \
../../example_design/gig_eth_pcs_pma_v11_4_example_design.v \
../stimulus_tb.v \
../demo_tb.v

echo "Elaborating design"
vcs +vcs+lic+wait \
    -debug \
    demo_tb glbl

echo "Starting simulation"
./simv -ucli -i ucli_commands.key

dve -vpd vcdplus.vpd -session vcs_session.tcl
