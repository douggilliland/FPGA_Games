library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Paddle_Controller is
		PORT (
			clk : in std_logic;
			rst : in std_logic;
			SW : in std_logic_vector(1 downto 0);
			LEDR : out std_logic_vector(9 downto 0);
			paddle_x : out unsigned (11 downto 0);
			paddle_hit : out std_logic
			);
			
end entity Paddle_Controller;

architecture behavior of Paddle_Controller is
	
	signal x_pos : unsigned (11 downto 0);
	
	begin
		process(clk, rst)
		variable count : integer := 0;
		begin
		if (rst = '0') then
			x_pos <= X"13F";
			LEDR <= (others => '0');
			count := 0;
		elsif rising_edge(clk) then
			count := count + 1;
			if (count = 133333) then
				LEDR(3) <= '1';
				if (SW(0) = '1') then
					LEDR(0) <= '1';
					x_pos <= x_pos + 1;
				elsif (SW(1) = '1') then
					LEDR(1) <= '1';
					x_pos <= x_pos - 1;
				else
					x_pos <= x_pos;
				end if;
				count := 0;
			end if;
			paddle_x <= x_pos;
		end if;
	end process;
	
end architecture behavior;