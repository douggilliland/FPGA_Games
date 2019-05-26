----------------------------------------------------------------------------------
-- Flappy Bird
--	
-- Authors: Steve Hammon and Luke Hsiao
--	Brigham Young University - ECEn 320
--	Winter Semester 2014
--	Dr. Mike Wirthlin
-- 
--
-- Create Date:    12:39:00 03/26/2014 
--
-- Revision History: 
-- Revision 0.01 - File Created
-- Revision 1.00 - [27 March 2014] Flappy Bird Completed!
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity flappy_top is
	generic(
		CLK_RATE: natural := 50_000_000;
		DEBOUNCE_TIME: natural := 10 --In miliseconds
	);
	port(
		clk: in std_logic;
		btn: in std_logic_vector(3 downto 0);
		sw: in std_logic_vector(7 downto 0);
		led: out std_logic_vector(7 downto 0);
		Hsync: out std_logic;
		Vsync: out std_logic;
		vgaRed: out std_logic_vector(2 downto 0);
		vgaGreen: out std_logic_vector(2 downto 0);
		vgaBlue: out std_logic_vector(1 downto 0);
		an: out std_logic_vector(3 downto 0);
		seg: out std_logic_vector(6 downto 0);
		dp: out std_logic
	);
end flappy_top;

architecture arch of flappy_top is

	-- Debounce
	-------------------Function-------------------
	function log2c(n: integer) return integer is
		variable m, p: integer;
	begin
		m := 0;
		p := 1;
		while p < n loop
			m := m + 1;
			p := p * 2;
		end loop;
		return m;
	end log2c;
	---------------------------------------------

	constant DEBOUNCE_TIMER_VALUE: natural := (DEBOUNCE_TIME * CLK_RATE) / 1000;
	constant DEBOUNCE_TIMER_BITS: natural := log2c(DEBOUNCE_TIMER_VALUE);
	signal debounce_counter_value, debounce_counter_value_next: unsigned(DEBOUNCE_TIMER_BITS-1 downto 0) := (others=>'0');
	
	-- VGA Signals
	signal pixel_x, pixel_y: std_logic_vector(9 downto 0);
	signal pix_x, pix_y: unsigned(9 downto 0);
	signal blank: std_logic;
	signal last_column: std_logic;
	signal last_row: std_logic;
	signal rst: std_logic;
	signal rgb: std_logic_vector(7 downto 0);
	signal HS: std_logic;
	signal VS: std_logic;
	
	-- Seven Segment Display Signals
	signal data_in: std_logic_vector(15 downto 0);
	signal dp_in: std_logic_vector(3 downto 0);
	signal blank_seg: std_logic_vector(3 downto 0);
	signal left_seven_seg_data, left_seven_seg_data_next: std_logic_vector(7 downto 0) := (others=>'0');
	signal right_seven_seg_data, right_seven_seg_data_next: std_logic_vector(7 downto 0) := (others=>'0');

	-- Signals for Flappy Bird Graphics
	signal bird_top, bird_top_next, bird_top_temp: unsigned(9 downto 0):= to_unsigned(200,10);
	signal bird_left: unsigned(9 downto 0):= to_unsigned(100,10);
	signal bird_outline_on, bird_lips_on, bird_white_on, bird_color_on, pipe_on, ground_on, ground_border_on: std_logic;
	signal bird_outline_rgb, bird_lips_rgb, bird_white_rgb, bird_color_rgb, sky_rgb, pipe_rgb, ground_rgb, ground_border: std_logic_vector(7 downto 0);
	
	
	-- Signals for column movement
	signal col1_x, col1_x_next, col1_y, col1_y_next: unsigned (pixel_x'range) := (others => '1');
	signal col2_x, col2_x_next, col2_y, col2_y_next: unsigned (pixel_x'range) := (others => '1');
	signal col3_x, col3_x_next, col3_y, col3_y_next: unsigned (pixel_x'range) := (others => '1');
	signal random, random_next, random_temp: unsigned (pixel_x'range) := (others => '0');
	signal moveEN, col1_on, col2_on, col3_on: std_logic := '0';	-- to delay the movement
	signal delay, delay_next: Natural := 0;
	
	-- Signals for State Machine (necessary to have a "tap to start" type of behavior)
	type state is (start, play);
	signal state_reg, state_next: state;
	signal crashed: std_logic;
	
	-- Signals to Keep Score
	signal scoreOnes, scoreOnes_next, scoreTens, scoreTens_next: unsigned (3 downto 0);
	signal highscore, highscore_next: unsigned (left_seven_seg_data'range);
	
	--Physics
	signal button0, button0_next, button0Pulse: std_logic;
	signal jump_reg, jump_reg_next: unsigned(4 downto 0) := "00000";
	signal fall_reg, fall_reg_next: unsigned(3 downto 0) := "0000";
	signal bird_delay, bird_delay_next: unsigned(20 downto 0):= to_unsigned(0,21);
	
begin
	------------------------Component Declarations-----------------------------------------------------
	vga_timer: entity work.vga_timing
			port map(clk=>clk, rst=>rst, HS=>HS, VS=>VS, pixel_x=>pixel_x, pixel_y=>pixel_y, blank=>blank,
						last_column=>last_column, last_row=>last_row);
						
	display: entity work.seven_segment_display
	port map(clk=>clk, data_in=>data_in, dp_in=>dp_in, blank=>blank_seg,
				an=>an, seg=>seg, dp=>dp);
				
	debouncer: entity work.btnpulse
	port map (btn=>button0, clk=>clk, reset=>rst, btnpulse=>button0Pulse);
				
	--==================================================================================================

	process(clk,btn)
	begin
		rst <='0';
		if btn(3)='1' then
			rst <= '1';
			bird_top <= to_unsigned(200,10);
			bird_delay <= (others=>'0');
			col1_x <= (others => '0');
			col2_x <= (others => '0');
			col3_x <= (others => '0');
			delay <= 0;
			state_reg <= start;
			highscore <= (others => '0');
			scoreOnes <= (others => '0');
			scoreTens <= (others => '0');
		elsif (clk'event and clk='1') then
			Hsync <= HS;
			Vsync <= VS;
			vgaRed <= rgb(7 downto 5);
			vgaGreen <= rgb(4 downto 2);
			vgaBlue <= rgb(1 downto 0);
			bird_top <= bird_top_next;
			bird_delay <= bird_delay_next;

			left_seven_seg_data <= left_seven_seg_data_next;
			right_seven_seg_data <= right_seven_seg_data_next;
			state_reg <= state_next;
			
			debounce_counter_value <= debounce_counter_value_next;
			button0 <= button0_next;
			
			if button0Pulse='1' then
				jump_reg <= "10111";
				fall_reg <= "0000";
			else
				jump_reg <= jump_reg_next;
				fall_reg <= fall_reg_next;
			end if;
			
			--signals for columns
			col1_x <= col1_x_next;
			col2_x <= col2_x_next;
			col3_x <= col3_x_next;
			col1_y <= col1_y_next;
			col2_y <= col2_y_next;
			col3_y <= col3_y_next;
			delay <= delay_next;
			
			--Signals for Score
			highscore <= highscore_next;
			scoreOnes <= scoreOnes_next;
			scoreTens <= scoreTens_next;
		end if;
	end process;
	
	--Debounce Logic
	debounce_counter_value_next <= debounce_counter_value + 1;
	button0_next <= '1' when (btn(0)='1' and debounce_counter_value = 0) else
								  '0' when (btn(0)='0' and debounce_counter_value = 0) else
						        button0;

	
	
	--X 640
	--Y 480
	
	
------------------------------------Bird Draw Logic----------------------------------------	
	pix_x <= unsigned(pixel_x);
	pix_y <= unsigned(pixel_y);
	
	bird_outline_on <= '1' when  
				((pix_y=bird_top or pix_y=bird_top+1) and (pix_x>=bird_left+12 and pix_x<=bird_left+25)) or  --line 0
				((pix_y=bird_top+2 or pix_y=bird_top+3) and ((pix_x>=bird_left+8 and pix_x<=bird_left+11) or pix_x=bird_left+20 or pix_x=bird_left+21 or pix_x=bird_left+26 or pix_x=bird_left+27)) or  --line 1
				((pix_y=bird_top+4 or pix_y=bird_top+5) and (pix_x=bird_left+6 or pix_x=bird_left+7 or pix_x=bird_left+18 or pix_x=bird_left+19 or pix_x=bird_left+28 or pix_x=bird_left+29)) or  --line 2
				((pix_y=bird_top+6 or pix_y=bird_top+7) and ((pix_x>=bird_left+2 and pix_x<=bird_left+11) or pix_x=bird_left+18 or pix_x=bird_left+19 or pix_x=bird_left+24 or pix_x=bird_left+25 or pix_x=bird_left+30 or pix_x=bird_left+31)) or  --line 3
				((pix_y=bird_top+8 or pix_y=bird_top+9) and (pix_x=bird_left or pix_x=bird_left+1 or pix_x=bird_left+12 or pix_x=bird_left+13 or pix_x=bird_left+18 or pix_x=bird_left+19 or pix_x=bird_left+24 or pix_x=bird_left+25 or pix_x=bird_left+30 or pix_x=bird_left+31)) or  --line 4
				((pix_y=bird_top+10 or pix_y=bird_top+11) and (pix_x=bird_left or pix_x=bird_left+1 or pix_x=bird_left+14 or pix_x=bird_left+15 or pix_x=bird_left+18 or pix_x=bird_left+19 or pix_x=bird_left+30 or pix_x=bird_left+31)) or  --line 5
				((pix_y=bird_top+12 or pix_y=bird_top+13) and (pix_x=bird_left or pix_x=bird_left+1 or pix_x=bird_left+14 or pix_x=bird_left+15 or pix_x=bird_left+20 or pix_x=bird_left+21 or pix_x=bird_left+30 or pix_x=bird_left+31)) or  --line 6
				((pix_y=bird_top+14 or pix_y=bird_top+15) and (pix_x=bird_left or pix_x=bird_left+1 or pix_x=bird_left+14 or pix_x=bird_left+15 or (pix_x>=bird_left+22 and pix_x<=bird_left+33))) or  --line 7
				((pix_y=bird_top+16 or pix_y=bird_top+17) and (pix_x=bird_left+2 or pix_x=bird_left+3  or pix_x=bird_left+12 or pix_x=bird_left+13 or pix_x=bird_left+20 or pix_x=bird_left+21 or pix_x=bird_left+34 or pix_x=bird_left+35)) or  --line 8
				((pix_y=bird_top+18 or pix_y=bird_top+19) and ((pix_x>=bird_left+4 and pix_x<=bird_left+11) or pix_x=bird_left+18 or pix_x=bird_left+19 or (pix_x>=bird_left+22 and pix_x<=bird_left+33))) or  --line 9
				((pix_y=bird_top+20 or pix_y=bird_top+21) and (pix_x=bird_left+4 or pix_x=bird_left+5 or pix_x=bird_left+20 or pix_x=bird_left+21 or pix_x=bird_left+32 or pix_x=bird_left+33)) or  --line 10
				((pix_y=bird_top+22 or pix_y=bird_top+23) and ((pix_x>=bird_left+6 and pix_x<=bird_left+11) or (pix_x>=bird_left+22 and pix_x<=bird_left+31))) or  --line 11
				((pix_y=bird_top+24 or pix_y=bird_top+25) and (pix_x>=bird_left+12 and pix_x<=bird_left+21))  --line 12
				else '0';
	
	bird_lips_on <= '1' when
				((pix_y=bird_top+16 or pix_y=bird_top+17) and (pix_x>=bird_left+22 and pix_x<=bird_left+33)) or  --line 8
				((pix_y=bird_top+18 or pix_y=bird_top+19) and (pix_x=bird_left+20 or pix_x=bird_left+21)) or  --line 9
				((pix_y=bird_top+20 or pix_y=bird_top+21) and (pix_x>=bird_left+22 and pix_x<=bird_left+31))  --line 10
				else '0';
	
	bird_white_on <= '1' when
				((pix_y=bird_top+2 or pix_y=bird_top+3) and (pix_x>=bird_left+22 and pix_x<=bird_left+25)) or  --line 1
				((pix_y=bird_top+4 or pix_y=bird_top+5) and (pix_x>=bird_left+20 and pix_x<=bird_left+27)) or  --line 2
				((pix_y=bird_top+6 or pix_y=bird_top+7) and ((pix_x>=bird_left+20 and pix_x<=bird_left+23) or (pix_x>=bird_left+26 and pix_x<=bird_left+29))) or  --line 3
				((pix_y=bird_top+8 or pix_y=bird_top+9) and ((pix_x>=bird_left+2 and pix_x<=bird_left+11) or (pix_x>=bird_left+20 and pix_x<=bird_left+23) or (pix_x>=bird_left+26 and pix_x<=bird_left+29))) or  --line 4
				((pix_y=bird_top+10 or pix_y=bird_top+11) and ((pix_x>=bird_left+2 and pix_x<=bird_left+13) or (pix_x>=bird_left+20 and pix_x<=bird_left+29))) or  --line 5
				((pix_y=bird_top+12 or pix_y=bird_top+13) and ((pix_x>=bird_left+2 and pix_x<=bird_left+13) or (pix_x>=bird_left+22 and pix_x<=bird_left+29))) or  --line 6
				((pix_y=bird_top+14 or pix_y=bird_top+15) and (pix_x>=bird_left+2 and pix_x<=bird_left+13)) or  --line 7
				((pix_y=bird_top+16 or pix_y=bird_top+17) and (pix_x>=bird_left+4 and pix_x<=bird_left+11))  --line 8
				else '0';
				
	bird_color_on <= '1' when
				((pix_y=bird_top+2 or pix_y=bird_top+3) and (pix_x>=bird_left+12 and pix_x<=bird_left+19)) or  --line 1
				((pix_y=bird_top+4 or pix_y=bird_top+5) and (pix_x>=bird_left+8 and pix_x<=bird_left+17)) or  --line 2
				((pix_y=bird_top+6 or pix_y=bird_top+7) and (pix_x>=bird_left+12 and pix_x<=bird_left+17)) or  --line 3
				((pix_y=bird_top+8 or pix_y=bird_top+9) and (pix_x>=bird_left+14 and pix_x<=bird_left+17)) or  --line 4
				((pix_y=bird_top+10 or pix_y=bird_top+11) and (pix_x=bird_left+16 or pix_x=bird_left+17)) or  --line 5
				((pix_y=bird_top+12 or pix_y=bird_top+13) and (pix_x>=bird_left+16 and pix_x<=bird_left+19)) or  --line 6
				((pix_y=bird_top+14 or pix_y=bird_top+15) and (pix_x>=bird_left+16 and pix_x<=bird_left+21)) or  --line 7
				((pix_y=bird_top+16 or pix_y=bird_top+17) and (pix_x>=bird_left+14 and pix_x<=bird_left+19)) or  --line 8
				((pix_y=bird_top+18 or pix_y=bird_top+19) and (pix_x>=bird_left+12 and pix_x<=bird_left+17)) or  --line 9
				((pix_y=bird_top+20 or pix_y=bird_top+21) and (pix_x>=bird_left+6 and pix_x<=bird_left+19)) or  --line 10
				((pix_y=bird_top+22 or pix_y=bird_top+23) and (pix_x>=bird_left+12 and pix_x<=bird_left+21))  --line 11
				else '0';
				
	bird_outline_rgb <= "00000000";  --black outline
	bird_lips_rgb <= "11101100";  --orange lips
	bird_white_rgb <= "11111111";
	bird_color_rgb <= sw;  --You can change the color of the bird based on the switches
--=====================================================================================
	
------------------------------------Bird Movement-------------------------------------
	-- (+ is down and - is up)
	process(bird_delay, button0Pulse, jump_reg, fall_reg)
	begin
		if bird_delay=0 then
			if jump_reg/="00000" then
				jump_reg_next <= '0' & jump_reg(4 downto 1);  --creates a shift register to add and subtract the heights
				fall_reg_next <= fall_reg;
			else
				jump_reg_next <= jump_reg;
				fall_reg_next <= fall_reg(2 downto 0) & '1';
			end if;
		else
			jump_reg_next <= jump_reg;
			fall_reg_next <= fall_reg;
		end if;
	end process;

	bird_delay_next <= bird_delay+1;
	bird_top_temp <= to_unsigned(200,10) when (state_reg=start and button0Pulse='1') else
						  (bird_top - jump_reg + fall_reg) when bird_delay=0 and state_reg/=start
						  else bird_top;
	bird_top_next <= bird_top_temp when (bird_top_temp>=0 and bird_top_temp<425) else  --This caps the level so the bird can't fly above it
							(others=>'0');
	bird_left <= to_unsigned(100,10);
	

--=====================================================================================
	
---------------Logic to generate a psuedorandom number between 15 and 255---------------
	process(clk)
	begin
		if clk'event and clk='1' then
			random <= random_next;
		end if;
	end process;
	-- concatenated values keep it in the proper range
	random_temp <=  random(6 downto 5) & (pix_x(3 downto 1) xor pix_y(8 downto 6)) & random(7) & (pix_x(5 downto 2) xor pix_y(9 downto 6));
	random_next <= "00" & random_temp(9 downto 6) & "1111";
--=======================================================================================

-----------------------------Column Draw Logic-------------------------------------------
	pipe_rgb <= "00010100";		-- solid colored, light green pipes
	ground_rgb <= "11110101";	-- orangish ground
	ground_border <= "00001100";	--Border for the ground

	ground_border_on <= '1' when (pix_y >= 425 and pix_y < 430) else '0';
	ground_on <= '1' when pix_y >= 430 else '0';
	
		
	--In order for columns to actually move off the the screen to the left, need to display them
	--relative to their right edge, rather than their left edge.
	
		
	-- Next State Logic
	process (state_reg, button0Pulse, crashed, col1_x, col2_x, col3_x, moveEN, col1_on, col2_on, col3_on, random, col1_y, col2_y, col3_y) 
	begin
		--Defaults
		state_next <= state_reg;
		col1_x_next <= col1_x;
		col2_x_next <= col2_x;
		col3_x_next <= col3_x;
		col1_y_next <= col1_y;
		col2_y_next <= col2_y;
		col3_y_next <= col3_y;
		--right_seven_seg_data_next <= right_seven_seg_data;
		case state_reg is
			when start =>
				if (button0Pulse = '1') then
					state_next <= play;
					col1_x_next <= to_unsigned((638+80), 10);		--start column 1s
					col2_x_next <= (others => '1');
					col3_x_next <= (others => '1');
					col1_y_next <= random;
				else
					state_next <= start;
				end if;
			when play =>
					if moveEN = '1' then
						if col1_on = '1' then
							col1_x_next <= col1_x - 1; 
						end if;
						if col2_on = '1' then
							col2_x_next <= col2_x - 1;
						end if;
						if col3_on = '1' then
							col3_x_next <= col3_x - 1;
						end if;
					end if;
					if col3_x = 450 then	--defines space between columns
						col1_x_next <= to_unsigned((638+80), 10);
						col1_y_next <= random;
					end if;
					if col2_x = 450 then
						col3_x_next <= to_unsigned((638+80), 10);
						col3_y_next <= random;
					end if;
					if col1_x = 450 then
						col2_x_next <= to_unsigned((638+80), 10);
						col2_y_next <= random;
					end if;
					if crashed = '1' then
						state_next <= start;
					else
						state_next <= play;
					end if;
		end case;
	end process;
	
	--Transition from start state to play state must turn col1 on.
	col1_on <= '1' when col1_x <= (639+80) and col1_x > 0 else '0';
	col2_on <= '1' when col2_x <= (639+80) and col2_x > 0 else '0';
	col3_on <= '1' when col3_x <= (639+80) and col3_x > 0 else '0';
	
	moveEN <= '1' when delay = 400000 else '0';
	delay_next <= 0 when delay > 400000 else delay + 1;
	
	--Logic to signal the pipe is on (80 is the width of the pipe, 100 is width of the gap)
	pipe_on <= '1' when 	(col1_on='1' and ((pix_x >= col1_x - 80 and pix_x < col1_x) or (col1_x <= 80 and pix_x < col1_x)) and (pix_y <= col1_y or pix_y > col1_y+100)) or
								(col2_on='1' and ((pix_x >= col2_x - 80 and pix_x < col2_x) or (col2_x <= 80 and pix_x < col2_x)) and (pix_y <= col2_y or pix_y > col2_y+100)) or
								(col3_on='1' and ((pix_x >= col3_x - 80 and pix_x < col3_x) or (col3_x <= 80 and pix_x < col3_x)) and (pix_y <= col3_y or pix_y > col3_y+100))
					else '0';
	
	-- Calculate Crashes
	crashed <= '1' when bird_outline_on='1' and (ground_border_on='1' or pipe_on='1') else '0';
--======================================================================================

-------------------------------------Calculate Scores-------------------------------------

	scoreOnes_next <= scoreOnes + 1 when (bird_left = col1_x or bird_left = col2_x or bird_left = col3_x) and moveEN = '1' else
							(others => '0') when (state_reg=start and button0Pulse='1') or scoreOnes = 9 else
							scoreOnes;
	scoreTens_next <= scoreTens + 1 when scoreOnes = 9 else
							(others => '0') when (state_reg=start and button0Pulse='1') else
							scoreTens;
						
	highscore_next <= (scoreTens & scoreOnes) when ((scoreTens&scoreOnes) > highscore and crashed='1') else highscore;
	
	left_seven_seg_data_next <= std_logic_vector(highscore);
	right_seven_seg_data_next <= std_logic_vector(scoreTens & scoreOnes);
	
--=======================================================================================
	
	
-----------------------Output Logic----------------------------------------------------
	sky_rgb <= "01011111";
	

	rgb <= (others=>'0') 	when blank='1' else
			 ground_border 	when ground_border_on='1' else
			 ground_rgb 		when ground_on='1' else
			 pipe_rgb			when pipe_on='1' else
			 bird_outline_rgb when bird_outline_on='1' else
			 bird_lips_rgb 	when bird_lips_on='1' else
			 bird_white_rgb 	when bird_white_on='1' else
			 bird_color_rgb 	when bird_color_on='1' else
			 sky_rgb;
	
	
	data_in <= left_seven_seg_data & right_seven_seg_data;
	blank_seg <= "0000";  --turn on all displays
	dp_in <= "0100";  --turn off decimal points
	
	
	led <= sw;
--=====================================================================================
	
end arch;