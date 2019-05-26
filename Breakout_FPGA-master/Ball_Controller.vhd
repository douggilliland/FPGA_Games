library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Ball_Controller is
		PORT (
			clk : in std_logic;
			rst : in std_logic;
			start_game : in std_logic;
			ball_x : out unsigned (11 downto 0);
			ball_y : out unsigned (11 downto 0);
			paddle_hit : in std_logic
			);
			
end entity Ball_Controller;

architecture behavior of Ball_Controller is
signal ball_enable : std_logic;
signal x_pos : unsigned(11 downto 0);
signal y_pos : unsigned(11 downto 0);


begin
	process(clk, rst)
	begin
		if(rst = '0') then
			ball_enable <= '0';
		elsif rising_edge(clk) then
			if (start_game = '0') then
				if ball_enable = '0' then
					ball_enable <= '1';
				end if;
			end if;
		end if;
	end process;
	
	process(clk, rst)
	variable count : integer := 0;
	variable velocity_x : integer := 0;
	variable velocity_y : integer := 1;
	variable has_hit : std_logic := '0';
	
	begin
		if (rst= '0') then
			x_pos <= X"13F";
			y_pos <= X"104";
			velocity_y := 1;
			velocity_x := 0;
			has_hit := '0';
			count := 0;			
		elsif rising_edge(clk) then
			count := count + 1;
			if (count = 333333) then
				if (ball_enable = '1') then
					if (y_pos = 246 OR y_pos = 474) then
						if has_hit = '0' then
							velocity_y := -velocity_y;
							velocity_x := 1;
							has_hit := '1';
						else
						velocity_x := velocity_x;
						velocity_y := -velocity_y;
						end if;
					end if;
					if (x_pos = 5 OR x_pos = 634) then
						velocity_x := -velocity_x;
						velocity_y := velocity_y;
					end if;
					x_pos <= x_pos + velocity_x;
					y_pos <= y_pos + velocity_y;
				else
					x_pos <= x_pos;
					y_pos <= y_pos;
				end if;

				count := 0;
			end if;
				ball_x <= x_pos;
				ball_y <= y_pos;
		end if;
	
	end process;


end architecture behavior;