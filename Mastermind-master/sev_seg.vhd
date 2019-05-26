library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.base_package.all;


entity sev_seg is
	port
	(
		CLOCK            : in std_logic;
		RESET_N          : in std_logic;
		
		GAME_WON         : in std_logic;
		GAME_LOST        : in std_logic;
		COUNTDOWN        : in natural;

		DISPLAY_1        : out std_logic_vector(6 downto 0);
		DISPLAY_2        : out std_logic_vector(6 downto 0);
		DISPLAY_3        : out std_logic_vector(6 downto 0);
		DISPLAY_4        : out std_logic_vector(6 downto 0)
	);
end sev_seg;

architecture behavioral of sev_seg is

	constant clockwise_circle_phases : natural := 6;
	constant flashing_x_phases       : natural := 2;
	
	signal animation_clock   : std_logic;
	signal current_phase     : natural;
	signal current_animation : std_logic_vector(6 downto 0);
			
	function clockwise_circle(x : natural)
		return std_logic_vector is
	begin
		case(x) is
			when 0      => return "1011111";
			when 1      => return "1101111";
			when 2      => return "1110111";
			when 3      => return "1111011";
			when 4      => return "1111101";
			when 5      => return "1111110";
			when others => return "1111111";
		end case;
	end function;
	
	function flashing_x(x : natural)
		return std_logic_vector is
	begin
		case(x) is
			when 0      => return "0001001";
			when 1      => return "1111111";
			when others => return "1111111";
		end case;
	end function;
	
begin

	display: process (CLOCK, RESET_N) is
   begin
		if (RESET_N = '0') then
			current_animation <= "1111111";
			current_phase <= 0;
			DISPLAY_1 <= "1111111";
			DISPLAY_2 <= "1111111";
			DISPLAY_3 <= "1111111";
			DISPLAY_4 <= "1111111";

		elsif (rising_edge(CLOCK)) then
			if (GAME_WON = '1' and animation_clock = '1') then
				current_animation <= clockwise_circle(current_phase);
				DISPLAY_1 <= current_animation;
				DISPLAY_2 <= current_animation;
				DISPLAY_3 <= current_animation;
				DISPLAY_4 <= current_animation;
				if current_phase + 1 = clockwise_circle_phases then
					current_phase <= 0;
				else
					current_phase <= current_phase + 1;
				end if;
				
			elsif (GAME_LOST = '1' and animation_clock = '1') then				
				current_animation <= flashing_x(current_phase);
				DISPLAY_1 <= current_animation;
				DISPLAY_2 <= current_animation;
				DISPLAY_3 <= current_animation;
				DISPLAY_4 <= current_animation;
				if current_phase + 1 = clockwise_circle_phases then
					current_phase <= 0;
				else
					current_phase <= current_phase + 1;
				end if;
				
			else
			-- qui il display 1 mostra il countdown
				if (GAME_WON = '0' and GAME_LOST = '0') then
					case (COUNTDOWN) is
						when 1 =>	   DISPLAY_1 <= "1111001";
						when 2 =>  	   DISPLAY_1 <= "0100100";
						when 3 =>	   DISPLAY_1 <= "0110000";
						when 4 =>	   DISPLAY_1 <= "0011001";
						when 5 =>	   DISPLAY_1 <= "0010010";
						when 6 =>	   DISPLAY_1 <= "0000010";
						when 7 =>	   DISPLAY_1 <= "1111000";
						when 8 =>	   DISPLAY_1 <= "0000000";
						when 9 =>		DISPLAY_1 <= "0011000";
						when others => DISPLAY_1 <= "1111111";
					end case;
				end if;
			end if;
		end if;
	end process display;
	
	animation_clock_gen : process(CLOCK, RESET_N) is
		variable counter : natural range 0 to (5000000 - 1);
	begin
		if (RESET_N = '0') then
			animation_clock <= '0';
			counter := 0;
			
		elsif (rising_edge(CLOCK)) then
			if counter = counter'HIGH then
				counter := 0;
				animation_clock <= '1';
			else
				counter := counter + 1;
				animation_clock <= '0';
			end if;
		end if;
	end process ;

end behavioral;