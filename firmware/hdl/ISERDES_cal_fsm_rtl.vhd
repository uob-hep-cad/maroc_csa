--=============================================================================
--! @file ISERDES_cal_fsm_rtl.vhd
--=============================================================================
--
-------------------------------------------------------------------------------
-- --
-- University of Bristol, High Energy Physics Group.
-- --
------------------------------------------------------------------------------- --
-- VHDL Architecture work.ISERDES_cal_fsm.rtl
--
--! @brief State machine to control reset and calibration of Input deserializers--
--! @author David Cussans , David.Cussans@bristol.ac.uk
--
--! @date 15/May/2013
--
--! @version v0.1
--
--! @details
--! See Spartan-6 IOSERDES2 documentation from Xilinx
--!
--! <b>Dependencies:</b>\n
--!
--! <b>References:</b>\n
--!
--! Author: 
-------------------------------------------------------------------------------
--! \n\n<b>Last changes:</b>\n
-------------------------------------------------------------------------------
--! @todo Implement a periodic calibration sequence\n
--! <another thing to do> \n
--
--------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity ISERDES_cal_fsm is
  
  port (
    clk_i          : in  std_logic;       --! Rising edge active.
    reset_i        : in  std_logic;
                                         --! Take high for at least on clock cycle to force reset/calibration
    busy_prompt_i  : in std_logic;
    busy_delayed_i   : in std_logic;
    
    reset_o : out std_logic;  --! To ISERDES reset pin
    cal_o : out std_logic       --! To ISERDES calibration pin

    );      

end ISERDES_cal_fsm;

architecture rtl of ISERDES_cal_fsm is

  signal s_reset_d1 ,s_reset_d2 : std_logic := '0';  
                                        -- ! Register reset signal onto IDELAY / ISERDES clock

  
--  signal s_rst_FSM      : std_logic := '0';         -- IODELAY reset
--  signal s_Enable       : std_logic := '0';         -- IODELAY Enable
--
--  --! Calibration FSM state values
--  type state_values is (st0, st1, st2, st3, st4);
--  signal pres_state, next_state: state_values := st0;

begin  -- rtl

--    --! Calibration start condition
--  s_Enable <= '1'; --serdes_reset_i; -- and (not s_busy_idelay);
--  s_rst <= s_rst_FSM or serdes_reset_i;
--  
--  --! Calibration FSM register
--  statereg: process(fabricClk_i, serdes_reset_i)
--  begin
--	 if serdes_reset_i = '1' then
--	   pres_state <= st0;            -- Move to st0 - INITIAL STATE
--        
--	 elsif rising_edge(fabricClk_i) then
--		pres_state <= next_state;     -- Move to next state
--        
--	 end if;
--  end process statereg;
--
--
--  --! Calibration FSM combinational block
--  fsm: process(pres_state, s_Enable, s_busy_idelay_m)
--  begin
--	 next_state <= pres_state;
--	 -- Default values
--    s_Rst_FSM <= '0';
--    s_cal_idelay <= '0';
--	 
--    case pres_state is
--	  
--	   -- st0 - INITIAL STATE
--		when st0=>
--        if (s_Enable = '1') then 
--          next_state <= st1;            -- Next state is "st1 - CALIBRATION STATE step 1"
--        end if;
--		
--		-- st1 - CALIBRATION STATE step 1
--		when st1=>
--		  s_cal_idelay <= '1';
--        if s_busy_idelay_m = '1' then 
--          next_state <= st2;            -- Next state is "st2 - CALIBRATION STATE step 2"
--        end if;
--      
--		-- st2 - CALIBRATION STATE step 2
--		when st2=>
--        if s_busy_idelay_m = '0' then 
--          next_state <= st3;            -- Next state is "st3 - RESET STATE"
--        end if;
--		
--		-- st3 - RESET STATE
--		when st3=>
--		  s_Rst_FSM <= '1';
--        next_state <= st4;              -- Next state is "st4 - WAIT"
--		  
--		-- st4 - WAIT
--		when st4=>
--        next_state <= st4;              -- Next state is "st4 - WAIT"
--	 end case;
--


  -- For now, just pass the reset signal straight to the output
  p_register_reset: process (clk_i)
  begin  -- process p_register_reset
    if rising_edge(clk_i) then  -- rising clock edge
      s_reset_d1 <= reset_i;
      s_reset_d2 <= s_reset_d1;
      reset_o <= s_reset_d2;
    end if;
  end process p_register_reset;

  -- Tie calibration signal low.
  cal_o <= '0';
  

end rtl;
