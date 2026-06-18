# The package naming convention is <core_name>_xmdf
package provide gig_eth_pcs_pma_v11_4_xmdf 1.0

# This includes some utilities that support common XMDF operations
package require utilities_xmdf

# Define a namespace for this package. The name of the name space
# is <core_name>_xmdf
namespace eval ::gig_eth_pcs_pma_v11_4_xmdf {
# Use this to define any statics
}

# Function called by client to rebuild the params and port arrays
# Optional when the use context does not require the param or ports
# arrays to be available.
proc ::gig_eth_pcs_pma_v11_4_xmdf::xmdfInit { instance } {
# Variable containing name of library into which module is compiled
# Recommendation: <module_name>
# Required
utilities_xmdf::xmdfSetData $instance Module Attributes Name gig_eth_pcs_pma_v11_4
}
# ::gig_eth_pcs_pma_v11_4_xmdf::xmdfInit

# Function called by client to fill in all the xmdf* data variables
# based on the current settings of the parameters
proc ::gig_eth_pcs_pma_v11_4_xmdf::xmdfApplyParams { instance } {

set fcount 0
# Array containing libraries that are assumed to exist
# Examples include unisim and xilinxcorelib
# Optional
# In this example, we assume that the unisim library will
# be available to the simulation and synthesis tool
utilities_xmdf::xmdfSetData $instance FileSet $fcount type logical_library
utilities_xmdf::xmdfSetData $instance FileSet $fcount logical_library unisim
incr fcount

utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path gig_eth_pcs_pma_v11_4/doc/gig_eth_pcs_pma_v11_4_vinfo.html
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount

utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path gig_eth_pcs_pma_v11_4/doc/pg047-gig-eth-pcs-pma.pdf
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount

utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path gig_eth_pcs_pma_v11_4/example_design/gig_eth_pcs_pma_v11_4_block.v
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount

utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path gig_eth_pcs_pma_v11_4/example_design/gig_eth_pcs_pma_v11_4_block.vhd
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount

utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path gig_eth_pcs_pma_v11_4/example_design/gig_eth_pcs_pma_v11_4_example_design.ucf
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount

utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path gig_eth_pcs_pma_v11_4/example_design/gig_eth_pcs_pma_v11_4_example_design.v
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount

utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path gig_eth_pcs_pma_v11_4/example_design/gig_eth_pcs_pma_v11_4_example_design.vhd
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount

utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path gig_eth_pcs_pma_v11_4/example_design/gig_eth_pcs_pma_v11_4_mod.v
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount

utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path gig_eth_pcs_pma_v11_4/example_design/gig_eth_pcs_pma_v11_4_reset_sync.v
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount

utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path gig_eth_pcs_pma_v11_4/example_design/gig_eth_pcs_pma_v11_4_reset_sync.vhd
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount

utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path gig_eth_pcs_pma_v11_4/example_design/gig_eth_pcs_pma_v11_4_sync_block.v
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount

utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path gig_eth_pcs_pma_v11_4/example_design/gig_eth_pcs_pma_v11_4_sync_block.vhd
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount

utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path gig_eth_pcs_pma_v11_4/example_design/gig_eth_pcs_pma_v11_4_tx_elastic_buffer.v
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount

utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path gig_eth_pcs_pma_v11_4/example_design/gig_eth_pcs_pma_v11_4_tx_elastic_buffer.vhd
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount

utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path gig_eth_pcs_pma_v11_4/example_design/transceiver/gig_eth_pcs_pma_v11_4_s6_gtpwizard.v
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount

utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path gig_eth_pcs_pma_v11_4/example_design/transceiver/gig_eth_pcs_pma_v11_4_s6_gtpwizard.vhd
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount

utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path gig_eth_pcs_pma_v11_4/example_design/transceiver/gig_eth_pcs_pma_v11_4_s6_gtpwizard.xco
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount

utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path gig_eth_pcs_pma_v11_4/example_design/transceiver/gig_eth_pcs_pma_v11_4_s6_gtpwizard_tile.v
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount

utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path gig_eth_pcs_pma_v11_4/example_design/transceiver/gig_eth_pcs_pma_v11_4_s6_gtpwizard_tile.vhd
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount

utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path gig_eth_pcs_pma_v11_4/example_design/transceiver/gig_eth_pcs_pma_v11_4_transceiver_A.v
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount

utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path gig_eth_pcs_pma_v11_4/example_design/transceiver/gig_eth_pcs_pma_v11_4_transceiver_A.vhd
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount

utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path gig_eth_pcs_pma_v11_4/gig_eth_pcs_pma_readme.txt
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount

utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path gig_eth_pcs_pma_v11_4/implement/example_design_xst.xcf
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount

utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path gig_eth_pcs_pma_v11_4/implement/implement.bat
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount

utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path gig_eth_pcs_pma_v11_4/implement/implement.sh
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount

utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path gig_eth_pcs_pma_v11_4/implement/xst.prj
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount

utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path gig_eth_pcs_pma_v11_4/implement/xst.scr
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount

utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path gig_eth_pcs_pma_v11_4/simulation/demo_tb.v
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount

utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path gig_eth_pcs_pma_v11_4/simulation/demo_tb.vhd
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount

utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path gig_eth_pcs_pma_v11_4/simulation/functional/simulate_mti.do
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount

utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path gig_eth_pcs_pma_v11_4/simulation/functional/simulate_ncsim.sh
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount

utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path gig_eth_pcs_pma_v11_4/simulation/functional/simulate_vcs.sh
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount

utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path gig_eth_pcs_pma_v11_4/simulation/functional/ucli_commands.key
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount

utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path gig_eth_pcs_pma_v11_4/simulation/functional/vcs_session.tcl
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount

utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path gig_eth_pcs_pma_v11_4/simulation/functional/wave_mti.do
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount

utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path gig_eth_pcs_pma_v11_4/simulation/functional/wave_ncsim.sv
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount

utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path gig_eth_pcs_pma_v11_4/simulation/stimulus_tb.v
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount

utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path gig_eth_pcs_pma_v11_4/simulation/stimulus_tb.vhd
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount

utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path gig_eth_pcs_pma_v11_4.asy
utilities_xmdf::xmdfSetData $instance FileSet $fcount type asy
incr fcount

utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path gig_eth_pcs_pma_v11_4.ngc
utilities_xmdf::xmdfSetData $instance FileSet $fcount type ngc
incr fcount

utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path gig_eth_pcs_pma_v11_4.v
utilities_xmdf::xmdfSetData $instance FileSet $fcount type verilog
incr fcount

utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path gig_eth_pcs_pma_v11_4.veo
utilities_xmdf::xmdfSetData $instance FileSet $fcount type verilog_template
incr fcount

utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path gig_eth_pcs_pma_v11_4.vhd
utilities_xmdf::xmdfSetData $instance FileSet $fcount type vhdl
incr fcount

utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path gig_eth_pcs_pma_v11_4.vho
utilities_xmdf::xmdfSetData $instance FileSet $fcount type vhdl_template
incr fcount

utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path gig_eth_pcs_pma_v11_4.xco
utilities_xmdf::xmdfSetData $instance FileSet $fcount type coregen_ip
incr fcount

utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path gig_eth_pcs_pma_v11_4_xmdf.tcl
utilities_xmdf::xmdfSetData $instance FileSet $fcount type AnyView
incr fcount

utilities_xmdf::xmdfSetData $instance FileSet $fcount associated_module gig_eth_pcs_pma_v11_4
incr fcount

}

# ::gen_comp_name_xmdf::xmdfApplyParams
