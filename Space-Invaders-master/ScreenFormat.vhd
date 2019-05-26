library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.ALL;

entity ScreenFormat is
	port (	
		x :   in std_logic_vector(9 downto 0);
		y :   in std_logic_vector(9 downto 0); 
		test_op: in std_logic;
		colss : in integer range 0 to 19;
		rowinv : in integer range 0 to 14;
		colinv : in  std_logic_vector(19 downto 0);
		bullet_row : in integer range 0 to 14;
		bullet_col : in  integer range 0 to 19;
		color: out std_logic_vector(2 downto 0)
	);
end ScreenFormat;

architecture ScreenFormat of ScreenFormat is
begin
	process(x, y, test_op, colss, rowinv, colinv, bullet_row, bullet_col)
	begin 
		if test_op = '1' then
			--color for spaceship
			if y > 448 and y < 480 and x > (colss*32) and x < ((colss+1)*32) then
				color <= "010";
			--color for invaders
			elsif y(9 downto 5) = rowinv and colinv(to_integer(unsigned(x(9 downto 5)))) = '1' then
				color <= "110";
			--color for bullet
			elsif y(9 downto 5) = bullet_row and x(9 downto 5) = bullet_col then
				color <= "011";
			--else color is black
			else
				color <= "000";
			end if;
		else 
			--checker board pattern as test screen
			if x(5) = y(5) then
				color <= "000";
			else
				color <= "111";
			end if;	
		end if;
		
	end process;
end ScreenFormat;