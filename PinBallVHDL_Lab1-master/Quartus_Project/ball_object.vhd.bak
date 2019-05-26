library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity ball_object is
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


architecture behav of ball_object is 

constant object_X_size : integer := 26;
constant object_Y_size : integer := 26;
--constant R_high		: integer := 7;
--constant R_low		: integer := 5;
--constant G_high		: integer := 4;
--constant G_low		: integer := 2;
--constant B_high		: integer := 1;
--constant B_low		: integer := 0;

type ram_array is array(0 to object_Y_size - 1 , 0 to object_X_size - 1) of std_logic_vector(7 downto 0);  

-- 8 bit - color definition : "RRRGGGBB"  
constant object_colors: ram_array := ( 
(x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF"),
(x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"D5", x"D0", x"D0", x"D4", x"D4", x"D4", x"D4", x"D0", x"D0", x"D5", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF"),
(x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"D5", x"D0", x"D4", x"64", x"8C", x"FF", x"FF", x"FF", x"FF", x"FF", x"64", x"AC", x"D0", x"D5", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF"), 
(x"FF", x"FF", x"FF", x"FF", x"FF", x"D0", x"D4", x"D9", x"8C", x"D9", x"FF", x"D9", x"D9", x"D9", x"D9", x"D9", x"FF", x"D5", x"D5", x"D4", x"D0", x"FF", x"FF", x"FF", x"FF", x"FF"), 
(x"FF", x"FF", x"FF", x"FF", x"D0", x"D4", x"D9", x"D9", x"FF", x"D9", x"D9", x"D9", x"D9", x"D9", x"D9", x"D9", x"D9", x"D9", x"D9", x"D9", x"D9", x"D0", x"FF", x"FF", x"FF", x"FF"), 
(x"FF", x"FF", x"FF", x"D0", x"D4", x"D9", x"D9", x"D5", x"D4", x"88", x"6C", x"D4", x"D9", x"D9", x"D9", x"D9", x"B0", x"D5", x"D9", x"D9", x"D9", x"D9", x"CC", x"FF", x"FF", x"FF"), 
(x"FF", x"FF", x"D0", x"D4", x"D9", x"D5", x"D4", x"40", x"04", x"9B", x"9B", x"96", x"D4", x"D9", x"D9", x"B1", x"9B", x"72", x"24", x"8C", x"D9", x"D9", x"D4", x"D0", x"FF", x"FF"), 
(x"FF", x"B6", x"D0", x"D9", x"D5", x"D9", x"40", x"29", x"FF", x"FF", x"FF", x"FF", x"92", x"D9", x"D4", x"FF", x"FF", x"FF", x"FF", x"24", x"8C", x"D5", x"D9", x"D0", x"D5", x"FF"), 
(x"FF", x"D0", x"D4", x"D9", x"B0", x"44", x"44", x"FF", x"96", x"0A", x"92", x"FF", x"FF", x"D0", x"B6", x"FF", x"4E", x"0A", x"FF", x"FF", x"44", x"B4", x"D8", x"D4", x"D0", x"FF"), 
(x"FF", x"D0", x"D4", x"D8", x"D8", x"D0", x"71", x"BA", x"FF", x"00", x"32", x"FF", x"FF", x"D4", x"BA", x"FF", x"68", x"2D", x"72", x"FF", x"D0", x"D8", x"D4", x"D4", x"D0", x"FF"), 
(x"D5", x"D0", x"D4", x"D4", x"D4", x"D0", x"B6", x"76", x"00", x"00", x"56", x"FF", x"FF", x"D4", x"BA", x"56", x"00", x"72", x"52", x"FF", x"D0", x"D4", x"D4", x"D4", x"D0", x"D5"), 
(x"D5", x"D0", x"D4", x"D4", x"D4", x"D4", x"B6", x"9B", x"32", x"52", x"52", x"FF", x"FF", x"D4", x"D5", x"76", x"2D", x"76", x"96", x"FF", x"D0", x"D4", x"D4", x"D4", x"D0", x"D5"), 
(x"D4", x"D0", x"D4", x"D4", x"D4", x"D4", x"D0", x"D9", x"72", x"4E", x"FF", x"FF", x"92", x"D9", x"D8", x"9B", x"72", x"72", x"FF", x"B0", x"D4", x"D4", x"D4", x"D4", x"D0", x"D4"), 
(x"D4", x"D0", x"D4", x"D4", x"D4", x"D4", x"D4", x"D0", x"D0", x"BA", x"9B", x"76", x"D4", x"D9", x"D9", x"D4", x"B6", x"B6", x"D0", x"D4", x"D4", x"D4", x"D4", x"D4", x"D0", x"D5"), 
(x"D5", x"D0", x"D4", x"D4", x"D4", x"D0", x"D0", x"D0", x"D0", x"D4", x"D4", x"D4", x"D9", x"D9", x"D8", x"D8", x"D8", x"D0", x"D0", x"D0", x"D0", x"D4", x"D4", x"D4", x"D0", x"D5"), 
(x"D5", x"D0", x"D4", x"D4", x"D4", x"D4", x"D0", x"D0", x"D0", x"D8", x"D8", x"D8", x"D8", x"D8", x"D8", x"D8", x"D8", x"D8", x"D0", x"D4", x"D4", x"D4", x"D4", x"D4", x"D0", x"D5"), 
(x"FF", x"D0", x"D4", x"D4", x"D4", x"D4", x"D4", x"D8", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D0", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D0", x"FF"), 
(x"FF", x"D0", x"D0", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D8", x"D4", x"D0", x"D0", x"D0", x"D0", x"D0", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D0", x"FF"), 
(x"FF", x"D5", x"D0", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D8", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D0", x"D5", x"FF"), 
(x"FF", x"FF", x"D0", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D0", x"D0", x"FF", x"FF"), 
(x"FF", x"FF", x"FF", x"D0", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D0", x"FF", x"FF", x"FF"), 
(x"FF", x"FF", x"FF", x"FF", x"D0", x"D8", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D0", x"FF", x"FF", x"FF", x"FF"), 
(x"FF", x"FF", x"FF", x"FF", x"FF", x"D0", x"D9", x"D9", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D0", x"D0", x"FF", x"FF", x"FF", x"FF", x"FF"), 
(x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"D5", x"D4", x"D9", x"D9", x"D9", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D0", x"D0", x"D5", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF"), 
(x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"D5", x"D4", x"D4", x"D4", x"D4", x"D4", x"D4", x"D0", x"D0", x"D5", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF"), 
(x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF")
);

-- one bit mask  0 - off 1 dispaly 
type object_form is array (0 to object_Y_size - 1 , 0 to object_X_size - 1) of std_logic;
constant object : object_form := (
("00000000000000000000000000"),
("00000011111111111111000000"),
("00000111111111111111110000"),
("00001111111111111111110000"),
("00011111111111111111111000"),
("00111111111111111111111100"),
("00111111111111111111111111"),
("01111111111111111111111111"),
("11111111111111111111111111"),
("11111111111111111111111111"),
("11111111111111111111111111"),
("11111111111111111111111111"),
("11111111111111111111111111"),
("11111111111111111111111111"),
("11111111111111111111111111"),
("11111111111111111111111111"),
("11111111111111111111111111"),
("11111111111111111111111111"),
("11111111111111111111111111"),
("11111111111111111111111111"),
("11111111111111111111111111"),
("11111111111111111111111111"),
("11111111111111111111111111"),
("11111111111111111111111111"),
("11111111111111111111111111"),
("11111111111111111111111111")
);



signal bCoord_X : integer := 0;-- offset from start position 
signal bCoord_Y : integer := 0;

signal drawing_X : std_logic := '0';
signal drawing_Y : std_logic := '0';

--		
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