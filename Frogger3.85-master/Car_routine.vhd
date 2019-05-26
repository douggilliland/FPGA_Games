
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

entity Car_routine is
   Port ( 
        Reset : in std_logic;
        frame_clk : in std_logic;
        Speed: in std_logic_vector(9 downto 0);
        carX : out std_logic_vector(29 downto 0);
        carY : out std_logic_vector(9 downto 0));
end Car_routine;

architecture Behavioral of Car_routine is

signal car_X_pos, car_X_motion, car_Y_pos, car_Y_motion : std_logic_vector(9 downto 0);
signal car2_X_pos, car2_X_motion : std_logic_vector(9 downto 0);
signal car3_X_pos, car3_X_motion : std_logic_vector(9 downto 0);

signal car_Size : std_logic_vector(9 downto 0);
--signal frame_clk_div : std_logic_vector(5 downto 0);

constant car_X_start : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(20, 10);  --start position on the X axis
constant car2_X_start : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(220, 10);  --start position on the X axis
constant car3_X_start : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(450, 10);  --start position on the X axis


constant car_Y_start : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(420, 10);  --start position on the Y axis                             
--constant car_X_Step   : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(1, 10);  --Step size on the X axis
signal car_X_Step : std_logic_vector(9 downto 0);

begin
  car_Size <= CONV_STD_LOGIC_VECTOR(20, 10); -- assigns the value 4 as a 10-digit binary number, ie "0000000100"
car_X_Step<=Speed;
-------------------------------------------------


  Move_car: process(Reset, frame_clk, car_Size,car_X_motion,car_Y_motion)
  begin
    if(Reset = '1') then   --Asynchronous Reset
      car_X_Motion <= CONV_STD_LOGIC_VECTOR(0, 10);
      car_Y_Motion <= CONV_STD_LOGIC_VECTOR(0, 10);
      car_X_pos <= car_X_start;
      car_Y_Pos <= car_Y_start;
      
      car2_X_Motion <= CONV_STD_LOGIC_VECTOR(0, 10);
      car2_X_pos <= car2_X_start;
     
      car3_X_Motion <= CONV_STD_LOGIC_VECTOR(0, 10);
      car3_X_pos <= car3_X_start;
      
    elsif(rising_edge(frame_clk)) then--moving cars	
					car_X_pos <= car_X_pos + car_X_Step;				
					car2_X_pos <= car2_X_pos + car_X_Step;					
					car3_X_pos <= car3_X_pos + car_X_Step;
					
					car_Y_Pos <= car_Y_start;
					
				if 	(car_X_pos=CONV_STD_LOGIC_VECTOR(700, 10) ) then  --reset car if it gets the edge of the screen
						car_X_pos<=CONV_STD_LOGIC_VECTOR(1000,10);
				end if;
					
					
				if 	(car2_X_pos=CONV_STD_LOGIC_VECTOR(700, 10) ) then
						car2_X_pos<=CONV_STD_LOGIC_VECTOR(1000,10);
				end if;
				
				if 	(car3_X_pos=CONV_STD_LOGIC_VECTOR(700, 10) ) then
						car3_X_pos<=CONV_STD_LOGIC_VECTOR(1000,10);
				end if;
  	
	end if; 
   
  end process Move_car;

  carX <= car_X_Pos & car2_X_pos & car3_X_pos;
  carY <= car_Y_Pos;
--  carS <= car_Size;
 
end Behavioral;      
