

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Color_Mapper is
   Port ( BallX : in std_logic_vector(9 downto 0);
          BallY : in std_logic_vector(9 downto 0);
          Ball_size : in std_logic_vector(9 downto 0);
          keyboard_input: in std_logic_vector(2 downto 0);           
          DrawX : in std_logic_vector(9 downto 0);
          DrawY : in std_logic_vector(9 downto 0);  
                  
          carX1 : in std_logic_vector(29 downto 0);--1st row of 3 cars
          carY1 : in std_logic_vector(9 downto 0);          
          CarX2 : in std_logic_vector(49 downto 0);--2nd row of 5 cars
          CarY2 : in std_logic_vector(9 downto 0);           
          CarX3 : in std_logic_vector(39 downto 0);--3rd row of 4 cars
          CarY3 : in std_logic_vector(9 downto 0); 
          CarX4 : in std_logic_vector(29 downto 0);--4th row of 3 cars
          CarY4 : in std_logic_vector(9 downto 0); 
          
          log1X : in std_logic_vector(29 downto 0);--1st row of 3 logs
          log1Y : in std_logic_vector(9 downto 0);             
          log2X : in std_logic_vector(39 downto 0);--2nd row of 4 logs
          log2Y : in std_logic_vector(9 downto 0);            
          log3X : in std_logic_vector(19 downto 0);--3rd row of 2 logs
          log3Y : in std_logic_vector(9 downto 0);           
          log4X : in std_logic_vector(19 downto 0);--4th row of 2 logs
          log4Y : in std_logic_vector(9 downto 0); 
          
          level: in std_logic_vector(1 downto 0);
          

          
          Min1,Min0,Sec1,Sec0: in std_logic_vector(3 downto 0); --number parameters for number display
          
          finished_terminal: in std_logic_vector(3 downto 0);
          lives : in std_logic_vector(1 downto 0); --number of lives
          win, fail: in std_logic;
          Anouncement: in std_logic; --intermission of difficulty announcement
          
          Red   : out std_logic_vector(9 downto 0);
          Green : out std_logic_vector(9 downto 0);
          Blue  : out std_logic_vector(9 downto 0)         
          );
end Color_Mapper;

architecture Behavioral of Color_Mapper is


component Car1_drawer is 
	Port(
		 
		 DrawX: in std_logic_vector( 9 downto 0); 
		 DrawY: in std_logic_vector( 9 downto 0);
		 Car_X_center: in std_logic_vector (9 downto 0); 
		 Car_Y_center: in std_logic_vector (9 downto 0); 
		 draw_red: out std_logic_vector(7 downto 0);
		 draw_green: out std_logic_vector(7 downto 0);
		 draw_blue: out std_logic_vector(7 downto 0)
		 
		 );
end component; 
		 
component Car2_drawer is 
	Port(
		 
		 DrawX: in std_logic_vector( 9 downto 0); 
		 DrawY: in std_logic_vector( 9 downto 0);
		 Car_X_center: in std_logic_vector (9 downto 0); 
		 Car_Y_center: in std_logic_vector (9 downto 0); 
		 draw_red: out std_logic_vector(7 downto 0);
		 draw_green: out std_logic_vector(7 downto 0);
		 draw_blue: out std_logic_vector(7 downto 0)
		 );		 
		 
end component;
 
component NumberDriver
   Port ( 
       
        Num: in std_logic_vector(3 downto 0); -- 0-9 display
        Xcenter,Ycenter: in std_logic_vector(9 downto 0); -- 0-99 display
        
        X: in std_logic_vector(9 downto 0); 
        Y: in std_logic_vector(9 downto 0); 
        
        DoDisplay: out std_logic);
end component;

component frog_drawer  
	Port(
		 DrawX: in std_logic_vector( 9 downto 0); 
		 DrawY: in std_logic_vector( 9 downto 0);
		 Ball_X_center: in std_logic_vector (9 downto 0); 
		 Ball_Y_center: in std_logic_vector (9 downto 0); 
		 keyboard_input : in std_logic_vector(2 downto 0);
		 draw_frog_red: out std_logic_vector(7 downto 0);
		 draw_frog_green: out std_logic_vector(7 downto 0);
		 draw_frog_blue: out std_logic_vector(7 downto 0)
		 );
end component;


--initialize constants

signal Ball_on, log_on, Ball_on2, Ball_on3, Ball_on4: std_logic;
signal Car_on1, Car_on2,Car_on3,Car_on4,Car_on14,Car_on5,Car_on6,Car_on7,Car_on8,Car_on15,Car_on9,Car_on10,Car_on11,Car_on12,Car_on13 : std_logic;
constant car_width  :    std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(20, 10);  --x value of terminal 4
 constant car_height:    std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(15, 10);  --x value of terminal 4
 constant log_width :    std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(40, 10);
 constant log_height:    std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(18, 10); 
  constant BallSize2:    std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(16, 10); 
 
 --declare signals
 signal car1x,car2x,car3x, car21x, car22x, car23x, car24x, car25x :    std_logic_vector(9 downto 0);
 signal car31x, car32x, car33x, car34x, car41x, car42x, car43x : std_logic_vector(9 downto 0); 
 
 signal log11x,log12x,log13x:    std_logic_vector(9 downto 0);
 signal log21x, log22x, log23x, log24x : std_logic_vector(9 downto 0); 	
 signal log31x,log32x:   std_logic_vector(9 downto 0);
 signal log41x,log42x:   std_logic_vector(9 downto 0);
 signal liveball1x,liveball2x,liveball3x,livebally :std_logic_vector(9 downto 0);
 signal Min1display,Min0display,Sec1display,Sec0display,LevelDisplay,Num_On: std_logic;
 
 
 signal Ldisplay,Odisplay,Sdisplay,Edisplay,Udisplay: std_logic;
 signal W1display,W2display,Idisplay,Ndisplay: std_logic;
 
signal FrogRed_sig1, FrogGreen_sig1, FrogBlue_sig1 : std_logic_vector(7 downto 0);
signal FrogRed_sig2, FrogGreen_sig2, FrogBlue_sig2 : std_logic_vector(7 downto 0);
signal FrogRed_sig3, FrogGreen_sig3, FrogBlue_sig3 : std_logic_vector(7 downto 0);
signal FrogRed_sig4, FrogGreen_sig4, FrogBlue_sig4 : std_logic_vector(7 downto 0);
 signal transparent1,transparent2,transparent3,transparent4: std_logic;
 signal redcar1, bluecar1, greencar1 : std_logic_vector(7 downto 0);
 signal redcar2, bluecar2, greencar2 : std_logic_vector(7 downto 0);
 signal redcar3, bluecar3, greencar3 : std_logic_vector(7 downto 0);
 signal redcar4, bluecar4, greencar4 : std_logic_vector(7 downto 0);
 signal redcar5, bluecar5, greencar5 : std_logic_vector(7 downto 0);
 signal redcar6, bluecar6, greencar6 : std_logic_vector(7 downto 0);
 signal redcar7, bluecar7, greencar7 : std_logic_vector(7 downto 0);
 signal redcar8, bluecar8, greencar8 : std_logic_vector(7 downto 0);
 signal redcar9, bluecar9, greencar9 : std_logic_vector(7 downto 0);
 signal redcar10, bluecar10, greencar10 : std_logic_vector(7 downto 0);
 signal redcar11, bluecar11, greencar11 : std_logic_vector(7 downto 0);
 signal redcar12, bluecar12, greencar12 : std_logic_vector(7 downto 0);
 signal redcar13, bluecar13, greencar13 : std_logic_vector(7 downto 0);
 signal redcar14, bluecar14, greencar14 : std_logic_vector(7 downto 0);
 signal redcar15, bluecar15, greencar15 : std_logic_vector(7 downto 0);
 constant car1_Y_start : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(420, 10);
 constant car2_Y_start : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(380, 10);
 constant car3_Y_start : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(340, 10);
 constant car4_Y_start : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(300, 10);
begin





draw1_car : Car1_drawer
	Port map(
		 
		 DrawX=>DrawX , 
		 DrawY=>DrawY , 
		 Car_X_center => car1x, 
		 Car_Y_center => car1_Y_start,
		 draw_red => redcar1, 
		 draw_green => greencar1,
		 draw_blue => bluecar1 
		 );


draw2_car : Car1_drawer
	Port map(
		 
		 DrawX=>DrawX , 
		 DrawY=>DrawY , 
		 Car_X_center => car2x, 
		 Car_Y_center => car1_Y_start,
		 draw_red => redcar2, 
		 draw_green => greencar2,
		 draw_blue => bluecar2 
		 );

draw3_car : Car1_drawer
	Port map(
		 
		 DrawX=>DrawX , 
		 DrawY=>DrawY , 
		 Car_X_center => car3x, 
		 Car_Y_center => car1_Y_start,
		 draw_red => redcar3, 
		 draw_green => greencar3,
		 draw_blue => bluecar3 
		 );
		 
draw4_car : Car2_drawer
	Port map(
		 
		 DrawX=>DrawX , 
		 DrawY=>DrawY , 
		 Car_X_center => car21x, 
		 Car_Y_center => car2_Y_start,
		 draw_red => redcar4, 
		 draw_green => greencar4,
		 draw_blue => bluecar4 
		 );		 
		 
draw5_car : Car2_drawer
	Port map(
		 
		 DrawX=>DrawX , 
		 DrawY=>DrawY , 
		 Car_X_center => car22x, 
		 Car_Y_center => car2_Y_start,
		 draw_red => redcar5, 
		 draw_green => greencar5,
		 draw_blue => bluecar5 
		 );			 

draw6_car : Car2_drawer
	Port map(
		 
		 DrawX=>DrawX , 
		 DrawY=>DrawY , 
		 Car_X_center => car23x, 
		 Car_Y_center => car2_Y_start,
		 draw_red => redcar6, 
		 draw_green => greencar6,
		 draw_blue => bluecar6 
		 );	

draw7_car : Car2_drawer
	Port map(
		 
		 DrawX=>DrawX , 
		 DrawY=>DrawY , 
		 Car_X_center => car24x, 
		 Car_Y_center => car2_Y_start,
		 draw_red => redcar7, 
		 draw_green => greencar7,
		 draw_blue => bluecar7 
		 );	

draw8_car : Car2_drawer
	Port map(
		 
		 DrawX=>DrawX , 
		 DrawY=>DrawY , 
		 Car_X_center => car25x, 
		 Car_Y_center => car2_Y_start,
		 draw_red => redcar8, 
		 draw_green => greencar8,
		 draw_blue => bluecar8 
		 );	
 
draw9_car : Car1_drawer
	Port map(
		 
		 DrawX=>DrawX , 
		 DrawY=>DrawY , 
		 Car_X_center => car31x, 
		 Car_Y_center => car3_Y_start,
		 draw_red => redcar9, 
		 draw_green => greencar9,
		 draw_blue => bluecar9 
		 );


draw10_car : Car1_drawer
	Port map(
		 
		 DrawX=>DrawX , 
		 DrawY=>DrawY , 
		 Car_X_center => car32x, 
		 Car_Y_center => car3_Y_start,
		 draw_red => redcar10, 
		 draw_green => greencar10,
		 draw_blue => bluecar10 
		 );

draw11_car : Car1_drawer
	Port map(
		 
		 DrawX=>DrawX , 
		 DrawY=>DrawY , 
		 Car_X_center => car33x, 
		 Car_Y_center => car3_Y_start,
		 draw_red => redcar11, 
		 draw_green => greencar11,
		 draw_blue => bluecar11 
		 );
	
	draw12_car : Car1_drawer	 		 
	Port map(
		 
		 DrawX=>DrawX , 
		 DrawY=>DrawY , 
		 Car_X_center => car34x, 
		 Car_Y_center => car3_Y_start,
		 draw_red => redcar12, 
		 draw_green => greencar12,
		 draw_blue => bluecar12 
		 );		 
		 
	draw13_car : Car1_drawer	 		 
	Port map(
		 
		 DrawX=>DrawX , 
		 DrawY=>DrawY , 
		 Car_X_center => car41x, 
		 Car_Y_center => car4_Y_start,
		 draw_red => redcar13, 
		 draw_green => greencar13,
		 draw_blue => bluecar13 
		 );		
		 
		 	draw14_car : Car1_drawer	 		 
	Port map(
		 
		 DrawX=>DrawX , 
		 DrawY=>DrawY , 
		 Car_X_center => car42x, 
		 Car_Y_center => car4_Y_start,
		 draw_red => redcar14, 
		 draw_green => greencar14,
		 draw_blue => bluecar14 
		 );		
		 
		 	draw15_car : Car1_drawer	 		 
	Port map(
		 
		 DrawX=>DrawX , 
		 DrawY=>DrawY , 
		 Car_X_center => car43x, 
		 Car_Y_center => car4_Y_start,
		 draw_red => redcar15, 
		 draw_green => greencar15,
		 draw_blue => bluecar15 
		 );				 
		 
		 
		 
---------------------------------------------------------------		 
--frog drawer
drawfrog: frog_drawer  
	Port map(
		 DrawX=>DrawX,
		 DrawY=>DrawY, 
		 Ball_X_center=> BallX,
		 Ball_Y_center=> BallY,
		 keyboard_input=> keyboard_input,
		 draw_frog_red=>   FrogRed_sig1,
		 draw_frog_green=> FrogGreen_sig1,
		 draw_frog_blue=>  FrogBlue_sig1
 
		 );
		 
--live frog drawer2
drawfrog2: frog_drawer  
	Port map(
		 DrawX=>DrawX,
		 DrawY=>DrawY, 
		 Ball_X_center=>CONV_STD_LOGIC_VECTOR(620, 10),
		 Ball_Y_center=>CONV_STD_LOGIC_VECTOR(20, 10),
		 keyboard_input=> "100",
		 draw_frog_red=>FrogRed_sig2,
		 draw_frog_green=> FrogGreen_sig2,
		 draw_frog_blue=>  FrogBlue_sig2
		 );
--live frog drawer3
drawfrog3: frog_drawer  
	Port map(
		 DrawX=>DrawX,
		 DrawY=>DrawY, 
		 Ball_X_center=> CONV_STD_LOGIC_VECTOR(570, 10),
		 Ball_Y_center=> CONV_STD_LOGIC_VECTOR(20, 10),
		 keyboard_input=> "100",
		 draw_frog_red=>FrogRed_sig3,
		 draw_frog_green=> FrogGreen_sig3,
		 draw_frog_blue=> FrogBlue_sig3 
		 );
--live frog drawer4		 
	drawfrog4: frog_drawer  
	Port map(
		 DrawX=>DrawX,
		 DrawY=>DrawY, 
		 Ball_X_center=>CONV_STD_LOGIC_VECTOR(520, 10),
		 Ball_Y_center=>CONV_STD_LOGIC_VECTOR(20, 10),
		 keyboard_input=> "100",
		 draw_frog_red=>FrogRed_sig4,
		 draw_frog_green=>FrogGreen_sig4 ,
		 draw_frog_blue=>  FrogBlue_sig4
		 );	 

--4 timer numbers
drivermin1: NumberDriver
   Port map(        
        Num=>Min1,
        Xcenter=>CONV_STD_LOGIC_VECTOR(20, 10),
        Ycenter=>CONV_STD_LOGIC_VECTOR(20, 10),
        X=>DrawX,
        Y=>DrawY,        
        DoDisplay=>Min1display);
drivermin0: NumberDriver
   Port map(        
        Num=>Min0,
        Xcenter=>CONV_STD_LOGIC_VECTOR(60, 10),
        Ycenter=>CONV_STD_LOGIC_VECTOR(20, 10),
        X=>DrawX,
        Y=>DrawY,        
        DoDisplay=>Min0display);
driversec1: NumberDriver
   Port map(        
        Num=>Sec1,
        Xcenter=>CONV_STD_LOGIC_VECTOR(110, 10),
        Ycenter=>CONV_STD_LOGIC_VECTOR(20, 10),
        X=>DrawX,
        Y=>DrawY,        
        DoDisplay=>Sec1display);
driversec0: NumberDriver
   Port map(        
        Num=>Sec0,
        Xcenter=>CONV_STD_LOGIC_VECTOR(150, 10),
        Ycenter=>CONV_STD_LOGIC_VECTOR(20, 10),
        X=>DrawX,
        Y=>DrawY,        
        DoDisplay=>Sec0display);

--level announce number        
Leveldisplaydriver: NumberDriver
   Port map(        
        Num=>"00" & level,
        Xcenter=>CONV_STD_LOGIC_VECTOR(320, 10),
        Ycenter=>CONV_STD_LOGIC_VECTOR(240, 10),
        X=>DrawX,
        Y=>DrawY,        
        DoDisplay=>LevelDisplay);
        
    
    
    
--U LOSE display
U: NumberDriver
   Port map(        
        Num=>"1100",
        Xcenter=>CONV_STD_LOGIC_VECTOR(220, 10),
        Ycenter=>CONV_STD_LOGIC_VECTOR(240, 10),
        X=>DrawX,
        Y=>DrawY,        
        DoDisplay=>Udisplay);    
        
L: NumberDriver
   Port map(        
        Num=>"1010",
        Xcenter=>CONV_STD_LOGIC_VECTOR(300, 10),
        Ycenter=>CONV_STD_LOGIC_VECTOR(240, 10),
        X=>DrawX,
        Y=>DrawY,        
        DoDisplay=>Ldisplay);
O: NumberDriver
   Port map(        
        Num=>"0000",
        Xcenter=>CONV_STD_LOGIC_VECTOR(340, 10),
        Ycenter=>CONV_STD_LOGIC_VECTOR(240, 10),
        X=>DrawX,
        Y=>DrawY,        
        DoDisplay=>Odisplay);
S: NumberDriver
   Port map(        
        Num=>"0101",
        Xcenter=>CONV_STD_LOGIC_VECTOR(380, 10),
        Ycenter=>CONV_STD_LOGIC_VECTOR(240, 10),
        X=>DrawX,
        Y=>DrawY,        
        DoDisplay=>Sdisplay);
E: NumberDriver
   Port map(        
        Num=>"1011",
        Xcenter=>CONV_STD_LOGIC_VECTOR(420, 10),
        Ycenter=>CONV_STD_LOGIC_VECTOR(240, 10),
        X=>DrawX,
        Y=>DrawY,        
        DoDisplay=>Edisplay);
        
        
--WIN, UUIN display
W1: NumberDriver
   Port map(        
        Num=>"1100",
        Xcenter=>CONV_STD_LOGIC_VECTOR(280, 10),
        Ycenter=>CONV_STD_LOGIC_VECTOR(240, 10),
        X=>DrawX,
        Y=>DrawY,        
        DoDisplay=>W1display);
W2: NumberDriver
   Port map(        
        Num=>"1100",
        Xcenter=>CONV_STD_LOGIC_VECTOR(305, 10),
        Ycenter=>CONV_STD_LOGIC_VECTOR(240, 10),
        X=>DrawX,
        Y=>DrawY,        
        DoDisplay=>W2display);
I: NumberDriver
   Port map(        
        Num=>"0001",
        Xcenter=>CONV_STD_LOGIC_VECTOR(330, 10),
        Ycenter=>CONV_STD_LOGIC_VECTOR(240, 10),
        X=>DrawX,
        Y=>DrawY,        
        DoDisplay=>Idisplay);
N: NumberDriver
   Port map(        
        Num=>"1101",
        Xcenter=>CONV_STD_LOGIC_VECTOR(370, 10),
        Ycenter=>CONV_STD_LOGIC_VECTOR(240, 10),
        X=>DrawX,
        Y=>DrawY,        
        DoDisplay=>Ndisplay);
        


  Ball_on_proc : process (lives,BallX, BallY, DrawX, DrawY, Ball_size, carX1, carY1, CarX2, CarY2,log1X,log1Y )
  begin

	--decompose the bus into each car positions
	car1x <=carX1(29 downto 20);
	car2x <=carX1(19 downto 10);
	car3x <= carX1(9 downto 0);

	car21x <= CarX2(49 downto 40);
	car22x <= CarX2(39 downto 30);    
	car23x <= CarX2(29 downto 20); 
	car24x <= CarX2(19 downto 10); 
	car25x <= CarX2(9 downto 0); 

	car31x <= CarX3(39 downto 30);
	car32x <= CarX3(29 downto 20);
	car33x <= CarX3(19 downto 10);
	car34x <= CarX3(9 downto 0);  

	car41x <= CarX4(29 downto 20);
	car42x <= CarX4 (19 downto 10);
	car43x <= CarX4 (9 downto 0);
		  
      

      

	if (Min1display='1' or Min0display='1' or Sec1display='1' or Sec0display='1'
		
		--draw colons
		or
		  ((DrawX >= CONV_STD_LOGIC_VECTOR(85, 10) - CONV_STD_LOGIC_VECTOR(3, 10)) AND
		  (DrawX <= CONV_STD_LOGIC_VECTOR(85, 10)  + CONV_STD_LOGIC_VECTOR(3, 10)) AND
		  (DrawY >= CONV_STD_LOGIC_VECTOR(10, 10)  - CONV_STD_LOGIC_VECTOR(3, 10)) AND
		  (DrawY <= CONV_STD_LOGIC_VECTOR(10, 10)  + CONV_STD_LOGIC_VECTOR(3, 10)))
		  
		or
		  ((DrawX >= CONV_STD_LOGIC_VECTOR(85, 10) - CONV_STD_LOGIC_VECTOR(3, 10)) AND
		  (DrawX <= CONV_STD_LOGIC_VECTOR(85, 10)  + CONV_STD_LOGIC_VECTOR(3, 10)) AND
		  (DrawY >= CONV_STD_LOGIC_VECTOR(30, 10)  - CONV_STD_LOGIC_VECTOR(3, 10)) AND
		  (DrawY <= CONV_STD_LOGIC_VECTOR(30, 10)  + CONV_STD_LOGIC_VECTOR(3, 10)))
		
		)then
		Num_On<='1'; --turn the number display on if drawx,drawy hits the region of number or the colon
	else 
		Num_On<='0'; 
	end if;
  

--if drawx, drawy are hitting the care region, turn on the car display
   if (
	  ((DrawX >= car1x - car_width) AND
      (DrawX <= car1x  + car_width) AND
      (DrawY >= carY1  - car_height) AND
      (DrawY <= carY1  + car_height))
      		) then
		Car_on1<= '1';
	else
		Car_on1<= '0';
	end if;
      
	if (
	  ((DrawX >= car2x - car_width) AND
      (DrawX <= car2x  + car_width) AND
      (DrawY >= carY1  - car_height) AND
      (DrawY <= carY1  + car_height))
		) then
		Car_on2<= '1';
	else
		Car_on2<= '0';
	end if;
		
	if (	
      ((DrawX >= car3x - car_width) AND
      (DrawX <= car3x  + car_width) AND
      (DrawY >= carY1  - car_height) AND
      (DrawY <= carY1  + car_height))
       			) then
		Car_on3<= '1';
	else
		Car_on3<= '0';
	end if;
       	
    if (   	
      ((DrawX >= car21x - car_width) AND
      (DrawX <= car21x  + car_width) AND
      (DrawY >= CarY2  - car_height) AND
      (DrawY <= CarY2  + car_height))	
      		) then
		Car_on4<= '1';
	else
		Car_on4<= '0';
	end if;
        
     if (   
       ((DrawX >= car22x - car_width) AND
      (DrawX <= car22x  + car_width) AND
      (DrawY >= CarY2  - car_height) AND
      (DrawY <= CarY2  + car_height))
			) then
		Car_on5<= '1';
	else
		Car_on5<= '0';
	end if;
		
	if( 	
	   ((DrawX >= car23x - car_width) AND
      (DrawX <= car23x  + car_width) AND
      (DrawY >= CarY2  - car_height) AND
      (DrawY <= CarY2  + car_height))	
      		) then
		Car_on6<= '1';
	else
		Car_on6<= '0';
	end if;
        
     if(    
       ((DrawX >= car24x - car_width) AND
      (DrawX <= car24x  + car_width) AND
      (DrawY >= CarY2  - car_height) AND
      (DrawY <= CarY2  + car_height))	
        		) then
		Car_on7<= '1';
	else
		Car_on7<= '0';
	end if;
        
       if( 
       ((DrawX >= car25x - car_width) AND
      (DrawX <= car25x  + car_width) AND
      (DrawY >= CarY2  - car_height) AND
      (DrawY <= CarY2  + car_height))
			) then
		Car_on8<= '1';
	else
		Car_on8<= '0';
	end if;
		
	if (	
     ((DrawX >= car31x - car_width) AND
      (DrawX <= car31x  + car_width) AND
      (DrawY >= CarY3  - car_height) AND
      (DrawY <= CarY3  + car_height))  
      		) then
		Car_on9<= '1';
	else
		Car_on9<= '0';
	end if;
      		
      if(		
     ((DrawX >= car32x - car_width) AND
      (DrawX <= car32x  + car_width) AND
      (DrawY >= CarY3  - car_height) AND
      (DrawY <= CarY3  + car_height)) 
      			) then
		Car_on10<= '1';
	else
		Car_on10<= '0';
	end if;
      		
      if(		
     ((DrawX >= car33x - car_width) AND
      (DrawX <= car33x  + car_width) AND
      (DrawY >= CarY3  - car_height) AND
      (DrawY <= CarY3  + car_height)) 
      		) then
		Car_on11<= '1';
	else
		Car_on11<= '0';
	end if;
      		
      if(		
     ((DrawX >= car34x - car_width) AND
      (DrawX <= car34x  + car_width) AND
      (DrawY >= CarY3  - car_height) AND
      (DrawY <= CarY3  + car_height)) 
         		) then
		Car_on12<= '1';
	else
		Car_on12<= '0';
	end if;
            		
       if(     		
     ((DrawX >= car41x - car_width) AND
      (DrawX <= car41x  + car_width) AND
      (DrawY >= CarY4  - car_height) AND
      (DrawY <= CarY4  + car_height)) 
          		) then
		Car_on13<= '1';
	else
		Car_on13<= '0';
	end if;
                  		
         if(         		
     ((DrawX >= car42x - car_width) AND
      (DrawX <= car42x  + car_width) AND
      (DrawY >= CarY4  - car_height) AND
      (DrawY <= CarY4  + car_height)) 
            		) then
		Car_on14<= '1';
	else
		Car_on14<= '0';
	end if;
                    		
       if(             		
     ((DrawX >= car43x - car_width) AND
      (DrawX <= car43x  + car_width) AND
      (DrawY >= CarY4  - car_height) AND
      (DrawY <= CarY4  + car_height)) 
        		) then
		Car_on15<= '1';
	else
		Car_on15<= '0';
	end if;
      
	
	
--initialize live frog x to somewhere invisible	
liveball1x <= CONV_STD_LOGIC_VECTOR(800, 10);
liveball2x <= CONV_STD_LOGIC_VECTOR(800, 10);
liveball3x <= CONV_STD_LOGIC_VECTOR(800, 10);


--initialize live frog y to the top row
livebally <= CONV_STD_LOGIC_VECTOR(20, 10);

	--move all the live frogs into the screen is there are 3 lives left
	if (lives="11") then
		liveball1x <= CONV_STD_LOGIC_VECTOR(620, 10);
		liveball2x <= CONV_STD_LOGIC_VECTOR(570, 10);
		liveball3x <= CONV_STD_LOGIC_VECTOR(520, 10);
		elsif(lives="10")then
		--move 2 the live frogs into the screen is there are 2 lives left
		liveball1x <= CONV_STD_LOGIC_VECTOR(620, 10);
		liveball2x <= CONV_STD_LOGIC_VECTOR(570, 10);
		elsif(lives="01") then
		--similar
  		liveball1x <= CONV_STD_LOGIC_VECTOR(620, 10);
  end if;
	

	--turn on the frog display if drawx,y hit the frog
	if ( 
		((DrawX >= BallX - BallSize2) AND
		(DrawX <= BallX + BallSize2-'1') AND
		(DrawY >= BallY - BallSize2) AND
		(DrawY <= BallY + BallSize2-'1'))
		) then
		Ball_on<= '1';
	else
		Ball_on<= '0';
	end if;	
	
		--the live frog1
	if(
		((DrawX >= liveball1x - BallSize2) AND
		(DrawX <= liveball1x + BallSize2) AND
		(DrawY >= livebally - BallSize2) AND
		(DrawY <= livebally + BallSize2))
		)then
		Ball_on2<= '1';
	else
		Ball_on2<= '0';
	end if;				
		--the live frog2
	if(
		((DrawX >= liveball2x - BallSize2) AND
		(DrawX <= liveball2x + BallSize2) AND
		(DrawY >= livebally - BallSize2) AND
		(DrawY <= livebally + BallSize2))	
		)then
		Ball_on3<= '1';
	else
		Ball_on3<= '0';
	end if;	
		--the live frog3
	if(
		((DrawX >= liveball3x - BallSize2) AND
		(DrawX <= liveball3x + BallSize2) AND
		(DrawY >= livebally - BallSize2) AND
		(DrawY <= livebally + BallSize2))		
		)then
		Ball_on4<= '1';
	else
		Ball_on4<= '0';
	end if;
	
	if (BallX<log_width)then
		log_on<= '1';
	end if;
	
--decompose log bus into each individual log	
log11x <=log1X(29 downto 20);
log12x <=log1X(19 downto 10);
log13x <= log1X(9 downto 0);
	
log21x <=log2X(39 downto 30);
log22x <=log2X(29 downto 20);
log23x <= log2X(19 downto 10);	
log24x <= log2X(9 downto 0);	

log31x <=log3X(19 downto 10);
log32x <=log3X(9 downto 0);

log41x <=log4X(19 downto 10);
log42x <=log4X(9 downto 0);

	
	
	--turn on log display if drawx,y hit in the log region
	if (
		
	  ((DrawX >= log1X - log_width) AND
      (DrawX <= log1X + log_width) AND
      (DrawY >= log1Y - log_height) AND
      (DrawY <= log1Y + log_height))
      or
      ((DrawX >= log11X - log_width) AND
      (DrawX <= log11X + log_width) AND
      (DrawY >= log1Y - log_height) AND
      (DrawY <= log1Y + log_height))
      or
	  ((DrawX >= log12X - log_width) AND
      (DrawX <= log12X + log_width) AND
      (DrawY >= log1Y - log_height) AND
      (DrawY <= log1Y + log_height))
      or      
	  ((DrawX >= log13X - log_width) AND
      (DrawX <= log13X + log_width) AND
      (DrawY >= log1Y - log_height) AND
      (DrawY <= log1Y + log_height))
	or
		
	  ((DrawX >= log21X - log_width) AND
      (DrawX <= log21X + log_width) AND
      (DrawY >= log2Y - log_height) AND
      (DrawY <= log2Y + log_height))
      or
      ((DrawX >= log22X - log_width) AND
      (DrawX <= log22X + log_width) AND
      (DrawY >= log2Y - log_height) AND
      (DrawY <= log2Y + log_height))
      or
	  ((DrawX >= log23X - log_width) AND
      (DrawX <= log23X + log_width) AND
      (DrawY >= log2Y - log_height) AND
      (DrawY <= log2Y + log_height))
      or      
	  ((DrawX >= log24X - log_width) AND
      (DrawX <= log24X + log_width) AND
      (DrawY >= log2Y - log_height) AND
      (DrawY <= log2Y + log_height))
        or
	  ((DrawX >= log31x - log_width) AND
      (DrawX <= log31x + log_width) AND
      (DrawY >= log3Y - log_height) AND
      (DrawY <= log3Y + log_height))
            or
	  ((DrawX >= log32x - log_width) AND
      (DrawX <= log32x + log_width) AND
      (DrawY >= log3Y - log_height) AND
      (DrawY <= log3Y + log_height))
       or
	  ((DrawX >= log41x - log_width) AND
      (DrawX <= log41x + log_width) AND
      (DrawY >= log4Y - log_height) AND
      (DrawY <= log4Y + log_height))  
        or
	  ((DrawX >= log42x - log_width) AND
      (DrawX <= log42x + log_width) AND
      (DrawY >= log4Y - log_height) AND
      (DrawY <= log4Y + log_height))
		) then
		log_on<= '1';
	else
		log_on<= '0';
	end if;
	
end process Ball_on_proc;			---Routine to draw the frog
  
 
  
  
  RGB_Display : process (Ball_on, DrawX, DrawY, win, fail, Car_on1,log_on,Anouncement)
    variable GreenVar, BlueVar : std_logic_vector(22 downto 0);
  begin
		--set up the transparency of the frog is the background is pure white
  		if (FrogRed_sig1=x"ff" and FrogGreen_sig1=x"ff" and FrogBlue_sig1=x"ff")then
			transparent1<='1';
		else
			  transparent1<='0'; 
		end if;
		
		if (FrogRed_sig2=x"ff" and FrogGreen_sig2=x"ff" and FrogBlue_sig2=x"ff")then
			transparent2<='1';
		else
			  transparent2<='0'; 
		end if;
		if (FrogRed_sig3=x"ff" and FrogGreen_sig3=x"ff" and FrogBlue_sig3=x"ff")then
			transparent3<='1';
		else
			  transparent3<='0'; 
		end if;
				if (FrogRed_sig4=x"ff" and FrogGreen_sig4=x"ff" and FrogBlue_sig4=x"ff")then
			transparent4<='1';
		else
			  transparent4<='0'; 
		end if;
		
	if (win='1') then -- if win
		--draw the white background
      Green<=CONV_STD_LOGIC_VECTOR(1023, 10);
      Red<= CONV_STD_LOGIC_VECTOR(1023, 10);
      Blue<= CONV_STD_LOGIC_VECTOR(1023, 10);
		--overwrite "win" on the screen
		  if (W1display='1' or W2display='1' or Idisplay='1' or Ndisplay='1')then
						Green<=CONV_STD_LOGIC_VECTOR(0, 10);
						Red<= CONV_STD_LOGIC_VECTOR(0, 10);
						Blue<= CONV_STD_LOGIC_VECTOR(0, 10);
		  end if;
      
      elsif (fail='1')then --if lose
			--draw the white background
			Green<=CONV_STD_LOGIC_VECTOR(1023, 10);
			Red<= CONV_STD_LOGIC_VECTOR(1023, 10);
			Blue<= CONV_STD_LOGIC_VECTOR(1023, 10);
			--overwrite "u lose" on the screen
			if (Ldisplay='1' or Odisplay='1' or Sdisplay='1' or Edisplay='1'or Udisplay='1') then 
					Green<=CONV_STD_LOGIC_VECTOR(0, 10);
					Red<= CONV_STD_LOGIC_VECTOR(0, 10);
					Blue<= CONV_STD_LOGIC_VECTOR(0, 10);
			end if;
	  elsif(Anouncement='1')then --if there's intermission
	  Green<=CONV_STD_LOGIC_VECTOR(1023, 10);
      Red<= CONV_STD_LOGIC_VECTOR(1023, 10);
      Blue<= CONV_STD_LOGIC_VECTOR(1023, 10);
		if (LevelDisplay='1')then --display the level number
			Green<=CONV_STD_LOGIC_VECTOR(0, 10);
			Red<= CONV_STD_LOGIC_VECTOR(0, 10);
			Blue<= CONV_STD_LOGIC_VECTOR(0, 10);
		end if;
      
	
	  elsif (Ball_on = '1' and transparent1='0') then --if on the actual frog and the region should not be transparent
			  Red <= FrogRed_sig1 &"00";				--set rgb to the corresponding image pixel
			  Green <=FrogGreen_sig1  &"00";			--transparency will be handled by background
			  Blue <= FrogBlue_sig1 &"00"; 
			  
	  elsif (Ball_on2 = '1' and transparent2='0') then --similar for live frogs below
			  Red <= FrogRed_sig2 &"00";
			  Green <=FrogGreen_sig2  &"00";
			  Blue <= FrogBlue_sig2 &"00"; 			  
			  
	  elsif (Ball_on3 = '1' and transparent3='0') then
			  Red <= FrogRed_sig3 &"00";
			  Green <=FrogGreen_sig3  &"00";
			  Blue <= FrogBlue_sig3 &"00"; 			  
			  
	  elsif (Ball_on4 = '1' and transparent4='0') then
			  Red <= FrogRed_sig4 &"00";
			  Green <=FrogGreen_sig4  &"00";
			  Blue <= FrogBlue_sig4 &"00"; 
			  
  
      elsif (Car_on1 = '1') then -- draw car1
      Red <=   redcar1 &"00";
      Green <= greencar1 &"00";
      Blue <=  bluecar1 &"00";
      
       elsif (Car_on2 = '1') then -- draw car2
      Red <=   redcar2 &"00";
      Green <= greencar2 &"00";
      Blue <=  bluecar2 &"00";
      
            elsif (Car_on3 = '1') then -- draw car3
      Red <=   redcar3 &"00";
      Green <= greencar3 &"00";
      Blue <=  bluecar3 &"00";
      
            elsif (Car_on4 = '1') then -- draw car4
      
      Red <=   redcar4 &"00";
      Green <= greencar4 &"00";
      Blue <=  bluecar4 &"00";     
      
            elsif (Car_on5 = '1') then -- draw car5
      
      Red <=   redcar5 &"00";
      Green <= greencar5 &"00";
      Blue <=  bluecar5 &"00"; 

            elsif (Car_on6 = '1') then -- draw car6
      
      Red <=   redcar6 &"00";
      Green <= greencar6 &"00";
      Blue <=  bluecar6 &"00"; 

            elsif (Car_on7 = '1') then -- draw car7
      
      Red <=   redcar7 &"00";
      Green <= greencar7 &"00";
      Blue <=  bluecar7 &"00"; 

      
      elsif (Car_on8 = '1') then -- draw car8
      
      Red <=   redcar8 &"00";
      Green <= greencar8 &"00";
      Blue <=  bluecar8 &"00"; 
      
      
           elsif (Car_on9 = '1') then -- draw car9
      
      Red <=   redcar9 &"00";
      Green <= greencar9 &"00";
      Blue <=  bluecar9 &"00"; 
      
           elsif (Car_on10 = '1') then -- draw car10
      
      Red <=   redcar10 &"00";
      Green <= greencar10 &"00";
      Blue <=  bluecar10 &"00"; 
      
           elsif (Car_on11 = '1') then -- draw car11
      
      Red <=   redcar11 &"00";
      Green <= greencar11 &"00";
      Blue <=  bluecar11 &"00"; 
      
           elsif (Car_on12 = '1') then -- draw car12
      
      Red <=   redcar12 &"00";
      Green <= greencar12 &"00";
      Blue <=  bluecar12 &"00"; 
      
           elsif (Car_on13 = '1') then -- draw car13
      
      Red <=   redcar13 &"00";
      Green <= greencar13 &"00";
      Blue <=  bluecar13 &"00"; 
      
           elsif (Car_on14 = '1') then -- draw car14
      
      Red <=   redcar14 &"00";
      Green <= greencar14 &"00";
      Blue <=  bluecar14 &"00"; 
            
              elsif (Car_on15 = '1') then -- draw car15
      
      Red <=   redcar15 &"00";
      Green <= greencar15 &"00";
      Blue <=  bluecar15 &"00"; 
      
     
      elsif (log_on = '1') then -- draw log
      Red <=   "0010010110";
      Green <= "0000110010";
      Blue <=  "0000110010";
      elsif(Num_On='1') then -- draw number
	  Red <=   "0010010110";
      Green <= "1000110010";
      Blue <=  "0010010110";


    else          --  background drawing
      Green<=CONV_STD_LOGIC_VECTOR(0, 10);
      Red<= CONV_STD_LOGIC_VECTOR(0, 10);
      Blue<= CONV_STD_LOGIC_VECTOR(0, 10);	
      
      
      if (DrawY<CONV_STD_LOGIC_VECTOR(480, 10) and DrawY>CONV_STD_LOGIC_VECTOR(440, 10)) then
      Green<=CONV_STD_LOGIC_VECTOR(512, 10);
      Red<= CONV_STD_LOGIC_VECTOR(0, 10);
      Blue<= CONV_STD_LOGIC_VECTOR(0, 10);			---First row of Green Grass
      end if;

      if (DrawY<=CONV_STD_LOGIC_VECTOR(440, 10) and DrawY>CONV_STD_LOGIC_VECTOR(280, 10)) then
      Green<=CONV_STD_LOGIC_VECTOR(0, 10);
      Red<= CONV_STD_LOGIC_VECTOR(0, 10);
      Blue<= CONV_STD_LOGIC_VECTOR(0, 10);			---Black Road
      
                  if (
		   (DrawY<=CONV_STD_LOGIC_VECTOR(323, 10) and DrawY>CONV_STD_LOGIC_VECTOR(318, 10)) and
		   (
		   (DrawX<CONV_STD_LOGIC_VECTOR(20, 10) and DrawX>CONV_STD_LOGIC_VECTOR(0, 10)) or
		   (DrawX<CONV_STD_LOGIC_VECTOR(80, 10) and DrawX>CONV_STD_LOGIC_VECTOR(60, 10)) or
		   (DrawX<CONV_STD_LOGIC_VECTOR(140, 10) and DrawX>CONV_STD_LOGIC_VECTOR(120, 10)) or
		   (DrawX<CONV_STD_LOGIC_VECTOR(200, 10) and DrawX>CONV_STD_LOGIC_VECTOR(180, 10)) or
		   (DrawX<CONV_STD_LOGIC_VECTOR(260, 10) and DrawX>CONV_STD_LOGIC_VECTOR(240, 10)) or
		   (DrawX<CONV_STD_LOGIC_VECTOR(320, 10) and DrawX>CONV_STD_LOGIC_VECTOR(300, 10)) or
		   (DrawX<CONV_STD_LOGIC_VECTOR(380, 10) and DrawX>CONV_STD_LOGIC_VECTOR(360, 10)) or
		   (DrawX<CONV_STD_LOGIC_VECTOR(440, 10) and DrawX>CONV_STD_LOGIC_VECTOR(420, 10)) or
		   (DrawX<CONV_STD_LOGIC_VECTOR(500, 10) and DrawX>CONV_STD_LOGIC_VECTOR(480, 10)) or
		   (DrawX<CONV_STD_LOGIC_VECTOR(560, 10) and DrawX>CONV_STD_LOGIC_VECTOR(540, 10)) or
		   (DrawX<CONV_STD_LOGIC_VECTOR(620, 10) and DrawX>CONV_STD_LOGIC_VECTOR(600, 10)) or
		   (DrawX<CONV_STD_LOGIC_VECTOR(680, 10) and DrawX>CONV_STD_LOGIC_VECTOR(660, 10)) or
		   (DrawX<CONV_STD_LOGIC_VECTOR(740, 10) and DrawX>CONV_STD_LOGIC_VECTOR(720, 10))		   
		   )																
		 ) then
      Red <=   "1111111111";
      Green <= "1111111111";
      Blue <=  "0000000000";
      end if;           
								-----Draw the lines on the street

      if (
		   (DrawY<=CONV_STD_LOGIC_VECTOR(363, 10) and DrawY>CONV_STD_LOGIC_VECTOR(358, 10)) and
		   (
		   (DrawX<CONV_STD_LOGIC_VECTOR(20, 10) and DrawX>CONV_STD_LOGIC_VECTOR(0, 10)) or
		   (DrawX<CONV_STD_LOGIC_VECTOR(80, 10) and DrawX>CONV_STD_LOGIC_VECTOR(60, 10)) or
		   (DrawX<CONV_STD_LOGIC_VECTOR(140, 10) and DrawX>CONV_STD_LOGIC_VECTOR(120, 10)) or
		   (DrawX<CONV_STD_LOGIC_VECTOR(200, 10) and DrawX>CONV_STD_LOGIC_VECTOR(180, 10)) or
		   (DrawX<CONV_STD_LOGIC_VECTOR(260, 10) and DrawX>CONV_STD_LOGIC_VECTOR(240, 10)) or
		   (DrawX<CONV_STD_LOGIC_VECTOR(320, 10) and DrawX>CONV_STD_LOGIC_VECTOR(300, 10)) or
		   (DrawX<CONV_STD_LOGIC_VECTOR(380, 10) and DrawX>CONV_STD_LOGIC_VECTOR(360, 10)) or
		   (DrawX<CONV_STD_LOGIC_VECTOR(440, 10) and DrawX>CONV_STD_LOGIC_VECTOR(420, 10)) or
		   (DrawX<CONV_STD_LOGIC_VECTOR(500, 10) and DrawX>CONV_STD_LOGIC_VECTOR(480, 10)) or
		   (DrawX<CONV_STD_LOGIC_VECTOR(560, 10) and DrawX>CONV_STD_LOGIC_VECTOR(540, 10)) or
		   (DrawX<CONV_STD_LOGIC_VECTOR(620, 10) and DrawX>CONV_STD_LOGIC_VECTOR(600, 10)) or
		   (DrawX<CONV_STD_LOGIC_VECTOR(680, 10) and DrawX>CONV_STD_LOGIC_VECTOR(660, 10)) or
		   (DrawX<CONV_STD_LOGIC_VECTOR(740, 10) and DrawX>CONV_STD_LOGIC_VECTOR(720, 10))		   
		   )																
		 ) then
      Red <=   "1111111111";
      Green <= "1111111111";
      Blue <=  "0000000000";
      end if;           
								-----Draw the lines on the street
      
     if (
		   (DrawY<=CONV_STD_LOGIC_VECTOR(403, 10) and DrawY>CONV_STD_LOGIC_VECTOR(398, 10)) and
		   (
		   (DrawX<CONV_STD_LOGIC_VECTOR(20, 10) and DrawX>CONV_STD_LOGIC_VECTOR(0, 10)) or
		   (DrawX<CONV_STD_LOGIC_VECTOR(80, 10) and DrawX>CONV_STD_LOGIC_VECTOR(60, 10)) or
		   (DrawX<CONV_STD_LOGIC_VECTOR(140, 10) and DrawX>CONV_STD_LOGIC_VECTOR(120, 10)) or
		   (DrawX<CONV_STD_LOGIC_VECTOR(200, 10) and DrawX>CONV_STD_LOGIC_VECTOR(180, 10)) or
		   (DrawX<CONV_STD_LOGIC_VECTOR(260, 10) and DrawX>CONV_STD_LOGIC_VECTOR(240, 10)) or
		   (DrawX<CONV_STD_LOGIC_VECTOR(320, 10) and DrawX>CONV_STD_LOGIC_VECTOR(300, 10)) or
		   (DrawX<CONV_STD_LOGIC_VECTOR(380, 10) and DrawX>CONV_STD_LOGIC_VECTOR(360, 10)) or
		   (DrawX<CONV_STD_LOGIC_VECTOR(440, 10) and DrawX>CONV_STD_LOGIC_VECTOR(420, 10)) or
		   (DrawX<CONV_STD_LOGIC_VECTOR(500, 10) and DrawX>CONV_STD_LOGIC_VECTOR(480, 10)) or
		   (DrawX<CONV_STD_LOGIC_VECTOR(560, 10) and DrawX>CONV_STD_LOGIC_VECTOR(540, 10)) or
		   (DrawX<CONV_STD_LOGIC_VECTOR(620, 10) and DrawX>CONV_STD_LOGIC_VECTOR(600, 10)) or
		   (DrawX<CONV_STD_LOGIC_VECTOR(680, 10) and DrawX>CONV_STD_LOGIC_VECTOR(660, 10)) or
		   (DrawX<CONV_STD_LOGIC_VECTOR(740, 10) and DrawX>CONV_STD_LOGIC_VECTOR(720, 10))		   
		   )																
		 ) then
      Red <=   "1111111111";
      Green <= "1111111111";
      Blue <=  "0000000000";
      end if;           
								-----Draw the lines on the street

      end if; 
      
      if (DrawY<=CONV_STD_LOGIC_VECTOR(280, 10) and DrawY>CONV_STD_LOGIC_VECTOR(240, 10)) then
      Green<=CONV_STD_LOGIC_VECTOR(512, 10);
      Red<= CONV_STD_LOGIC_VECTOR(0, 10);
      Blue<= CONV_STD_LOGIC_VECTOR(0, 10);				---Second row of green grass
      end if;      
	
	  if (DrawY<=CONV_STD_LOGIC_VECTOR(240, 10) and DrawY>CONV_STD_LOGIC_VECTOR(80, 10)) then
      Green<=CONV_STD_LOGIC_VECTOR(0, 10);
      Red<= CONV_STD_LOGIC_VECTOR(0, 10);
      Blue<= CONV_STD_LOGIC_VECTOR(800, 10);			---Blue water
      end if;    
      
	  if (DrawY<=CONV_STD_LOGIC_VECTOR(80, 10) and DrawY>CONV_STD_LOGIC_VECTOR(40, 10) and 
		DrawX<CONV_STD_LOGIC_VECTOR(80, 10) and DrawX>CONV_STD_LOGIC_VECTOR(40, 10)) then
						
						
			if ( finished_terminal(3)/='1') then -- if t1 is finished
			Green<=CONV_STD_LOGIC_VECTOR(1023, 10);
			Red<= CONV_STD_LOGIC_VECTOR(1023, 10);
			Blue<= CONV_STD_LOGIC_VECTOR(1023, 10);			---Win Teriminal 1
			else
			Green<=CONV_STD_LOGIC_VECTOR(1023, 10);
			Red<= CONV_STD_LOGIC_VECTOR(0, 10);
			Blue<= CONV_STD_LOGIC_VECTOR(0, 10);			---Win Teriminal 1
			end if;					
			end if;
		
			if (DrawY<=CONV_STD_LOGIC_VECTOR(80, 10) and DrawY>CONV_STD_LOGIC_VECTOR(40, 10) and 
				DrawX<CONV_STD_LOGIC_VECTOR(240, 10) and DrawX>CONV_STD_LOGIC_VECTOR(200, 10)) then
									
						if ( finished_terminal(2)/='1') then -- if t2 is finished
						Green<=CONV_STD_LOGIC_VECTOR(1023, 10);
						Red<= CONV_STD_LOGIC_VECTOR(1023, 10);
						Blue<= CONV_STD_LOGIC_VECTOR(1023, 10);
						else
						Green<=CONV_STD_LOGIC_VECTOR(1023, 10);
						Red<= CONV_STD_LOGIC_VECTOR(0, 10);
						Blue<= CONV_STD_LOGIC_VECTOR(0, 10); --Win Teriminal 2
						end if;	
			end if;											
		
			if (DrawY<=CONV_STD_LOGIC_VECTOR(80, 10) and DrawY>CONV_STD_LOGIC_VECTOR(40, 10)and 
				DrawX<CONV_STD_LOGIC_VECTOR(400, 10) and DrawX>CONV_STD_LOGIC_VECTOR(360, 10)) then
						if ( finished_terminal(1)/='1') then -- if t3 is finished
						Green<=CONV_STD_LOGIC_VECTOR(1023, 10);
						Red<= CONV_STD_LOGIC_VECTOR(1023, 10);
						Blue<= CONV_STD_LOGIC_VECTOR(1023, 10);			---Win Teriminal 3
						else
						Green<=CONV_STD_LOGIC_VECTOR(1023, 10);
						Red<= CONV_STD_LOGIC_VECTOR(0, 10);
						Blue<= CONV_STD_LOGIC_VECTOR(0, 10);
		
						end if;		
			end if;
								
			if (DrawY<=CONV_STD_LOGIC_VECTOR(80, 10) and DrawY>CONV_STD_LOGIC_VECTOR(40, 10)and 
				DrawX<CONV_STD_LOGIC_VECTOR(560, 10) and DrawX>CONV_STD_LOGIC_VECTOR(520, 10)) then
						if ( finished_terminal(0)/='1') then -- if t4 is finished
						Green<=CONV_STD_LOGIC_VECTOR(1023, 10);
						Red<= CONV_STD_LOGIC_VECTOR(1023, 10);
						Blue<= CONV_STD_LOGIC_VECTOR(1023, 10);			---Win Teriminal 4
						else
						Green<=CONV_STD_LOGIC_VECTOR(1023, 10);
						Red<= CONV_STD_LOGIC_VECTOR(0, 10);
						Blue<= CONV_STD_LOGIC_VECTOR(0, 10);
						end if;	
			end if; 
      end if;  
      
      
      
      
      
      
      
      

		
  end process RGB_Display;

end Behavioral;