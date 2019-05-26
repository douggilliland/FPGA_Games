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
		random	: in std_logic_vector (1 downto 0);
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
	
	case random is
	when "00" => -- black
		mVGA_R <= "000";
		mVGA_G <= "000";		
		mVGA_B <= "00";
	when "01" => --light blue
		mVGA_R <= "000";
		mVGA_G <= "111";		
		mVGA_B <= "11";
	when "10" =>--kinda pink
		mVGA_R <= "111";
		mVGA_G <= "100";		
		mVGA_B <= "11";
	when "11" =>--yellow
		mVGA_R <= "111";
		mVGA_G <= "110";		
		mVGA_B <= "10";
	end case;
	

end process ; 

		
end behav;		