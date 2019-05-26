library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity ball_move is
	port(
			CLK : in std_logic;
			resetN : in std_logic;
			enable : in std_logic;
			start_shot : in std_logic;
			bounce_enable : in std_logic;
			bounce_data : in std_logic_vector (4 downto 0);
			flipper_hit_enable : in std_logic;
			flipper_hit_left_data : in std_logic_vector (2 downto 0);
			is_dead : in std_logic;
			game_over : in std_logic;
			end_of_frame : in std_logic;
			flipper_hit_right_data : in std_logic_vector (2 downto 0);
			
			left_tilt : in std_logic;
			right_tilt : in std_logic;
			
			ballSpeedX : out integer;
			ballSpeedY : out integer;
			currLocation_X : out integer;
			currLocation_Y : out integer;
			beep : out std_logic;
			beep_data : out std_logic_vector (2 downto 0);
			
			score_out : out std_logic_vector (3 downto 0);
			score_hit : out std_logic;
			
			max_charge: out std_logic;
			charge_level : out std_logic_vector (1 downto 0)
	);
end entity;


architecture arc_ball_move of ball_move is

		constant StartX : integer := 570;   -- starting point
		constant StartY : integer := 250;
		
		constant start_shot_speed : integer := 0;-- -12;
		constant gravity : integer := 1;
		constant speed_devider : integer := 4;
		constant max_speed : integer := 12;
	
		signal game_started : std_logic;
		
		signal sigCurrLocationX : integer range 0 to 640;  --vga screen size 
		signal sigCurrLocationY : integer range 0 to 480;
		
		signal sigSpeedX : integer;
		signal sigSpeedY : integer;
		
		constant Y_FLOOR : integer := 380;
		constant X_Left_Stage : integer := 190;
		constant X_Right_Stage : integer := 380;
		constant BallDrawY_Size : integer := 27;
		
		signal sigBeep : std_logic;
		signal sigBeepData : std_logic_vector (2 downto 0);
		
		-----------------------------------------------------
		signal sigStartShotPossible : std_logic;
		
		signal sigHit : std_logic;
		signal sigScore : std_logic_vector (3 downto 0);
		
		constant charge_devider : integer := 8;
		
		signal sigChargeLevel : std_logic_vector (1 downto 0);
		signal sigMaxCharge : std_logic;

	begin
	
		currLocation_X <= sigCurrLocationX;
		currLocation_Y <= sigCurrLocationY;
		ballSpeedX <= sigSpeedX;
		ballSpeedY <= sigSpeedY;
		
		beep <= sigBeep;
		beep_data <= sigBeepData;
		
		process (CLK, resetN)
		
		variable ObjectStartX_t : integer range 0 to 640;  --vga screen size 
		variable ObjectStartY_t : integer range 0 to 480;
		
		variable Ball_Movement_X : integer range -640 to 640;
		variable Ball_Movement_Y : integer range -640 to 640;
		variable temp : integer range -max_speed*speed_devider to max_speed*speed_devider;
		
		variable start_shot_counter : integer;
		variable beepCount : integer range 0 to 7;
		
		
		begin
		if RESETn = '0' then
				game_started <= '0';
				sigCurrLocationX	<= StartX;
				sigCurrLocationY	<= StartY ;
				sigBeep <= '0';
				sigBeepData <= "000";
				beepCount := 0;
				--------------------------------
				start_shot_counter := 0;
				sigStartShotPossible <= '1';
				sigScore <= "0000";
				sigHit <= '0';
				--------------------------------
		elsif rising_edge(CLK) then
			if game_over = '1' and end_of_frame = '1' then
				case beepCount is
					when 0 =>
						sigBeep <= '1';
						sigBeepData <= "000";
					when 1 =>
						sigBeep <= '1';
						sigBeepData <= "001";
					when 2 =>
						sigBeep <= '1';
						sigBeepData <= "010";
					when 3 =>
						sigBeep <= '1';
						sigBeepData <= "011";
					when 4 =>
						sigBeep <= '1';
						sigBeepData <= "100";
					when 5 =>
						sigBeep <= '1';
						sigBeepData <= "101";
					when 6 =>
						sigBeep <= '1';
						sigBeepData <= "110";
					when 7 =>
						sigBeep <= '1';
						sigBeepData <= "111";
				end case;
				beepCount := beepCount +1;
				
			elsif (enable = '1' and game_over = '0') then
				if end_of_frame = '1' then
					sigScore <= "0000";
					sigHit <= '0';
					if game_started = '0' then
						ObjectStartX_t := StartX;
						ObjectStartY_t := StartY;
						sigBeep <= '0';
						sigBeepData <= "000";
					else
						if ((flipper_hit_left_data = "000") and (flipper_hit_right_data = "000") and ((bounce_enable = '0') or (bounce_data = "00000")) and game_started = '1') then
							ObjectStartX_t  := ObjectStartX_t + Ball_Movement_X/speed_devider;  -- move X 
							ObjectStartY_t  := ObjectStartY_t + Ball_Movement_Y/speed_devider; -- move Y
							sigBeep <= '0';
							sigBeepData <= "000";
						end if;
					end if;
					
					if is_dead = '1' then
						game_started <= '0';
						sigBeep <= '1';
						sigBeepData <= "000";
						
						start_shot_counter := 0;
						sigStartShotPossible <= '1';
					end if;
					
					if sigStartShotPossible = '1' then
						if (start_shot = '1') and (start_shot_counter > -max_speed * charge_devider) then
							Ball_Movement_X := 0;--just for simulation
							start_shot_counter := start_shot_counter - 1;
							if (start_shot_counter = -max_speed * charge_devider) then
								sigMaxCharge <= '1';
							elsif (start_shot_counter <= -((max_speed * charge_devider)/4)*3) then
								sigChargeLevel <= "11";
							elsif (start_shot_counter <= -((max_speed * charge_devider)/4)*2) then
								sigChargeLevel <= "10";
							elsif (start_shot_counter <= -((max_speed * charge_devider)/4)) then
								sigChargeLevel <= "01";
							else
								sigChargeLevel <= "00";
							end if;
								
						elsif (start_shot = '0') and (start_shot_counter < 0) then
							Ball_Movement_Y := (start_shot_speed + (start_shot_counter / charge_devider)) * speed_devider;
							sigStartShotPossible <= '0';
							game_started <= '1';
							sigBeep <= '1';
							sigBeepData <= "000";
						end if;
					else
						sigMaxCharge <= '0';
						sigChargeLevel <= "00";
						sigHit <= '1';
						sigScore <= "0000";
						
						if (flipper_hit_left_data > 0) then		-- flipper hit movement.
									sigBeep <= '1';
									sigBeepData <= "100";
									sigScore <= "0111";
							case flipper_hit_left_data is
								when "000" => null;
								
								when "001" => 								-- Neg 30
									temp := Ball_Movement_X;
									Ball_Movement_X := abs(Ball_Movement_Y);
									Ball_Movement_Y := abs(temp);
									
								when "010" =>								-- Neg 20
									Ball_Movement_X := 2 * abs (Ball_Movement_x);
									Ball_Movement_Y := -2 * abs(Ball_Movement_Y);
								when "011" =>								-- Neg 10
									Ball_Movement_X := max_speed * Ball_Movement_X;
									
									Ball_Movement_Y := -(max_speed - 2) * Ball_Movement_Y;
								when "100" =>								-- val 0
									Ball_Movement_Y := max_speed * speed_devider;
									
								when "101" =>								-- pos 10
									Ball_Movement_X := -2*abs (Ball_Movement_X);
									Ball_Movement_Y := -2*abs (Ball_Movement_Y);
								when "110" =>								-- pos 20
									Ball_Movement_X := -2*abs (Ball_Movement_X);
									Ball_Movement_Y := -abs (Ball_Movement_Y);
								when "111" => 								-- pos 30
									temp := Ball_Movement_X;
									Ball_Movement_X := -abs(Ball_Movement_Y);
									Ball_Movement_Y := -abs(temp);
							end case;
							
						elsif (flipper_hit_right_data > 0) then
									sigBeep <= '1';
									sigBeepData <= "100";
									sigScore <= "0111";
							case flipper_hit_right_data is
								when "000" => null;
								
								when "001" => 								-- Neg 30
									temp := Ball_Movement_X;
									Ball_Movement_X := -abs(Ball_Movement_Y);
									Ball_Movement_Y := abs(temp);
									
								when "010" =>								-- Neg 20
									Ball_Movement_X := -2 * abs (Ball_Movement_x);
									Ball_Movement_Y := -2 * abs(Ball_Movement_Y);
								when "011" =>								-- Neg 10
									Ball_Movement_X := -max_speed * Ball_Movement_X;
									
									Ball_Movement_Y := -(max_speed - 2) * Ball_Movement_Y;

								when "100" =>								-- val 0
									Ball_Movement_Y := max_speed * speed_devider;
									
								when "101" =>								-- pos 10
									Ball_Movement_X := 2*abs (Ball_Movement_X);
									Ball_Movement_Y := -2*abs (Ball_Movement_Y);
									
								when "110" =>								-- pos 20
									Ball_Movement_X := 2*abs (Ball_Movement_X);
									Ball_Movement_Y := -abs (Ball_Movement_Y);
									
								when "111" => 								-- pos 30
									temp := Ball_Movement_X;
									Ball_Movement_X := abs(Ball_Movement_Y);
									Ball_Movement_Y := -abs(temp);
							end case;
									
									
						elsif (bounce_enable = '1') then				-- usual movement enable.

							case bounce_data is 
								when "00000" => null;	-- noBounce
										
								when "00001" => 	-- horizontal floor
										Ball_Movement_Y := -Ball_Movement_Y;
										sigBeep <= '1';
										sigBeepData <= "000";
									--end if;
								when "00010" =>	-- left-down slope
										temp := Ball_Movement_X;
										--Ball_Movement_X := abs(Ball_Movement_Y);
										--Ball_Movement_Y := -abs(temp);
										if (abs (Ball_Movement_X) > abs (Ball_Movement_Y)) then
											Ball_Movement_X := abs(Ball_Movement_Y);
											Ball_Movement_Y := -abs(temp);
										else
											Ball_Movement_X := abs(Ball_Movement_Y);
											Ball_Movement_Y := -speed_devider*2;
										end if;
										sigScore <= "0101";
										sigBeep <= '1';
										sigBeepData <= "001";
									
								when "00011" => 	-- left vertical wall.
									--if Ball_Movement_X < 0 then
										Ball_Movement_X := -Ball_Movement_X;
									--	score_out <= "0000";
										sigBeep <= '1';
										sigBeepData <= "110";
									--end if;
								when "00100" =>   -- left-up slope
									temp := Ball_Movement_X;
									Ball_Movement_X := abs(Ball_Movement_Y);
									Ball_Movement_Y := abs(temp);
									sigScore <= "0101";
										sigBeep <= '1';
										sigBeepData <= "010";
								
								when "00101" =>   -- horizontal ceiling
									--if Ball_Movement_Y < 0 then
										Ball_Movement_Y := -Ball_Movement_Y;
									--	score_out <= "0000";
											sigBeep <= '1';
										sigBeepData <= "011";									
									--end if;
								when "00110" =>	-- right-up slope
									temp := Ball_Movement_X;
									Ball_Movement_X := -abs(Ball_Movement_Y);
									Ball_Movement_Y := abs(temp);
									sigScore <= "0101";

										sigBeep <= '1';
										sigBeepData <= "100";
								when "00111" =>	-- right vertical wall
								 --if Ball_Movement_X > 0 then
									Ball_Movement_X := -Ball_Movement_X;
									--score_out <= "0000";
										sigBeep <= '1';
										sigBeepData <= "101";									
								 --end if;
								when "01000" =>	-- right-down slope
										temp := Ball_Movement_X;
										--Ball_Movement_X := -abs(Ball_Movement_Y);
										--Ball_Movement_Y := -abs(temp);
										if (abs (Ball_Movement_X) > abs (Ball_Movement_Y)) then
											Ball_Movement_X := -abs(Ball_Movement_Y);
											Ball_Movement_Y := -abs(temp);
										else
											Ball_Movement_X := -abs(Ball_Movement_Y);
											Ball_Movement_Y := -speed_devider*2;
										end if;
										sigScore <= "0101";
										sigBeep <= '1';
										sigBeepData <= "111";

										
								when others => null;
							end case;
						elsif (left_tilt = '1') then
							Ball_Movement_X := Ball_Movement_X - 1;
							sigScore <= "0000";
						elsif (right_tilt = '1') then
							Ball_Movement_X := Ball_Movement_X + 1;
							sigScore <= "0000";
						end if;
					end if;
					
					if (Ball_Movement_X/speed_devider > max_speed) then
						Ball_Movement_X := max_speed*speed_devider;
					end if;
					if (Ball_Movement_Y/speed_devider > max_speed) then
						Ball_Movement_Y := max_speed*speed_devider;
					end if;
					if (Ball_Movement_X/speed_devider < -max_speed) then
						Ball_Movement_X := -max_speed*speed_devider;
					end if;
					if (Ball_Movement_Y/speed_devider < -max_speed) then
						Ball_Movement_Y := -max_speed*speed_devider;
					end if;
					
					sigCurrLocationX <= ObjectStartX_t;
					sigCurrLocationY <= ObjectStartY_t;	-- usual movement. Gravity.
					
					if (ObjectStartY_t + BallDrawY_Size < Y_FLOOR) or ((ObjectStartX_t + 12 > X_Left_Stage) and ((ObjectStartX_t + 12 < X_Right_Stage)))then
						Ball_Movement_Y := Ball_Movement_Y + gravity;
					end if;
					
					sigSpeedX <= Ball_Movement_X;
					sigSpeedY <= Ball_Movement_Y;
					
				else
					sigScore <= "0000";
					score_hit <= '0';
					
				end if;--end of frame
				
			score_out <= sigScore;
			score_hit <= sigHit;
			max_charge <= sigMaxCharge;
			charge_level <= sigChargeLevel;
			end if;--enabled/game over
		end if;--resetN/CLK
		
		

		
		end process;
end architecture;