library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.base_package.all;
use work.vga_package.all;
use work.text_package.all;

entity view is
	port
	(
		CLOCK               : in  std_logic;
		RESET_N             : in  std_logic;
		
		REDRAW              : in  std_logic;
		
		FB_READY            : in  std_logic;
		FB_CLEAR            : out std_logic;
		FB_DRAW_EMPTY_RECT  : out std_logic;
		FB_DRAW_FILLED_RECT : out std_logic;
		FB_DRAW_TEXT        : out std_logic;
		FB_FLIP             : out std_logic;

		FB_COLOR            : out color_type;
		FB_X0               : out xy_coord_type;
		FB_Y0               : out xy_coord_type;
		FB_X1               : out xy_coord_type;
		FB_Y1               : out xy_coord_type;
		FB_TEXT             : out message;
		
		QUERY_GUESS         : out natural range 0 to GUESSES_NUMBER;
		GUESS_CONTENT       : in  guess;
		QUERY_HINT          : out natural range 0 to GUESSES_NUMBER;
		HINT_CONTENT        : in  hint;
		CHECK               : in  guess;
		GAME_WON            : in  std_logic;
		GAME_LOST           : in  std_logic;
		CURRENT_GUESS       : in  natural range 0 to (GUESSES_NUMBER - 1);
		CURRENT_SQUARE      : in  natural range 0 to (SQUARES_NUMBER - 1);
		CURRENT_COLOR       : in  guess_peg;
		
		SHOW_SECRET         : in std_logic
	);
end entity;


architecture RTL of view is
	constant CENTER_X : xy_coord_type := 512/2;
	constant CENTER_Y : xy_coord_type := 480/2;
	constant LEFT_MARGIN            : positive := 8;
	constant TOP_MARGIN             : positive := 8;
	constant SQUARE_SIZE            : positive := 24;
	constant SQUARE_SPACING         : positive := 4;
	constant LEFT_SPACING_TO_CENTER : positive := CENTER_X - 
	(LEFT_MARGIN * 2  + (SQUARES_NUMBER * (SQUARE_SIZE + SQUARE_SPACING)) * 2 + SQUARE_SPACING) / 2;
	constant TOP_SPACING_TO_CENTER  : positive := 32;
	
	constant BACKGROUND_COLOR : color_type := COLOR_BLACK;
	constant TABLES_COLOR     : color_type := COLOR_BROWN;
	constant SELECTION_COLOR  : color_type := COLOR_WHITE;
	constant TEXT_COLOR       : color_type := COLOR_WHITE;
	
	type colors_array is array(natural range<>) of color_type;
	constant GUESS_PEG_COLORS : colors_array(0 to (COLORS_NUMBER - 1)) := 
	(0 => COLOR_ORANGE, 1 => COLOR_RED, 2 => COLOR_GREEN, 3 => COLOR_BLUE, 4 => COLOR_YELLOW, 
	5 => COLOR_CYAN, 6 => COLOR_MAGENTA, 7 => COLOR_PURPLE);
	constant HINT_PEG_COLORS  : colors_array(0 to (HINTS_NUMBER - 1)) := 
	(0 => COLOR_BLACK, 1 => COLOR_WHITE, 2 => COLOR_BROWN);
	
	
	type   state_type      is (IDLE, WAIT_FOR_READY, DRAWING);
	signal state           : state_type;

	type   substate_type   is (CLEAR_SCENE, DRAW_INITIAL_TEXT, DRAW_INTRO_TEXT, DRAW_GAME_LOST, 
										DRAW_CHECK_GUESS, DRAW_GAME_WON, DRAW_GUESS_BOARD, DRAW_GUESSES, 
										DRAW_HINT_BOARD, DRAW_HINTS, DRAW_SQUARE_BORDER, 
										DRAW_SELECTABLE_COLORS, DRAW_SELECTED_COLOR_BORDER, 
										DRAW_SECRET, FLIP_FRAMEBUFFER);
	signal substate        : substate_type;
	
	signal query_guess_r   : natural range 0 to GUESSES_NUMBER;
	signal query_hint_r    : natural range 0 to GUESSES_NUMBER;
	signal square_to_draw  : natural range 0 to SQUARES_NUMBER;
	
	
	function guess_peg_to_color(x : guess_peg)
		return color_type	is
	begin
		return GUESS_PEG_COLORS(x);
	end function;
	
	function hint_peg_to_color(x : hint_peg)
		return color_type	is
	begin
		return HINT_PEG_COLORS(hint_peg'POS(x));
	end function;
	
begin
	
	QUERY_GUESS    <= query_guess_r;
	QUERY_HINT     <= query_hint_r;

	process(CLOCK, RESET_N)
		variable initial_screen : std_logic := '1';
		variable color_to_show  : natural := 0;
	begin
	
		if (RESET_N = '0') then
			state               <= IDLE;
			substate            <= CLEAR_SCENE;
			FB_CLEAR            <= '0';
			FB_DRAW_EMPTY_RECT  <= '0';
			FB_DRAW_FILLED_RECT <= '0';
			FB_DRAW_TEXT        <= '0';
			FB_FLIP             <= '0';

			initial_screen      := '1';
			query_guess_r       <= 0;
			query_hint_r        <= 0;
			square_to_draw      <= 0;

		elsif (rising_edge(CLOCK)) then
		
			FB_CLEAR            <= '0';
			FB_DRAW_FILLED_RECT <= '0';
			FB_DRAW_EMPTY_RECT  <= '0';
			FB_DRAW_TEXT        <= '0';
			FB_FLIP             <= '0';
	
			case (state) is
				when IDLE =>
					if (REDRAW = '1') then
						state    <= WAIT_FOR_READY;
						substate <= CLEAR_SCENE;
					end if;
					
				when WAIT_FOR_READY =>
					if (FB_READY = '1') then
						state <= DRAWING;
					end if;
				
				when DRAWING =>
					state <= WAIT_FOR_READY;
				
					case (substate) is
						when CLEAR_SCENE =>
							FB_COLOR <= BACKGROUND_COLOR;
							FB_CLEAR <= '1';
							if initial_screen = '1' then
								initial_screen := '0';
								substate <= DRAW_INITIAL_TEXT;
							elsif GAME_WON = '1'	then
								substate <= DRAW_GAME_WON;
							elsif GAME_LOST = '1' then
								substate <= DRAW_GAME_LOST;
							else
								substate <= DRAW_GUESS_BOARD;
							end if;
							
						when DRAW_INITIAL_TEXT =>
							FB_COLOR       <= TEXT_COLOR;
							FB_TEXT        <= TITLE;
							FB_X0          <= TEXT_X - (TITLE_TEXT'length * FONT_WIDTH) / 2;
							FB_Y0          <= TEXT_Y - FONT_HEIGHT / 2;
							FB_X1          <= TEXT_X + (TITLE_TEXT'length * FONT_WIDTH) / 2;
							FB_Y1          <= TEXT_Y + FONT_HEIGHT / 2;
							FB_DRAW_TEXT   <= '1';
							substate       <= DRAW_INTRO_TEXT;
							
						when DRAW_INTRO_TEXT =>
							FB_COLOR       <= TEXT_COLOR;
							FB_TEXT        <= INTRO;
							FB_X0          <= TEXT_X - (INTRO_TEXT'length * FONT_WIDTH) / 2;
							FB_Y0          <= TEXT_Y - FONT_HEIGHT / 2 + FONT_HEIGHT * 4;
							FB_X1          <= TEXT_X + (INTRO_TEXT'length * FONT_WIDTH) / 2;
							FB_Y1          <= TEXT_Y + FONT_HEIGHT / 2 + FONT_HEIGHT * 4;
							FB_DRAW_TEXT   <= '1';
							substate       <= FLIP_FRAMEBUFFER;
						
						when DRAW_GAME_WON =>
							FB_COLOR       <= TEXT_COLOR;
							FB_TEXT        <= WIN;
							FB_X0          <= TEXT_X - (WIN_TEXT'length * FONT_WIDTH) / 2;
							FB_Y0          <= TEXT_Y - FONT_HEIGHT / 2;
							FB_X1          <= TEXT_X + (WIN_TEXT'length * FONT_WIDTH) / 2;
							FB_Y1          <= TEXT_Y + FONT_HEIGHT / 2;
							FB_DRAW_TEXT   <= '1';
							substate       <= DRAW_CHECK_GUESS;
						
						when DRAW_GAME_LOST =>
							FB_COLOR       <= TEXT_COLOR;
							FB_TEXT        <= LOSE;
							FB_X0          <= TEXT_X - (LOSE_TEXT'length * FONT_WIDTH) / 2;
							FB_Y0          <= TEXT_Y - FONT_HEIGHT / 2;
							FB_X1          <= TEXT_X + (LOSE_TEXT'length * FONT_WIDTH) / 2;
							FB_Y1          <= TEXT_Y + FONT_HEIGHT / 2;
							FB_DRAW_TEXT   <= '1';
							substate       <= DRAW_CHECK_GUESS;
							
						when DRAW_CHECK_GUESS =>
							FB_COLOR     <= guess_peg_to_color(CHECK(square_to_draw));
							FB_X0        <= TEXT_X - (SQUARES_NUMBER * SQUARE_SIZE + (SQUARES_NUMBER) * SQUARE_SPACING) / 2 
												+ SQUARE_SPACING * (square_to_draw + 1) + SQUARE_SIZE * square_to_draw;
							FB_Y0        <= TEXT_Y + FONT_HEIGHT * 2;
							FB_X1        <= TEXT_X - (SQUARES_NUMBER * SQUARE_SIZE + (SQUARES_NUMBER - 1) * SQUARE_SPACING) / 2
												+ SQUARE_SPACING * (square_to_draw + 1) + SQUARE_SIZE * (square_to_draw + 1);
							FB_Y1        <= TEXT_Y + FONT_HEIGHT * 2 + SQUARE_SPACING + SQUARE_SIZE;	
							FB_DRAW_FILLED_RECT <= '1';
							if (square_to_draw + 1 < SQUARES_NUMBER) then
								square_to_draw <= square_to_draw + 1;
								substate       <= DRAW_CHECK_GUESS;
							else
								square_to_draw <= 0;
								substate <= FLIP_FRAMEBUFFER;
							end if;
							
						when DRAW_GUESS_BOARD =>
							FB_COLOR     <= TABLES_COLOR;
							FB_X0        <= LEFT_MARGIN + LEFT_SPACING_TO_CENTER;
							FB_Y0        <= TOP_MARGIN + TOP_SPACING_TO_CENTER;
							FB_X1        <= LEFT_MARGIN + LEFT_SPACING_TO_CENTER
												+ SQUARES_NUMBER * (SQUARE_SIZE + SQUARE_SPACING) 
												+ SQUARE_SPACING;
							FB_Y1        <= TOP_MARGIN  + TOP_SPACING_TO_CENTER + GUESSES_NUMBER * (SQUARE_SIZE + SQUARE_SPACING) + SQUARE_SPACING;						
							FB_DRAW_FILLED_RECT <= '1';
							substate     <= DRAW_GUESSES;

						when DRAW_GUESSES =>
							FB_COLOR     <= guess_peg_to_color(GUESS_CONTENT(square_to_draw));
							FB_X0        <= LEFT_MARGIN + LEFT_SPACING_TO_CENTER + SQUARE_SPACING * (square_to_draw + 1) + SQUARE_SIZE * square_to_draw;
							FB_Y0        <= TOP_MARGIN + TOP_SPACING_TO_CENTER + SQUARE_SPACING * (query_guess_r + 1) + SQUARE_SIZE * query_guess_r;
							FB_X1        <= LEFT_MARGIN + LEFT_SPACING_TO_CENTER + SQUARE_SPACING * (square_to_draw + 1) + SQUARE_SIZE * (square_to_draw + 1);
							FB_Y1        <= TOP_MARGIN + TOP_SPACING_TO_CENTER + SQUARE_SPACING * (query_guess_r + 1) + SQUARE_SIZE * (query_guess_r + 1);	
							FB_DRAW_FILLED_RECT <= '1';
							if (square_to_draw + 1 < SQUARES_NUMBER) then
								square_to_draw <= square_to_draw + 1;
								substate       <= DRAW_GUESSES;
							else
								square_to_draw <= 0;
								if (query_guess_r + 1 <= CURRENT_GUESS) then
									query_guess_r <= query_guess_r + 1;
									substate    <= DRAW_GUESSES;
								else
									query_guess_r <= 0;
									substate    <= DRAW_HINT_BOARD;
								end if;
							end if;

						when DRAW_HINT_BOARD =>
							FB_COLOR     <= TABLES_COLOR;
							FB_X0        <= LEFT_MARGIN * 2 + LEFT_SPACING_TO_CENTER + SQUARES_NUMBER * (SQUARE_SIZE + SQUARE_SPACING) + SQUARE_SPACING;
							FB_Y0        <= TOP_MARGIN + TOP_SPACING_TO_CENTER;
							FB_X1        <= LEFT_MARGIN * 2 + LEFT_SPACING_TO_CENTER + (SQUARES_NUMBER * (SQUARE_SIZE + SQUARE_SPACING)) * 2 + SQUARE_SPACING * 2;
							FB_Y1        <= TOP_MARGIN  + TOP_SPACING_TO_CENTER + GUESSES_NUMBER * (SQUARE_SIZE + SQUARE_SPACING) + SQUARE_SPACING;						
							FB_DRAW_FILLED_RECT <= '1';
							if CURRENT_GUESS > 0 then
								substate <= DRAW_HINTS;
							else 
								substate <= DRAW_SQUARE_BORDER;
							end if;

						when DRAW_HINTS =>
							FB_COLOR     <= hint_peg_to_color(HINT_CONTENT(square_to_draw));
							FB_X0        <= LEFT_MARGIN * 2 + LEFT_SPACING_TO_CENTER + SQUARES_NUMBER * (SQUARE_SIZE + SQUARE_SPACING) + SQUARE_SPACING
											+ SQUARE_SPACING * (square_to_draw + 1) + SQUARE_SIZE * square_to_draw;
							FB_Y0        <= TOP_MARGIN + TOP_SPACING_TO_CENTER + SQUARE_SPACING * (query_hint_r + 1) + SQUARE_SIZE * query_hint_r;
							FB_X1        <= LEFT_MARGIN * 2 + LEFT_SPACING_TO_CENTER + SQUARES_NUMBER * (SQUARE_SIZE + SQUARE_SPACING) 
											+ SQUARE_SPACING * (square_to_draw + 2) + SQUARE_SIZE * (square_to_draw + 1);
							FB_Y1        <= TOP_MARGIN + TOP_SPACING_TO_CENTER + SQUARE_SPACING * (query_hint_r + 1) + SQUARE_SIZE * (query_hint_r + 1);	
							FB_DRAW_FILLED_RECT <= '1';
							if (square_to_draw + 1 < SQUARES_NUMBER) and (HINT_CONTENT(square_to_draw + 1) /= NOTHING) then
								square_to_draw <= square_to_draw + 1;
								substate       <= DRAW_HINTS;
							else
								square_to_draw <= 0;
								if (query_hint_r + 1 < CURRENT_GUESS) then
									query_hint_r  <= query_hint_r + 1;
									substate    <= DRAW_HINTS;
								else
									query_hint_r <= 0;
									substate    <= DRAW_SQUARE_BORDER;
								end if;
							end if;
					
						when DRAW_SQUARE_BORDER =>
							FB_COLOR <= SELECTION_COLOR;
							FB_X0        <= LEFT_MARGIN + LEFT_SPACING_TO_CENTER
													+ SQUARE_SPACING * CURRENT_SQUARE 
													+ SQUARE_SIZE * CURRENT_SQUARE;
							FB_Y0        <= TOP_MARGIN + TOP_SPACING_TO_CENTER + SQUARE_SPACING * CURRENT_GUESS
													+ SQUARE_SIZE * CURRENT_GUESS;
							FB_X1        <= LEFT_MARGIN + LEFT_SPACING_TO_CENTER + 
													SQUARE_SPACING * (CURRENT_SQUARE + 2)
													+ SQUARE_SIZE * (CURRENT_SQUARE + 1);
							FB_Y1        <= TOP_MARGIN + TOP_SPACING_TO_CENTER + SQUARE_SPACING * (CURRENT_GUESS + 2) 
													+ SQUARE_SIZE * (CURRENT_GUESS + 1);
							FB_DRAW_EMPTY_RECT <= '1';	
							substate <= DRAW_SELECTABLE_COLORS;
							
						when DRAW_SELECTABLE_COLORS =>
							FB_COLOR     <= GUESS_PEG_COLORS(square_to_draw);
							FB_X0        <= LEFT_MARGIN + LEFT_SPACING_TO_CENTER +  (SQUARE_SPACING + LEFT_MARGIN) / 2
													+ SQUARE_SPACING * (square_to_draw + 1) 
													+ SQUARE_SIZE * square_to_draw;
							FB_Y0        <= TOP_MARGIN  + TOP_SPACING_TO_CENTER * 3 
												+ GUESSES_NUMBER * (SQUARE_SIZE + SQUARE_SPACING) 
												+ SQUARE_SPACING;
							FB_X1        <= LEFT_MARGIN + LEFT_SPACING_TO_CENTER
													+ (SQUARE_SPACING + LEFT_MARGIN) / 2 
													+ SQUARE_SPACING * (square_to_draw + 1) 
													+ SQUARE_SIZE * (square_to_draw + 1);
							FB_Y1        <= TOP_MARGIN  + TOP_SPACING_TO_CENTER * 3 
												+ GUESSES_NUMBER * (SQUARE_SIZE + SQUARE_SPACING) 
												+ SQUARE_SPACING + SQUARE_SIZE;	
							FB_DRAW_FILLED_RECT <= '1';
							if (square_to_draw + 1 < COLORS_NUMBER) then
								square_to_draw <= square_to_draw + 1;
								substate       <= DRAW_SELECTABLE_COLORS;
							else
								square_to_draw <= 0;
								substate    <= DRAW_SELECTED_COLOR_BORDER;
							end if;
						
						when DRAW_SELECTED_COLOR_BORDER =>
							FB_COLOR <= SELECTION_COLOR;
							FB_X0        <= LEFT_MARGIN + LEFT_SPACING_TO_CENTER +  (SQUARE_SPACING + LEFT_MARGIN) / 2
													+ SQUARE_SPACING * CURRENT_COLOR
													+ SQUARE_SIZE * CURRENT_COLOR;
							FB_Y0        <= TOP_MARGIN  + TOP_SPACING_TO_CENTER * 3 
												+ GUESSES_NUMBER * (SQUARE_SIZE + SQUARE_SPACING) ;
							FB_X1        <= LEFT_MARGIN + LEFT_SPACING_TO_CENTER
													+ (SQUARE_SPACING + LEFT_MARGIN) / 2 
													+ SQUARE_SPACING * (CURRENT_COLOR + 2) 
													+ SQUARE_SIZE * (CURRENT_COLOR + 1);
							FB_Y1        <= TOP_MARGIN  + TOP_SPACING_TO_CENTER * 3 
												+ GUESSES_NUMBER * (SQUARE_SIZE + SQUARE_SPACING) 
												+ SQUARE_SPACING * 2 + SQUARE_SIZE;
							FB_DRAW_EMPTY_RECT <= '1';	
							
							if SHOW_SECRET = '1' then
								substate <= DRAW_SECRET;
							else
								substate <= FLIP_FRAMEBUFFER;
							end if;
							
						when DRAW_SECRET =>
							FB_COLOR     <= guess_peg_to_color(CHECK(square_to_draw));
							FB_X0        <= LEFT_MARGIN + LEFT_SPACING_TO_CENTER + 
												(LEFT_SPACING_TO_CENTER / 2)
													+ SQUARE_SPACING * square_to_draw
													+ SQUARE_SIZE * square_to_draw;
							FB_Y0        <= TOP_MARGIN * 4  + TOP_SPACING_TO_CENTER * 3 
												+ GUESSES_NUMBER * (SQUARE_SIZE + SQUARE_SPACING) 
												+ SQUARE_SPACING + SQUARE_SIZE;	
							FB_X1        <= LEFT_MARGIN + LEFT_SPACING_TO_CENTER
													+ (LEFT_SPACING_TO_CENTER / 2)
													+ SQUARE_SPACING * square_to_draw
													+ SQUARE_SIZE * (square_to_draw + 1);
							FB_Y1        <= TOP_MARGIN * 4  + TOP_SPACING_TO_CENTER * 3 
												+ GUESSES_NUMBER * (SQUARE_SIZE + SQUARE_SPACING) 
												+ SQUARE_SPACING + SQUARE_SIZE * 2;	
							FB_DRAW_FILLED_RECT <= '1';
							if (square_to_draw + 1 < SQUARES_NUMBER) then
								square_to_draw <= square_to_draw + 1;
								substate       <= DRAW_SECRET;
							else
								square_to_draw <= 0;
								substate    <= FLIP_FRAMEBUFFER;
							end if;
							
						when FLIP_FRAMEBUFFER =>
							FB_FLIP  <= '1';
							state    <= IDLE;						
							
					end case;
			end case;
	
		end if;
	end process;
	
end architecture;