library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity ball_object_try is
port 	(
		
	   CLK  		: in std_logic;
		RESETn		: in std_logic;
		oCoord_X	: in integer;
		oCoord_Y	: in integer;
		ObjectStartX	: in integer;
		ObjectStartY 	: in integer;
		drawing_request	: out std_logic ;
		mVGA_RGB 	: out std_logic_vector(7 downto 0) 
	);
end entity;


architecture behav of ball_object_try is 

constant object_X_size : integer := 40;
constant object_Y_size : integer := 40;
type ram_array is array(0 to object_Y_size - 1 , 0 to object_X_size - 1) of std_logic_vector(7 downto 0);
constant object_colors: ram_array := (
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"db",x"92",x"6d",x"4d",x"4d",x"6e",x"92",x"db",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"db",x"6d",x"92",x"96",x"52",x"4e",x"2e",x"2e",x"32",x"52",x"92",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"b6",x"25",x"4e",x"72",x"29",x"25",x"00",x"00",x"00",x"05",x"2e",x"2e",x"6d",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"db",x"00",x"00",x"04",x"24",x"24",x"24",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"6d",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"49",x"00",x"00",x"24",x"49",x"4d",x"6d",x"49",x"24",x"24",x"00",x"00",x"00",x"00",x"49",x"92",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"da",x"24",x"24",x"25",x"49",x"72",x"db",x"ff",x"bb",x"4d",x"24",x"00",x"00",x"00",x"00",x"49",x"49",x"db",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"92",x"04",x"04",x"24",x"49",x"bb",x"ff",x"ff",x"ff",x"92",x"29",x"24",x"00",x"00",x"00",x"49",x"49",x"b6",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"91",x"00",x"00",x"24",x"49",x"bb",x"ff",x"ff",x"ff",x"72",x"29",x"25",x"00",x"00",x"00",x"00",x"49",x"92",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"92",x"00",x"00",x"24",x"29",x"4d",x"bb",x"db",x"92",x"4d",x"25",x"24",x"04",x"00",x"00",x"00",x"24",x"92",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"b6",x"29",x"00",x"04",x"04",x"24",x"29",x"49",x"29",x"29",x"24",x"04",x"00",x"00",x"00",x"00",x"49",x"b6",x"df",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"db",x"92",x"04",x"00",x"00",x"24",x"24",x"24",x"24",x"04",x"00",x"00",x"00",x"00",x"00",x"24",x"92",x"b6",x"db",x"df",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"da",x"db",x"92",x"00",x"00",x"00",x"24",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"24",x"92",x"b6",x"ba",x"bb",x"bb",x"db",x"df",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"db",x"db",x"db",x"96",x"49",x"24",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"49",x"b6",x"b6",x"ba",x"ba",x"72",x"97",x"bb",x"db",x"df",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"db",x"db",x"db",x"db",x"b6",x"6d",x"49",x"49",x"49",x"49",x"6d",x"b6",x"ba",x"ba",x"da",x"db",x"92",x"52",x"73",x"97",x"bb",x"df",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"db",x"db",x"db",x"db",x"db",x"db",x"db",x"db",x"db",x"db",x"db",x"da",x"da",x"ba",x"db",x"b6",x"4e",x"4e",x"72",x"97",x"bb",x"db",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"db",x"db",x"db",x"db",x"db",x"db",x"db",x"db",x"db",x"db",x"db",x"db",x"db",x"b6",x"4e",x"4e",x"4e",x"72",x"97",x"bb",x"df",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"df",x"db",x"db",x"db",x"ff",x"db",x"db",x"db",x"db",x"db",x"db",x"db",x"b6",x"4e",x"4e",x"4e",x"4e",x"72",x"97",x"bb",x"df",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"df",x"bb",x"db",x"db",x"ff",x"df",x"db",x"db",x"db",x"db",x"da",x"92",x"4d",x"4e",x"4e",x"4e",x"72",x"97",x"bb",x"df",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"db",x"92",x"92",x"b6",x"b6",x"ba",x"b6",x"96",x"6d",x"49",x"29",x"49",x"4e",x"4e",x"72",x"97",x"bb",x"df",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"db",x"96",x"6d",x"49",x"49",x"49",x"28",x"48",x"49",x"4d",x"6d",x"72",x"96",x"bb",x"db",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"db",x"ba",x"b6",x"92",x"92",x"92",x"96",x"b6",x"ba",x"db",x"df",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff")
);

constant object : object_form := (
("0000000000000000000000000000000000000000"),
("0000000000000000000000000000000000000000"),
("0000000000000000000000000000000000000000"),
("0000000000000000000000000000000000000000"),
("0000000000000000000000000000000000000000"),
("0000000000000000000000000000000000000000"),
("0000000000000000000000000000000000000000"),
("0000000000000000000000000000000000000000"),
("0000000000000000000000000000000000000000"),
("0000000000000000000000000000000000000000"),
("0000000000000000111111110000000000000000"),
("0000000000000011111111111000000000000000"),
("0000000000000111111111111100000000000000"),
("0000000000001111111111111110000000000000"),
("0000000000001111111111111111000000000000"),
("0000000000011111110111111111100000000000"),
("0000000000011111100011111111100000000000"),
("0000000000011111100011111111100000000000"),
("0000000000011111111111111111100000000000"),
("0000000000011111111111111111110000000000"),
("0000000000011111111111111111111000000000"),
("0000000000011111111111111111111110000000"),
("0000000000011111111111111111111111000000"),
("0000000000001111111111111111111111000000"),
("0000000000001111111111111111111111000000"),
("0000000000000111111111111111111111000000"),
("0000000000000111101111111111111111000000"),
("0000000000000111101111111111111110000000"),
("0000000000000011111111111111111100000000"),
("0000000000000001111111111111110000000000"),
("0000000000000000011111111111000000000000"),
("0000000000000000000000000000000000000000"),
("0000000000000000000000000000000000000000"),
("0000000000000000000000000000000000000000"),
("0000000000000000000000000000000000000000"),
("0000000000000000000000000000000000000000"),
("0000000000000000000000000000000000000000"),
("0000000000000000000000000000000000000000"),
("0000000000000000000000000000000000000000"),
("0000000000000000000000000000000000000000")
);

signal bCoord_X : integer := 0;-- offset from start position 
signal bCoord_Y : integer := 0;

signal drawing_X : std_logic := '0';
signal drawing_Y : std_logic := '0';
	
signal objectEndX : integer;
signal objectEndY : integer;

begin

-- Calculate object end boundaries
objectEndX	<= object_X_size+ObjectStartX;
objectEndY	<= object_Y_size+ObjectStartY;

-- Signals drawing_X[Y] are active when obects coordinates are being crossed

-- test if ooCoord is in the rectangle defined by Start and End 
	drawing_X	<= '1' when  (oCoord_X  >= ObjectStartX) and  (oCoord_X < objectEndX) else '0';
    drawing_Y	<= '1' when  (oCoord_Y  >= ObjectStartY) and  (oCoord_Y < objectEndY) else '0';

-- calculate offset from start corner 
	bCoord_X 	<= (oCoord_X - ObjectStartX) when ( drawing_X = '1' and  drawing_Y = '1'  ) else 0 ; 
	bCoord_Y 	<= (oCoord_Y - ObjectStartY) when ( drawing_X = '1' and  drawing_Y = '1'  ) else 0 ; 


process ( RESETn, CLK)

  		
   begin
	if RESETn = '0' then
	    mVGA_RGB	<=  (others => '0') ; 	
		drawing_request	<=  '0' ;

		elsif rising_edge(CLK) then
			mVGA_RGB	<=  object_colors(bCoord_Y , bCoord_X);	--get from colors table 
			drawing_request	<= object(bCoord_Y , bCoord_X) and drawing_X and drawing_Y ; -- get from mask table if inside rectangle  
	end if;

  end process;

		
end behav;