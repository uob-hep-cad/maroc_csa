--=============================================================================
--! @file marocTimeStampMux_rtl.vhd
--=============================================================================
--! Standard library
library IEEE;
--! Standard packages
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

--! Use UNISIM for Xilix primitives
--Library UNISIM;
--use UNISIM.vcomponents.all;


-------------------------------------------------------------------------------
-- --
-- University of Bristol, High Energy Physics Group.
-- --
------------------------------------------------------------------------------- --
-- unit name: marocTimeStampMux_rtl (marocTimeStampMux / rtl)
--
--! @brief Multiplexes between two data streams from FIFOs.
--
--! @author David Cussans , David.Cussans@bristol.ac.uk
--
--! @date 4\4\2016
--
--! @version v0.1
--
--! @details There is an upstream data source and an input data source.
--! If there is data on both sources the upstream source has priority.
--! N.B. There is no provision for back-pressure - downstream *must* be
--! ready to accept data or it will be lost. (hence priority for upstream input)
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
entity marocTimeStampMux is
  
  generic (
    g_BUSWIDTH       : positive := 32   --! Number of bits in input/output data
    );      

  port (
    clk_i       : in  std_logic;        --! rising edge active

    upstream_data_i : in std_logic_vector(g_BUSWIDTH-1 downto 0); --! Upstream data
    upstream_data_present_i : in std_logic; --! High if data present
    read_upstream_data_o : out std_logic; --! Take high to read data

    input_data_i : in std_logic_vector(g_BUSWIDTH-1 downto 0); --! Input data
    input_data_present_i : in std_logic; --! High if data present
    read_input_data_o : out std_logic; --! Take high to read data

    downstream_data_o : out std_logic_vector(g_BUSWIDTH-1 downto 0); --! Downstream data. Remains at state of last valid data.
    downstream_data_present_o : out std_logic --! High if data present

    );  

end entity marocTimeStampMux;

architecture rtl of marocTimeStampMux is


  signal s_read_input_data , s_read_upstream_data : std_logic := '0';  
  
begin  -- architecture rtl

  -- purpose: reads data from inputs and outputs downstream
  -- type   : combinational
  -- inputs : clk_i
  -- outputs: downstream_data_o , downstream_data_present_o
  p_muxData: process (clk_i) is
  begin  -- process p_muxData
    
    if rising_edge(clk_i) then

      
      downstream_data_present_o <='0';

      if (input_data_present_i = '1') and ( s_read_input_data = '0' ) and ( upstream_data_present_i = '0' ) then
        s_read_input_data <='1';
      else
        s_read_input_data <='0';
      end if;
      
      if (upstream_data_present_i = '1') and ( s_read_upstream_data = '0' )  then
        s_read_upstream_data <= '1';
      else
        s_read_upstream_data <='0';        
      end if;

      ---------
      -- Data Mux
      if s_read_upstream_data = '1' then

        downstream_data_o <= upstream_data_i;
        downstream_data_present_o <='1';        

      elsif s_read_input_data = '1' then
        
        downstream_data_o <= input_data_i;
        downstream_data_present_o <='1';        

      end if;
    end if;
  end process p_muxData;

  read_input_data_o <= s_read_input_data;
  read_upstream_data_o <= s_read_upstream_data;
  
end architecture rtl;
