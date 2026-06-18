//------------------------------------------------------------------------------
// File       : gig_eth_pcs_pma_v11_4_block.v
// Author     : Xilinx Inc.
//------------------------------------------------------------------------------
// (c) Copyright 2009 Xilinx, Inc. All rights reserved.
//
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
//
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
//
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
//
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES. 
// 
// 
//------------------------------------------------------------------------------
// Description: This design example connects the core to a Spartan-6
//              tranceiver.
//
//              All of the clock circuitry required for a single
//              instance of the core is included.
//
//
//   ------------------------------------------------------------
//   |                                                          |
//   |        ------------------          -----------------     |
//   |        |      Core      |          |   tranceiver  |     |
//   |        |                |          |               |     |
//   |        |                |          |               |     |
//   |        |                |          |               |     |
// ---------->| GMII        Tx |--------->|           TXP |-------->
//   |        | Tx             |          |           TXN |     |
//   |        |                |          |               |     |
//   |        |                |tranceiver|               |     |
//   |        |                |    I/F   |               |     |
//   |        |                |          |               |     |
//   |        |                |          |               |     |
//   |        | GMII        Rx |          |           RXP |     |
// <----------| Rx             |<---------|           RXN |<--------
//   |        |                |          |               |     |
//   |        ------------------          -----------------     |
//   |                                                          |
//   ------------------------------------------------------------
//
//


`timescale 1 ps/1 ps

//------------------------------------------------------------------------------
// The module declaration for the Core Block Level wrapper.
//------------------------------------------------------------------------------

module gig_eth_pcs_pma_v11_4_block #
   (
      // Set to 1 to Speed up the GTP simulation
      parameter SIM_GTPRESET_SPEEDUP = 0
   )
   (
      output         gtpclkout,             // tranceiver output clock made available to the FPGA fabric.

      //------------------------------------------------------------------------
      // Core connected to GTP0
      //------------------------------------------------------------------------

      input          gtpreset0,             // Full System GTP Reset

      // GMII Interface
      //---------------
     input [7:0]     gmii_txd0,             // Transmit data from client MAC.
     input           gmii_tx_en0,           // Transmit control signal from client MAC.
     input           gmii_tx_er0,           // Transmit control signal from client MAC.
     output [7:0]    gmii_rxd0,             // Received Data to client MAC.
     output          gmii_rx_dv0,           // Received control signal to client MAC.
     output          gmii_rx_er0,           // Received control signal to client MAC.
     output          gmii_isolate0,         // Tristate control to electrically isolate GMII.

      // Management: Alternative to MDIO Interface
      //------------------------------------------
      input [4:0]    configuration_vector0, // Alternative to MDIO interface.

      output [15:0]  status_vector0,        // Core status.
      input          reset0,                // Asynchronous reset for entire core.
      input          signal_detect0,        // Input from PMD to indicate presence of optical input.


      //------------------------------------------------------------------------
      // Tranceiver interface
      //------------------------------------------------------------------------
      input          clkin,                 // tranceiver 125MHz clock, very high quality.
      input          userclk2,              // 125MHz reference clock for all core logic.

      output         txp0,                  // Differential +ve of serial transmission from PMA to PMD.
      output         txn0,                  // Differential -ve of serial transmission from PMA to PMD.
      input          rxp0,                  // Differential +ve for serial reception from PMD to PMA.
      input          rxn0,                  // Differential -ve for serial reception from PMD to PMA.

      output         txp1,                  // Differential +ve of serial transmission from PMA to PMD.
      output         txn1,                  // Differential -ve of serial transmission from PMA to PMD.
      input          rxp1,                  // Differential +ve for serial reception from PMD to PMA.
      input          rxn1                   // Differential -ve for serial reception from PMD to PMA.

   );



   //---------------------------------------------------------------------------
   // internal signals used in this Block level wrapper.
   //---------------------------------------------------------------------------

   // Core <=> tranceiver (GTP0) interconnect
   wire         plllkdet0;                // The PLLs of the tranceiver have locked.
   wire         mgt_rx_reset0;            // Reset for the receiver half of the tranceiver
   wire         mgt_tx_reset0;            // Reset for the transmitter half of the tranceiver
   wire [1:0]   rxbufstatus0;             // Elastic Buffer Status (bit 1 asserted indicates  overflow or underflow).
   wire         rxchariscomma0;           // Comma detected in RXDATA.
   wire         rxcharisk0;               // K character received (or extra data bit) in RXDATA.
   wire [2:0]   rxclkcorcnt0;             // Indicates clock correction.
   wire [7:0]   rxdata0;                  // Data after 8B/10B decoding.
   wire         rxrundisp0;               // Running Disparity after current byte, becomes 9th data bit when RXNOTINTABLE='1'.
   wire         rxdisperr0;               // Disparity-error in RXDATA.
   wire         rxnotintable0;            // Non-existent 8B/10 code indicated.
   wire         txbuferr0;                // TX Buffer error (overflow or underflow).
   wire         powerdown0;               // Powerdown the tranceiver
   wire         txchardispmode0;          // Set running disparity for current byte.
   wire         txchardispval0;           // Set running disparity value.
   wire         txcharisk0;               // K character transmitted in TXDATA.
   wire [7:0]   txdata0;                  // Data for 8B/10B encoding.
   wire         enablealign0;             // Allow the transceivers to serially realign to a comma character.

   wire         loopback;                 // Set the tranceiver for serial or parallel loopback.



   //---------------------------------------------------------------------------
   // Instantiate the core connected to GTP0
   //---------------------------------------------------------------------------

   gig_eth_pcs_pma_v11_4 gig_eth_pcs_pma_core_0
     (
      .mgt_rx_reset         (mgt_rx_reset0),
      .mgt_tx_reset         (mgt_tx_reset0),
      .userclk              (userclk2),
      .userclk2             (userclk2),
      .dcm_locked           (plllkdet0),
      .rxbufstatus          (rxbufstatus0),
      .rxchariscomma        (rxchariscomma0),
      .rxcharisk            (rxcharisk0),
      .rxclkcorcnt          (rxclkcorcnt0),
      .rxdata               (rxdata0),
      .rxdisperr            (rxdisperr0),
      .rxnotintable         (rxnotintable0),
      .rxrundisp            (rxrundisp0),
      .txbuferr             (txbuferr0),
      .powerdown            (powerdown0),
      .txchardispmode       (txchardispmode0),
      .txchardispval        (txchardispval0),
      .txcharisk            (txcharisk0),
      .txdata               (txdata0),
      .enablealign          (enablealign0),
      .gmii_txd             (gmii_txd0),
      .gmii_tx_en           (gmii_tx_en0),
      .gmii_tx_er           (gmii_tx_er0),
      .gmii_rxd             (gmii_rxd0),
      .gmii_rx_dv           (gmii_rx_dv0),
      .gmii_rx_er           (gmii_rx_er0),
      .gmii_isolate         (gmii_isolate0),
      .configuration_vector (configuration_vector0),
      .status_vector        (status_vector0),
      .reset                (reset0),
      .signal_detect        (signal_detect0)

      );

   assign rxbufstatus0[0] = 1'b0;



   //---------------------------------------------------------------------------
   // Component Instantiation for the Spartan-6 Transceiver wrapper
   //---------------------------------------------------------------------------

   gig_eth_pcs_pma_v11_4_transceiver_A #
   (
      // Simulation attribute
      .SIM_GTPRESET_SPEEDUP (SIM_GTPRESET_SPEEDUP)
   )
   transceiver_inst
   (
      .gtpclkout            (gtpclkout),
      .gtpclkin             (userclk2),

      // tranceiver 0
      .gtpreset0            (gtpreset0),
      .plllkdet0            (plllkdet0),
      .resetdone0           (),
      .enablealign0         (enablealign0),
      .powerdown0           (powerdown0),
      .loopback0            (loopback),
      .rxchariscomma0       (rxchariscomma0),
      .rxcharisk0           (rxcharisk0),
      .rxclkcorcnt0         (rxclkcorcnt0),
      .rxdata0              (rxdata0),
      .rxdisperr0           (rxdisperr0),
      .rxnotintable0        (rxnotintable0),
      .rxrundisp0           (rxrundisp0),
      .rxbuferr0            (rxbufstatus0[1]),
      .rxusrclk0            (userclk2),
      .rxusrclk20           (userclk2),
      .rxreset0             (mgt_rx_reset0),
      .txchardispmode0      (txchardispmode0),
      .txchardispval0       (txchardispval0),
      .txcharisk0           (txcharisk0),
      .txdata0              (txdata0),
      .txbuferr0            (txbuferr0),
      .txusrclk0            (userclk2),
      .txusrclk20           (userclk2),
      .txreset0             (mgt_tx_reset0),


      .txn0                 (txn0),
      .txp0                 (txp0),
      .rxn0                 (rxn0),
      .rxp0                 (rxp0),

      .txn1                 (txn1),
      .txp1                 (txp1),
      .rxn1                 (rxn1),
      .rxp1                 (rxp1),

      .clkin                (clkin)
   );


   // Loopback is performed in the core itself.  To alternatively use
   // tranceiver loopback, please drive this port appropriately.
   assign loopback = 1'b0;



endmodule

