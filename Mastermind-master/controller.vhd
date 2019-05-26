library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.base_package.all;


entity controller is
	port
	(
		CLOCK                : in  std_logic;
		RESET_N              : in  std_logic;

		CHANGE_SQUARE_BUTTON : in  std_logic;
		CHANGE_COLOR_BUTTON  : in  std_logic;
		CONFIRM_GUESS_BUTTON : in  std_logic;
		SHOW_SECRET_BUTTON   : in  std_logic;

		-- Connections with Datapath
		CHANGE_SQUARE        : out std_logic;
		CHANGE_COLOR         : out std_logic;
		CONFIRM_GUESS        : out std_logic;

		-- Connections with View
		SHOW_SECRET          : out std_logic;
		REDRAW               : out std_logic
	);

end entity;


architecture RTL of controller is
begin
	
	process (CLOCK, RESET_N)
		variable first_time        : std_logic;
		variable confirm_guess_old : std_logic;
		variable change_square_old : std_logic;
		variable change_color_old  : std_logic;
		variable show_secret_old   : std_logic;
		variable in_play           : std_logic;
	begin
		if (RESET_N = '0') then
			CHANGE_SQUARE     <= '0';
			CHANGE_COLOR      <= '0';
			CONFIRM_GUESS     <= '0';
			SHOW_SECRET       <= '0';
			REDRAW            <= '0';
			first_time        := '1';
			confirm_guess_old := '0';
			change_square_old := '0';
			change_color_old  := '0';
			show_secret_old   := '0';
			in_play           := '0';
			
		elsif rising_edge(CLOCK) then
			CHANGE_SQUARE   <= '0';	
			CHANGE_COLOR    <= '0';
			CONFIRM_GUESS   <= '0';
			REDRAW          <= '0';
			if (first_time = '1') then
				first_time := '0';
				REDRAW <= '1';
			elsif (change_square_old = '0' and CHANGE_SQUARE_BUTTON = '1') then
				CHANGE_SQUARE <= '1';
				REDRAW        <= '1';
				in_play       := '1';
			elsif (change_color_old = '0' and CHANGE_COLOR_BUTTON = '1') then
				CHANGE_COLOR  <= '1';
				REDRAW        <= '1';
				in_play       := '1';
			elsif (confirm_guess_old = '0' and CONFIRM_GUESS_BUTTON = '1') then					
				CONFIRM_GUESS <= '1';
				REDRAW        <= '1';
				in_play       := '1';
			elsif (in_play = '1' and show_secret_old /= SHOW_SECRET_BUTTON) then					
				SHOW_SECRET <= SHOW_SECRET_BUTTON;
				REDRAW      <= '1';
				show_secret_old   := SHOW_SECRET_BUTTON;
			end if;
			change_square_old := CHANGE_SQUARE_BUTTON;
			change_color_old  := CHANGE_COLOR_BUTTON;
			confirm_guess_old := CONFIRM_GUESS_BUTTON;
		end if;
	end process;
		
end architecture;