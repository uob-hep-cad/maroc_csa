--=============================================================================
--! @file IPBusInterfaceGTP_rtl.vhd
--=============================================================================
--
-------------------------------------------------------------------------------
-- --
-- University of Bristol, High Energy Physics Group.
-- --
------------------------------------------------------------------------------- --
-- VHDL Architecture fmc_mTLU_lib.IPBusInterfaceGTP.rtl
--
--! @brief \n
--! \n
--
--! @author David Cussans , David.Cussans@bristol.ac.uk
--
--! @date 16:06:57 11/09/12
--
--! @version v0.1
--
--! @details
--!
--!
--! <b>Dependencies:</b>\n
--!
--! <b>References:</b>\n
--!
--! <b>Modified by:</b>\n
--! Author: 
-------------------------------------------------------------------------------
--! \n\n<b>Last changes:</b>\n
-------------------------------------------------------------------------------
--! @todo <next thing to do> \n
--! <another thing to do> \n
--
--------------------------------------------------------------------------------
-- 
-- Created using using Mentor Graphics HDL Designer(TM) 2010.3 (Build 21)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

USE work.ipbus.all;
use work.emac_hostbus_decl.all;

ENTITY IPBusInterfaceGTP IS
   GENERIC( 
      NUM_EXT_SLAVES : positive := 5
   );
   PORT(

     -- Connections to GTP Spartan6
     -- Gigabit transceiver
     gtp_clkp, gtp_clkn: in std_logic;
     gtp_txp, gtp_txn: out std_logic;
     gtp_rxp, gtp_rxn: in std_logic;
     sfp_los: in std_logic;

     sfp_scl_o  : out std_logic;
     sfp_scl_i  : in  std_logic := '1';
     sfp_sda_o  : out std_logic;
     sfp_sda_i  : in  std_logic := '1';
     sfp_det_i  : in  std_logic;

     -- Gigabit connections for SATA connector		
     gtp_aux_txp, gtp_aux_txn: out std_logic;
     gtp_aux_rxp, gtp_aux_rxn: in std_logic;
     

     ipbr_i           : IN     ipb_rbus_array (NUM_EXT_SLAVES-1 DOWNTO 0);  -- ! IPBus read signals
     sysclk_i         : IN     std_logic;                                   -- ! 125 MHz xtal clock
      clocks_locked_o  : OUT    std_logic;
      ipb_clk_o        : OUT    std_logic;                                   -- ! IPBus clock to slaves
      ipb_rst_o        : OUT    std_logic;                                   -- ! IPBus reset to slaves
      ipbw_o           : OUT    ipb_wbus_array (NUM_EXT_SLAVES-1 DOWNTO 0);  -- ! IBus write signals
      onehz_o          : OUT    std_logic;
      phy_rstb_o       : OUT    std_logic;
      dip_switch_i     : IN     std_logic_vector (3 DOWNTO 0);
      clk_logic_xtal_o : OUT    std_logic
   );

-- Declarations

END ENTITY IPBusInterfaceGTP ;

--
ARCHITECTURE rtl OF IPBusInterfaceGTP IS
  
  --! Number of slaves inside the IPBusInterfaceGTP block.
  constant c_NUM_INTERNAL_SLAVES : positive := 1;

  signal clk125, locked, rst_125, rst_ipb: STD_LOGIC;
  signal mac_txd, mac_rxd : STD_LOGIC_VECTOR(7 downto 0);
  signal mac_txdvld, mac_txack, mac_rxclko, mac_rxdvld, mac_rxgoodframe, mac_rxbadframe : STD_LOGIC;
  signal ipb_master_out : ipb_wbus;
  signal ipb_master_in : ipb_rbus;
  signal mac_addr: std_logic_vector(47 downto 0);
  signal mac_tx_data, mac_rx_data: std_logic_vector(7 downto 0);
  signal mac_tx_valid, mac_tx_last, mac_tx_error, mac_tx_ready, mac_rx_valid, mac_rx_last, mac_rx_error: std_logic;

  signal ip_addr: std_logic_vector(31 downto 0);
  signal s_ipb_clk : std_logic;
  signal s_ipbw_internal: ipb_wbus_array (NUM_EXT_SLAVES+c_NUM_INTERNAL_SLAVES-1 DOWNTO 0);
  signal s_ipbr_internal: ipb_rbus_array (NUM_EXT_SLAVES+c_NUM_INTERNAL_SLAVES-1 DOWNTO 0);
  signal s_sysclk : std_logic;
  signal pkt_rx, pkt_tx, pkt_rx_led, pkt_tx_led, sys_rst: std_logic;
  
BEGIN
  

  -- FIXME - connect SFP control signals
  sfp_scl_o <= '1';
  sfp_sda_o <= '1';
  
--	DCM clock generation for internal bus, ethernet
	clocks: entity work.clocks_s6_basex port map(
		sysclk_i => sysclk_i,
		clki_125 => clk125,
		clko_ipb => s_ipb_clk,
		sysclko => s_sysclk,
		locked => locked,
		nuke => sys_rst,
		rsto_125 => rst_125,
		rsto_ipb => rst_ipb,
		onehz => onehz_o
	);
        
        -- Connect IPBus clock and reset to output ports.
        ipb_clk_o <= s_ipb_clk;
        ipb_rst_o <= rst_ipb;

  -- connect up locked signal
  clocks_locked_o <= locked;
	
--	Ethernet MAC core and PHY interface
--      In this version, consists of hard MAC core + GTP transceiver
--      Can be replaced by any other MAC / PHY combination

        eth: entity work.eth_s6_1000basex port map(
          gtp_clkp => gtp_clkp,
          gtp_clkn => gtp_clkn,
          gtp_txp => gtp_txp,
          gtp_txn => gtp_txn,
          gtp_rxp => gtp_rxp,
          gtp_rxn => gtp_rxn,
          gtp_aux_txp => gtp_aux_txp,
          gtp_aux_txn => gtp_aux_txn,
          gtp_aux_rxp => gtp_aux_rxp,
          gtp_aux_rxn => gtp_aux_rxn,			 
          clk125_out => clk125,
          locked => locked,
          rst => rst_125,
          tx_data => mac_tx_data,
          tx_valid => mac_tx_valid,
          tx_last => mac_tx_last,
          tx_error => mac_tx_error,
          tx_ready => mac_tx_ready,
          rx_data => mac_rx_data,
          rx_valid => mac_rx_valid,
          rx_last => mac_rx_last,
          rx_error => mac_rx_error
          );
	
	phy_rstb_o <= '1';
	
-- ipbus control logic
        ipbus: entity work.ipbus_ctrl
          generic map (
            BUFWIDTH => 2)
          port map(
            mac_clk => clk125,
            rst_macclk => rst_125,
            ipb_clk => s_ipb_clk,
            rst_ipb => rst_ipb,
            mac_rx_data => mac_rx_data,
            mac_rx_valid => mac_rx_valid,
            mac_rx_last => mac_rx_last,
            mac_rx_error => mac_rx_error,
            mac_tx_data => mac_tx_data,
            mac_tx_valid => mac_tx_valid,
            mac_tx_last => mac_tx_last,
            mac_tx_error => mac_tx_error,
            mac_tx_ready => mac_tx_ready,
            ipb_out => ipb_master_out,
            ipb_in => ipb_master_in,
            mac_addr => mac_addr,
            ip_addr => ip_addr,
            pkt_rx => pkt_rx,
            pkt_tx => pkt_tx,
            pkt_rx_led => pkt_rx_led,
            pkt_tx_led => pkt_tx_led
            );

	
	mac_addr <= X"020ddba115" & dip_switch_i & X"0"; -- Careful here, arbitrary addresses do not always work
	ip_addr   <= X"c0a8c8" & dip_switch_i & X"0"; -- 192.168.200.X
 
  fabric: entity work.ipbus_fabric
    generic map(NSLV => NUM_EXT_SLAVES+c_NUM_INTERNAL_SLAVES)
    port map(
      ipb_in => ipb_master_out,
      ipb_out => ipb_master_in,
      ipb_to_slaves => s_ipbw_internal,
      ipb_from_slaves => s_ipbr_internal
    );
    
    ipbw_o <= s_ipbw_internal(NUM_EXT_SLAVES-1 downto 0);

    s_ipbr_internal(NUM_EXT_SLAVES-1 downto 0) <= ipbr_i;
         
  -- Slave: firmware ID
  firmware_id: entity work.ipbus_ver
    port map(
      ipbus_in =>  s_ipbw_internal(NUM_EXT_SLAVES+c_NUM_INTERNAL_SLAVES-1),
      ipbus_out => s_ipbr_internal(NUM_EXT_SLAVES+c_NUM_INTERNAL_SLAVES-1)
      );

END ARCHITECTURE rtl;

