library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

entity HexDriver is
   port (In0 : in std_logic_vector (3 downto 0);
		  Out0: out std_logic_vector (6 downto 0));
end HexDriver;

architecture Behavorial of HexDriver is

begin
	with In0 select
		Out0 <= "1000000" when "0000" , --'0'
				"1111001" when "0001" , --'1'
				"0100100" when "0010" , --'2'
				"0110000" when "0011" , --'3'
				"0011001" when "0100" , --'4'
				"0010010" when "0101" , --'5'
				"0000010" when "0110" , --'6'
				"1111000" when "0111" , --'7'
				"0000000" when "1000" , --'8'
				"0010000" when "1001" , --'9'
				"0001000" when "1010" , --'A'
				"0000011" when "1011" , --'b'
				"1000110" when "1100" , --'C'
				"0100001" when "1101" , --'d'
				"0000110" when "1110" , --'E'
				"0001110" when "1111" , --'F'
				"XXXXXXX" when others;
end Behavorial;