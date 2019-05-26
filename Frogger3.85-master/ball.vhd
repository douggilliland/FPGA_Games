---------------------------------------------------------------------------
--    Ball.vhd                                                           --
--    Viral Mehta                                                        --
--    Spring 2005                                                        --
--                                                                       --
--    Modified by Stephen Kempf 03-01-2006                               --
--                              03-12-2007                               --
--    Fall 2008 Distribution                                           --
--                                                                       --
--    For use with ECE 385 Lab 9                                         --
--    UIUC ECE Department                                                --
---------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ball is
  Port (
       Reset : in std_logic;
       frame_clk : in std_logic;
       CountOver : in std_logic;
       keyin: in std_logic_vector(2 downto 0);
       finished_terminal: out std_logic_vector(3 downto 0);
       BallX: out std_logic_vector(9 downto 0); --ball parameters
       BallS : out std_logic_vector(9 downto 0);
       
       CarROWONEX : out std_logic_vector(29 downto 0); 

       CarROWTWOX: out std_logic_vector(49 downto 0); 
       CarROWTHREEX: out std_logic_vector (39 downto 0); 
       CarROWFOURX:  out std_logic_vector (29 downto 0); 
       BallY, CarROWONEY, CarROWTWOY, CarROWTHREEY, CarROWFOURY : out std_logic_vector(9 downto 0); --car parameters

       
       log1X  : out std_logic_vector(29 downto 0);
       log1Y  : out std_logic_vector(9 downto 0); --First row of log parameters
             
       log2X : out std_logic_vector(39 downto 0); 
       log2Y : out std_logic_vector(9 downto 0); --log2 parameters    
       
       
       log3X,log4X : out std_logic_vector(19 downto 0); --log3 parameters  
       log3Y : out std_logic_vector(9 downto 0); --log3 parameters  
       log4Y : out std_logic_vector(9 downto 0); --log3 parameters  
       
       Min1,Min0,Sec1,Sec0: out std_logic_vector(3 downto 0); --starting time set up
       
       levelout: out std_logic_vector(1 downto 0);
       Anouncement: out std_logic;
       lives :	out std_logic_vector(1 downto 0); 
       fail, win : out std_logic);
end ball;

architecture Behavioral of ball is

signal Ball_X_pos, Ball_X_motion, Ball_Y_pos, Ball_Y_motion: std_logic_vector(9 downto 0);
signal Ball_Size, Car_Size : std_logic_vector(9 downto 0);


constant Ball_X_Center : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(320, 10);  --Center position on the X axis
constant Ball_Y_Center : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(240, 10);  --Center position on the Y axis

constant Ball_X_Min    : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(0, 10);  --Leftmost point on the X axis
constant Ball_X_Max    : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(639, 10);  --Rightmost point on the X axis
constant Ball_Y_Min    : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(0, 10);   --Topmost point on the Y axis
constant Ball_Y_Max    : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(479, 10);  --Bottommost point on the Y axis
                             
constant Ball_X_Step   : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(40, 10);  --Step size on the X axis
constant Ball_Y_Step   : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(40, 10);  --Step size on the Y axis


constant TXstart :     std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(300, 10);   --x value of starting position
constant TYstart :    std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(460, 10);   --y value of starting position

constant T1X    :     std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(60, 10);   --x value of terminal 1
constant T2X    :    std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(220, 10);  --x value of terminal 2
constant T3X    :    std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(380, 10);  --x value of terminal 3
constant T4X    :    std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(540, 10);  --x value of terminal 4

constant TY        :    std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(60, 10);   --y value of all terminals

component Car_routine is
    Port (  Reset : in std_logic;
        frame_clk : in std_logic;
        Speed: in std_logic_vector(9 downto 0);
        carX : out std_logic_vector(29 downto 0);
        carY : out std_logic_vector(9 downto 0));
end component;

component CarROWTWO_routine is
   Port ( 
        Reset : in std_logic;
        frame_clk : in std_logic;
        Speed: in std_logic_vector(9 downto 0);
        carX : out std_logic_vector(49 downto 0);
        carY : out std_logic_vector(9 downto 0));
end component;

component CarRowThree_routine is
   Port ( 
        Reset : in std_logic;
        frame_clk : in std_logic;
        Speed: in std_logic_vector(9 downto 0);
        carX : out std_logic_vector(39 downto 0);
        carY : out std_logic_vector(9 downto 0));
end component;

component CarRowFour_Routine is
   Port ( 
        Reset : in std_logic;
        frame_clk : in std_logic;
        Speed: in std_logic_vector(9 downto 0);
        carX : out std_logic_vector(29 downto 0);
        carY : out std_logic_vector(9 downto 0));
end component;





--log

component log_routine is
    Port (  Reset : in std_logic;
        frame_clk : in std_logic;
        CounterPeriod: in std_logic_vector(9 downto 0);
        logX : out std_logic_vector(29 downto 0);
        logY : out std_logic_vector(9 downto 0));
end component;

component log2_routine is
    Port (  Reset : in std_logic;
        frame_clk : in std_logic;
        CounterPeriod: in std_logic_vector(9 downto 0);
        logX : out std_logic_vector(39 downto 0);
        logY : out std_logic_vector(9 downto 0));
end component;

component log3_routine is
    Port (  Reset : in std_logic;
        frame_clk : in std_logic;
        CounterPeriod: in std_logic_vector(9 downto 0);
        logX : out std_logic_vector(19 downto 0);
        logY : out std_logic_vector(9 downto 0));
end component;

component log4_routine is
    Port (  Reset : in std_logic;
        frame_clk : in std_logic;
        CounterPeriod: in std_logic_vector(9 downto 0);
        logX : out std_logic_vector(19 downto 0);
        logY : out std_logic_vector(9 downto 0));
end component;



signal  log1_X_pos	: std_logic_vector(29 downto 0);
signal	log1_Y_pos,log1_Size : std_logic_vector (9 downto 0);
		

signal log2_X_pos : std_logic_vector( 39 downto 0); 
signal log2_Y_pos,log2_Size  : std_logic_vector (9 downto 0);

signal log3_X_pos,log4_X_pos: std_logic_vector (19 downto 0);
signal log3_Y_pos,log3_Size  : std_logic_vector (9 downto 0);

signal log4_Y_pos,log4_Size  : std_logic_vector (9 downto 0);

signal is_on_log11, is_on_log12, is_on_log13: std_logic; 


signal is_on_log21, is_on_log22, is_on_log23, is_on_log24 : std_logic;

signal is_on_log3,is_on_log4: std_logic;

signal CarROWONE_X_pos  : std_logic_vector (29 downto 0);
signal CarROWONE_Y_pos  : std_logic_vector (9 downto 0);

signal CarROWTWO_X_pos  : std_logic_vector (49 downto 0);
signal CarROWTWO_Y_pos  : std_logic_vector (9 downto 0);

signal CarROWTHREE_X_POS: std_logic_vector (39 downto 0);
signal CarROWTHREE_Y_POS: std_logic_vector (9 downto 0); 

signal CarROWFOUR_X_POS: std_logic_vector (29 downto 0);
signal CarRowFour_Y_POS: std_logic_vector (9 downto 0); 

signal loser, winner,t1done,t2done,t3done,t4done : std_logic;

signal liveSig,level : std_logic_vector(1 downto 0);

signal SpeedSig1,SpeedSig2,SpeedSig3,SpeedSig4 : std_logic_vector(9 downto 0);
signal PeriodSig1,PeriodSig2,PeriodSig3,PeriodSig4 :std_logic_vector(9 downto 0);


signal AnnounceSig: std_logic;
signal AnnounceCount: std_logic_vector(9 downto 0);


begin

Car_instance : Car_routine
   Port map(Reset=> Reset,
        frame_clk=>frame_clk,
        Speed=>SpeedSig1,
        carX=> CarROWONE_X_pos, 
        carY=> CarROWONE_Y_pos  );
        
Car_instance2 : CarROWTWO_routine
   Port map(Reset=> Reset,
        frame_clk=>frame_clk,
        Speed=>SpeedSig2,
        carX=> CarROWTWO_X_pos, 
        carY=> CarROWTWO_Y_pos  );        
        
Car_instance3 : CarRowThree_routine
   Port map(Reset=> Reset,
        frame_clk=>frame_clk,
        Speed=>SpeedSig3,
        carX=> CarROWTHREE_X_POS, 
        carY=> CarROWTHREE_Y_POS  );        
        
Car_instance4 : CarRowFour_Routine
   Port map(Reset=> Reset,
        frame_clk=>frame_clk,
        Speed=>SpeedSig4,
        carX=> CarROWFOUR_X_POS, 
        carY=> CarROWFOUR_Y_POS  );      
        
        
log1_instance : log_routine
   Port map(Reset=> Reset,
        frame_clk=>frame_clk,
        CounterPeriod=>PeriodSig1,
        logX=> log1_X_pos, 
        logY=> log1_Y_pos  );
        
log2_instance : log2_routine
   Port map(Reset=> Reset,
        frame_clk=>frame_clk,
        CounterPeriod=>PeriodSig2,
        logX=> log2_X_pos, 
        logY=> log2_Y_pos );
        
log3_instance : log3_routine
   Port map(Reset=> Reset,
        frame_clk=>frame_clk,
        CounterPeriod=>PeriodSig3,
        logX=> log3_X_pos, 
        logY=> log3_Y_pos );
        
log4_instance : log4_routine
   Port map(Reset=> Reset,
        frame_clk=>frame_clk,
        CounterPeriod=>PeriodSig4,
        logX=> log4_X_pos, 
        logY=> log4_Y_pos );




 Ball_Size <= CONV_STD_LOGIC_VECTOR(20, 10); -- assigns the value 4 as a 10-digit binary number, ie "0000000100"
 Car_Size <= CONV_STD_LOGIC_VECTOR(20, 10);
 Log1_Size <= CONV_STD_LOGIC_VECTOR(20, 10);
 Log2_Size <= CONV_STD_LOGIC_VECTOR(20, 10);
 Log3_Size <= CONV_STD_LOGIC_VECTOR(20, 10);
 Log4_Size <= CONV_STD_LOGIC_VECTOR(20, 10);
-------------------------------------------------



 Move_Ball: process(Reset, frame_clk, Ball_Size, keyin,Ball_X_motion,Ball_Y_motion,CountOver)
 begin
	
is_on_log11<='0';
is_on_log12<='0';
is_on_log13<='0';


is_on_log21<='0';
is_on_log22<='0';
is_on_log23<='0';
is_on_log24<='0';


is_on_log3<='0';
is_on_log4<='0';

   if(Reset = '1') then   --Asynchronous Reset
     Ball_Y_Motion <= CONV_STD_LOGIC_VECTOR(0, 10);
     Ball_X_Motion <= CONV_STD_LOGIC_VECTOR(0, 10);
     Ball_Y_Pos <= TYstart;
     Ball_X_pos <= TXstart;
     t1done<='0';
     t2done<='0';
     t3done<='0';
     t4done<='0';
     loser <='0';
     liveSig <="11";
     AnnounceSig<='1'; 
     AnnounceCount<=CONV_STD_LOGIC_VECTOR(0, 10);
     winner <='0';
     
     level<="01";
     SpeedSig1<= CONV_STD_LOGIC_VECTOR(1, 10);

     
     

   elsif(rising_edge(frame_clk)) then   
   
				if(AnnounceSig='1')then					--if it is announcing now, starting counting the time
					AnnounceCount<=AnnounceCount+'1';
					if (AnnounceCount=CONV_STD_LOGIC_VECTOR(200, 10))then --if it finishes counts to 200, quit intermission, reset counter
						AnnounceSig<='0';								
						AnnounceCount<=CONV_STD_LOGIC_VECTOR(0, 10);
					end if;
				else
					AnnounceCount<=CONV_STD_LOGIC_VECTOR(0, 10);
				end if;
				
				--setting up difficulties for each level with parameters of car speed and log moving period
				if (level="01") then
					SpeedSig1<= CONV_STD_LOGIC_VECTOR(2, 10);
					SpeedSig2<= CONV_STD_LOGIC_VECTOR(1, 10);
					SpeedSig3<= CONV_STD_LOGIC_VECTOR(1, 10);
					SpeedSig4<= CONV_STD_LOGIC_VECTOR(1, 10);
					PeriodSig1<=CONV_STD_LOGIC_VECTOR(50, 10);
					PeriodSig2<=CONV_STD_LOGIC_VECTOR(100, 10);
					PeriodSig3<=CONV_STD_LOGIC_VECTOR(75, 10);
					PeriodSig4<=CONV_STD_LOGIC_VECTOR(125, 10);
				elsif (level="10") then
					SpeedSig1<= CONV_STD_LOGIC_VECTOR(4, 10);
					SpeedSig2<= CONV_STD_LOGIC_VECTOR(1, 10);
					SpeedSig3<= CONV_STD_LOGIC_VECTOR(2, 10);
					SpeedSig4<= CONV_STD_LOGIC_VECTOR(4, 10);
					PeriodSig1<=CONV_STD_LOGIC_VECTOR(35, 10);
					PeriodSig2<=CONV_STD_LOGIC_VECTOR(70, 10);
					PeriodSig3<=CONV_STD_LOGIC_VECTOR(55, 10);
					PeriodSig4<=CONV_STD_LOGIC_VECTOR(80, 10);
				elsif (level="11") then
					SpeedSig1<= CONV_STD_LOGIC_VECTOR(5, 10);
					SpeedSig2<= CONV_STD_LOGIC_VECTOR(3, 10);
					SpeedSig3<= CONV_STD_LOGIC_VECTOR(4, 10);
					SpeedSig4<= CONV_STD_LOGIC_VECTOR(6, 10);
					PeriodSig1<=CONV_STD_LOGIC_VECTOR(20, 10);
					PeriodSig2<=CONV_STD_LOGIC_VECTOR(30, 10);
					PeriodSig3<=CONV_STD_LOGIC_VECTOR(40, 10);
					PeriodSig4<=CONV_STD_LOGIC_VECTOR(45, 10);
				end if;
   
                Ball_X_motion <= CONV_STD_LOGIC_VECTOR(0, 10);
                Ball_Y_motion <=CONV_STD_LOGIC_VECTOR(0, 10);
     
     
				--response with keys
                if (keyin = "100") then --up
                    Ball_Y_motion <= not(Ball_Y_Step) + '1';
                    Ball_X_motion <=CONV_STD_LOGIC_VECTOR(0, 10);
                   
                elsif (keyin = "101") then --down
					Ball_Y_motion <= Ball_Y_Step;
					Ball_X_motion <=CONV_STD_LOGIC_VECTOR(0, 10);
                   
                elsif (keyin = "110") then  --left
                    Ball_X_motion <= not(Ball_X_Step) + '1';
                    Ball_Y_motion <=CONV_STD_LOGIC_VECTOR(0, 10);
                elsif (keyin = "111") then  --right
                    Ball_X_motion <= Ball_X_Step;
                    Ball_Y_motion <=CONV_STD_LOGIC_VECTOR(0, 10);
                end if;   
					
					if (Ball_Y_pos=CONV_STD_LOGIC_VECTOR(460, 10) and Ball_Y_Motion=Ball_Y_Step) then--cheat
						Ball_Y_pos<=CONV_STD_LOGIC_VECTOR(20, 10);
					else
						Ball_Y_pos <= Ball_Y_pos + Ball_Y_Motion; -- Update ball position
					end if;
				 Ball_X_pos <= Ball_X_pos + Ball_X_Motion;
   
--normal condition for 1st row of logs
--frog can hop on the log if their y postions are the same and x distances are within in the range
   if ( (Log1_Y_pos=Ball_Y_pos)		
			AND
			(Ball_X_pos >= Log1_X_pos(29 downto 20) - Log1_Size-Ball_Size) AND (Ball_X_pos <= Log1_X_pos(29 downto 20) + Log1_Size+Ball_Size)
		) then   
		   is_on_log11<='1';
		   
		   Ball_X_Motion<=Ball_X_Step;  
		   Ball_X_pos<= Log1_X_pos(29 downto 20);
		
	elsif ( (Log1_Y_pos=Ball_Y_pos)		
			AND
			(Ball_X_pos >= Log1_X_pos(19 downto 10) - Log1_Size-Ball_Size) AND (Ball_X_pos <= Log1_X_pos(19 downto 10) + Log1_Size+Ball_Size)
		) then   
		   is_on_log12<='1';
		   
		   Ball_X_Motion<=Ball_X_Step;  
	       Ball_X_pos<= Log1_X_pos(19 downto 10);
	   
	elsif ( (Log1_Y_pos=Ball_Y_pos)		
			AND
			(Ball_X_pos >= Log1_X_pos(9 downto 0) - Log1_Size-Ball_Size) AND (Ball_X_pos <= Log1_X_pos(9 downto 0) + Log1_Size+Ball_Size)
		) then   
		   is_on_log13<='1';
		   
		   Ball_X_Motion<=Ball_X_Step;  
	       Ball_X_pos<= Log1_X_pos(9 downto 0);
		   
--normal condition for 2nd row of logs		      
	elsif ( (Log2_Y_pos=Ball_Y_pos)		
			AND
			(Ball_X_pos >= Log2_X_pos(39 downto 30) - Log1_Size-Ball_Size) AND (Ball_X_pos <= Log2_X_pos(39 downto 30) + Log1_Size+Ball_Size)
		) then   
		   is_on_log21<='1';
		   
		   Ball_X_Motion<=Ball_X_Step;  
	       Ball_X_pos<= Log2_X_pos(39 downto 30);
		
	elsif ( (Log2_Y_pos=Ball_Y_pos)		
			AND
			(Ball_X_pos >= Log2_X_pos(29 downto 20) - Log1_Size-Ball_Size) AND (Ball_X_pos <= Log2_X_pos(29 downto 20) + Log1_Size+Ball_Size)
		) then   
		   is_on_log22<='1';
		   
		   Ball_X_Motion<=Ball_X_Step;  
	       Ball_X_pos<= Log2_X_pos(29 downto 20);
	   
	elsif ( (Log2_Y_pos=Ball_Y_pos)		
			AND
			(Ball_X_pos >= Log2_X_pos(19 downto 10) - Log1_Size-Ball_Size) AND (Ball_X_pos <= Log2_X_pos(19 downto 10) + Log1_Size+Ball_Size)
		) then   
		   is_on_log23<='1';
		   
		   Ball_X_Motion<=Ball_X_Step;  
	       Ball_X_pos<= Log2_X_pos(19 downto 10);
	    
	elsif ( (Log2_Y_pos=Ball_Y_pos)		
			AND
			(Ball_X_pos >= Log2_X_pos(9 downto 0) - Log1_Size-Ball_Size) AND (Ball_X_pos <= Log2_X_pos(9 downto 0) + Log1_Size+Ball_Size)
		) then   
		   is_on_log24<='1';
		   
		   Ball_X_Motion<=Ball_X_Step;  
		   Ball_X_pos<= Log2_X_pos(9 downto 0);
			   
			   
--normal condition for 3rd row of logs				   
   elsif ( (Log3_Y_pos=Ball_Y_pos)
			AND
			(Ball_X_pos >= Log3_X_pos(19 downto 10) - Log3_Size-Ball_Size) AND (Ball_X_pos <= Log3_X_pos(19 downto 10) + Log3_Size+Ball_Size)
		) then   
		   is_on_log3<='1';		   
		   Ball_X_Motion<=not(Ball_X_Step) + '1';  
		   Ball_X_pos<= Log3_X_pos(19 downto 10);	
		   
    elsif ( (Log3_Y_pos=Ball_Y_pos)
			AND
			(Ball_X_pos >= Log3_X_pos(9 downto 0) - Log3_Size-Ball_Size) AND (Ball_X_pos <= Log3_X_pos(9 downto 0) + Log3_Size+Ball_Size)
		) then   
		   is_on_log3<='1';		   
		   Ball_X_Motion<=not(Ball_X_Step) + '1';  
		   Ball_X_pos<= Log3_X_pos(9 downto 0);			
		      	   
--normal condition for 4th row of logs			   	   
   elsif ( (Log4_Y_pos=Ball_Y_pos)
			AND
			(Ball_X_pos >= Log4_X_pos(19 downto 10) - Log4_Size-Ball_Size) AND (Ball_X_pos <= Log4_X_pos(19 downto 10) + Log4_Size+Ball_Size)
		) then   
		   is_on_log4<='1';		   
		   Ball_X_Motion<=not(Ball_X_Step) + '1';  
		   Ball_X_pos<= Log4_X_pos(19 downto 10);	
		   
		   
   elsif ( (Log4_Y_pos=Ball_Y_pos)
			AND
			(Ball_X_pos >= Log4_X_pos(9 downto 0) - Log4_Size-Ball_Size) AND (Ball_X_pos <= Log4_X_pos(9 downto 0) + Log4_Size+Ball_Size)
		) then   
		   is_on_log4<='1';		   
		   Ball_X_Motion<=not(Ball_X_Step) + '1';  
		   Ball_X_pos<= Log4_X_pos(9 downto 0);	
		   
	-- Losing condition   	   	   
   elsif ( 
   
			--losing condition for ball being in the river or forbidden region, and not in the terminals	
			( Ball_Y_pos=CONV_STD_LOGIC_VECTOR(220, 10) or --in the river
			Ball_Y_pos=CONV_STD_LOGIC_VECTOR(180, 10) or
			Ball_Y_pos=CONV_STD_LOGIC_VECTOR(140, 10) or
			Ball_Y_pos=CONV_STD_LOGIC_VECTOR(100, 10) or 
			( Ball_Y_pos=CONV_STD_LOGIC_VECTOR(60, 10) 
				and 
			 (Ball_X_pos /=T1X or Ball_X_pos /=T2X or Ball_X_pos /=T3X or Ball_X_pos /=T4X) --terminal level
			))			
			
			or 
			--ball going out of bound
			(
			( Ball_X_pos=CONV_STD_LOGIC_VECTOR(20, 10) and Ball_X_Motion= (not(Ball_X_Step) + '1') )
			or
			( Ball_X_pos=CONV_STD_LOGIC_VECTOR(620, 10) and Ball_X_Motion= Ball_X_Step )   
			)
			
			--lose when the frog is run over by 1st row vehicle
			or
			( 
				(
				  ((Ball_X_pos-CarROWONE_X_pos(29 downto 20) )<=(Ball_Size+Car_Size) 
				  or (CarROWONE_X_pos(29 downto 20)-Ball_X_pos)<=(Ball_Size+Car_Size))
				  or
				  ((Ball_X_pos-CarROWONE_X_pos(19 downto 10) )<=(Ball_Size+Car_Size) 
				  or (CarROWONE_X_pos(19 downto 10)-Ball_X_pos)<=(Ball_Size+Car_Size))
				  or
				  ((Ball_X_pos-CarROWONE_X_pos(9 downto 0) )<=(Ball_Size+Car_Size) 
				  or (CarROWONE_X_pos(9 downto 0)-Ball_X_pos)<=(Ball_Size+Car_Size))
				)			  
					and 
				(carROWONE_Y_pos=Ball_Y_pos)
			)
			or
			--lose when the frog is run over by 2nd row vehicle
			  ( 
				(
				
				((Ball_X_pos-CarROWTWO_X_pos(49 downto 40) )<=(Ball_Size+Car_Size) 
				  or (CarROWTWO_X_pos(49 downto 40)-Ball_X_pos)<=(Ball_Size+Car_Size))
				  or
				((Ball_X_pos-CarROWTWO_X_pos(39 downto 30) )<=(Ball_Size+Car_Size) 
				  or (CarROWTWO_X_pos(39 downto 30)-Ball_X_pos)<=(Ball_Size+Car_Size))
				  or
				  ((Ball_X_pos-CarROWTWO_X_pos(29 downto 20) )<=(Ball_Size+Car_Size) 
				  or (CarROWTWO_X_pos(29 downto 20)-Ball_X_pos)<=(Ball_Size+Car_Size))
				  or
				  ((Ball_X_pos-CarROWTWO_X_pos(19 downto 10) )<=(Ball_Size+Car_Size) 
				  or (CarROWTWO_X_pos(19 downto 10)-Ball_X_pos)<=(Ball_Size+Car_Size))
				  or
				  ((Ball_X_pos-CarROWTWO_X_pos(9 downto 0) )<=(Ball_Size+Car_Size) 
				  or (CarROWTWO_X_pos(9 downto 0)-Ball_X_pos)<=(Ball_Size+Car_Size))
				)			  
					and 
				(carROWTWO_Y_pos=Ball_Y_pos)
			)
			
			or
			--lose when the frog is run over by 3rd row vehicle
				( 
					(
					
					((Ball_X_pos-CarROWTHREE_X_pos(39 downto 30) )<=(Ball_Size+Car_Size) 
					  or (CarROWTHREE_X_pos(39 downto 30)-Ball_X_pos)<=(Ball_Size+Car_Size))
					  or
					((Ball_X_pos-CarROWTHREE_X_pos(29 downto 20) )<=(Ball_Size+Car_Size) 
					  or (CarROWTHREE_X_pos(29 downto 20)-Ball_X_pos)<=(Ball_Size+Car_Size))
					  or
					  ((Ball_X_pos-CarROWTHREE_X_pos(19 downto 10) )<=(Ball_Size+Car_Size) 
					  or (CarROWTHREE_X_pos(19 downto 10)-Ball_X_pos)<=(Ball_Size+Car_Size))
					  or
					  ((Ball_X_pos-CarROWTHREE_X_pos(9 downto 0) )<=(Ball_Size+Car_Size) 
					  or (CarROWTHREE_X_pos(9 downto 0)-Ball_X_pos)<=(Ball_Size+Car_Size))
					   )			  
						and 
					(carROWTHREE_Y_pos=Ball_Y_pos)
				)
			or
			--lose when the frog is run over by 4th row vehicle
			 ( 
				(
				  ((Ball_X_pos-CarROWFour_X_pos(29 downto 20) )<=(Ball_Size+Car_Size) 
				  or (CarROWFour_X_pos(29 downto 20)-Ball_X_pos)<=(Ball_Size+Car_Size))
				  or
				  ((Ball_X_pos-CarROWFour_X_pos(19 downto 10) )<=(Ball_Size+Car_Size) 
				  or (CarROWFour_X_pos(19 downto 10)-Ball_X_pos)<=(Ball_Size+Car_Size))
				  or
				  ((Ball_X_pos-CarROWFour_X_pos(9 downto 0) )<=(Ball_Size+Car_Size) 
				  or (CarROWFour_X_pos(9 downto 0)-Ball_X_pos)<=(Ball_Size+Car_Size))
				)			  
				and 
			(carROWFour_Y_pos=Ball_Y_pos)
			)
   
		) then
			if (liveSig="00") then --lose if there's no more liveSig
				loser<='1';
			else				--otherwise restart
				liveSig<=liveSig+"11";
				Ball_X_Pos<=TXstart;
				Ball_Y_Pos<=TYstart;
			end if;
   end if;
     
     if(CountOver='1')then
		loser<='1';
	 end if;
	 
	 
     
    
     
	 
	 --modified win condition for the log
	 --if the frog is right below the terminals, then the decrement of Y will result a terminal finish
	 if ((Ball_X_pos = T1X) and (Ball_Y_pos + Ball_Y_Motion=TY)) 
		then
		t1done<='1';
		Ball_X_Pos<=TXstart;
		Ball_Y_Pos<=TYstart;
		
	 elsif( (Ball_X_pos = T2X) and (Ball_Y_pos + Ball_Y_Motion=TY))  
		then
		t2done<='1';
		Ball_X_Pos<=TXstart;
		Ball_Y_Pos<=TYstart;
	 elsif( (Ball_X_pos = T3X) and (Ball_Y_pos + Ball_Y_Motion=TY))  
		then
		t3done<='1';	
		Ball_X_Pos<=TXstart;
		Ball_Y_Pos<=TYstart;	
	 elsif( (Ball_X_pos = T4X) and (Ball_Y_pos + Ball_Y_Motion=TY))  
		then
		t4done<='1';
		Ball_X_Pos<=TXstart;
		Ball_Y_Pos<=TYstart;			
	 end if;	 
	 
	 
	 if (t1done='1' and t2done='1' and t3done='1' and t4done='1')
	 then 
		if (level/="11") then --if not on level 3, increment the level, and reset terminals
		t1done<='0';
		t2done<='0';
		t3done<='0';
		t4done<='0';
		level<=level+'1';
		AnnounceSig<='1';
		else
		winner<='1'; -- if all of terminals and all 3 levels are done , then set win condition
		end if;
     end if;
      
   end if;
   
 
 end process Move_Ball;

 BallX <= Ball_X_Pos;
 BallY <= Ball_Y_Pos;
 BallS <= Ball_Size;
 win<=winner;
 fail<=loser;
 lives<=liveSig;
 finished_terminal <= t1done & t2done & t3done & t4done;

CarROWONEX   <= CarROWONE_X_pos;
CarROWONEY   <= CarROWONE_Y_pos;
CarROWTWOX   <= CarROWTWO_X_pos;
CarROWTWOY   <= CarROWTWO_Y_pos;
CarROWTHREEX <= CarROWTHREE_X_pos;
CarROWTHREEY <= CarROWTHREE_Y_Pos;
CarROWFOURX  <= CarROWFOUR_X_pos;
CARROWFOURY  <= CarROWFOUR_Y_pos; 

Min1<="0000"; --initialize counting time
Min0<="1001";
Sec1<="0011";
Sec0<="0000";

log1X <= Log1_X_pos;
log1Y <= Log1_Y_pos;
log2X <= Log2_X_pos;
log2Y <= Log2_Y_pos;
log3X <= Log3_X_pos;
log3Y <= Log3_Y_pos;
log4X <= Log4_X_pos;
log4Y <= Log4_Y_pos;
levelout<=level;
Anouncement <= AnnounceSig;
end Behavioral;      

