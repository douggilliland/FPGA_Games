library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;
-- Alex Grinshpun July 24 2017 
-- Dudy Nov 13 2017


entity back_ground_draw is
port 	(
		
	   CLK      : in std_logic;
		RESETn	: in std_logic;
		oCoord_X : in integer;
		oCoord_Y : in integer;
		mVGA_RGB	: out std_logic_vector(7 downto 0) --	,//	VGA composite RGB
	);
end back_ground_draw;

architecture behav of back_ground_draw is 

-- Constants for frame drawing
constant	x_frame	: integer :=	639;
constant	y_frame	: integer :=	479;
constant	int_frame	: integer :=	10;

signal mVGA_R	: std_logic_vector(2 downto 0); --	,	 			//	VGA Red[2:0]
signal mVGA_G	: std_logic_vector(2 downto 0); --	,	 			//	VGA Green[2:0]
signal mVGA_B	: std_logic_vector(1 downto 0); --	,  			//	VGA Blue[1:0]
	
begin

mVGA_RGB <=  mVGA_R & mVGA_G &  mVGA_B ;
-- defining three rectangles 

process ( oCoord_X,oCoord_y )
begin 

	if (oCoord_X = 0 or oCoord_y = 0  or oCoord_X = x_frame or oCoord_y = y_frame) then 
			mVGA_R <= "111" ;	
			mVGA_G <= "111"  ;	
			mVGA_B <= "00" ;	 
	
	else if (oCoord_X = int_frame or oCoord_y = int_frame or oCoord_X = x_frame-int_frame or oCoord_y = y_frame-int_frame) then 
			mVGA_R <= "111" ;	
			mVGA_G <= "111"  ;	
			mVGA_B <= "11" ;	 
		else 
			  if (oCoord_X > 156 and oCoord_y >= 256 ) then  mVGA_R <= "111" ; else mVGA_R <= "010" ; end if ; 	
			  if (oCoord_X <  220 and oCoord_Y < 350 ) then  mVGA_G <= "011" ; else mVGA_G <= "110" ; end if ; 	
			  if (oCoord_X <  300 and oCoord_Y < 200 ) then  mVGA_B <= "10"  ; else mVGA_B <= "00";	 end if ;
			  if (oCoord_X < 50 and oCoord_Y < 70) then mVGA_R <= "000"; mVGA_G <= "000"; mVGA_B <= "11"; end if; 
		
		end if ; 
	end if ; 

end process ; 

		
end behav;		