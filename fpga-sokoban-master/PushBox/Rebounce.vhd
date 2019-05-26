library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Rebounce is
	generic (
		COUNTER_SIZE : natural := 19
	);
	
	port (
		clk    : in  std_logic;
		button : in  std_logic;
		result : out std_logic
	);
end entity;

architecture archRebounce of Rebounce is
signal flipflops   : unsigned(1 downto 0);
signal counter_set : std_logic;
signal counter_out : unsigned(COUNTER_SIZE downto 0) := (others => '0');

begin

	counter_set <= flipflops(0) xor flipflops(1);
	
	process (clk)
	begin
	
		if rising_edge(clk) then
			flipflops(0) <= button;
			flipflops(1) <= flipflops(0);
			if counter_set = '1' then
				counter_out <= (others => '0');
			elsif counter_out(COUNTER_SIZE) = '0' then
				counter_out <= counter_out + 1;
			else
				result <= flipflops(1);
			end if;
		end if;
	
	end process;

end architecture;
