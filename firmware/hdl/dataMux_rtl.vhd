--=============================================================================
--! @file dataMux_rtl.vhd
--=============================================================================
--! Standard library
library IEEE;
--! Standard packages
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;
--! Package containing type definition and constants for MAROC interface
--use work.maroc.ALL;
--! Package containing type definition and constants for IPBUS
use work.ipbus.all;

--! Use UNISIM for Xilix primitives
Library UNISIM;
use UNISIM.vcomponents.all;


-------------------------------------------------------------------------------
-- --
-- University of Bristol, High Energy Physics Group.
-- --
------------------------------------------------------------------------------- --
-- unit name: dataMux_rtl (dataMux / rtl)
--
--! @brief connects to the output of multiple FIFOs, multiplexs data and pushes
--! into circular dual-port-ram buffer
--
--! @author David Cussans , David.Cussans@bristol.ac.uk
--
--! @date 30\3\2016
--
--! @version v0.1
--
--! @details
--!
--! <b>Dependencies:</b>\n
--! Instantiates dataMuxFSM
--!
--! <b>References:</b>\n
--! referenced by dataMux \n
--!
--! <b>Modified by:</b>\n
--! Author: 
-------------------------------------------------------------------------------
--! \n\n<b>Last changes:</b>\n
--! 
-------------------------------------------------------------------------------
--! @todo 
--
---------------------------------------------------------------------------------
entity dataMux is
  
  generic (
    g_ADDRWIDTH  : positive := 12;   --! size of circular buffer
    g_BUSWIDTH   : positive := 32   --! IPBUS data width
    );      

  port (
    clk_i       : in  std_logic;        --! clock. rising edge active.

    );  

end entity dataMux;

architecture rtl of dataMux is

begin  -- architecture rtl

  

end architecture rtl;
