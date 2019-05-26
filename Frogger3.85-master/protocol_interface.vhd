library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity keyboard_reader is
	Port ( Keyboard_Output: in STD_LOGIC_VECTOR (7 downto 0);
			Control_Out:	out STD_LOGIC_VECTOR (2 downto 0));
end keyboard_reader;

architecture behavorial of keyboard_reader is

begin 
	process( Keyboard_Output)
	begin
		if (Keyboard_Output = x"75") then		-- Keyboard outputting (up)
		Control_Out<= "100";
		elsif (Keyboard_Output = x"6B") then	-- Keyboard outputting (left)
		Control_Out<= "110";
		elsif (Keyboard_Output = x"72") then	-- Keyboard outputting (down)
		Control_Out<= "101";
		elsif (Keyboard_Output = x"74") then 	-- Keyboard outputting (right)
		Control_Out<= "111";
		else
		Control_Out<= "000";
		end if;
	end process;
end Behavorial; 