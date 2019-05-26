----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:18:03 04/15/2015 
-- Design Name: 
-- Module Name:    screen - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity screen is
    Port ( Hposition : in  STD_LOGIC_VECTOR (10 downto 0);
           Vposition : in  STD_LOGIC_VECTOR (9 downto 0);
           VIDON     : in  STD_LOGIC;
			  buttons   : in  STD_LOGIC_VECTOR(3 downto 0);
			  switch    : in  STD_LOGIC;
			  switch2   : in  STD_LOGIC;
			  clk_60    : in  STD_LOGIC;
           red       : out  STD_LOGIC_VECTOR (4 downto 0);
           green     : out  STD_LOGIC_VECTOR (5 downto 0);
           blue      : out  STD_LOGIC_VECTOR (4 downto 0) );
end screen;


architecture Behavioral of screen is

component refresh_clock2 is
    Port ( clk_60  : in  STD_LOGIC;
           refresh : out  STD_LOGIC );
end component;

component controll is
    Port ( Hposition   : in  STD_LOGIC_VECTOR (10 downto 0);
           Vposition   : in  STD_LOGIC_VECTOR (9 downto 0);
           VIDON       : in  STD_LOGIC;
			  buttons     : in  STD_LOGIC_VECTOR(3 downto 0);
			  refresh     : in  STD_LOGIC;
			  enable_game : in  STD_LOGIC;
           obj_on      : out  STD_LOGIC;
			  Hobj_top    : out  STD_LOGIC_VECTOR(10 downto 0);
			  Vobj_center : out  STD_LOGIC_VECTOR(9 downto 0);
			  obj_col     : out  STD_LOGIC_VECTOR (9 downto 0);
			  obj_row     : out  STD_LOGIC_VECTOR (10 downto 0) );
end component;

component spaceship1 is
    Port ( obj_on  : in  STD_LOGIC;
           obj_row : in  STD_LOGIC_VECTOR (10 downto 0);
           obj_col : in  STD_LOGIC_VECTOR (9 downto 0);
           obj_rgb : out  STD_LOGIC );
end component;

component spaceship2 is
    Port ( obj_on  : in  STD_LOGIC;
           obj_row : in  STD_LOGIC_VECTOR (10 downto 0);
           obj_col : in  STD_LOGIC_VECTOR (9 downto 0);
           obj_rgb : out  STD_LOGIC );
end component;

component spaceship3 is
    Port ( obj_on  : in  STD_LOGIC;
           obj_row : in  STD_LOGIC_VECTOR (10 downto 0);
           obj_col : in  STD_LOGIC_VECTOR (9 downto 0);
           obj_rgb : out  STD_LOGIC );
end component;

component spaceship4 is
    Port ( obj_on  : in  STD_LOGIC;
           obj_row : in  STD_LOGIC_VECTOR (10 downto 0);
           obj_col : in  STD_LOGIC_VECTOR (9 downto 0);
           obj_rgb : out  STD_LOGIC );
end component;

component animation is
    Port ( obj_on1          : in  STD_LOGIC;
           obj_on2          : in  STD_LOGIC;
			  obj_on3          : in  STD_LOGIC;
			  obj_on4          : in  STD_LOGIC;
			  obj_on           : in  STD_LOGIC;
           clk              : in  STD_LOGIC;
			  spaceship_enable : out  STD_LOGIC;
           objrgb           : out  STD_LOGIC );
end component;

component spaceship_second_colour is
    Port ( obj_on  : in  STD_LOGIC;
           obj_row : in  STD_LOGIC_VECTOR (10 downto 0);
           obj_col : in  STD_LOGIC_VECTOR (9 downto 0);
           obj_rgb : out  STD_LOGIC );
end component;

component obstacles_control is
    Port ( Hposition     : in  STD_LOGIC_VECTOR (10 downto 0);
           Vposition     : in  STD_LOGIC_VECTOR (9 downto 0);
           VIDON         : in  STD_LOGIC;
           refresh       : in  STD_LOGIC;
			  enable_game   : in  STD_LOGIC;
           obstacle1_on  : out  STD_LOGIC;
			  obstacle1_row : out  STD_LOGIC_VECTOR(10 downto 0);
			  obstacle1_col : out  STD_LOGIC_VECTOR(9 downto 0);
           obstacle2_on  : out  STD_LOGIC;
			  obstacle2_row : out  STD_LOGIC_VECTOR(10 downto 0);
			  obstacle2_col : out  STD_LOGIC_VECTOR(9 downto 0);
			  obstacle3_on  : out  STD_LOGIC;
			  obstacle3_row : out  STD_LOGIC_VECTOR(10 downto 0);
			  obstacle3_col : out  STD_LOGIC_VECTOR(9 downto 0) );
end component;

component obstacles1_ROM is
    Port ( obstacle1_on     : in  STD_LOGIC;
           obstacle1_row    : in  STD_LOGIC_VECTOR (10 downto 0);
           obstacle1_col    : in  STD_LOGIC_VECTOR (9 downto 0);
			  obstacle1_enable : out  STD_LOGIC;
           obstacle1_rgb    : out  STD_LOGIC );
end component;

component obstacles2_ROM is
    Port ( obstacle2_on     : in  STD_LOGIC;
           obstacle2_row    : in  STD_LOGIC_VECTOR (10 downto 0);
           obstacle2_col    : in  STD_LOGIC_VECTOR (9 downto 0);
			  obstacle2_enable : out  STD_LOGIC;
           obstacle2_rgb    : out  STD_LOGIC );
end component;

component obstacles3_ROM is
    Port ( obstacle3_on     : in  STD_LOGIC;
           obstacle3_row    : in  STD_LOGIC_VECTOR (10 downto 0);
           obstacle3_col    : in  STD_LOGIC_VECTOR (9 downto 0);
			  obstacle3_enable : out  STD_LOGIC;
           obstacle3_rgb    : out  STD_LOGIC );
end component;

component laser_controll is
    Port ( Hposition    : in  STD_LOGIC_VECTOR (10 downto 0);
           Vposition    : in  STD_LOGIC_VECTOR (9 downto 0);
			  refresh      : in  STD_LOGIC;
           VIDON        : in  STD_LOGIC;
           Hobj_top     : in  STD_LOGIC_VECTOR(10 downto 0);
			  Vobj_center  : in  STD_LOGIC_VECTOR(9 downto 0);
           switch       : in  STD_LOGIC;
			  laser_off    : in  STD_LOGIC;
			  enable_game  : in  STD_LOGIC;
			  laser_enable : out  STD_LOGIC;
           laser_on     : out  STD_LOGIC );
end component;

component enemy_control is
    Port ( Hposition      : in  STD_LOGIC_VECTOR (10 downto 0);
	        Vposition      : in  STD_LOGIC_VECTOR (9 downto 0);
           VIDON          : in  STD_LOGIC;
           refresh        : in  STD_LOGIC;
			  enable_game    : in  STD_LOGIC;
			  laser_on       : in  STD_LOGIC;
			  enemy_out      : out  STD_LOGIC;
			  enemy_position : out  STD_LOGIC_VECTOR (9 downto 0);
           enemy_on       : out  STD_LOGIC );
end component;

component enemy_shoot is
    Port ( Hposition      : in  STD_LOGIC_VECTOR (10 downto 0);
           Vposition      : in  STD_LOGIC_VECTOR (9 downto 0);
           VIDON          : in  STD_LOGIC;
           refresh        : in  STD_LOGIC;
			  enable_game    : in  STD_LOGIC;
           enemy_on       : in  STD_LOGIC;
           enemy_position : in  STD_LOGIC_VECTOR (9 downto 0);
			  laser_on       : in  STD_LOGIC;
			  shoot_row      : out  STD_LOGIC_VECTOR(10 downto 0);
			  shoot_col      : out  STD_LOGIC_VECTOR(9 downto 0);
           shoot_on       : out  STD_LOGIC );
end component;

component shoot_ROM is
    Port ( shoot_on  : in  STD_LOGIC;
           shoot_row : in  STD_LOGIC_VECTOR (10 downto 0);
           shoot_col : in  STD_LOGIC_VECTOR (9 downto 0);
           shoot_rgb : out  STD_LOGIC );
end component;

component obstacle_collision is
    Port ( spaceship_enable : in  STD_LOGIC;
			  obj_rgb          : in  STD_LOGIC;
           obstacle1_enable : in  STD_LOGIC;
			  obstacle1_rgb    : in  STD_LOGIC;
			  obstacle2_enable : in  STD_LOGIC;
			  obstacle2_rgb    : in  STD_LOGIC;
			  obstacle3_rgb    : in  STD_LOGIC;
			  obstacle3_enable : in  STD_LOGIC;
           obj_off          : out  STD_LOGIC );
end component;

component game_controll is
    Port ( game_over   : in  STD_LOGIC;
	        switch2     : in  STD_LOGIC;
			  start       : out STD_LOGIC;
			  start_game  : out STD_LOGIC;
           enable_game : out  STD_LOGIC );
end component;

component game_over_ROM is
    Port ( start_game       : in  STD_LOGIC;
           Hposition        : in  STD_LOGIC_VECTOR (10 downto 0);
           Vposition        : in  STD_LOGIC_VECTOR (9 downto 0);
			  game_over_enable : out  STD_LOGIC;
           game_over_on     : out  STD_LOGIC;
           game_over_rgb    : out  STD_LOGIC );
end component;

component score is
    Port ( ref_clk      : in  STD_LOGIC;
	        reset        : in  STD_LOGIC;
			  enemy_out    : in  STD_LOGIC;
           first_digit  : out  STD_LOGIC_VECTOR (3 downto 0);
			  second_digit : out  STD_LOGIC_VECTOR (3 downto 0);
			  third_digit  : out  STD_LOGIC_VECTOR (3 downto 0);
			  fourth_digit : out  STD_LOGIC_VECTOR (3 downto 0)
			--  first_digit_f  : out  STD_LOGIC_VECTOR (3 downto 0);
			--  second_digit_f: out  STD_LOGIC_VECTOR (3 downto 0);
			 -- third_digit_f  : out  STD_LOGIC_VECTOR (3 downto 0);
			--  fourth_digit_f : out  STD_LOGIC_VECTOR (3 downto 0)
			  );
end component;

component score_ROM1 is
Port (     digit_value  : in  STD_LOGIC_VECTOR(3 downto 0);
	     --  digit_value_f: in STD_LOGIC_VECTOR(3 downto 0);
			  start_game  : in STD_LOGIC;
	        Hposition    : in  STD_LOGIC_VECTOR (10 downto 0);
           Vposition    : in  STD_LOGIC_VECTOR (9 downto 0);
			  obj_on       : out  STD_LOGIC;
           obj_rgb      : out  STD_LOGIC );
end component;

component score_ROM2 is
  Port ( digit_value  : in  STD_LOGIC_VECTOR(3 downto 0);
	     -- digit_value_f: in STD_LOGIC_VECTOR(3 downto 0);
			  start_game  : in STD_LOGIC;
	        Hposition    : in  STD_LOGIC_VECTOR (10 downto 0);
           Vposition    : in  STD_LOGIC_VECTOR (9 downto 0);
			  obj_on       : out  STD_LOGIC;
           obj_rgb      : out  STD_LOGIC );
end component;

component score_ROM3 is
  Port ( digit_value  : in  STD_LOGIC_VECTOR(3 downto 0);
	   --  digit_value_f: in STD_LOGIC_VECTOR(3 downto 0);
			  start_game  : in STD_LOGIC;
	        Hposition    : in  STD_LOGIC_VECTOR (10 downto 0);
           Vposition    : in  STD_LOGIC_VECTOR (9 downto 0);
			  obj_on       : out  STD_LOGIC;
           obj_rgb      : out  STD_LOGIC );
end component;

component score_ROM4 is
     Port ( digit_value  : in  STD_LOGIC_VECTOR(3 downto 0);
	   --  digit_value_f: in STD_LOGIC_VECTOR(3 downto 0);
			  start_game  : in STD_LOGIC;
	        Hposition    : in  STD_LOGIC_VECTOR (10 downto 0);
           Vposition    : in  STD_LOGIC_VECTOR (9 downto 0);
			  obj_on       : out  STD_LOGIC;
           obj_rgb      : out  STD_LOGIC );
end component;

component SCORE_ROM is
 Port ( Hposition   : in  STD_LOGIC_VECTOR(10 downto 0);
		  Vposition   : in  STD_LOGIC_VECTOR(9 downto 0);
		  VIDON       : in  STD_LOGIC;
		  enable_game : in  STD_LOGIC;
        obj_rgb     : out  STD_LOGIC;
		  obj_on      : out  STD_LOGIC );
end component;

component laser_timer is
    Port ( refresh       : in  STD_LOGIC;
	        VIDON         : in  STD_LOGIC;
           laser_enable  : in  STD_LOGIC;
           Hposition     : in  STD_LOGIC_VECTOR(10 downto 0);
           Vposition     : in  STD_LOGIC_VECTOR(9 downto 0);
           laser_off     : out  STD_LOGIC;
           laser_bar_on  : out  STD_LOGIC;
           laser_bar_rgb : out  STD_LOGIC );
end component;

component Rom_laser_text is
 Port ( Hposition   : in  STD_LOGIC_VECTOR(10 downto 0);
		  Vposition   : in  STD_LOGIC_VECTOR(9 downto 0);
		  VIDON       : in  STD_LOGIC;
		  enable_game : in  STD_LOGIC;
        obj_rgb     : out  STD_LOGIC;
		  obj_on      : out  STD_LOGIC );
end component;

component imm_generator is
    Port ( spaceship_enable   : in  STD_LOGIC;
           obj_rgb            : in  STD_LOGIC;
			  obstacle1_rgb      : in  STD_LOGIC;
			  obstacle1_enable   : in  STD_LOGIC;
			  obstacle2_rgb      : in  STD_LOGIC;
			  obstacle2_enable   : in  STD_LOGIC;
			  obstacle3_rgb      : in  STD_LOGIC;
			  obstacle3_enable   : in  STD_LOGIC;
			  laser_on           : in  STD_LOGIC;
			  enemy_on           : in  STD_LOGIC;
			  shoot_on           : in  STD_LOGIC;
			  shoot_rgb          : in  STD_LOGIC;
			  start              : in  STD_LOGIC;
           VIDON              : in  STD_LOGIC;
			  game_over_enable   : in  STD_LOGIC;
			  game_over_on       : in  STD_LOGIC;
           game_over_rgb      : in  STD_LOGIC;
			  first_digit_on     : in  STD_LOGIC;
			  second_digit_on    : in  STD_LOGIC;
			  third_digit_on     : in  STD_LOGIC;
			  fourth_digit_on    : in  STD_LOGIC;
			  first_digit_rgb    : in  STD_LOGIC;
			  second_digit_rgb   : in  STD_LOGIC;
			  third_digit_rgb    : in  STD_LOGIC;
			  fourth_digit_rgb   : in  STD_LOGIC;
			  laser_bar_rgb      : in  STD_LOGIC;
			  laser_bar_on       : in  STD_LOGIC;
			  Rom_laser_text_rgb : in  STD_LOGIC;
			  Rom_laser_text_on  : in  STD_LOGIC;
			  SCORE_ROM_on       : in  STD_LOGIC;
			  SCORE_ROM_rgb      : in  STD_LOGIC;
			  spaceship_armor    : in  STD_LOGIC;
			  mitra_rgb          : in  STD_LOGIC_VECTOR  (3 downto 0);
           red                : out  STD_LOGIC_VECTOR (4 downto 0);
           green              : out  STD_LOGIC_VECTOR (5 downto 0);
           blue               : out  STD_LOGIC_VECTOR (4 downto 0) );
end component;

component mitra is
    Port ( refresh : in  STD_LOGIC;
           VIDON : in  STD_LOGIC;
           enable_game : in  STD_LOGIC;
			  Hposition : in STD_LOGIC_VECTOR(10 downto 0);
			  Vposition : in STD_LOGIC_VECTOR(9 downto 0);
           mitra_trigger : in  STD_LOGIC;
			  enemy_on : in STD_LOGIC;
			  enemy_position : in STD_LOGIC_VECTOR(9 downto 0);
			  mitra_rgb : out STD_LOGIC);
end component;

component counter_mitra is
    Port ( refresh : in  STD_LOGIC;
           VIDON : in  STD_LOGIC;
           enable_game : in  STD_LOGIC;
           mitra_trigger : out  STD_LOGIC_VECTOR (3 downto 0));
end component;

signal a : std_logic;
signal b : std_logic;
signal col : std_logic_vector(9 downto 0);
signal row : std_logic_vector(10 downto 0);
signal ref_clk : std_logic;
signal ob1 : std_logic;
signal ob2 : std_logic;
signal ob3 : std_logic;
signal objtop : std_logic_vector(10 downto 0);
signal objcenter : std_logic_vector(9 downto 0);
signal las_on : std_logic;
signal start_game : std_logic;
signal game_over : std_logic;
signal enable_game : std_logic;
signal animation1 : std_logic;
signal animation2 : std_logic;
signal animation3 : std_logic;
signal animation4 : std_logic;
signal ob1_rgb : std_logic;
signal ob1_row : std_logic_vector(10 downto 0);
signal ob1_col : std_logic_vector(9 downto 0);
signal ob2_rgb : std_logic;
signal ob2_row : std_logic_vector(10 downto 0);
signal ob2_col : std_logic_vector(9 downto 0);
signal ob3_rgb : std_logic;
signal ob3_row : std_logic_vector(10 downto 0);
signal ob3_col : std_logic_vector(9 downto 0);
signal game_over_on : std_logic;
signal game_over_rgb : std_logic;
signal enemy_on : std_logic;
signal enemy_position : std_logic_vector(9 downto 0);
signal shoot_on : std_logic;
signal enemy_out : std_logic;
signal start : std_logic;
signal game_over_enable : std_logic;
signal obstacle1_enable : std_logic;
signal obstacle2_enable : std_logic;
signal obstacle3_enable : std_logic;
signal spaceship_enable : std_logic;
signal first_digit : std_logic_vector(3 downto 0);
signal second_digit : std_logic_vector(3 downto 0);
signal third_digit : std_logic_vector(3 downto 0);
signal fourth_digit : std_logic_vector(3 downto 0);
signal first_digit_on : std_logic;
signal second_digit_on : std_logic;
signal third_digit_on : std_logic;
signal fourth_digit_on : std_logic;
signal first_digit_rgb : std_logic;
signal second_digit_rgb : std_logic;
signal third_digit_rgb : std_logic;
signal fourth_digit_rgb : std_logic;
signal shoot_row : std_logic_vector(10 downto 0);
signal shoot_col : std_logic_vector(9 downto 0);
signal shoot_rgb : std_logic;
signal laser_bar_rgb : std_logic;
signal laser_bar_on : std_logic;
signal laser_enable : std_logic;
signal laser_off : std_logic;
signal Rom_laser_text_on : std_logic;
signal Rom_laser_text_rgb : std_logic;
signal SCORE_ROM_on : std_logic;
signal SCORE_ROM_rgb : std_logic;
signal spaceship_armor : std_logic;
signal mitra_trigger : std_logic_vector(3 downto 0);
signal mitra_rgb : std_logic_vector(3 downto 0);
signal first_digit_f : std_logic_vector (3 downto 0);
signal second_digit_f : std_logic_vector (3 downto 0);
signal third_digit_f : std_logic_vector (3 downto 0);
signal fourth_digit_f : std_logic_vector (3 downto 0);

begin
    
    D : refresh_clock2 port map ( clk_60 => clk_60,
	                               refresh => ref_clk );
    
	 E : controll port map ( Hposition => Hposition,
                            Vposition => Vposition,
                            VIDON => VIDON,
	 							    buttons => buttons,
	 							    refresh => ref_clk,
	 							    Hobj_top => objtop,
	 		                   Vobj_center => objcenter,
	 							    enable_game => enable_game,
                            obj_on => a,
	 		                   obj_col => col,
	 		                   obj_row => row );
	 								
    ER1 : spaceship1 port map ( obj_on => a,
                                obj_row => row,
                                obj_col => col,
                                obj_rgb => animation1 );
	 						  
    ER2 : spaceship2 port map ( obj_on => a,
                                obj_row => row,
                                obj_col => col,
                                obj_rgb => animation2 );
	 						  
    ER3 : spaceship3 port map ( obj_on => a,
                                obj_row => row,
                                obj_col => col,
                                obj_rgb => animation3 );
	 						  
    ER4 : spaceship4 port map ( obj_on => a,
                                obj_row => row,
                                obj_col => col,
                                obj_rgb => animation4 );
	 						  
    EA : animation port map ( obj_on1 => animation1,
                              obj_on2 => animation2,
	 								   obj_on3 => animation3,
	 								   obj_on4 => animation4,
	 								   obj_on => a,
                              clk => ref_clk,
	 								   spaceship_enable => spaceship_enable,
                              objrgb => b );
	 						  
	 ER5 : spaceship_second_colour port map ( obj_on => a,
                                             obj_row => row,
                                             obj_col => col,
                                             obj_rgb => spaceship_armor );
	 													  
    F : obstacles_control port map ( Hposition => Hposition,
                                     Vposition => Vposition,
                                     VIDON => VIDON,
                                     refresh => ref_clk,
	 										    enable_game => enable_game,
                                     obstacle1_on => ob1,
	 										    obstacle1_row => ob1_row,
	 										    obstacle1_col => ob1_col,
                                     obstacle2_on => ob2,
	 										    obstacle2_row => ob2_row,
	 										    obstacle2_col => ob2_col,
	 										    obstacle3_on => ob3,
	 										    obstacle3_row => ob3_row,
	 										    obstacle3_col => ob3_col );
	 										  
    FR1 : obstacles1_ROM port map ( obstacle1_on => ob1,
                                    obstacle1_row => ob1_row,
                                    obstacle1_col => ob1_col,
	 									      obstacle1_enable => obstacle1_enable,
                                    obstacle1_rgb => ob1_rgb );
	 									  
    FR2 : obstacles2_ROM port map ( obstacle2_on => ob2,
                                    obstacle2_row => ob2_row,
                                    obstacle2_col => ob2_col,
	 									      obstacle2_enable => obstacle2_enable,
                                    obstacle2_rgb => ob2_rgb );
	 									  
    FR3 : obstacles3_ROM port map ( obstacle3_on => ob3,
                                    obstacle3_row => ob3_row,
                                    obstacle3_col => ob3_col,
	 									      obstacle3_enable => obstacle3_enable,
                                    obstacle3_rgb => ob3_rgb );
	 										  
    G : laser_controll port map ( Hposition => Hposition,
                                  Vposition => Vposition,
	 										 refresh => ref_clk,
                                  VIDON => VIDON,
                                  Hobj_top => objtop,
	 		                         Vobj_center => objcenter,
                                  switch => switch,
	 										 laser_off => laser_off,
	 										 enable_game => enable_game,
	 										 laser_enable => laser_enable,
                                  laser_on => las_on );
	 										
    H : enemy_control port map ( Hposition => Hposition,
	                              Vposition => Vposition,
                                 VIDON => VIDON,
                                 refresh => ref_clk,
	 		                        enable_game => enable_game,
	 										enemy_out => enemy_out,
	 										enemy_position => enemy_position,
	 										laser_on => las_on,
                                 enemy_on => enemy_on );
	 										
    I : enemy_shoot port map ( Hposition => Hposition,
                               Vposition => Vposition,
                               VIDON => VIDON,
                               refresh => ref_clk,
	 		                      enable_game => enable_game,
                               enemy_on => enemy_on,
                               enemy_position => enemy_position,
	 									 laser_on => las_on,
	 									 shoot_row => shoot_row,
	 									 shoot_col => shoot_col,
                               shoot_on => shoot_on );
	 									 
    IR : shoot_ROM port map ( shoot_on => shoot_on,
                              shoot_row => shoot_row,
                              shoot_col => shoot_col,
                              shoot_rgb => shoot_rgb );
	 										
    J : obstacle_collision port map ( spaceship_enable => spaceship_enable,
	 											  obj_rgb => b,
                                      obstacle1_enable => obstacle1_enable,
	 											  obstacle1_rgb => ob1_rgb,
	 											  obstacle2_enable => obstacle2_enable,
	 											  obstacle2_rgb => ob2_rgb,
	 											  obstacle3_rgb => ob3_rgb,
	 											  obstacle3_enable => obstacle3_enable,
                                      obj_off => game_over );
	 													  
    K : game_controll port map ( game_over => game_over,
	                              switch2 => switch2,
	 									   start => start,
	 									   start_game => start_game,
                                 enable_game => enable_game );
	 									  
	 L : game_over_ROM port map ( start_game => start_game,
                                 Hposition => Hposition,
                                 Vposition => Vposition,
	 										game_over_enable => game_over_enable,
                                 game_over_on => game_over_on,
                                 game_over_rgb => game_over_rgb );
	 										
    M : score port map ( ref_clk => ref_clk,
	                      reset => enable_game,
	 		                enemy_out => enemy_out,
                         first_digit => first_digit,
	 		                second_digit => second_digit,
	 		                third_digit => third_digit,
	 		                fourth_digit => fourth_digit);
                       --  first_digit_f => first_digit_f,
			               -- second_digit_f =>second_digit_f,
			                --third_digit_f  =>third_digit_f,
			                --fourth_digit_f => fourth_digit_f );
	 							 
    MR1 : score_ROM1 port map ( digit_value => first_digit,
	                            -- digit_value_f => first_digit_f,
										  start_game  => enable_game,
	 									  Hposition => Hposition,
	 									  Vposition => Vposition,
	 									  obj_on => first_digit_on,
	 									  obj_rgb => first_digit_rgb );
	 										
	 										
    MR2 : score_ROM2 port map ( digit_value => second_digit,
	                           --  digit_value_f => second_digit_f,
										  start_game  => enable_game,
	 									  Hposition => Hposition,
	 									  Vposition => Vposition,
	 									  obj_on => second_digit_on,
	 									  obj_rgb => second_digit_rgb );
	 										
    MR3 : score_ROM3 port map ( digit_value => third_digit,
                             -- digit_value_f => third_digit_f,
											start_game  => enable_game,
	 									  Hposition => Hposition,
	 									  Vposition => Vposition,
	 									  obj_on => third_digit_on,
	 									  obj_rgb => third_digit_rgb );
	 									
    MR4 : score_ROM4 port map ( digit_value => fourth_digit,
	                           -- digit_value_f => fourth_digit_f,
										  start_game  => enable_game,
	 									  Hposition => Hposition,
	 									  Vposition => Vposition,
	 									  obj_on => fourth_digit_on,
	 									  obj_rgb => fourth_digit_rgb );
	 									
    MRW : SCORE_ROM port map ( Hposition => Hposition,
	 	                         Vposition => Vposition,
	 	                         VIDON => VIDON,
	 	                         enable_game => enable_game,
                               obj_rgb => SCORE_ROM_rgb,
	 	                         obj_on => SCORE_ROM_on );
	 									
    N : laser_timer port map ( refresh => ref_clk,
	                            VIDON => VIDON,
                               laser_enable => laser_enable,
                               Hposition => Hposition,
                               Vposition => Vposition,
                               laser_off => laser_off,
                               laser_bar_on => laser_bar_on,
                               laser_bar_rgb => laser_bar_rgb );

    NRW : Rom_laser_text port map ( Hposition => Hposition,
		                              Vposition => Vposition,
											   VIDON => VIDON,
											   enable_game => enable_game,
                                    obj_rgb => Rom_laser_text_rgb,
		                              obj_on => Rom_laser_text_on );
								
    O : imm_generator port map ( spaceship_enable => spaceship_enable,
                                 obj_rgb => b,
										   obstacle1_rgb => ob1_rgb,
										   obstacle1_enable => obstacle1_enable,
										   obstacle2_rgb => ob2_rgb,
										   obstacle2_enable => obstacle2_enable,
										   obstacle3_rgb => ob3_rgb,
										   obstacle3_enable => obstacle3_enable,
										   laser_on => las_on,
										   enemy_on => enemy_on,
										   shoot_on => shoot_on,
										   shoot_rgb => shoot_rgb,
										   start => start,
                                 VIDON => VIDON,
										   game_over_enable => game_over_enable,
								         game_over_on => game_over_on,
                                 game_over_rgb => game_over_rgb,
										   first_digit_on => first_digit_on,
										   second_digit_on => second_digit_on,
										   third_digit_on => third_digit_on,
										   fourth_digit_on => fourth_digit_on,
										   first_digit_rgb => first_digit_rgb,
										   second_digit_rgb => second_digit_rgb,
										   third_digit_rgb => third_digit_rgb,
										   fourth_digit_rgb => fourth_digit_rgb,
										   laser_bar_rgb => laser_bar_rgb,
										   laser_bar_on => laser_bar_on,
										   Rom_laser_text_rgb => Rom_laser_text_rgb,
										   Rom_laser_text_on => Rom_laser_text_on,
										   SCORE_ROM_on => SCORE_ROM_on,
										   SCORE_ROM_rgb => SCORE_ROM_rgb,
										   spaceship_armor => spaceship_armor,
											mitra_rgb => mitra_rgb,
                                 red => red,
                                 green => green,
                                 blue => blue );
											
    P : counter_mitra port map (   refresh => ref_clk,
											  VIDON => VIDON,
											  enable_game => enable_game,
											  mitra_trigger => mitra_trigger);
											
    P0 : mitra port map ( refresh => ref_clk,
								  VIDON => VIDON,
								  enable_game => enable_game,
								  Hposition => Hposition,
								  Vposition => Vposition,
								  mitra_trigger => mitra_trigger(0),
								  enemy_on => enemy_on,
								  enemy_position => enemy_position,
								  mitra_rgb => mitra_rgb(0));
								  
    P1 : mitra port map ( refresh => ref_clk,
								  VIDON => VIDON,
								  enable_game => enable_game,
								  Hposition => Hposition,
								  Vposition => Vposition,
								  mitra_trigger => mitra_trigger(1),
								  enemy_on => enemy_on,
								  enemy_position => enemy_position,
								  mitra_rgb => mitra_rgb(1));
								  
    P2 : mitra port map ( refresh => ref_clk,
								  VIDON => VIDON,
								  enable_game => enable_game,
								  Hposition => Hposition,
								  Vposition => Vposition,
								  mitra_trigger => mitra_trigger(2),
								  enemy_on => enemy_on,
								  enemy_position => enemy_position,
								  mitra_rgb => mitra_rgb(2));
								  
    P3 : mitra port map ( refresh => ref_clk,
								  VIDON => VIDON,
								  enable_game => enable_game,
								  Hposition => Hposition,
								  Vposition => Vposition,
								  mitra_trigger => mitra_trigger(3),
								  enemy_on => enemy_on,
								  enemy_position => enemy_position,
								  mitra_rgb => mitra_rgb(3));
										   
end Behavioral;












