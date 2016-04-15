library IEEE;

USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE ieee.numeric_std.ALL;


--! Package containing type definition and constants for MAROC interface
use work.maroc.ALL;

entity dummyMarocADC is
  
  generic (
    g_NUMADC     : integer := 64;       -- ! number of ADC inside each MAROC
    g_NUMADCBITS : integer := 12);      -- ! Number of bits in each ADC

  port (
    clk_i        : in  std_logic;       -- ! clocks out data on falling edge
    reset_n_i      : in  std_logic;  -- ! Resets state. Synchronous. Active low
    startadc_n_i : in  std_logic;       -- ! Take low to start conversion
    adc_dav_o    : out std_logic;  -- ! Goes high when data is being transmitted
    adc_data_o   : out std_logic);      -- ! Serialized ADC data

end dummyMarocADC;

architecture behavioural of dummyMarocADC is
  
    --! Can't have index constraint in function return value, so define subtype
    subtype t_adcData is std_logic_vector((c_NUMADC*c_NUMADCBITS)-1 downto 0);  

    -- purpose: Generates a std_logic_vector containing simulated ADC data
    function f_generateADCData (
      constant numADC     : integer;
      constant numADCBits : integer)
      return t_adcData is

      variable data : t_adcData;
      
    begin  -- f_generateADCData

      for iADC in 0 to numADC-1 loop
        data( ((iADC+1)*numADCBits)-1 downto iADC*numADCBits) :=
          std_logic_vector(to_unsigned(iADC,numADCBits));
        
      end loop;  -- iADC
      return data;
    end f_generateADCData;

    signal c_adcData : t_adcData := f_generateADCData( g_NUMADC , g_NUMADCBITS );-- ! Dummy ADC data
    
    constant c_conversion_time : time := 10 us;  -- time take for ADC to convert
    
begin  -- behavioural

      -- Dummy ADC data
  -- purpose: Generates fake ADC data
  -- type   : combinational
  -- inputs : clk_i , startadc_n_i
  -- outputs: adc_dav_o , 
  p_output_data: process -- (clk_i , startadc_n_i)
  begin  -- process p_output_data

    adc_dav_o <= '0';
    adc_data_o <= '0';

    wait until falling_edge(startadc_n_i);

    wait for c_conversion_time;
    wait until falling_edge(clk_i);

    adc_dav_o <= '1';
    
    for iBit in (c_NUMADC*c_NUMADCBITS)-1 downto 0 loop

      adc_data_o <= c_adcData(iBit);
      wait until falling_edge(clk_i);
      
    end loop;  -- iBit

    adc_dav_o <= '0';
    
  end process p_output_data;


end behavioural;
