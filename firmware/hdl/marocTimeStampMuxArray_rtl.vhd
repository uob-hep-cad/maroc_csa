--=============================================================================
--! @file marocTimeStampMuxArray_rtl.vhd
--=============================================================================
--! Standard library
library IEEE;
--! Standard packages
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

--! Use UNISIM for Xilix primitives
--Library UNISIM;
--use UNISIM.vcomponents.all;

--type   t_triggerTimeArray is array(natural range <>) of std_logic_vector(31 downto 0) ;
use work.maroc.ALL;

-------------------------------------------------------------------------------
-- --
-- University of Bristol, High Energy Physics Group.
-- --
------------------------------------------------------------------------------- --
-- unit name: marocTimeStampMuxArray_rtl (marocTimeStampMuxArray / rtl)
--
--! @brief Multiplexes between data streams from multiple FIFOs.
--
--! @author David Cussans , David.Cussans@bristol.ac.uk
--
--! @date 4\4\2016
--
--! @version v0.1
--
--! @details There is an array of data sources.
--! If there is data on more than one sources the source with highest index has priority.
--! N.B. There is no provision for back-pressure - downstream *must* be
--! ready to accept data or it will be lost.
--!
--! <b>Dependencies:</b>\n
--!
--! <b>References:</b>\n
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



 
entity marocTimeStampMuxArray is
  
  generic (
    g_BUSWIDTH       : positive := 32;   --! Number of bits in input/output data
    g_NCHANNELS      : positive := 64
    );      

  port (
    clk_i       : in  std_logic;        --! rising edge active

    data_i : in t_timeStampArray(g_NCHANNELS-1 downto 0); 
    data_present_i : in std_logic_vector(g_NCHANNELS-1 downto 0); --! High if data present
    read_data_o : out std_logic_vector(g_NCHANNELS-1 downto 0); --! Take high to read data

    data_o : out std_logic_vector(g_BUSWIDTH-1 downto 0); --! Downstream data. Stays at state of last valid data.
    data_present_o : out std_logic --! High if data present

    );  

end entity marocTimeStampMuxArray;

architecture rtl of marocTimeStampMuxArray is

  signal s_downstream_data : t_timeStampArray(g_NCHANNELS-1 downto 0) := ( others => (others => '0'));     -- data from one pipeline mux to another
  signal s_downstream_data_present , s_read_upstream_data : std_logic_vector(g_NCHANNELS-1 downto 0) := (others => '0');
  
begin  -- architecture rtl


  -- connect the start of the pipeline to the channel with highest index.
  s_downstream_data(g_NCHANNELS-1)         <= data_i(g_NCHANNELS-1);
  s_downstream_data_present(g_NCHANNELS-1) <= data_present_i(g_NCHANNELS-1);
  read_data_o(g_NCHANNELS-1)               <= s_read_upstream_data(g_NCHANNELS-1);
  
  -- Generate an array of 2 way multiplexers....
  gen_2wayMuxes: for channel in g_NCHANNELS-2 downto 0 generate

    cmp_muxN: entity work.marocTimeStampMux PORT MAP (
      clk_i => clk_i,
      upstream_data_i => s_downstream_data(channel+1),
      upstream_data_present_i => s_downstream_data_present(channel+1),
      read_upstream_data_o => s_read_upstream_data(channel+1),
      input_data_i => data_i(channel),
      input_data_present_i => data_present_i(channel),
      read_input_data_o => read_data_o(channel),
      downstream_data_o => s_downstream_data(channel),
      downstream_data_present_o => s_downstream_data_present(channel)
      );
  end generate gen_2wayMuxes;

  -- copy the last stage of the pipeline to the output.....
  data_o         <= s_downstream_data(0);
  data_present_o <= s_downstream_data_present(0);
  
  
end architecture rtl;
