
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
use work.ipbus.ALL;
use work.maroc.all;

--! Xilinx primitives
LIBRARY UNISIM;
USE UNISIM.vcomponents.all;


entity marocInterface is
  generic (
    g_NSLAVES : positive := 5);  -- number of IPBus slaves inside the maroc interface.
  port (

    -- Interface to IPBus
    ipb_clk_i : in STD_LOGIC;
    ipb_in : in ipb_wbus_array(g_NSLAVES-1 downto 0);
    ipb_out : out ipb_rbus_array(g_NSLAVES-1 downto 0);
    rst_i : in std_logic;

    -- fast clock....
    clk_fast_i : in std_logic;
    
    -- Trigger signals
    external_Trigger_i : in std_logic;
    trigger_o : out std_logic;
    
    -- Pins connected to MAROC
    CK_40M_P_O: out STD_LOGIC;
    CK_40M_N_O: out STD_LOGIC;
    HOLD2_O: out STD_LOGIC;
    HOLD1_O: out STD_LOGIC;
    OR_I: in STD_LOGIC_VECTOR(1 downto 0);
    MAROC_TRIGGER_I: in std_logic_vector(63 downto 0);
    EN_OTAQ_O: out STD_LOGIC;
    CTEST_O: out STD_LOGIC_VECTOR(5 downto 0); -- 4-bit R/2R DAC
    ADC_DAV_I: in STD_LOGIC;
    OUT_ADC_I: in STD_LOGIC;
    START_ADC_N_O: out STD_LOGIC;
    RST_ADC_N_O: out STD_LOGIC;
    RST_SC_N_O: out STD_LOGIC;
    Q_SC_I: in STD_LOGIC;
    D_SC_O: out STD_LOGIC;
    RST_R_N_O: out STD_LOGIC;
    Q_R_I: in STD_LOGIC;
    D_R_O: out STD_LOGIC;
    CK_R_O: out STD_LOGIC;
    CK_SC_O: out STD_LOGIC

    );

end marocInterface;

architecture rtl of marocInterface is

  signal register_data: std_logic_vector(c_BUSWIDTH-1 downto 0);
  signal s_adcConversionStatus  : std_logic;
  signal s_adcConversionEnd  : std_logic;
  signal s_adcConversionStart  : std_logic;
  signal s_externalTrigger_o : std_logic;
  signal s_triggerNumber : std_logic_vector(c_BUSWIDTH-1 downto 0);
  signal s_timeStamp : std_logic_vector(c_BUSWIDTH-1 downto 0);

  signal s_tree_or : std_logic_vector( maroc_trigger_i'left+1 downto 0);
  
begin  -- rtl


 -- --! Slave 1: 32b register ( output from FPGA to MAROC)
 -- slave0: entity work.ipbus_reg
 --   generic map(addr_width => 0)
 --   port map(
 --     clk => ipb_clk_i,
 --     reset => rst_i,
 --     ipbus_in => ipb_in(0),
 --     ipbus_out => ipb_out(0),
 --     q => register_data
 --     );

  -- Slave 1: slow control shift register controller
  slave1: entity work.ipbusMarocShiftReg
    generic map(
      g_NBITS    => 829,  --! Number of bits to shift out to MAROC
      g_NWORDS   => c_NWORDS,    --! Number of words in IPBUS space to store data
      --! Number of bits in clock divider between system clock and clock to shift reg
      g_CLKDIVISION => 4,
      g_ADDRWIDTH => 5 )
    port map(

      -- signals to IPBus
      clk_i => ipb_clk_i,
      reset_i  => rst_i,
      ipbus_i  => ipb_in(0),
      ipbus_o  => ipb_out(0),

      -- Signals to MAROC
      clk_sr_o => ck_sc_o,
      d_sr_o   => d_sc_o,
      q_sr_i   => q_sc_i,
      rst_sr_n_o => rst_sc_n_o
      );

  -- Slave 2: "R" register shift register controller
  slave2: entity work.ipbusMarocShiftReg
    generic map(
      g_NBITS    => 128,  --! Number of bits to shift out to MAROC
      g_NWORDS   => c_NWORDS,    --! Number of words in IPBUS space to store data
      --! Number of bits in clock divider between system clock and clock to shift reg
      g_CLKDIVISION => 4,
      g_ADDRWIDTH => 5 )
    port map(

      -- signals to IPBus
      clk_i => ipb_clk_i,
      reset_i  => rst_i,
      ipbus_i  => ipb_in(1),
      ipbus_o  => ipb_out(1),

      -- Signals to MAROC
      clk_sr_o => ck_r_o,
      d_sr_o   => d_r_o,
      q_sr_i   => q_r_i,
      rst_sr_n_o => rst_r_n_o
      );

-- Slave 3: Simple ADC controller
  slave3: entity work.ipbusMarocADC
    generic map(
      g_ADDRWIDTH => 10 )
    port map(

      -- signals to IPBus
      clk_i => ipb_clk_i,
      reset_i  => rst_i,
 
      control_ipbus_i  => ipb_in(2),
      control_ipbus_o => ipb_out(2),
      data_ipbus_i  => ipb_in(3),
      data_ipbus_o => ipb_out(3),

      -- global reset signal
      logic_reset_i => '0',
      
      -- Signals to trigger controller
      adcStatus_o   => s_adcConversionStatus,
      adcConversionStart_i => s_adcConversionStart,
      triggerNumber_i => s_triggerNumber ,
      timeStamp_i => s_timeStamp ,
       
      -- Signals to MAROC
      START_ADC_N_O => START_ADC_N_O,
      RST_ADC_N_O => RST_ADC_N_O,
      ADC_DAV_I => ADC_DAV_I,
      OUT_ADC_I => OUT_ADC_I
      );

  -- FIXME - this should be edge sensitive.... ir trigger generator changed to
  -- be level sensitive.
  s_adcConversionEnd <= s_adcConversionStatus;

  -- FIXME - clk fast
  
  -- Slave 4: Trigger generator
  slave4: entity work.ipbusMarocTriggerGenerator 
    port map (
      -- signals to IPBus
      clk_i => ipb_clk_i,
      reset_i  => rst_i,
      ipbus_i  => ipb_in(4),
      ipbus_o  => ipb_out(4),

      -- Signals to MAROC and ADC controller
      adcConversionEnd_i   => s_adcConversionEnd,
      adcConversionStart_o => s_adcConversionStart,
      triggerNumber_o => s_triggerNumber ,
      timeStamp_o => s_timeStamp ,

      -- global reset signal
      logic_reset_i => '0',
 
      -- Fast clock and external trigger signals
      clk_fast_i           => clk_fast_i,
      externalTrigger_a_i  => external_trigger_i,
      externalTrigger_o    => s_externalTrigger_o,

      -- Signals to MAROC
      or1_a_i              => OR_I(0),
      or2_a_i              => OR_I(1),
      hold1_o              => hold1_o  ,
      hold2_o              => hold2_o  ,

      -- CTEST output for then CTEST selected
      ctest_o              => ctest_o
      );

  trigger_o    <= s_externalTrigger_o;
--  gpio_o(5) <= s_externalTrigger_o;


  -- FIXME - connect combination of MAROC signals to an output
  s_tree_or(0) <= '0';
  gen_maroc_or: for i in maroc_trigger_i'range generate
    s_tree_or(i+1) <= s_tree_or(i) or maroc_trigger_i(i);
  end generate gen_maroc_or;
  
  -- FIXME - for now, just wire up any old signal to an OBUFDS
  -- to get correct signal type for CK_40M
  ck_40m_obuf : OBUFDS
    port map (
      I  => s_externalTrigger_o or s_tree_or(s_tree_or'left),
      O  =>  CK_40M_P_O,
      OB => CK_40M_N_O
      );
  

  EN_OTAQ_O <= '1';
  
end rtl;
