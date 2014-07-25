--============================================================================
--! @file generate_test_signals.vhd
--============================================================================
-- @brief Given a 200MHz clock generates a 25MHz clock and trigger pulses

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

Library UNISIM;
use UNISIM.vcomponents.all;

entity generate_test_signals is
  
  generic (
    TRIGGER_DIVIDER : positive := 15;  --! Number of 25MHz clock ticks between
                                       --each trigger pulse is 2^TRIGGER_DIVIDER
    TRIGGER_WIDTH   : positive := 3);   --! width in 25mHz clock cycles

  port (
    sysclk        : in  std_logic;      -- ! system clock ( 200MHz )
    test_clk_25M  : out std_logic;      -- ! Generated from system clock
    test_trigger : out std_logic;       -- ! periodic , regular pulses, sync with 25MHz clock
    dcm_locked : out std_logic          --! Connected to locked pin of DCM
    );  

end generate_test_signals;

architecture rtl of generate_test_signals is

  signal clkfb             : std_logic;
  signal clk0              : std_logic;
  signal clkfx,clkfx_n      : std_logic;
  signal clkfbout          : std_logic;
  --signal locked_internal   : std_logic;
  signal status_internal   : std_logic_vector(7 downto 0);

  signal trigger_scaler : unsigned( TRIGGER_DIVIDER downto 0) := (others => '0');  -- counter to produce triggers at uniform interval
  signal trigger_squarewave : std_logic;
  signal trigger_squarewave_d1 , trigger_squarewave_d2 : std_logic;        --! delayed trigger
  
begin  -- rtl

  -- expects a 200MHz input clock ( sysclk )
  -- generates a 25MHz output clock
  
  dcm_sp_inst: DCM_SP
  generic map
   (CLKDV_DIVIDE          => 2.000,
    CLKFX_DIVIDE          => 16,
    CLKFX_MULTIPLY        => 2,
    CLKIN_DIVIDE_BY_2     => FALSE,
    CLKIN_PERIOD          => 5.0,
    CLKOUT_PHASE_SHIFT    => "NONE",
--    CLK_FEEDBACK          => "NONE",
    CLK_FEEDBACK          => "1X",
    DESKEW_ADJUST         => "SYSTEM_SYNCHRONOUS",
    PHASE_SHIFT           => 0,
    STARTUP_WAIT          => FALSE)
  port map
   -- Input clock
   (CLKIN                 => sysclk,
    CLKFB                 => clkfb,
    -- Output clocks
    CLK0                  => clk0,
    CLK90                 => open,
    CLK180                => open,
    CLK270                => open,
    CLK2X                 => open,
    CLK2X180              => open,
    CLKFX                 => clkfx,
    CLKFX180              => clkfx_n,
    CLKDV                 => open,
   -- Ports for dynamic phase shift
    PSCLK                 => '0',
    PSEN                  => '0',
    PSINCDEC              => '0',
    PSDONE                => open,
   -- Other control and status signals
    LOCKED                => dcm_locked,
    STATUS                => status_internal,
    RST                   => '0',
   -- Unused pin, tie low
    DSSEN                 => '0');


  -- no phase alignment active, connect clock feedback to ground
  clkfb <= clk0 ; -- '0';

  -- trying to connect up a global clock net straight to an output pin
  -- generally doesn't give good results, so use a DDR output register...
  clock_output_register  : ODDR2
   port map (
      Q =>  test_clk_25M, -- 1-bit output data
      C0 => clkfx, -- 1-bit clock input
      C1 => clkfx_n, -- 1-bit clock input
      CE => '1',  -- 1-bit clock enable input
      D0 => '0',   -- 1-bit data input (associated with C0)
      D1 => '1',   -- 1-bit data input (associated with C1)
      R => '0',    -- 1-bit reset input
      S => '0'     -- 1-bit set input
   );

  -- Generate trigger pulses....
  -- purpose: generates a square wave, shaped to be trigger pulses
  -- type   : sequential
  -- inputs : clkfx, <reset>
  -- outputs: test_trigger
  generate_triggers: process (clkfx)
  begin  -- process generate_triggers
    if rising_edge(clkfx) then  -- rising clock edge
      
      trigger_scaler <= trigger_scaler +1 ;
      trigger_squarewave <= trigger_scaler(TRIGGER_DIVIDER);
      trigger_squarewave_d1 <= trigger_squarewave;
      trigger_squarewave_d2 <= trigger_squarewave_d1;
      test_trigger <= trigger_squarewave and not trigger_squarewave_d2;
      
    end if;
  end process generate_triggers;

  

  

end rtl;
