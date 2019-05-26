library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity Tyranicide is
	port (
		-- attack input buttons
		physical, spirit, trick: in std_logic;
		clk : in std_logic;
		
		-- hex grid ports
		hp0, hp1, hp2, hp3, hp4, hp5, hp6 : out std_logic; -- h
		hp10, hp11, hp12, hp13, hp14, hp15, hp16 : out std_logic; -- p
		hp20, hp21, hp22, hp23, hp24, hp25, hp26 : out std_logic; -- tens
		hp30, hp31, hp32, hp33, hp34, hp35, hp36 : out std_logic; -- ones
		
		-- lcd screen in/outs
		data_bus_0, data_bus_1, data_bus_2, data_bus_3, data_bus_4, data_bus_5, data_bus_6, data_bus_7 : inout std_logic;
		lcd_rs, lcd_e, lcd_rw, lcd_on, lcd_blon : out std_logic
		);
end Tyranicide;

architecture behavior of Tyranicide is

	-- type enumerations for the string being read by the display (23), and the states for the FSM's used in the program (24-25)
	type string is array(0 to 31) of STD_LOGIC_VECTOR(7 downto 0);
	type state_type is (START, GOBLIN, OGRE, BEAST, GUARD, SORC, JESTER, TYRANT, WIN, LOSS, TRANSITION);
	type screen_state is (reset1, reset2, reset3, func_set, display_off, display_clear, display_on, mode_set, print_string, line2, return_home, drop_lcd_e);
	
	-- initialization of the states
	signal current_state : state_type := START;
	signal prev_state : state_type := START;
	signal current_screen : screen_state := reset1;
	signal next_screen : screen_state := reset1;
	
	-- variables holding player stats
	shared variable base_player_hp : integer := 60; -- start at base
	shared variable current_hp : integer; -- start at base
	shared variable player_dmg : integer := 5; -- start at dmg
	shared variable dmg_done : integer := 0;
	
	-- variables holding enemy stats
	shared variable enemy_hp : integer; 
	shared variable enemy_dmg : integer;
	
	-- variables for calculating health display values for player feedback
	shared variable php0 : integer;
	shared variable php1 : integer;
	shared variable ehp0 : integer;
	shared variable ehp1 : integer;
	shared variable ehp2 : integer;

	-- signals for player health display functions (50), tyrant boss fight defenses(51-56), and when the player levels up (57)
	signal vp0, vp1, vp2, vp3, vp4, vp5, vp6, vp7 : std_logic;
	signal strong_p : std_logic := '1';
	signal strong_s : std_logic := '0';
	signal strong_t : std_logic := '0';
	signal weak_p : std_logic := '0';
	signal weak_s : std_logic := '0';
	signal weak_t : std_logic := '1';
	signal level_up : std_logic := '0';
	
	-- signals used for lcd display
	signal lcd_display : string;
	signal hund : STD_LOGIC_VECTOR(7 downto 0) := x"30";
	signal tens : STD_LOGIC_VECTOR(7 downto 0) := x"30";
	signal ones : STD_LOGIC_VECTOR(7 downto 0) := x"30";
	shared variable char_count : integer := 0;
	signal lcd_rw_int : std_logic;
	signal data_bus_value, next_char : STD_LOGIC_VECTOR(7 downto 0);
	signal data_bus : STD_LOGIC_VECTOR(7 downto 0);
	
	
begin
	-- mapping the data_bus values to the bidrectional ports
	data_bus_0 <= data_bus(0);
	data_bus_1 <= data_bus(1);
	data_bus_2 <= data_bus(2);
	data_bus_3 <= data_bus(3);
	data_bus_4 <= data_bus(4);
	data_bus_5 <= data_bus(5);
	data_bus_6 <= data_bus(6);
	data_bus_7 <= data_bus(7);
	data_bus <= data_bus_value when lcd_rw_int = '0' else "ZZZZZZZZ";
	lcd_rw <= lcd_rw_int;
	
	--
	main_game: process (physical, spirit, trick, clk)
	begin
		case current_state is
			when START =>
				if(physical = '0' or spirit = '0' or trick = '0') then
					current_state <= GOBLIN;
					current_hp := base_player_hp;
					enemy_hp := 14;
					enemy_dmg := 6;
				end if;
				
			when GOBLIN =>
				prev_state <= GOBLIN;
				if(physical = '0' or spirit = '0' or trick = '0') then
					dmg_done := player_dmg;
				end if;
				enemy_hp := enemy_hp - dmg_done;
				if(enemy_hp < 1) then
					current_state <= TRANSITION;
				else
					current_hp := current_hp - enemy_dmg;
					if(current_hp < 1) then
						current_state <= LOSS;
						current_hp := 0;
					end if;
				end if;
				
			when OGRE =>
				prev_state <= OGRE;
				if(physical = '0') then
					dmg_done := player_dmg / 2;
				else
					dmg_done := player_dmg * 2;
				end if;
				enemy_hp := enemy_hp - dmg_done;
				if(enemy_hp < 1) then
					current_state <= TRANSITION;
				else
					current_hp := current_hp - enemy_dmg;
					if(current_hp < 1) then
						current_state <= LOSS;
						current_hp := 0;
					end if;
				end if;
			
			when BEAST =>
				prev_state <= BEAST;
				if(spirit = '0') then
					dmg_done := player_dmg / 2;
				else
					dmg_done := player_dmg * 2;
				end if;
				enemy_hp := enemy_hp - dmg_done;
				if(enemy_hp < 1) then
					current_state <= TRANSITION;
				else
					current_hp := current_hp - enemy_dmg;
					if(current_hp < 1) then
						current_state <= LOSS;
						current_hp := 0;
					end if;
				end if;
			
			when GUARD =>
				prev_state <= GUARD;
				if(trick = '0') then
					dmg_done := player_dmg * 2;
				else
					dmg_done := player_dmg / 2;
				end if;
				enemy_hp := enemy_hp - dmg_done;
				if(enemy_hp < 1) then
					current_state <= TRANSITION;
				else
					current_hp := current_hp - enemy_dmg;
					if(current_hp < 1) then
						current_state <= LOSS;
						current_hp := 0;
					end if;
				end if;
			
			when SORC =>
				prev_state <= SORC;
				if(physical = '0') then
					dmg_done := player_dmg * 2;
				else
					dmg_done := player_dmg / 2;
				end if;
				enemy_hp := enemy_hp - dmg_done;
				if(enemy_hp < 1) then
					current_state <= TRANSITION;
				else
					current_hp := current_hp - enemy_dmg;
					if(current_hp < 1) then
						current_state <= LOSS;
						current_hp := 0;
					end if;
				end if;
			
			when JESTER =>
				prev_state <= JESTER;
				if(physical = '0') then
					dmg_done := player_dmg * 2;
				else
					dmg_done := player_dmg / 2;
				end if;
				enemy_hp := enemy_hp - dmg_done;
				if(enemy_hp < 1) then
					current_state <= TRANSITION;
				else
					current_hp := current_hp - enemy_dmg;
					if(current_hp < 1) then
						current_state <= LOSS;
						current_hp := 0;
					end if;
				end if;
			
			when TYRANT =>
				prev_state <= TYRANT;
				if((physical = '0' and strong_p = '1') or (spirit = '0' and strong_s = '1') or (trick = '0' and strong_t = '1')) then
					dmg_done := player_dmg / 2;
				elsif((physical = '0' and weak_p = '1') or (spirit = '0' and weak_s = '1') or (trick = '0' and weak_t = '1')) then
					dmg_done := player_dmg * 2;
				else
					dmg_done := player_dmg;
				end if;
				
				if(strong_p = '1') then
					strong_p <= '0';
					strong_s <= '1';
					weak_p <= '1';
					weak_t <= '0';
				elsif(strong_s = '1') then
					strong_s <= '0';
					strong_t <= '1';
					weak_p <= '0';
					weak_s <= '1';
				else
					strong_p <= '1';
					strong_t <= '0';
					weak_s <= '0';
					weak_t <= '1';
				end if;
				
				enemy_hp := enemy_hp - dmg_done;
				if(enemy_hp < 1) then
					current_state <= WIN;
				else
					current_hp := current_hp - enemy_dmg;
					if(current_hp < 1) then
						current_state <= LOSS;
						current_hp := 0;
					end if;
				end if;
			
			when WIN =>
				if(physical = '0' or spirit = '0' or trick = '0') then
					current_state <= START;
					base_player_hp := 60;
					player_dmg := 5;
				end if;
			
			when LOSS =>
				if(physical = '0' or spirit = '0' or trick = '0') then
					current_state <= START;
					base_player_hp := 60;
					player_dmg := 5;
				end if;
			
			when TRANSITION =>
				case prev_state is
					when GOBLIN =>
						if(physical = '0' or spirit = '0' or trick = '0') then
							current_state <= OGRE;
							enemy_hp := 56;
							enemy_dmg := 7;
							level_up <= '1';
						end if;
						
					when OGRE =>
						if(physical = '0' or spirit = '0' or trick = '0') then
							current_state <= BEAST;
							enemy_hp := 56;
							level_up <= '1';
						end if;
					
					when BEAST =>
						if(physical = '0' or spirit = '0' or trick = '0') then
							current_state <= GUARD;
							enemy_hp := 56;
							enemy_dmg := 8;
							level_up <= '1';
						end if;
					
					when GUARD =>
						if(physical = '0' or spirit = '0' or trick = '0') then
							current_state <= SORC;
							enemy_hp := 56;
							enemy_dmg := 9;
							level_up <= '1';
						end if;
					
					when SORC =>
						if(physical = '0' or spirit = '0' or trick = '0') then
							current_state <= JESTER;
							enemy_hp := 56;
							level_up <= '1';
						end if;
					
					when JESTER =>
						if(physical = '0' or spirit = '0' or trick = '0') then
							current_state <= TYRANT;
							enemy_hp := 120;
							enemy_dmg := 10;
							level_up <= '1';
						end if;
					
					when OTHERS =>
				end case;
				if(level_up = '1') then
					base_player_hp := base_player_hp + 5;
					current_hp := base_player_hp;
					player_dmg := player_dmg + 2;
					level_up <= '0';
				end if;
		end case;
	end process main_game;
	
	-- screen_load_text process based off code written at the following link:
	-- http://www.digital-circuitry.com/Projects_LCD_DISPLAYS.htm
	screen_load_text: process (clk)
	begin
	next_char <= lcd_display(char_count);
	case current_screen is
		when reset1 =>
			lcd_e <= '1';
			lcd_rs <= '0';
			lcd_rw_int <= '0';
			data_bus_value <= x"38";
			current_screen <= drop_lcd_e;
			next_screen <= reset2;
			char_count := 0;
		
		when reset2 =>
			lcd_e <= '1';
			lcd_rs <= '0';
			lcd_rw_int <= '0';
			data_bus_value <= x"38";
			current_screen <= drop_lcd_e;
			next_screen <= reset3;
		
		when reset3 =>
			lcd_e <= '1';
			lcd_rs <= '0';
			lcd_rw_int <= '0';
			data_bus_value <= x"38";
			current_screen <= drop_lcd_e;
			next_screen <= func_set;
		
		when func_set =>
			lcd_e <= '1';
			lcd_rs <= '0';
			lcd_rw_int <= '0';
			data_bus_value <= x"38";
			current_screen <= drop_lcd_e;
			next_screen <= display_off;
		
		when display_off =>
			lcd_e <= '1';
			lcd_rs <= '0';
			lcd_rw_int <= '0';
			data_bus_value <= x"08";
			current_screen <= drop_lcd_e;
			next_screen <= display_clear;
		
		when display_clear =>
			lcd_e <= '1';
			lcd_rs <= '0';
			lcd_rw_int <= '0';
			data_bus_value <= x"01";
			current_screen <= drop_lcd_e;
			next_screen <= display_on;
		
		when display_on =>
			lcd_e <= '1';
			lcd_rs <= '0';
			lcd_rw_int <= '0';
			data_bus_value <= x"0C";
			current_screen <= drop_lcd_e;
			next_screen <= mode_set;
		
		when mode_set =>
			lcd_e <= '1';
			lcd_rs <= '0';
			lcd_rw_int <= '0';
			data_bus_value <= x"06";
			current_screen <= drop_lcd_e;
			next_screen <= print_string;
		
		when print_string =>
			current_screen <= drop_lcd_e;
			lcd_e <= '1';
			lcd_rs <= '1';
			lcd_rw_int <= '0';
			if(next_char(7 downto 0) /= x"0") then
				data_bus_value <= next_char;
			else
				if(next_char(3 downto 0) >9) then
					data_bus_value <= x"4" & (next_char(3 downto 0) - 9);
				else
					data_bus_value <= x"3" & next_char(3 downto 0);
				end if;
			end if;
			
			if((char_count < 31) and (next_char /= x"fe")) then
				char_count := char_count + 1;
			else
				char_count := 0;
			end if;
			
			if(char_count = 15) then
				next_screen <= line2;
			elsif((char_count = 31) or (next_char = x"fe")) then
				next_screen <= return_home;
			else
				next_screen <= print_string;
			end if;
		
		when line2 =>
			lcd_e <= '1';
			lcd_rs <= '0';
			lcd_rw_int <= '0';
			data_bus_value <= x"c0";
			current_screen <= drop_lcd_e;
			next_screen <= print_string;
		
		when return_home =>
			lcd_e <= '1';
			lcd_rs <= '0';
			lcd_rw_int <= '0';
			data_bus_value <= x"80";
			current_screen <= drop_lcd_e;
			next_screen <= print_string;
		
		when drop_lcd_e =>
			current_screen <= next_screen;
			lcd_e <= '0';
			lcd_blon <= '1';
			lcd_on <= '1';
	end case;
	end process screen_load_text;
	
	--
	enemy_health_to_text: process(clk)
	begin
		ehp0 := enemy_hp / 100;
		ehp1 := (enemy_hp / 10) mod 10;
		ehp2 := enemy_hp mod 10;
	
		case ehp0 is
			when 0 =>
				hund <= x"30";
			when 1 =>
				hund <= x"31";
			when 2 =>
				hund <= x"32";
			when 3 =>
				hund <= x"33";
			when 4 =>
				hund <= x"34";
			when 5 =>
				hund <= x"35";
			when 6 =>
				hund <= x"36";
			when 7 =>
				hund <= x"37";
			when 8 =>
				hund <= x"38";
			when 9 =>
				hund <= x"39";
			when OTHERS =>
		end case;
		
		case ehp1 is
			when 0 =>
				tens <= x"30";
			when 1 =>
				tens <= x"31";
			when 2 =>
				tens <= x"32";
			when 3 =>
				tens <= x"33";
			when 4 =>
				tens <= x"34";
			when 5 =>
				tens <= x"35";
			when 6 =>
				tens <= x"36";
			when 7 =>
				tens <= x"37";
			when 8 =>
				tens <= x"38";
			when 9 =>
				tens <= x"39";
			when OTHERS =>
		end case;
		
		case ehp2 is
			when 0 =>
				ones <= x"30";
			when 1 =>
				ones <= x"31";
			when 2 =>
				ones <= x"32";
			when 3 =>
				ones <= x"33";
			when 4 =>
				ones <= x"34";
			when 5 =>
				ones <= x"35";
			when 6 =>
				ones <= x"36";
			when 7 =>
				ones <= x"37";
			when 8 =>
				ones <= x"38";
			when 9 =>
				ones <= x"39";
			when OTHERS =>
		end case;
	end process enemy_health_to_text;
	
	--
	screen_set_text: process(clk)
	begin
		case current_state is
			when START =>
				lcd_display <= ( x"20", x"20", x"20", x"57", x"65", x"6C", x"63", x"6F", x"6D", x"65", x"20", x"74", x"6F", x"20", x"20", x"20",
									  x"20", x"20", x"20", x"20", x"54", x"59", x"52", x"41", x"4E", x"4E", x"55", x"53", x"20", x"20", x"20", x"20");
			
			when GOBLIN =>
				lcd_display <= ( x"47", x"4F", x"42", x"4C", x"49", x"4E", x"20", x"3C", x"22", x"3E", x"20", x"48", x"50", hund, tens, ones,
									  x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"60", x"4D", x"2F", x"20", x"20", x"20", x"20", x"20", x"20");
			
			when OGRE =>
				lcd_display <= ( x"20", x"20", x"4F", x"47", x"52", x"45", x"20", x"28", x"30", x"29", x"20", x"48", x"50", hund, tens, ones,
									  x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"6E", x"3D", x"6E", x"20", x"20", x"20", x"20", x"20", x"20");
			
			when BEAST =>
				lcd_display <= ( x"20", x"42", x"45", x"41", x"53", x"54", x"20", x"5E", x"2D", x"5E", x"20", x"48", x"50", hund, tens, ones,
									  x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"28", x"22", x"29", x"20", x"20", x"20", x"20", x"20", x"20");
			
			when GUARD =>
				lcd_display <= ( x"20", x"47", x"55", x"41", x"52", x"44", x"20", x"5F", x"6E", x"31", x"20", x"48", x"50", hund, tens, ones,
									  x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"55", x"22", x"2B", x"20", x"20", x"20", x"20", x"20", x"20");
			
			when SORC =>
				lcd_display <= ( x"20", x"20", x"53", x"4F", x"52", x"43", x"20", x"2D", x"5E", x"2D", x"20", x"48", x"50", hund, tens, ones,
									  x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"2F", x"22", x"60", x"20", x"20", x"20", x"20", x"20", x"20");
			
			when JESTER =>
				lcd_display <= ( x"4A", x"45", x"53", x"54", x"45", x"52", x"20", x"60", x"56", x"2F", x"20", x"48", x"50", hund, tens, ones,
									  x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"6F", x"22", x"6F", x"20", x"20", x"20", x"20", x"20", x"20");
			
			when TYRANT =>
				lcd_display <= ( x"54", x"59", x"52", x"41", x"4E", x"54", x"20", x"2A", x"77", x"2F", x"20", x"48", x"50", hund, tens, ones,
									  x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"59", x"22", x"3F", x"20", x"20", x"20", x"20", x"20", x"20");
			
			when WIN =>
				lcd_display <= ( x"20", x"20", x"20", x"20", x"57", x"49", x"4E", x"4E", x"45", x"52", x"21", x"21", x"20", x"20", x"20", x"20",
									  x"50", x"72", x"65", x"73", x"73", x"20", x"61", x"6E", x"79", x"20", x"62", x"75", x"74", x"74", x"6F", x"6E");
			
			when LOSS =>
				lcd_display <= ( x"20", x"20", x"20", x"47", x"41", x"4D", x"45", x"20", x"20", x"4F", x"56", x"45", x"52", x"20", x"20", x"20",
									  x"50", x"72", x"65", x"73", x"73", x"20", x"61", x"6E", x"79", x"20", x"62", x"75", x"74", x"74", x"6F", x"6E");
			
			when TRANSITION =>
				lcd_display <= ( x"20", x"20", x"20", x"20", x"53", x"75", x"63", x"63", x"65", x"73", x"73", x"21", x"20", x"20", x"20", x"20",
									  x"20", x"20", x"2B", x"35", x"20", x"48", x"50", x"20", x"2B", x"32", x"20", x"44", x"4D", x"47", x"20", x"20");	
		end case;
		
	end process screen_set_text;
	
	--
	health_to_text: process(clk)
	begin
		case current_state is
			when START =>
				hp0 <= '0';
				hp1 <= '1';
				hp2 <= '0';
				hp3 <= '0';
				hp4 <= '1';
				hp5 <= '0';
				hp6 <= '0';
				
				hp10 <= '1';
				hp11 <= '1';
				hp12 <= '1';
				hp13 <= '1';
				hp14 <= '1';
				hp15 <= '1';
				hp16 <= '1';
				
				hp20 <= '1';
				hp21 <= '1';
				hp22 <= '1';
				hp23 <= '1';
				hp24 <= '1';
				hp25 <= '1';
				hp26 <= '1';
				
				hp30 <= '1';
				hp31 <= '1';
				hp32 <= '1';
				hp33 <= '1';
				hp34 <= '1';
				hp35 <= '1';
				hp36 <= '1';
			when WIN =>
				hp0 <= '1';
				hp1 <= '0';
				hp2 <= '0';
				hp3 <= '0';
				hp4 <= '0';
				hp5 <= '0';
				hp6 <= '1';
				
				hp10 <= '1';
				hp11 <= '1';
				hp12 <= '1';
				hp13 <= '1';
				hp14 <= '1';
				hp15 <= '1';
				hp16 <= '1';
				
				hp20 <= '1';
				hp21 <= '1';
				hp22 <= '1';
				hp23 <= '1';
				hp24 <= '1';
				hp25 <= '1';
				hp26 <= '1';
				
				hp30 <= '1';
				hp31 <= '1';
				hp32 <= '1';
				hp33 <= '1';
				hp34 <= '1';
				hp35 <= '1';
				hp36 <= '1';
			when LOSS =>
				hp0 <= '1';
				hp1 <= '1';
				hp2 <= '1';
				hp3 <= '0';
				hp4 <= '0';
				hp5 <= '0';
				hp6 <= '1';
				
				hp10 <= '1';
				hp11 <= '1';
				hp12 <= '1';
				hp13 <= '1';
				hp14 <= '1';
				hp15 <= '1';
				hp16 <= '1';
				
				hp20 <= '1';
				hp21 <= '1';
				hp22 <= '1';
				hp23 <= '1';
				hp24 <= '1';
				hp25 <= '1';
				hp26 <= '1';
				
				hp30 <= '1';
				hp31 <= '1';
				hp32 <= '1';
				hp33 <= '1';
				hp34 <= '1';
				hp35 <= '1';
				hp36 <= '1';
			when TRANSITION =>
				hp0 <= '0';
				hp1 <= '0';
				hp2 <= '0';
				hp3 <= '1';
				hp4 <= '1';
				hp5 <= '1';
				hp6 <= '1';
				
				hp10 <= '1';
				hp11 <= '1';
				hp12 <= '1';
				hp13 <= '1';
				hp14 <= '1';
				hp15 <= '1';
				hp16 <= '1';
				
				hp20 <= '1';
				hp21 <= '1';
				hp22 <= '1';
				hp23 <= '1';
				hp24 <= '1';
				hp25 <= '1';
				hp26 <= '1';
				
				hp30 <= '1';
				hp31 <= '1';
				hp32 <= '1';
				hp33 <= '1';
				hp34 <= '1';
				hp35 <= '1';
				hp36 <= '1';
			when OTHERS =>
				hp0 <= '1';
				hp1 <= '1';
				hp2 <= '0';
				hp3 <= '1';
				hp4 <= '0';
				hp5 <= '0';
				hp6 <= '0';
				
				hp10 <= '0';
				hp11 <= '0';
				hp12 <= '1';
				hp13 <= '1';
				hp14 <= '0';
				hp15 <= '0';
				hp16 <= '0';
				
				--php0 := current_hp / 10;
				php1 := current_hp mod 10;
				php0 := (current_hp-php1) / 10;
				
				case php0 is
					when 0 =>
						vp0 <= '0';
						vp1 <= '0';
						vp2 <= '0';
						vp3 <= '0';
					when 1 =>
						vp0 <= '0';
						vp1 <= '0';
						vp2 <= '0';
						vp3 <= '1';
					when 2 =>
						vp0 <= '0';
						vp1 <= '0';
						vp2 <= '1';
						vp3 <= '0';
					when 3 =>
						vp0 <= '0';
						vp1 <= '0';
						vp2 <= '1';
						vp3 <= '1';
					when 4 =>
						vp0 <= '0';
						vp1 <= '1';
						vp2 <= '0';
						vp3 <= '0';
					when 5 =>
						vp0 <= '0';
						vp1 <= '1';
						vp2 <= '0';
						vp3 <= '1';
					when 6 =>
						vp0 <= '0';
						vp1 <= '1';
						vp2 <= '1';
						vp3 <= '0';
					when 7 =>
						vp0 <= '0';
						vp1 <= '1';
						vp2 <= '1';
						vp3 <= '1';
					when 8 =>
						vp0 <= '1';
						vp1 <= '0';
						vp2 <= '0';
						vp3 <= '0';
					when 9 =>
						vp0 <= '1';
						vp1 <= '0';
						vp2 <= '0';
						vp3 <= '1';
					when others =>
				end case;
				
				case php1 is
					when 0 =>
						vp4 <= '0';
						vp5 <= '0';
						vp6 <= '0';
						vp7 <= '0';
					when 1 =>
						vp4 <= '0';
						vp5 <= '0';
						vp6 <= '0';
						vp7 <= '1';
					when 2 =>
						vp4 <= '0';
						vp5 <= '0';
						vp6 <= '1';
						vp7 <= '0';
					when 3 =>
						vp4 <= '0';
						vp5 <= '0';
						vp6 <= '1';
						vp7 <= '1';
					when 4 =>
						vp4 <= '0';
						vp5 <= '1';
						vp6 <= '0';
						vp7 <= '0';
					when 5 =>
						vp4 <= '0';
						vp5 <= '1';
						vp6 <= '0';
						vp7 <= '1';
					when 6 =>
						vp4 <= '0';
						vp5 <= '1';
						vp6 <= '1';
						vp7 <= '0';
					when 7 =>
						vp4 <= '0';
						vp5 <= '1';
						vp6 <= '1';
						vp7 <= '1';
					when 8 =>
						vp4 <= '1';
						vp5 <= '0';
						vp6 <= '0';
						vp7 <= '0';
					when 9 =>
						vp4 <= '1';
						vp5 <= '0';
						vp6 <= '0';
						vp7 <= '1';
					when others =>
				end case;
				
				hp20 <= not((not vp0 and not vp1 and not vp3) or (not vp0 and not vp1 and vp2) or (not vp0 and vp1 and vp3) or (vp0 and vp1 and not vp2));
				hp21 <= not((not vp0 and not vp1) or (not vp0 and not vp2 and not vp3) or (not vp0 and vp2 and vp3) or (vp0 and vp1 and not vp2));
				hp22 <= not((not vp0 and not vp2) or (not vp0 and vp3) or (not vp0 and vp1) or (vp1 and not vp2));
				hp23 <= not((not vp0 and not vp1 and not vp3) or (not vp0 and not vp1 and vp2) or (not vp0 and vp2 and not vp3) or (not vp0 and vp1 and not vp2 and vp3) or (vp0 and vp1 and not vp2 and not vp3));
				hp24 <= not((not vp0 and not vp1 and not vp3) or (not vp0 and vp2 and not vp3) or (vp0 and vp1 and not vp2 and not vp3));
				hp25 <= not((not vp0 and not vp2 and not vp3) or (not vp0 and vp1 and not vp3) or (vp1 and not vp2));
				hp26 <= not((not vp0 and not vp2 and not vp3) or (not vp0 and not vp1 and vp2) or (not vp0 and vp2 and not vp3) or (vp1 and not vp2));
				
				hp30 <= not((not vp4 and not vp5 and not vp7) or (not vp4 and not vp5 and vp6) or (not vp4 and vp5 and vp7) or (vp4 and vp5 and not vp6));
				hp31 <= not((not vp4 and not vp5) or (not vp4 and not vp6 and not vp7) or (not vp4 and vp6 and vp7) or (vp4 and vp5 and not vp6));
				hp32 <= not((not vp4 and not vp6) or (not vp4 and vp7) or (not vp4 and vp5) or (vp5 and not vp6));
				hp33 <= not((not vp4 and not vp5 and not vp7) or (not vp4 and not vp5 and vp6) or (not vp4 and vp6 and not vp7) or (not vp4 and vp5 and not vp6 and vp7) or (vp4 and vp5 and not vp6 and not vp7));
				hp34 <= not((not vp4 and not vp5 and not vp7) or (not vp4 and vp6 and not vp7) or (vp4 and vp5 and not vp6 and not vp7));
				hp35 <= not((not vp4 and not vp6 and not vp7) or (not vp4 and vp5 and not vp7) or (vp5 and not vp6));
				hp36 <= not((not vp4 and not vp6 and not vp7) or (not vp4 and not vp5 and vp6) or (not vp4 and vp6 and not vp7) or (vp5 and not vp6));
				
			end case;
	end process health_to_text;

end behavior;
