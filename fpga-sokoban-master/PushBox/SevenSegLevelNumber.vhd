library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.PushBoxLevels.all;

-- Assumimos que o número de níveis nunca chegará a 100 ou mais.
-- Se precisar de mais um display de sete segmentos, essa entidade
-- precisará ser atualizada.

entity SevenSegLevelNumber is
	port (
		cur_level   : in  unsigned(7 downto 0);
		seven_seg_0 : out unsigned(6 downto 0);
		seven_seg_1 : out unsigned(6 downto 0);
		seven_seg_2 : out unsigned(6 downto 0);
		seven_seg_3 : out unsigned(6 downto 0)
	);
end entity;

architecture archSevenSegLevelNumber of SevenSegLevelNumber is
begin
	seven_seg_0 <= "1000000" when unsigned((cur_level+1) mod 10) = "0000" else
	               "1111001" when unsigned((cur_level+1) mod 10) = "0001" else
	               "0100100" when unsigned((cur_level+1) mod 10) = "0010" else
	               "0110000" when unsigned((cur_level+1) mod 10) = "0011" else
	               "0011001" when unsigned((cur_level+1) mod 10) = "0100" else
	               "0010010" when unsigned((cur_level+1) mod 10) = "0101" else
	               "0000010" when unsigned((cur_level+1) mod 10) = "0110" else
	               "1111000" when unsigned((cur_level+1) mod 10) = "0111" else
	               "0000000" when unsigned((cur_level+1) mod 10) = "1000" else
	               "0011000" when unsigned((cur_level+1) mod 10) = "1001" else
	               "1111111";
	
	seven_seg_1 <= "1000000" when unsigned((cur_level+1) / 10) = "0000" else
	               "1111001" when unsigned((cur_level+1) / 10) = "0001" else
	               "0100100" when unsigned((cur_level+1) / 10) = "0010" else
	               "0110000" when unsigned((cur_level+1) / 10) = "0011" else
	               "0011001" when unsigned((cur_level+1) / 10) = "0100" else
	               "0010010" when unsigned((cur_level+1) / 10) = "0101" else
	               "0000010" when unsigned((cur_level+1) / 10) = "0110" else
	               "1111000" when unsigned((cur_level+1) / 10) = "0111" else
	               "0000000" when unsigned((cur_level+1) / 10) = "1000" else
	               "0011000" when unsigned((cur_level+1) / 10) = "1001" else
	               "1111111";
	
	seven_seg_2 <= "1111111";
	seven_seg_3 <= "1111111";
	
end architecture;
