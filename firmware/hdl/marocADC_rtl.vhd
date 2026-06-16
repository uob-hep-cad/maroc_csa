--=============================================================================
--! @file marocADC_rtl.vhd
--=============================================================================
--! Standard library
library IEEE;
--! Standard packages
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;
--! Package containing type definition and constants for MAROC interface
use work.maroc.ALL;
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
-- unit name: marocADC_rtl (marocADC / rtl)
--
--! @brief Interfaces to Maroc ADC\n
--! when start_p_i pulses high issues a reset to ADC then a startADC signal.
--! status_o goes high during conversion.
--! Waits for ADC data valid to return low again before dropping status_o
--
--! @author David Cussans , David.Cussans@bristol.ac.uk
--
--! @date 4\1\2012
--
--! @version v0.1
--
--! @details
--! Controls the physical signal lines to and from MAROC.
--! Deserializes the data coming from the ADCs, and puts into Dual-Port-RAM
--! Each event is preceeded by a trigger number and a timestamp .
--!
--! <b>Dependencies:</b>\n
--! Instantiates marocADCFSM
--!
--! <b>References:</b>\n
--! referenced by marocADC \n
--!
--! <b>Modified by:</b>\n
--! Author: 
-------------------------------------------------------------------------------
--! \n\n<b>Last changes:</b>\n
--! 17/Feb/2012 DGC Move to storing data in a DPR. Change ports accordingly\n
--! 
-------------------------------------------------------------------------------
--! @todo Include trigger number and timestamp \n
--
---------------------------------------------------------------------------------

--============================================================================
--! Entity declaration for marocADC
--============================================================================
entity marocADC is
  generic(
    g_ADDRWIDTH   : positive; --! Size of dual port RAM holding event data
    g_EVENT_ADDRWIDTH : positive := 5; --! Number of bits needed to address a single event in DPR. Event size = 24 words of ADC data + 2 header. So, 32 locations
    g_BUSWIDTH    : positive := 32
    );
  port(
    clk_i        : in STD_LOGIC;
    reset_i      : in STD_LOGIC;

    start_p_i    : in STD_LOGIC;        --! Pulse high to start conversion.
    end_p_o      : out STD_LOGIC;       --! Pulses high at end of conversion
    status_o     : out STD_LOGIC;       --! goes high during conversion

    ipbus_i : in  ipb_wbus;             --! Signals from IPBus master for data
    ipbus_o : out ipb_rbus;             --! Signals to IPBus master

    --! Next location in DPR circular buffer that will get written to
    write_pointer_o : out STD_LOGIC_VECTOR(g_ADDRWIDTH-1 downto 0);
    
    --! Number of bits shifted in  
    bitcount_o   : out STD_LOGIC_VECTOR( 9 downto 0 );  

    triggerNumber_i   : in std_logic_vector(g_BUSWIDTH-1 downto 0);
    timeStamp_i       : in std_logic_vector(g_BUSWIDTH-1 downto 0);

    -- Signals to MAROC
    START_ADC_N_O : out std_logic;
    RST_ADC_N_O   : out std_logic;
    ADC_DAV_I     : in std_logic;
    OUT_ADC_I     : in std_logic
      
    );
	
end marocADC;

--============================================================================
--! architecture declaration
--============================================================================
architecture rtl of marocADC is

  signal s_status : std_logic;   --! Control line from ADC interface. Goes high when conversion in progress

  --! Shift register
  signal s_shiftReg : std_logic_vector(g_BUSWIDTH-1 downto 0) := (others => '0');
  signal s_dataToDPR , s_dataToDPR_d1 : std_logic_vector(g_BUSWIDTH-1 downto 0) := (others => '0');

  signal s_shiftRegCounter : unsigned(bitcount_o'range) := (others => '0');  --! Counts bits shifted in
  
  signal s_reset_sr : std_logic := '0';  -- ! Driven by ADC FSM. When high resets the shift register and bit counter
  signal s_reset_sr_d1 : std_logic := '0';  -- ! s_reset_sr delayed one clk_i cycle
--  signal s_reset_sr_d2 : std_logic := '0';  -- ! s_reset_sr_d1 delayed one clk_i cycle

  --! DPR signals
  signal s_wen , s_wen_d1 : std_logic := '0';      -- ! Write enable for DPR
  signal s_shiftRegFull , s_shiftRegFull_d1 : std_logic := '0';      -- ! Write enable for DPR
  signal s_writeAddr , s_writeAddr_d1 : unsigned(write_pointer_o'range) := (others => '0');   --! Address into write-port of DPR
  -- signal s_readAddr : unsigned(addr_i'range);  -- ! Read address in DPR
  signal  s_RegisteredEventTimestamp : std_logic_vector( timeStamp_i'range) := (others => '0');

  signal s_wordCounter : unsigned( g_EVENT_ADDRWIDTH -1 downto 0) := ( others =>'0');  -- --! Counts 32-bit words within an event
  
  signal s_eventCounter : unsigned( ( g_ADDRWIDTH - g_EVENT_ADDRWIDTH -1 ) downto 0) := ( others => '0' );  -- --! Counter for events in DPR. One count is one event

  signal s_endOfSequence,  s_endOfSequence_d1  : std_logic := '0';  -- --! Goes high for one cycle at end of MAROC ADC readout.
    
begin


  --! Capture the timestamp at the start of the event.
  p_captureTimestamp: process (clk_i)
  begin  -- process p_captureTimestamp
    if rising_edge(clk_i) and (start_p_i = '1') then  -- rising clock edge
       s_RegisteredEventTimestamp <= timeStamp_i;
    end if;
  end process p_captureTimestamp;
  
  --==========================================================================
  -- purpose: Shift register to deserialize data from MAROC
  -- type   : combinational
  -- inputs : clk_i , reset_i , out_adc_i
  -- outputs: s_shiftReg
  --==========================================================================
  p_shiftReg: process (clk_i , reset_i, out_adc_i)
  begin  -- process p_shiftReg
    if rising_edge(clk_i) then

      if (reset_i = '1') then
        s_shiftRegCounter <= (others => '0');
      elsif (s_reset_sr='1') then
        s_shiftRegCounter <= (others => '0');
      elsif adc_dav_i = '1' then
        s_shiftReg <= s_shiftReg(s_shiftReg'left-1 downto 0) & out_adc_i;
        s_shiftRegCounter <=  s_shiftRegCounter + 1;
      end if;

      --! Delay reset shift-reg signal to act as flag for
      --! writing timestamp into DPR.
      s_reset_sr_d1 <= s_reset_sr;

      s_shiftRegFull_d1 <= s_shiftRegFull;
      
    end if;                             -- rising_edge(clk_i)
    
  end process p_shiftReg;

  -- purpose: Increments event counter every time the MAROC ADC has finished readout out
  -- type   : combinational
  -- inputs : clk_i , reset_i , s_endOfSequence
  -- outputs: s_eventCounter
  p_eventCounterControl: process (clk_i , reset_i , s_endOfSequence) is
  begin  -- process p_eventCounterControl
    if rising_edge(clk_i) then
      if (reset_i = '1')  then
        s_eventCounter <= ( others => '0');
      elsif (s_endOfSequence = '1') then
        -- Increment event counter at end of ADC readout
        s_eventCounter <= s_eventCounter + 1;
      end if;
    end if;
  end process p_eventCounterControl;

  p_wordCounterControl: process(clk_i , s_wen , reset_i ,s_endOfSequence)
    begin
      if rising_edge(clk_i) then
        if (reset_i = '1') or ( s_endOfSequence = '1' ) then
          s_wordCounter <= ( others => '0');
        elsif (s_wen = '1') then
          -- Increment write address if a complete word has been shifted or if end
          -- of ADC readout has been reached.
          s_wordCounter <= s_wordCounter + 1;
        end if;
      end if;
  end process p_wordCounterControl;

  s_writeAddr <= s_eventCounter & s_wordCounter;
  
  --! Generate write enable for DPRAM ( also increments write address
  s_shiftRegFull <= '1' when (s_shiftRegCounter(4 downto 0) = "11111" ) else '0';
  
  s_wen <= '1' when s_shiftRegFull_d1='1' or
           (s_reset_sr = '1') or (s_reset_sr_d1 = '1')
           else '0';

  s_dataToDPR <= triggerNumber_i when (s_reset_sr = '1') else
                 s_RegisteredEventTimestamp when (s_reset_sr_d1 = '1') else
                 s_shiftReg ;

  -- ... put in a register for s_wen and s_dataToDPR to help debugging....
  -- purpose: registers data going to DPR
  -- type   : combinational
  -- inputs : clk_i , s_dataToDPR , s_wen
  -- outputs: s_dataToDPR_d1 , s_wen_d1
  p_registerDPRData: process (clk_i , s_dataToDPR , s_writeAddr_d1 , s_wen) is
  begin  -- process p_registerDPRData
    if rising_edge(clk_i) then
      s_wen_d1 <= s_wen;
      s_writeAddr_d1 <= s_writeAddr;
      if s_wen = '1' then
        s_dataToDPR_d1 <= s_dataToDPR;
      end if;
    end if;
  end process p_registerDPRData;
  

  --! Instantiate finite state machine that drives control lines.
  cmp_marocADC_fsm: entity work.marocADCFSM 
   port map (
      clk_system_i   => clk_i,
      rst_i          => reset_i,
      start_p_i      => start_p_i,
      adc_dav_i      => adc_dav_i,
      reset_sr_o     => s_reset_sr,
      start_adc_n_o  => start_adc_n_o,
      end_of_sequence_o => s_endOfSequence,
      status_o       => status_o
      ); 

  -- Instantiate Dual Port RAM
  cmp_capbuf: entity work.ipbusDPRAM
    generic map (
      data_width => g_BUSWIDTH,
      ram_address_width => g_ADDRWIDTH )
    Port map (
      Wren_a    =>  s_wen_d1,
--      Wren_a    =>  s_wen,
      clk       =>  clk_i,

      -- Write port
--      address_a =>  std_logic_vector(s_writeAddr),
      address_a =>  std_logic_vector(s_writeAddr_d1),      
--      data_a     =>  s_dataToDPR,
      data_a     =>  s_dataToDPR_d1,

      -- IPBus for read-port
      ipbus_i => ipbus_i,
      ipbus_o => ipbus_o

      );

  -- Connect internal signals to output ports
  
  RST_ADC_N_O   <= not s_reset_sr;

  bitcount_o    <= std_logic_vector(s_shiftRegCounter);



  -- purpose: updates write pointer at end of every readout 
  -- Register write_pointer after endOfSequence goes high. Then, should only
  -- see write pointer increment by 32.....
  -- inputs : clk_i ,  s_endOfSequence_d1 , s_writeAddr
  -- outputs: write_pointer_o
  p_writePointerCtl: process (clk_i ,  s_endOfSequence_d1 , s_endOfSequence, s_writeAddr) is
  begin  -- process p_writePointerCtl
    if rising_edge(clk_i)  then
      s_endOfSequence_d1 <= s_endOfSequence;
      if s_endOfSequence_d1='1' then
        write_pointer_o <= std_logic_vector(s_writeAddr);        
      end if;
    end if;
  end process p_writePointerCtl;

  
end rtl;
