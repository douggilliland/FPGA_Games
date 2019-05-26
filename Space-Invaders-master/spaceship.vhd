library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Starship is
	port (  clk, reset: in std_logic;
		rightdir: in std_logic;
		leftdir: in std_logic;
		colss: out  integer range 0 to 19
	);
end Starship;

architecture ss of Starship is
signal colposition : integer range 0 to 19;
signal right_dir: std_logic;

begin
	process (clk, reset)
	begin 
		if reset = '1' then
			colposition <= 9;
		elsif clk'event and clk = '1' then
			if rightdir = '1' then
			     if colposition < 19 then
				        colposition <= colposition + 1;
			     else
				        colposition <= 19;
				 end if;
			end if;
		
			if leftdir = '1' then 
			     if colposition > 0 then
			            colposition <= colposition - 1;
			     else 
				        colposition <= 0;
			     end if;
			end if;
		end if;
	end process;	
colss <= colposition;	

end ss;

