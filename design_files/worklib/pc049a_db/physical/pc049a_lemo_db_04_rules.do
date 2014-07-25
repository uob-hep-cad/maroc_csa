# start of do file

################################################################################
# CLASS DEFINITIONS                                                            #
################################################################################
define (class _bus_ANALOG_TO_MAROC ANALOG_TO_MAROC<63> ANALOG_TO_MAROC<62> ANALOG_TO_MAROC<61> ANALOG_TO_MAROC<60> 
  ANALOG_TO_MAROC<59> ANALOG_TO_MAROC<58> ANALOG_TO_MAROC<57> ANALOG_TO_MAROC<56> 
  ANALOG_TO_MAROC<55> ANALOG_TO_MAROC<54> ANALOG_TO_MAROC<53> ANALOG_TO_MAROC<52> 
  ANALOG_TO_MAROC<51> ANALOG_TO_MAROC<50> ANALOG_TO_MAROC<49> ANALOG_TO_MAROC<48> 
  ANALOG_TO_MAROC<47> ANALOG_TO_MAROC<46> ANALOG_TO_MAROC<45> ANALOG_TO_MAROC<44> 
  ANALOG_TO_MAROC<43> ANALOG_TO_MAROC<42> ANALOG_TO_MAROC<41> ANALOG_TO_MAROC<40> 
  ANALOG_TO_MAROC<39> ANALOG_TO_MAROC<38> ANALOG_TO_MAROC<37> ANALOG_TO_MAROC<36> 
  ANALOG_TO_MAROC<35> ANALOG_TO_MAROC<34> ANALOG_TO_MAROC<33> ANALOG_TO_MAROC<32> 
  ANALOG_TO_MAROC<31> ANALOG_TO_MAROC<30> ANALOG_TO_MAROC<29> ANALOG_TO_MAROC<28> 
  ANALOG_TO_MAROC<27> ANALOG_TO_MAROC<26> ANALOG_TO_MAROC<25> ANALOG_TO_MAROC<24> 
  ANALOG_TO_MAROC<23> ANALOG_TO_MAROC<22> ANALOG_TO_MAROC<21> ANALOG_TO_MAROC<20> 
  ANALOG_TO_MAROC<19> ANALOG_TO_MAROC<18> ANALOG_TO_MAROC<17> ANALOG_TO_MAROC<16> 
  ANALOG_TO_MAROC<15> ANALOG_TO_MAROC<14> ANALOG_TO_MAROC<13> ANALOG_TO_MAROC<12> 
  ANALOG_TO_MAROC<11> ANALOG_TO_MAROC<10> ANALOG_TO_MAROC<9> ANALOG_TO_MAROC<8> 
  ANALOG_TO_MAROC<7> ANALOG_TO_MAROC<6> ANALOG_TO_MAROC<5> ANALOG_TO_MAROC<4> 
  ANALOG_TO_MAROC<3> ANALOG_TO_MAROC<2> ANALOG_TO_MAROC<1> ANALOG_TO_MAROC<0> )
#forget class _bus_ANALOG_TO_MAROC

################################################################################
# LAYERSET DEFINITIONS                                                         #
################################################################################

################################################################################
# CLEARANCE RULES                                                              #
################################################################################
# rule assignments for PCB clearances                                          #
################################################################################
rule PCB (width 0.2257)
rule PCB (clearance 0.1270 (type buried_via_gap))
rule PCB (clearance 0.2570 (type wire_wire))
rule PCB (clearance 0.1800 (type wire_smd))
rule PCB (clearance 0.2000 (type wire_pin))
rule PCB (clearance 0.2000 (type wire_via))
rule PCB (clearance 0.1270 (type smd_smd))
rule PCB (clearance 0.1270 (type smd_pin))
rule PCB (clearance 0.1270 (type smd_via))
rule PCB (clearance 0.1270 (type pin_pin))
rule PCB (clearance 0.1270 (type pin_via))
rule PCB (clearance 0.1270 (type via_via))
rule PCB (clearance 0.1270 (type test_test))
rule PCB (clearance 0.2000 (type test_wire))
rule PCB (clearance 0.1270 (type test_smd))
rule PCB (clearance 0.1270 (type test_pin))
rule PCB (clearance 0.1270 (type test_via))
rule PCB (clearance 0 (type area_wire))
rule PCB (clearance 0 (type area_smd))
rule PCB (clearance 0 (type area_area))
rule PCB (clearance 0 (type area_pin))
rule PCB (clearance 0 (type area_via))
rule PCB (clearance 0 (type area_test))

rule PCB (clearance 0.1270 (type microvia_microvia))
set microvia_microvia off
rule PCB (clearance 0.1270 (type microvia_thrupin))
set microvia_thrupin off
rule PCB (clearance 0.1270 (type microvia_smdpin))
set microvia_smdpin off
rule PCB (clearance 0.1270 (type microvia_thruvia))
set microvia_thruvia off
rule PCB (clearance 0.1270 (type microvia_bbvia))
set microvia_bbvia off
rule PCB (clearance 0.2000 (type microvia_wire))
set microvia_wire off
rule PCB (clearance 0.1270 (type bbvia_bbvia))
set bbvia_bbvia on
rule PCB (clearance 0.1270 (type microvia_testpin))
set microvia_testpin off
rule PCB (clearance 0.1270 (type bbvia_thrupin))
set bbvia_thrupin on
rule PCB (clearance 0.1270 (type microvia_testvia))
set microvia_testvia off
rule PCB (clearance 0.1270 (type bbvia_smdpin))
set bbvia_smdpin on
rule PCB (clearance 0.1270 (type microvia_bondpad))
set microvia_bondpad off
rule PCB (clearance 0.1270 (type bbvia_thruvia))
set bbvia_thruvia on
rule PCB (clearance 0.1270 (type microvia_area))
set microvia_area off
rule PCB (clearance 0.2000 (type bbvia_wire))
set bbvia_wire on
rule PCB (clearance 0.2032 (type nhole_pin))
set nhole_pin off
rule PCB (clearance 0.2032 (type nhole_via))
set nhole_via off
rule PCB (clearance 0.1270 (type bbvia_area))
set bbvia_area on
rule PCB (clearance 0.2032 (type nhole_wire))
set nhole_wire off
rule PCB (clearance 0.2032 (type nhole_area))
set nhole_area off
rule PCB (clearance 0.2032 (type nhole_nhole))
set nhole_nhole off
rule PCB (clearance 0 (type mhole_pin))
set mhole_pin off
rule PCB (clearance 0.1270 (type bbvia_testpin))
set bbvia_testpin on
rule PCB (clearance 0 (type mhole_via))
set mhole_via off
rule PCB (clearance 0.1270 (type bbvia_testvia))
set bbvia_testvia on
rule PCB (clearance 0 (type mhole_wire))
set mhole_wire off
rule PCB (clearance 0 (type mhole_area))
set mhole_area off
rule PCB (clearance 0 (type mhole_nhole))
set mhole_nhole off
rule PCB (clearance 0 (type mhole_mhole))
set mhole_mhole off
rule PCB (clearance 0.1270 (type bbvia_bondpad))
set bbvia_bondpad on

################################################################################
# rule assignments for layer clearances                                        #
################################################################################
rule layer BOTTOM (clearance 0.2000 (type wire_smd))

################################################################################
# rule assignments for class clearances                                        #
################################################################################

################################################################################
# rule assignments for class layer clearances                                  #
################################################################################

################################################################################
# rule assignments for net clearances                                          #
################################################################################

################################################################################
# SAMENET CLEARANCE RULES                                                      #
################################################################################
# rule assignments for PCB clearances                                          #
################################################################################
rule PCB (clearance -1 same_net (type wire_wire))
rule PCB (clearance -1 same_net (type wire_smd))
rule PCB (clearance -1 same_net (type wire_pin))
rule PCB (clearance -1 same_net (type wire_via))
rule PCB (clearance -1 same_net (type smd_smd))
rule PCB (clearance -1 same_net (type smd_pin))
rule PCB (clearance -1 same_net (type smd_via))
rule PCB (clearance -1 same_net (type pin_pin))
rule PCB (clearance -1 same_net (type pin_via))
rule PCB (clearance -1 same_net (type via_via))
rule PCB (clearance -1 same_net (type test_test))
rule PCB (clearance -1 same_net (type test_wire))
rule PCB (clearance -1 same_net (type test_smd))
rule PCB (clearance -1 same_net (type test_pin))
rule PCB (clearance -1 same_net (type test_via))
rule PCB (clearance 0 same_net (type area_wire))
rule PCB (clearance 0 same_net (type area_smd))
rule PCB (clearance 0 same_net (type area_area))
rule PCB (clearance 0 same_net (type area_pin))
rule PCB (clearance 0 same_net (type area_via))
rule PCB (clearance 0 same_net (type area_test))

rule PCB (clearance 0.1270 same_net (type microvia_microvia))
set microvia_microvia same_net off
rule PCB (clearance 0.1270 same_net (type microvia_thrupin))
set microvia_thrupin same_net off
rule PCB (clearance 0.1270 same_net (type microvia_smdpin))
set microvia_smdpin same_net off
rule PCB (clearance 0.1270 same_net (type microvia_thruvia))
set microvia_thruvia same_net off
rule PCB (clearance 0.1270 same_net (type microvia_bbvia))
set microvia_bbvia same_net off
rule PCB (clearance 0.1270 same_net (type microvia_wire))
set microvia_wire same_net off
rule PCB (clearance 0.1270 same_net (type microvia_testpin))
set microvia_testpin same_net off
rule PCB (clearance 0.1270 same_net (type microvia_testvia))
set microvia_testvia same_net off
rule PCB (clearance 0.1270 same_net (type microvia_bondpad))
set microvia_bondpad same_net off
rule PCB (clearance 0.1270 same_net (type microvia_area))
set microvia_area same_net off
rule PCB (clearance 0.2032 same_net (type nhole_pin))
set nhole_pin same_net off
rule PCB (clearance 0.2032 same_net (type nhole_via))
set nhole_via same_net off
rule PCB (clearance 0.2032 same_net (type nhole_wire))
set nhole_wire same_net off
rule PCB (clearance 0.2032 same_net (type nhole_area))
set nhole_area same_net off
rule PCB (clearance 0.2032 same_net (type nhole_nhole))
set nhole_nhole same_net off
rule PCB (clearance 0.1270 same_net (type bbvia_bbvia))
set bbvia_bbvia same_net off
rule PCB (clearance 0.1270 same_net (type bbvia_thrupin))
set bbvia_thrupin same_net off
rule PCB (clearance 0.1270 same_net (type bbvia_smdpin))
set bbvia_smdpin same_net off
rule PCB (clearance 0.1270 same_net (type bbvia_thruvia))
set bbvia_thruvia same_net off
rule PCB (clearance 0.1270 same_net (type bbvia_wire))
set bbvia_wire same_net off
rule PCB (clearance 0.1270 same_net (type bbvia_area))
set bbvia_area same_net off
rule PCB (clearance 0.1270 same_net (type bbvia_testpin))
set bbvia_testpin same_net off
rule PCB (clearance 0.1270 same_net (type bbvia_testvia))
set bbvia_testvia same_net off
rule PCB (clearance 0.1270 same_net (type bbvia_bondpad))
set bbvia_bondpad same_net off

################################################################################
# rule assignments for layer clearances                                        #
################################################################################

################################################################################
# rule assignments for class clearances                                        #
################################################################################

################################################################################
# rule assignments for class layer clearances                                  #
################################################################################

################################################################################
# rule assignments for net clearances                                          #
################################################################################

################################################################################
# WIRING RULES                                                                 #
################################################################################

################################################################################
# rule assignments for pcb wiring                                              #
################################################################################
rule pcb (tjunction on)(junction_type all)
rule pcb (staggered_via on (min_gap 0.1270))

################################################################################
# rule assignments for layer wiring                                            #
################################################################################

################################################################################
# rule assignments for class wiring                                            #
################################################################################

################################################################################
# rule assignments for net wiring                                              #
################################################################################
################################################################################
# VIA_AT_SMD RULES                                                            #
################################################################################
rule pcb (via_at_smd off)
rule PCB (turn_under_pad off)

################################################################################
# PROPERTIES                                                                   #
################################################################################

################################################################################
# TIMING RULES                                                                 #
################################################################################

################################################################################
# rule assignments for class timing                                            #
################################################################################

################################################################################
# rule assignments for class layer timing                                      #
################################################################################

################################################################################
# rule assignments for layer timing                                            #
################################################################################
rule layer TOP (restricted_layer_length_factor 1)
rule layer BOTTOM (restricted_layer_length_factor 1)

################################################################################
# Shielding RULES                                                              #
################################################################################

################################################################################
# NOISE RULES                                                                  #
################################################################################

################################################################################
# rule assignments for class layer noise                                       #
################################################################################

################################################################################
# rule assignments for class noise                                             #
################################################################################

################################################################################
# rule assignments for net noise                                               #
################################################################################

################################################################################
# XTALK RULES                                                                  #
################################################################################

################################################################################
# rule assignments for net xtalk                                               #
################################################################################

################################################################################
# Diff Pair RULES                                                              #
################################################################################

################################################################################
# rule assignments for class diff pair                                         #
################################################################################

################################################################################
# rule assignments for group diff pair                                         #
################################################################################

# end of do file