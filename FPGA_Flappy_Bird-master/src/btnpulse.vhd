----------------------------------------------------------------------------------
-- Luke Hsiao
-- ECEN 320 Lab 12
-- Generates a single clk pulse  on the rising edge of a button
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity btnpulse is
    Port ( btn : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           btnpulse : out  STD_LOGIC);
end btnpulse;

architecture state_arch of btnpulse is
	type states is (zero, riseEdge, one);
	signal state_reg, state_next: states;
begin

	process(clk, reset)
	begin
		if reset='1' then 
			state_reg <= zero;
		elsif clk'event and clk='1' then
			state_reg <= state_next;
		end if;
	end process;
	
	--Next State and Output Logic
	process (btn, state_reg)
	begin
		--Defaults
		btnpulse <= '0';
		state_next <= state_reg;
		case state_reg is
			when zero =>
				if (btn='0') then
					state_next <= zero;
				else
					state_next <= riseEdge;
				end if;
			when riseEdge =>
				btnpulse <= '1';
				state_next <= one;
			when one =>
				if btn='1' then
					state_next <= one;
				else
					state_next <= zero;
				end if;
		end case;
	end process;
	
end state_arch;

