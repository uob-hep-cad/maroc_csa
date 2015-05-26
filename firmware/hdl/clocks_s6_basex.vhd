-- clocks_s6_basex
--
-- Generates a 31.25MHz ipbus clock from 125MHz xtal reference
-- Includes reset logic for ipbus
--
-- Dave Newbold, April 2011
--
-- DGC , 26/March/2015 Modified original (which generated a 25MHz ipbus clock from 200MHz xtal reference)
-- change for 15.625 MHz clock to help debug timing. 9/apr/15

library ieee;
use ieee.std_logic_1164.all;

library unisim;
use unisim.VComponents.all;

entity clocks_s6_basex is port(
		sysclk_i: in std_logic;
		clki_125: in std_logic;
		clko_ipb: out std_logic;
		sysclko: out std_logic;
		locked: out std_logic;
		nuke: in std_logic;
		rsto_125: out std_logic;
		rsto_ipb: out std_logic;
		onehz: out std_logic
	);

end clocks_s6_basex;

architecture rtl of clocks_s6_basex is

	signal clk_ipb_i, clk_ipb_b, d17, d17_d, dcm_locked, sysclk, sysclk_ub: std_logic;
	signal nuke_i, nuke_d, nuke_d2: std_logic := '0';
	signal rst, rst_ipb, rst_125: std_logic := '1';

begin

	sysclko <= sysclk_i;
	clko_ipb <= clk_ipb_b;

	bufg_ipb: BUFG port map(
		i => clk_ipb_i,
		o => clk_ipb_b
	);

        -- 125MHz input ( 8ns period ), 31.25MHz output ( 32ns )
        -- 125MHz input ( 8ns period ), 15.625MHz output ( 64ns ) --- put in to make timing clearer
	dcm0: DCM_CLKGEN
		generic map(
			CLKIN_PERIOD => 8.0,
			CLKFX_MULTIPLY => 2,
			CLKFX_DIVIDE => 8 -- 31.25MHz
         -- CLKFX_DIVIDE => 16  -- 15.625MHz
		)
		port map(
			clkin => sysclk_i,
			clkfx => clk_ipb_i,
			locked => dcm_locked,
			rst => '0'
		);
		
	clkdiv: entity work.clock_div port map(
		clk => sysclk_i,
		d17 => d17,
		d28 => onehz
	);
	
	process(sysclk_i)
	begin
		if rising_edge(sysclk_i) then
			d17_d <= d17;
			if d17='1' and d17_d='0' then
				rst <= nuke_d2 or not dcm_locked;
				nuke_d <= nuke_i; -- Time bomb (allows return packet to be sent)
				nuke_d2 <= nuke_d;
			end if;
		end if;
	end process;
		
	locked <= dcm_locked;
	
	process(clk_ipb_b)
	begin
		if rising_edge(clk_ipb_b) then
			rst_ipb <= rst;
			rsto_ipb <= rst_ipb; -- Delay by extrac clock cycle to give extra time for routing.
			nuke_i <= nuke;
		end if;
	end process;
	
	
	
	process(clki_125)
	begin
		if rising_edge(clki_125) then
			rst_125 <= rst;
		end if;
	end process;
	
	rsto_125 <= rst_125;

end rtl;
