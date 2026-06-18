//------------------------------------------------------------------------------
// File       : gig_eth_pcs_pma_v11_4_example_design.v
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
// Description: This is the top level Verilog example design for the
//              Ethernet 1000BASE-X PCS/PMA core.
//
//              This design example instantiates IOB flip-flops
//              on the GMII.
//
//              A Transmitter Elastic Buffer is instantiated on the Tx
//              GMII path to perform clock compenstation between the
//              core and the external MAC driving the Tx GMII.
//
//              This design example can be synthesised.
//
//
//
//    ----------------------------------------------------------------
//    |                             Example Design                   |
//    |                                                              |
//    |             ----------------------------------------------   |
//    |             |           Core Block (wrapper)             |   |
//    |             |                                            |   |
//    |             |   --------------          --------------   |   |
//    |             |   |    Core    |          | tranceiver |   |   |
//    |             |   |            |          |            |   |   |
//    |  ---------  |   |            |          |            |   |   |
//    |  |       |  |   |            |          |            |   |   |
//    |  |  Tx   |  |   |            |          |            |   |   |
//  ---->|Elastic|----->| GMII       |--------->|        TXP |--------->
//    |  |Buffer |  |   | Tx         |          |        TXN |   |   |
//    |  |       |  |   |            |          |            |   |   |
//    |  ---------  |   |            |tranceiver|            |   |   |
//    | GMII        |   |            |    I/F   |            |   |   |
//    | IOBs        |   |            |          |            |   |   |
//    |             |   |            |          |            |   |   |
//    |             |   | GMII       |          |        RXP |   |   |
//  <-------------------| Rx         |<---------|        RXN |<---------
//    |             |   |            |          |            |   |   |
//    |             |   --------------          --------------   |   |
//    |             |                                            |   |
//    |             ----------------------------------------------   |
//    |                                                              |
//    ----------------------------------------------------------------
//
//


`timescale 1 ps/1 ps

//------------------------------------------------------------------------------
// The module declaration for the example design
//------------------------------------------------------------------------------

module gig_eth_pcs_pma_v11_4_example_design
   (

      //------------------------------------------------------------------------
      // Core connected to GTP0
      //------------------------------------------------------------------------

      // GMII Interface
      //---------------
      input        gmii_tx_clk0,          // Transmit clock from client MAC.
      output       gmii_rx_clk0,          // Receive clock to client MAC.
      input  [7:0] gmii_txd0,             // Transmit data from client MAC.
      input        gmii_tx_en0,           // Transmit control signal from client MAC.
      input        gmii_tx_er0,           // Transmit control signal from client MAC.
      output [7:0] gmii_rxd0,             // Received Data to client MAC.
      output       gmii_rx_dv0,           // Received control signal to client MAC.
      output       gmii_rx_er0,           // Received control signal to client MAC.

      // Management: Alternative to MDIO Interface
      //------------------------------------------
      input  [4:0] configuration_vector0, // Alternative to MDIO interface.

      // General IO's
      //-------------
      output [15:0] status_vector0,        // Core status.
      input        reset0,                // Asynchronous reset for entire core.
      input        signal_detect0,        // Input from PMD to indicate presence of optical input.


      //------------------------------------------------------------------------
      // Tranceiver interfaces
      //------------------------------------------------------------------------

      input        brefclk_p,             // Differential +ve of reference clock for tranceiver: 125MHz, very high quality
      input        brefclk_n,             // Differential -ve of reference clock for tranceiver: 125MHz, very high quality

      output       txp0,                  // Differential +ve of serial transmission from PMA to PMD.
      output       txn0,                  // Differential -ve of serial transmission from PMA to PMD.
      input        rxp0,                  // Differential +ve for serial reception from PMD to PMA.
      input        rxn0,                  // Differential -ve for serial reception from PMD to PMA.

      output       txp1,                  // Differential +ve of serial transmission from PMA to PMD.
      output       txn1,                  // Differential -ve of serial transmission from PMA to PMD.
      input        rxp1,                  // Differential +ve for serial reception from PMD to PMA.
      input        rxn1                   // Differential -ve for serial reception from PMD to PMA.
   );



   //---------------------------------------------------------------------------
   // internal signals used in this top level example design.
   //---------------------------------------------------------------------------

   // clock/reset generation signals
   wire         clkin;                    // tranceiver 125MHz clock, very high quality.
   wire         userclk2;                 // 125MHz reference clock derived from tranceiver clock circuitry.
   wire         not_userclk2;             // Inverted form of userclk2.
   wire         gtpclkout;                // tranceiver output clock made available to the FPGA fabric.
   wire         gtpclkout_bufio2;         // gtpclkout is routed through a BUFIO2 clock buffer

   // GMII signals for the core connected to GTP0
   wire         gtpreset0;                // System reset for tranceiver.
   wire         gmii_tx_clk_bufio0;       // gmii_tx_clk routed through an BUFIO.
   wire         gmii_tx_clk_bufg0;        // gmii_tx_clk_ibuf routed through a BUFR.
   wire [7:0]   gmii_txd_delay0;          // Internal gmii_txd signal after IDELAY.
   wire         gmii_tx_en_delay0;        // Internal gmii_tx_en signal after IDELAY.
   wire         gmii_tx_er_delay0;        // Internal gmii_tx_er signal after IDELAY.
   wire         gmii_isolate0;            // internal gmii_isolate signal.
   reg  [7:0]   gmii_txd_iff0;            // gmii_txd signal for input IOB flip-flop.
   reg          gmii_tx_en_iff0;          // gmii_tx_en signal for input IOB flip-flop.
   reg          gmii_tx_er_iff0;          // gmii_tx_er signal for input IOB flip-flop.
   reg  [7:0]   gmii_txd_reg0;            // gmii_txd signal reclocked onto regional routing.
   reg          gmii_tx_en_reg0;          // gmii_tx_en signal reclocked onto regional routing.
   reg          gmii_tx_er_reg0;          // gmii_tx_er signal reclocked onto regional routing.
   wire  [7:0]  gmii_txd_fifo0;           // gmii_txd signal after Tx Elastic Buffer.
   wire         gmii_tx_en_fifo0;         // gmii_tx_en signal after Tx Elastic Buffer.
   wire         gmii_tx_er_fifo0;         // gmii_tx_er signal after Tx Elastic Buffer.
   wire  [7:0]  gmii_rxd_int0;            // internal gmii_rxd signal.
   wire         gmii_rx_dv_int0;          // internal gmii_rx_dv signal.
   wire         gmii_rx_er_int0;          // internal gmii_rx_er signal.
   wire         gmii_rx_clk_obuf0;        // gmii_rx_clk  registered in IOBs prior to an OBUF.
   reg   [7:0]  gmii_rxd_obuf0;           // gmii_rxd registered in IOBs prior to an OBUF.
   reg          gmii_rx_dv_obuf0;         // gmii_rx_dv registered in IOBs prior to an OBUF.
   reg          gmii_rx_er_obuf0;         // gmii_rx_er registered in IOBs prior to an OBUF.



   //---------------------------------------------------------------------------
   // Spartan-6 Transceiver Clock Management
   //---------------------------------------------------------------------------

   // NOTE: BREFCLK circuitry for the Transceiver requires the use of a
   // 125MHz differential input clock.  clkin is routed to the tranceiver
   // pair.

   IBUFDS clkingen (
      .I   (brefclk_p),
      .IB  (brefclk_n),
      .O   (clkin)
   );


   // gtpclkout (125MHz) is made avaiable by the tranceiver to the FPGA
   // fabric. This is routed to a BUFIO2 before being placed onto global clock
   // routing where it is then used for tranceiver TXUSRCLK2/RXUSRCLK2 and used
   // to clock all Ethernet core logic.

   // Route through a BUFIO2
   BUFIO2 # (
      .DIVIDE        (1),
      .DIVIDE_BYPASS ("TRUE")
   ) bufio2_clk125m  (
      .DIVCLK        (gtpclkout_bufio2),
      .I             (gtpclkout),
      .IOCLK         (),
      .SERDESSTROBE  ()
   );


   // Route through a BUFG
   BUFG bufg_clk125m (
      .I   (gtpclkout_bufio2),
      .O   (userclk2)
   );


   // An inverted version of userclk2 is created.
   INV invert_userclk2 
   (
      .I  (userclk2),
      .O  (not_userclk2)
   );



   //---------------------------------------------------------------------------
   // Spartan-6 Transceiver System Reset
   //---------------------------------------------------------------------------

   // tranceiver 0
   gig_eth_pcs_pma_v11_4_reset_sync gtpreset0_gen (
      .clk       (userclk2),
      .reset_in  (reset0),
      .reset_out (gtpreset0)
   );


   //---------------------------------------------------------------------------
   // Instantiate the Core Block (core wrapper).
   //---------------------------------------------------------------------------
   gig_eth_pcs_pma_v11_4_block #
   (
      // Simulation attribute: this setting does not affect the hardware
      // It is a Smartmodel setting only.  Setting it to 1 reduces the
      // simulation time required for the GTP to intialise.
      .SIM_GTPRESET_SPEEDUP  (1)
   )
   core_wrapper
   (
      .gtpclkout             (gtpclkout),

      .gtpreset0             (gtpreset0),
      .gmii_txd0             (gmii_txd_fifo0),
      .gmii_tx_en0           (gmii_tx_en_fifo0),
      .gmii_tx_er0           (gmii_tx_er_fifo0),
      .gmii_rxd0             (gmii_rxd_int0),
      .gmii_rx_dv0           (gmii_rx_dv_int0),
      .gmii_rx_er0           (gmii_rx_er_int0),
      .gmii_isolate0         (gmii_isolate0),
      .configuration_vector0 (configuration_vector0),
      .status_vector0        (status_vector0),
      .reset0                (reset0),
      .signal_detect0        (signal_detect0),

      .clkin                 (clkin),
      .userclk2              (userclk2),

      .txp0                  (txp0),
      .txn0                  (txn0),
      .rxp0                  (rxp0),
      .rxn0                  (rxn0),
      .txp1                  (txp1),
      .txn1                  (txn1),
      .rxp1                  (rxp1),
      .rxn1                  (rxn1)

   );



   //---------------------------------------------------------------------------
   // GMII logic for the core connected to GTP0
   //---------------------------------------------------------------------------


   // GMII transmitter clock logic
   //-----------------------------

   // Route gmii_tx_clk from PAD through a BUFIO2 Buffer
   BUFIO2 receive_gmii_tx_clk0 (
      .DIVCLK       (),
      .I            (gmii_tx_clk0),
      .IOCLK        (gmii_tx_clk_bufio0),
      .SERDESSTROBE ()
   );


   // Route gmii_tx_clk through a BUFG onto global clock routing
   BUFG drive_tx_clk0 (
      .I   (gmii_tx_clk0),
      .O   (gmii_tx_clk_bufg0)
   );



   // GMII transmitter data logic
   //----------------------------

   // An IODELAY2 is used with Spartan-6 devices to meet the GMII input
   // setup and hold specifications. The data is delayed so to compensate for
   // the clock routing delay so that the GMII input data will be correctly
   // sampled at the IOB flip-flops

   // Please modify the value of the IODELAY2 according to your design.
   // The value in this file will be overridden with the value in the
   // UCF.  For more information, please refer to the User Guide.

   // The tap delay values can also be adjusted to compensate for PCB routing
   // deskew.

   // IODELAY2 for GMII_TXD
   genvar i;
   generate for (i=0; i<8; i=i+1)
     begin : gmii_data_bus0

      IODELAY2 # (
        .IDELAY_TYPE    ("FIXED"),
        .DATA_RATE      ("SDR"),
        .DELAY_SRC      ("IDATAIN")

      ) delay_gmii_txd0 (
        .BUSY           (),
        .DATAOUT        (gmii_txd_delay0[i]),
        .DATAOUT2       (),
        .DOUT           (),
        .TOUT           (),
        .CAL            (1'b0),
        .CE             (1'b0),
        .CLK            (1'b0),
        .IDATAIN        (gmii_txd0[i]),
        .INC            (1'b0),
        .IOCLK0         (1'b0),
        .IOCLK1         (1'b0),
        .ODATAIN        (1'b0),
        .RST            (1'b0),
        .T              (1'b1)
     );

     end
   endgenerate


   // IODELAY2 for GMII_TX_EN
   IODELAY2 # (
     .IDELAY_TYPE    ("FIXED"),
     .DATA_RATE      ("SDR"),
     .DELAY_SRC      ("IDATAIN")

   ) delay_gmii_tx_en0 (
     .BUSY           (),
     .DATAOUT        (gmii_tx_en_delay0),
     .DATAOUT2       (),
     .DOUT           (),
     .TOUT           (),
     .CAL            (1'b0),
     .CE             (1'b0),
     .CLK            (1'b0),
     .IDATAIN        (gmii_tx_en0),
     .INC            (1'b0),
     .IOCLK0         (1'b0),
     .IOCLK1         (1'b0),
     .ODATAIN        (1'b0),
     .RST            (1'b0),
     .T              (1'b1)
   );


   // IODELAY2 for GMII_TX_ER
   IODELAY2 # (
     .IDELAY_TYPE    ("FIXED"),
     .DATA_RATE      ("SDR"),
     .DELAY_SRC      ("IDATAIN")

   ) delay_gmii_tx_er0 (
     .BUSY           (),
     .DATAOUT        (gmii_tx_er_delay0),
     .DATAOUT2       (),
     .DOUT           (),
     .TOUT           (),
     .CAL            (1'b0),
     .CE             (1'b0),
     .CLK            (1'b0),
     .IDATAIN        (gmii_tx_er0),
     .INC            (1'b0),
     .IOCLK0         (1'b0),
     .IOCLK1         (1'b0),
     .ODATAIN        (1'b0),
     .RST            (1'b0),
     .T              (1'b1)
   );


   // Drive input GMII through IOB input flip-flops (inferred).
   always @ (posedge gmii_tx_clk_bufio0)
   begin
      gmii_txd_iff0   <= gmii_txd_delay0;
      gmii_tx_en_iff0 <= gmii_tx_en_delay0;
      gmii_tx_er_iff0 <= gmii_tx_er_delay0;
   end



   // Reclock onto regional clock routing
   always @ (posedge gmii_tx_clk_bufg0)
   begin
      gmii_txd_reg0   <= gmii_txd_iff0;
      gmii_tx_en_reg0 <= gmii_tx_en_iff0;
      gmii_tx_er_reg0 <= gmii_tx_er_iff0;
   end


   // Component Instantiation for the Transmitter Elastic Buffer
   gig_eth_pcs_pma_v11_4_tx_elastic_buffer tx_elastic_buffer_inst0
   (
      .reset            (reset0),
      .gmii_tx_clk_wr   (gmii_tx_clk_bufg0),
      .gmii_txd_wr      (gmii_txd_reg0),
      .gmii_tx_en_wr    (gmii_tx_en_reg0),
      .gmii_tx_er_wr    (gmii_tx_er_reg0),
      .gmii_tx_clk_rd   (userclk2),
      .gmii_txd_rd      (gmii_txd_fifo0),
      .gmii_tx_en_rd    (gmii_tx_en_fifo0),
      .gmii_tx_er_rd    (gmii_tx_er_fifo0)
   );



   // GMII receiver clock logic
   //--------------------------

   // This instantiates a DDR output register.  This is a nice way to
   // drive the GMII output clock since the clock-to-PAD delay will the
   // same as that of data driven from an IOB Ouput flip-flop.  This is
   // set to produce an inverted clock w.r.t. userclk2 so that clock
   // rising edge appears in the centre of GMII data.
   ODDR2 rx_clk_ddr_iob0 (
      .Q  (gmii_rx_clk0),
      .C0 (userclk2),
      .C1 (not_userclk2),
      .CE (1'b1),
      .D0 (1'b0),
      .D1 (1'b1),
      .R  (1'b0),
      .S  (1'b0)
   );



   // GMII receiver data logic
   //-------------------------


   // Drive Rx GMII signals through IOB output flip-flops (inferred).
   always @ (posedge userclk2)
   begin
      gmii_rxd_obuf0    <= gmii_rxd_int0;
      gmii_rx_dv_obuf0  <= gmii_rx_dv_int0;
      gmii_rx_er_obuf0  <= gmii_rx_er_int0;
   end


   //  drive GMII Rx signals through output PADS.
   OBUFT rx_data_valid0 (
      .I  (gmii_rx_dv_obuf0),
      .O  (gmii_rx_dv0),
      .T  (gmii_isolate0)
   );

   OBUFT rx_data_error0 (
      .I  (gmii_rx_er_obuf0),
      .O  (gmii_rx_er0),
      .T  (gmii_isolate0)
   );

   genvar m;
   generate for (m=0; m<8; m=m+1)
     begin : rx_data_bus0

     OBUFT rx_data_bits0 (
        .I (gmii_rxd_obuf0[m]),
        .O (gmii_rxd0[m]),
        .T (gmii_isolate0));

     end
   endgenerate



endmodule // gig_eth_pcs_pma_v11_4_example_design

