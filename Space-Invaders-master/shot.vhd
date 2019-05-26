library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity shot is
port	(enable, clk, reset	  : in  std_logic;
	 Fire		          : in  std_logic; 
	 bullet_row		  : out integer range 0 to 14;
	 bullet_col		  : out integer range 0 to 19;
	 end_bullet		  : in  std_logic;
	 bullet_on		  : out std_logic;
	 colss			  : in integer range 0 to 19
	);
end shot;

architecture ups of shot is 

signal x :  integer range 0 to 14; --bullet_row
signal y :  integer range 0 to 19; --bullet_column
signal bullet : std_logic; --bullet_on

begin 

	process(reset, clk,x,y,bullet, colss)
	begin
	if reset = '1' then --if it's a reset the bullet is in the position of the space ship
		x <= 0;
		y <= colss;
	elsif(clk'event and clk = '1' ) then
		if Fire = '1' then
			bullet <= '1';
			y <= y;
		elsif bullet = '1' then
			if enable = '1' then
				x <= x + 1;
				y <= y;
				if x = 14 or end_bullet = '1' then --conditions that turn bullet off
					bullet <= '0';
					y <= y;
				end if;
			end if;
		end if;	
	end if;

bullet_row <= x;
bullet_col <= y;
bullet_on  <= bullet;

	end process;
end ups;