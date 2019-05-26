library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;


entity random is
	port(
			CLK : 					in std_logic;
			resetN : 				in std_logic;
			enable : 				in std_logic;
			get_value 	: in std_logic;
			
			taken_value : out std_logic_vector(1 downto 0)

		);
end entity;

architecture arch_random of random is
	signal sigCounter : std_logic_Vector(1 downto 0);
	type can_take is (can , can_not);

	signal sigCanWeTake : can_take;
begin
	process (CLK, resetN)
	begin
		if (resetN = '0') then
			sigCounter <= "00";
			sigCanWeTake <= can;
		elsif rising_edge(CLK) then
			if (enable = '1') then
				sigCounter <= sigCounter + 1;
				if (get_value = '1' and sigCanWeTake = can) then
					taken_value <= sigCounter;
					sigCanWeTake <= can_not;
				elsif (get_value = '0') then
					sigCanWeTake <= can;
				end if;
			end if;
		end if;
	end process;
end architecture;
