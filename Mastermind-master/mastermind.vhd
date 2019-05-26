library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.base_package.all;
use work.vga_package.all;
use work.text_package.all;

entity mastermind is

	port
	(
		CLOCK_50            : in  std_logic;
		KEY                 : in  std_logic_vector(3 downto 0);

		SW                 : in  std_logic_vector(9 downto 0);
		VGA_R               : out std_logic_vector(3 downto 0);
		VGA_G               : out std_logic_vector(3 downto 0);
		VGA_B               : out std_logic_vector(3 downto 0);
		VGA_HS              : out std_logic;
		VGA_VS              : out std_logic;
		
		HEX0                : out std_logic_vector(6 downto 0);
		HEX1                : out std_logic_vector(6 downto 0);
		HEX2                : out std_logic_vector(6 downto 0);
		HEX3                : out std_logic_vector(6 downto 0);
		
		SRAM_ADDR           : out   std_logic_vector(17 downto 0);
		SRAM_DQ             : inout std_logic_vector(15 downto 0);
		SRAM_CE_N           : out   std_logic;
		SRAM_OE_N           : out   std_logic;
		SRAM_WE_N           : out   std_logic;
		SRAM_UB_N           : out   std_logic;
		SRAM_LB_N           : out   std_logic
	);

end;


architecture RTL of mastermind is
	signal clock          		: std_logic;
	signal clock_vga      		: std_logic;
	signal RESET_N        		: std_logic;
	signal fb_ready       		: std_logic;
	signal fb_clear       		: std_logic;
	signal fb_flip        		: std_logic;
	signal fb_draw_filled_rect : std_logic;
	signal fb_draw_empty_rect  : std_logic;
	signal fb_draw_text   		: std_logic;
	signal fb_x0          		: xy_coord_type;
	signal fb_y0          		: xy_coord_type;
	signal fb_x1          		: xy_coord_type;
	signal fb_y1          		: xy_coord_type;
	signal fb_color       		: color_type;
	signal fb_text        		: message;
	signal redraw         		: std_logic;
	signal change_square  		: std_logic;
	signal change_color   		: std_logic;
	signal confirm_guess  		: std_logic;
	signal query_guess    		: natural range 0 to GUESSES_NUMBER;
	signal guess_content  		: guess;
	signal query_hint     		: natural range 0 to GUESSES_NUMBER;
	signal hint_content   		: hint;
	signal check          		: guess;
	signal game_won       		: std_logic;
	signal game_lost      		: std_logic;
	signal current_guess  		: natural range 0 to (GUESSES_NUMBER - 1);
	signal current_square 		: natural range 0 to (SQUARES_NUMBER - 1);
	signal current_color  		: guess_peg;
	signal countdown_r    		: natural;
	signal reset_sync_reg 		: std_logic;
	signal show_secret         : std_logic;
begin

	pll : entity work.PLL
		port map (
			inclk0  => CLOCK_50,
			c0      => clock_vga,
			c1      => clock
		); 
	
	reset_sync : process(CLOCK_50)
	begin
		if (rising_edge(CLOCK_50)) then
			reset_sync_reg <= SW(9);
			RESET_N <= reset_sync_reg;
		end if;
	end process;
	
	vga : entity work.vga_framebuffer
		port map (
			CLOCK     			=> clock_vga,
			RESET_N   			=> RESET_N,
			READY     			=> fb_ready,
			COLOR     			=> fb_color,
			CHOSEN_TEXT 		=> fb_text,
			CLEAR     			=> fb_clear,
			DRAW_EMPTY_RECT 	=> fb_draw_empty_rect,
			DRAW_FILLED_RECT 	=> fb_draw_filled_rect,
			DRAW_TEXT 			=> fb_draw_text,
			FLIP      			=> fb_flip,	
			X0        			=> fb_x0,
			Y0        			=> fb_y0,
			X1        			=> fb_x1,
			Y1        			=> fb_y1,
				
			VGA_R     			=> VGA_R,
			VGA_G     			=> VGA_G,
			VGA_B     			=> VGA_B,
			VGA_HS    			=> VGA_HS,
			VGA_VS    			=> VGA_VS,
		
			SRAM_ADDR 			=> SRAM_ADDR,
			SRAM_DQ   			=> SRAM_DQ,			
			SRAM_CE_N 			=> SRAM_CE_N,
			SRAM_OE_N 			=> SRAM_OE_N,
			SRAM_WE_N 			=> SRAM_WE_N,
			SRAM_UB_N 			=> SRAM_UB_N,
			SRAM_LB_N 			=> SRAM_LB_N
		);
	
	controller : entity work.controller
		port map (
			CLOCK           			 => clock,
			RESET_N         			 => RESET_N,
			
			CHANGE_SQUARE_BUTTON     => not(KEY(3)),
			CHANGE_COLOR_BUTTON    	 => not(KEY(2)),
			CONFIRM_GUESS_BUTTON     => not(KEY(1)),
			SHOW_SECRET_BUTTON       => SW(0),
			
			CHANGE_SQUARE      		 => change_square,
			CHANGE_COLOR       		 => change_color,
			CONFIRM_GUESS      		 => confirm_guess,
			SHOW_SECRET              => show_secret,
			REDRAW          	 		 => redraw
		);
		
	datapath : entity work.datapath
		port map (
			CLOCK          => clock,
			RESET_N        => RESET_N,
			CHANGE_SQUARE  => change_square,
			CHANGE_COLOR   => change_color,
			CONFIRM_GUESS  => confirm_guess,
			QUERY_GUESS    => query_guess,   
			GUESS_CONTENT	=> guess_content,
			QUERY_HINT		=> query_hint,
			HINT_CONTENT 	=> hint_content,
			CHECK          => check,
			CURRENT_SQUARE => current_square,
			CURRENT_COLOR 	=> current_color,
			CURRENT_GUESS  => current_guess,
			GAME_WON       => game_won,
			GAME_LOST  	   => game_lost,
			COUNTDOWN      => countdown_r
		);
		
	sev_seg : entity work.sev_seg
		port map (
			CLOCK           => clock,
			RESET_N         => RESET_N,
			
			GAME_WON        => game_won,
			GAME_LOST       => game_lost,
			COUNTDOWN       => countdown_r,

			DISPLAY_1       => HEX0,
			DISPLAY_2       => HEX1,
			DISPLAY_3       => HEX2,
			DISPLAY_4       => HEX3
		);
			
	view : entity work.view
		port map (
			CLOCK           		=> clock,
			RESET_N         		=> RESET_N,
			REDRAW          		=> redraw,
			FB_READY        		=> fb_ready,
			FB_CLEAR        		=> fb_clear,
			FB_DRAW_FILLED_RECT  => fb_draw_filled_rect,
			FB_DRAW_EMPTY_RECT 	=> fb_draw_empty_rect,
			FB_DRAW_TEXT    		=> fb_draw_text,
			FB_FLIP         		=> fb_flip,
			FB_COLOR        		=> fb_color,
			FB_TEXT         		=> fb_text,
			FB_X0           		=> fb_x0,
			FB_Y0           		=> fb_y0,
			FB_X1           		=> fb_x1,
			FB_Y1           		=> fb_y1,
			QUERY_GUESS    		=> query_guess,   
			GUESS_CONTENT			=> guess_content,
			QUERY_HINT				=> query_hint,
			HINT_CONTENT 			=> hint_content,
			CHECK          		=> check,
			CURRENT_SQUARE 		=> current_square,
			CURRENT_COLOR 			=> current_color,
			CURRENT_GUESS  		=> current_guess,
			GAME_WON       		=> game_won,
			GAME_LOST  	   		=> game_lost,
			SHOW_SECRET          => show_secret
		);			
		
end architecture;