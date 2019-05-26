library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity timer is
generic(maxval: integer);
port (clk, reset  : in std_logic;
      enable      : out std_logic 
      );
end timer;

architecture Behavioral of timer is

signal cnt : integer range 0 to maxval;
signal Ct: std_logic :='0';
begin
	process(clk, reset)
	begin
	if reset = '1' then
		cnt <= 0; 
	end if;
	if(clk'event and clk='1') then
		cnt <=cnt+1;
		if(cnt = maxval) then
		  cnt <=0;
		end if;
	end if;
end process;
enable <= '1' when cnt = maxval else '0';
end Behavioral;
