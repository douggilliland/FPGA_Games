library ieee;
use ieee.std_logic_1164.ALL;
use ieee.std_logic_arith.ALL;
use ieee.std_logic_unsigned.ALL;

entity Dflipflop is
  port(
	D, clk, rs: in std_logic;
	Q: out std_logic);
end Dflipflop;

architecture behavior of Dflipflop is
begin
	  process(rs, clk)
			begin
				if rs = '1' then
				Q <= '0';
				elsif(rising_edge(clk)) then
				Q <= D;
				end if;
			end process;	
end behavior;