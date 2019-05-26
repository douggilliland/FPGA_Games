library IEEE;
use IEEE.STD_LOGIC_1164.all;
--use IEEE.std_logic_unsigned.all;
--use ieee.numeric_std.all;
--use ieee.std_logic_arith.all;
-- Alex Grinshpun April 2017
-- Dudy Nov 13 2017


entity souls  is
port 	(
		--////////////////////	Clock Input	 	////////////////////	
	   	CLK  		: in std_logic;
		RESETn		: in std_logic;
		oCoord_X	: in integer;
		oCoord_Y	: in integer;
		Bom : in std_logic ; 
		life : in std_logic ;
		cieling : in std_logic ;
		drawing_request	: out std_logic ;
		mVGA_RGB 	: out std_logic_vector(7 downto 0) ;
		remove   : out std_logic ; --- to remove life or coin 
		explosion  : out std_logic ;
		hit        : out std_logic 

		
	); 
end souls ;

architecture behav of souls is 
constant MaxNum : integer := 45000000; 

constant ObjectStartX : integer := 10 ;
constant ObjectStartY : integer := 10;

constant object1_X_size : integer := 20;
constant object1_Y_size : integer := 15;

constant object2_X_size : integer := 40;
constant object2_Y_size : integer := 15; 

constant object3_X_size : integer := 60;
constant object3_Y_size : integer := 15;



--one heart

type ram_array1 is array(0 to object1_Y_size - 1 , 0 to object1_X_size - 1) of std_logic_vector(7 downto 0);  

-- 8 bit - color definition : "RRRGGGBB"  
constant object_colors1: ram_array1 := ( 
     (x"ff",x"ff",x"f2",x"e8",x"e0",x"e0",x"e8",x"f2",x"ff",x"ff",x"ff",x"ff",x"f2",x"e8",x"e0",x"e0",x"e8",x"f2",x"ff",x"ff"),
     (x"ff",x"e4",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e4",x"ff",x"ff",x"e8",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e8",x"ff"),
     (x"ed",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"ed",x"ed",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"ed"),
     (x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0"),
     (x"e4",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e4"),
     (x"ed",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"ed"),
     (x"ff",x"e4",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e4",x"ff"),
     (x"ff",x"f6",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"f6",x"ff"),
     (x"ff",x"ff",x"f6",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"f6",x"ff",x"ff"),
     (x"ff",x"ff",x"ff",x"fa",x"e4",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e4",x"fb",x"ff",x"ff",x"ff"),
     (x"ff",x"ff",x"ff",x"ff",x"fb",x"e9",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e9",x"ff",x"ff",x"ff",x"ff",x"ff"),
     (x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ed",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"ed",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
     (x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"f2",x"e0",x"e0",x"e0",x"e0",x"f2",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
     (x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"f6",x"e0",x"e0",x"f6",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
     (x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"f2",x"f6",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff")



);


-- one bit mask  0 - off 1 dispaly 
type object_form1 is array (0 to object1_Y_size - 1 , 0 to object1_X_size - 1) of std_logic;
constant object1 : object_form1 := (
       ("00111111000011111100"),
     ("01111111100111111110"),
     ("11111111111111111111"),
     ("11111111111111111111"),
     ("11111111111111111111"),
     ("11111111111111111111"),
     ("01111111111111111110"),
     ("01111111111111111110"),
     ("00111111111111111100"),
     ("00011111111111111000"),
     ("00001111111111100000"),
     ("00000011111111000000"),
     ("00000001111110000000"),
     ("00000000111100000000"),
     ("00000000011000000000")
);

----two hears
type ram_array2 is array(0 to object2_Y_size - 1 , 0 to object2_X_size - 1) of std_logic_vector(7 downto 0);

constant object_colors2: ram_array2 := ( 
     
     (x"ff",x"ff",x"f2",x"e8",x"e0",x"e0",x"e8",x"f2",x"ff",x"ff",x"ff",x"ff",x"f2",x"e8",x"e0",x"e0",x"e8",x"f2",x"ff",x"ff",x"ff",x"ff",x"f2",x"e8",x"e0",x"e0",x"e8",x"f2",x"ff",x"ff",x"ff",x"ff",x"f2",x"e8",x"e0",x"e0",x"e8",x"f2",x"ff",x"ff"),
     (x"ff",x"e4",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e4",x"ff",x"ff",x"e8",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e8",x"ff",x"ff",x"e4",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e4",x"ff",x"ff",x"e8",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e8",x"ff"),
     (x"ed",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"ed",x"ed",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"ed",x"ed",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"ed",x"ed",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"ed"),
     (x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0"),
     (x"e4",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e4",x"e4",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e4"),
     (x"ed",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"ed",x"ed",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"ed"),
     (x"ff",x"e4",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e4",x"ff",x"ff",x"e4",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e4",x"ff"),
     (x"ff",x"f6",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"f6",x"ff",x"ff",x"f6",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"f6",x"ff"),
     (x"ff",x"ff",x"f6",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"f6",x"ff",x"ff",x"ff",x"ff",x"f6",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"f6",x"ff",x"ff"),
     (x"ff",x"ff",x"ff",x"fa",x"e4",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e4",x"fb",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"fa",x"e4",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e4",x"fb",x"ff",x"ff",x"ff"),
     (x"ff",x"ff",x"ff",x"ff",x"fb",x"e9",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e9",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"fb",x"e9",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e9",x"ff",x"ff",x"ff",x"ff",x"ff"),
     (x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ed",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"ed",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ed",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"ed",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
     (x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"f2",x"e0",x"e0",x"e0",x"e0",x"f2",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"f2",x"e0",x"e0",x"e0",x"e0",x"f2",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
     (x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"f6",x"e0",x"e0",x"f6",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"f6",x"e0",x"e0",x"f6",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
     (x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"f2",x"f6",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"f2",x"f6",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff")

);


-- one bit mask  0 - off 1 dispaly 
type object_form2 is array (0 to object2_Y_size - 1 , 0 to object2_X_size - 1) of std_logic;
constant object2 : object_form2 := (
    ("0011111100001111110000111111000011111100"),
     ("0111111110011111111001111111100111111110"),
     ("1111111111111111111111111111111111111111"),
     ("1111111111111111111111111111111111111111"),
     ("1111111111111111111111111111111111111111"),
     ("1111111111111111111111111111111111111111"),
     ("0111111111111111111001111111111111111110"),
     ("0111111111111111111001111111111111111110"),
     ("0011111111111111110000111111111111111100"),
     ("0001111111111111100000011111111111111000"),
     ("0000111111111110000000001111111111100000"),
     ("0000001111111100000000000011111111000000"),
     ("0000000111111000000000000001111110000000"),
     ("0000000011110000000000000000111100000000"),
     ("0000000001100000000000000000011000000000")
     

);

------3 hearts
type ram_array3 is array(0 to object3_Y_size - 1 , 0 to object3_X_size - 1) of std_logic_vector(7 downto 0);
constant object_colors3: ram_array3 := ( 
     (x"ff",x"ff",x"f2",x"e8",x"e0",x"e0",x"e8",x"f2",x"ff",x"ff",x"ff",x"ff",x"f2",x"e8",x"e0",x"e0",x"e8",x"f2",x"ff",x"ff",x"ff",x"ff",x"f2",x"e8",x"e0",x"e0",x"e8",x"f2",x"ff",x"ff",x"ff",x"ff",x"f2",x"e8",x"e0",x"e0",x"e8",x"f2",x"ff",x"ff",x"ff",x"ff",x"f2",x"e8",x"e0",x"e0",x"e8",x"f2",x"ff",x"ff",x"ff",x"ff",x"f2",x"e8",x"e0",x"e0",x"e8",x"f2",x"ff",x"ff"),
     (x"ff",x"e4",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e4",x"ff",x"ff",x"e8",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e8",x"ff",x"ff",x"e4",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e4",x"ff",x"ff",x"e8",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e8",x"ff",x"ff",x"e4",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e4",x"ff",x"ff",x"e8",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e8",x"ff"),
     (x"ed",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"ed",x"ed",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"ed",x"ed",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"ed",x"ed",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"ed",x"ed",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"ed",x"ed",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"ed"),
     (x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0"),
     (x"e4",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e4",x"e4",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e4",x"e4",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e4"),
     (x"ed",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"ed",x"ed",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"ed",x"ed",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"ed"),
     (x"ff",x"e4",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e4",x"ff",x"ff",x"e4",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e4",x"ff",x"ff",x"e4",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e4",x"ff"),
     (x"ff",x"f6",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"f6",x"ff",x"ff",x"f6",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"f6",x"ff",x"ff",x"f6",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"f6",x"ff"),
     (x"ff",x"ff",x"f6",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"f6",x"ff",x"ff",x"ff",x"ff",x"f6",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"f6",x"ff",x"ff",x"ff",x"ff",x"f6",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"f6",x"ff",x"ff"),
     (x"ff",x"ff",x"ff",x"fa",x"e4",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e4",x"fb",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"fa",x"e4",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e4",x"fb",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"fa",x"e4",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e4",x"fb",x"ff",x"ff",x"ff"),
     (x"ff",x"ff",x"ff",x"ff",x"fb",x"e9",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e9",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"fb",x"e9",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e9",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"fb",x"e9",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"e9",x"ff",x"ff",x"ff",x"ff",x"ff"),
     (x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ed",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"ed",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ed",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"ed",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ed",x"e0",x"e0",x"e0",x"e0",x"e0",x"e0",x"ed",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
     (x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"f2",x"e0",x"e0",x"e0",x"e0",x"f2",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"f2",x"e0",x"e0",x"e0",x"e0",x"f2",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"f2",x"e0",x"e0",x"e0",x"e0",x"f2",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
     (x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"f6",x"e0",x"e0",x"f6",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"f6",x"e0",x"e0",x"f6",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"f6",x"e0",x"e0",x"f6",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
     (x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"f2",x"f6",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"f2",x"f6",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"f2",x"f6",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff")
     


);


type object_form3 is array (0 to object3_Y_size - 1 , 0 to object3_X_size - 1) of std_logic;
constant object3 : object_form3 := (
     ("001111110000111111000011111100001111110000111111000011111100"),
     ("011111111001111111100111111110011111111001111111100111111110"),
     ("111111111111111111111111111111111111111111111111111111111111"),
     ("111111111111111111111111111111111111111111111111111111111111"),
     ("111111111111111111111111111111111111111111111111111111111111"),
     ("111111111111111111111111111111111111111111111111111111111111"),
     ("011111111111111111100111111111111111111001111111111111111110"),
     ("011111111111111111100111111111111111111001111111111111111110"),
     ("001111111111111111000011111111111111110000111111111111111100"),
     ("000111111111111110000001111111111111100000011111111111111000"),
     ("000011111111111000000000111111111110000000001111111111100000"),
     ("000000111111110000000000001111111100000000000011111111000000"),
     ("000000011111100000000000000111111000000000000001111110000000"),
     ("000000001111000000000000000011110000000000000000111100000000"),
     ("000000000110000000000000000001100000000000000000011000000000")
);

signal  souls_number  : integer := 3;
signal bCoord1_X : integer := 0;-- offset from start position 
signal bCoord1_Y : integer := 0;
signal bCoord2_X : integer := 0;-- offset from start position 
signal bCoord2_Y : integer := 0;
signal bCoord3_X : integer := 0;-- offset from start position 
signal bCoord3_Y : integer := 0;

signal drawing1_X : std_logic := '0';
signal drawing1_Y : std_logic := '0';
signal drawing2_X : std_logic := '0';
signal drawing2_Y : std_logic := '0';
signal drawing3_X : std_logic := '0';
signal drawing3_Y : std_logic := '0';
--		
signal object1EndX : integer;
signal object1EndY : integer;
signal object2EndX : integer;
signal object2EndY : integer;
signal object3EndX : integer;
signal object3EndY : integer;

begin


-- Calculate object end boundaries
object1EndX	<= object1_X_size+ObjectStartX;
object1EndY	<= object1_Y_size+ObjectStartY;

object2EndX	<= object2_X_size+ObjectStartX;
object2EndY	<= object2_Y_size+ObjectStartY;

object3EndX	<= object3_X_size+ObjectStartX;
object3EndY	<= object3_Y_size+ObjectStartY;

-- Signals drawing_X[Y] are active when obects coordinates are being crossed

-- test if ooCoord is in the rectangle defined by Start and End 
	drawing1_X	<= '1' when  (oCoord_X  >= ObjectStartX) and  (oCoord_X < object1EndX) else '0';
    drawing1_Y	<= '1' when  (oCoord_Y  >= ObjectStartY) and  (oCoord_Y < object1EndY) else '0';

	 drawing2_X	<= '1' when  (oCoord_X  >= ObjectStartX) and  (oCoord_X < object2EndX) else '0';
    drawing2_Y	<= '1' when  (oCoord_Y  >= ObjectStartY) and  (oCoord_Y < object2EndY) else '0';
	 
	 drawing3_X	<= '1' when  (oCoord_X  >= ObjectStartX) and  (oCoord_X < object3EndX) else '0';
    drawing3_Y	<= '1' when  (oCoord_Y  >= ObjectStartY) and  (oCoord_Y < object3EndY) else '0';
-- calculate offset from start corner 


	bCoord1_X 	<= (oCoord_X - ObjectStartX) when ( drawing1_X = '1' and  drawing1_Y = '1'  ) else 0 ; 
	bCoord1_Y 	<= (oCoord_Y - ObjectStartY) when ( drawing1_X = '1' and  drawing1_Y = '1'  ) else 0 ; 
	bCoord2_X 	<= (oCoord_X - ObjectStartX) when ( drawing2_X = '1' and  drawing2_Y = '1'  ) else 0 ; 
	bCoord2_Y 	<= (oCoord_Y - ObjectStartY) when ( drawing2_X = '1' and  drawing2_Y = '1'  ) else 0 ;
	bCoord3_X 	<= (oCoord_X - ObjectStartX) when ( drawing3_X = '1' and  drawing3_Y = '1'  ) else 0 ; 
	bCoord3_Y 	<= (oCoord_Y - ObjectStartY) when ( drawing3_X = '1' and  drawing3_Y = '1'  ) else 0 ;

process ( RESETn, CLK)


   variable Bom_delay : integer := 0;--ready for bpm
   variable life_delay : integer := 0;--ready for bpmb
 	variable flag_Bom : std_logic := '0' ; --ready for bomb
	variable flag_life : std_logic := '1' ; --ready for new life 
   begin
	
	if RESETn = '0' then
	    mVGA_RGB	<=  (others => '0') ; 	
		drawing_request	<=  '0' ;
		souls_number <=3; 
		 flag_Bom := '0';
		 flag_life := '1';
		 Bom_delay :=0 ;
		 life_delay := 0 ;
       explosion    <= '0' ; 
		 hit <= '0' ;
		     
		elsif rising_edge(CLK) then
		
     
		     if (Bom ='1' or cieling ='1') and flag_Bom='1'  then 
				  souls_number <= souls_number -1 ;
				  
				   if souls_number <= 0 then 
				     explosion <= '1' ; 
		        else 
				     explosion <= '0' ;
					end if; 
					hit <= '1';
					
					
				  flag_Bom := '0' ;
				  Bom_delay := 0;
				else 
				   hit <= '0' ;
				  Bom_delay := Bom_delay +1 ;
				  
				  if Bom_delay=MaxNum/2 then 
				     flag_Bom :='1' ;
				   end if ;		 
				  
			 end if;
				
				
		     if life ='1' and flag_life='1'  then 
			      remove  <= '1' ; 
				  if souls_number<3 then 
				      souls_number <= souls_number +1 ;
					end if;
				  flag_life := '0' ;
				  life_delay := 0;
				else 
				   remove <= '0' ; 
				  life_delay := life_delay +1 ;
				  
				  if life_delay=MaxNum then 
				     flag_life :='1' ;
				   end if ;
				  
			 end if;
			     

			    
				 if souls_number < 0 then 
				    drawing_request <= '0' ;
				 else 
                
		      case souls_number is 
				  when 1 => 
				    mVGA_RGB	<=  object_colors1(bCoord1_Y , bCoord1_X);	--get from colors table 
			       drawing_request	<= object1(bCoord1_Y , bCoord1_X) and drawing1_X and drawing1_Y ; -- get from mask table 	
              when 2 => 
				     mVGA_RGB	<=  object_colors2(bCoord2_Y , bCoord2_X);	--get from colors table 
			   	 drawing_request	<= object2(bCoord2_Y , bCoord2_X) and drawing2_X and drawing2_Y ; -- get from mask table 	
	           when 0 =>
				     drawing_request <= '0' ;
               when others => 
				     mVGA_RGB	<=  object_colors3(bCoord3_Y , bCoord3_X);	--get from colors table 
			        drawing_request	<= object3(bCoord3_Y , bCoord3_X) and drawing3_X and drawing3_Y ; -- get from mask table 	
				  end case ;
				  end if ; 
				  
				    
				  
				  
	 end if;
	    
	

  end process;

		
end behav;		
		