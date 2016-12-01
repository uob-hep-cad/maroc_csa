# SimVision Command Script

#
# groups
#

if {[catch {group new -name {System Signals} -overlay 0}] != ""} {
    group using {System Signals}
    group set -overlay 0
    group set -comment {}
    group clear 0 end
}
group insert \
    demo_tb.reset \
    demo_tb.brefclk_p \
    demo_tb.brefclk_n
    demo_tb.signal_detect0 \

if {[catch {group new -name {Management I/F 0} -overlay 0}] != ""} {
    group using {Management I/F}
    group set -overlay 0
    group set -comment {}
    group clear 0 end
}
group insert \
    {demo_tb.dut.configuration_vector0[3:0]} \
    demo_tb.status_vector0

if {[catch {group new -name {Tx GMII 0} -overlay 0}] != ""} {
    group using {Tx GMII}
    group set -overlay 0
    group set -comment {}
    group clear 0 end
}
group insert \
    {demo_tb.gmii_txd0[7:0]} \
    demo_tb.gmii_tx_en0 \
    demo_tb.gmii_tx_er0

if {[catch {group new -name {Rx GMII 0} -overlay 0}] != ""} {
    group using {Rx GMII}
    group set -overlay 0
    group set -comment {}
    group clear 0 end
}
group insert \
    {demo_tb.gmii_rxd0[7:0]} \
    demo_tb.gmii_rx_dv0 \
    demo_tb.gmii_rx_er0

if {[catch {group new -name {Transceiver Tx 0} -overlay 0}] != ""} {
    group using {Transceiver Tx}
    group set -overlay 0
    group set -comment {}
    group clear 0 end
}
group insert \
    demo_tb.txp0 \
    demo_tb.txn0

if {[catch {group new -name {Transceiver Rx 0} -overlay 0}] != ""} {
    group using {Transceiver Rx}
    group set -overlay 0
    group set -comment {}
    group clear 0 end
}
group insert \
    demo_tb.rxp0 \
    demo_tb.rxn0

if {[catch {group new -name {Tx Monitor 0} -overlay 0}] != ""} {
    group using {Tx Monitor}
    group set -overlay 0
    group set -comment {}
    group clear 0 end
}
group insert \
    demo_tb.stimulus_0.mon_tx_clk \
    {demo_tb.stimulus_0.tx_pdata[7:0]} \
    demo_tb.stimulus_0.tx_is_k \
    demo_tb.stimulus_0.bitclock
if {[catch {group new -name {Rx Stimulus 0} -overlay 0}] != ""} {
    group using {Rx Stimulus}
    group set -overlay 0
    group set -comment {}
    group clear 0 end
}
group insert \
    demo_tb.stimulus_0.stim_rx_clk \
    demo_tb.stimulus_0.rx_even \
    {demo_tb.stimulus_0.rx_pdata[7:0]} \
    demo_tb.stimulus_0.rx_is_k \
    demo_tb.stimulus_0.rx_rundisp_pos

if {[catch {group new -name {Test semaphores} -overlay 0}] != ""} {
    group using {Test semaphores}
    group set -overlay 0
    group set -comment {}
    group clear 0 end
}
    demo_tb.configuration_finished \
    demo_tb.tx_monitor_finished0 \
    demo_tb.rx_monitor_finished0 \
    demo_tb.simulation_finished
#
# Waveform windows
#
if {[window find -match exact -name "Waveform 1"] == {}} {
    window new WaveWindow -name "Waveform 1" -geometry 906x585+25+55
} else {
    window geometry "Waveform 1" 906x585+25+55
}
window target "Waveform 1" on
waveform using {Waveform 1}
waveform sidebar visibility partial
waveform set \
    -primarycursor TimeA \
    -signalnames name \
    -signalwidth 175 \
    -units fs \
    -valuewidth 75
cursor set -using TimeA -time 50,000,000,000fs
cursor set -using TimeA -marching 1
waveform baseline set -time 0

set groupId [waveform add -groups {{System Signals}}]

set groupId [waveform add -groups {{Management I/F 0}}]

set groupId [waveform add -groups {{Tx GMII 0}}]

set groupId [waveform add -groups {{Rx GMII 0}}]

set groupId [waveform add -groups {{Transceiver Tx 0}}]

set groupId [waveform add -groups {{Transceiver Rx 0}}]


set groupId [waveform add -groups {{Tx Monitor 0}}]

set groupId [waveform add -groups {{Rx Stimulus 0}}]

set groupId [waveform add -groups {{Test semaphores}}]

waveform xview limits 0fs 10us

simcontrol run -time 200us
