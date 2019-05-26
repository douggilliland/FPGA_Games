library IEEE;
use IEEE.STD_LOGIC_1164.all;
--use IEEE.std_logic_unsigned.all;
--use ieee.numeric_std.all;
--use ieee.std_logic_arith.all;
-- Alex Grinshpun April 2017
-- Dudy Nov 13 2017


entity life_draw is
port 	(
		--////////////////////	Clock Input	 	////////////////////	
	   	CLK  		: in std_logic;
		RESETn		: in std_logic;
		oCoord_X	: in integer;
		oCoord_Y	: in integer;
		ObjectStartX	: in integer;
		ObjectStartY 	: in integer;
		drawing_request	: out std_logic ;
		mVGA_RGB 	: out std_logic_vector(7 downto 0) ;
		life : in std_logic 


		
	); 
end life_draw;

architecture behav of life_draw is 

constant object_X_size : integer := 40;
constant object_Y_size : integer := 30;



type ram_array is array(0 to object_Y_size - 1 , 0 to object_X_size - 1) of std_logic_vector(7 downto 0);  
  
constant object_colors: ram_array := (

(x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00"),
(x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00"),
(x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"24",x"24",x"24",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"24",x"24",x"24",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00"),
(x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"24",x"24",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"24",x"24",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00"),
(x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"24",x"24",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"24",x"24",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00"),
(x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00"),
(x"00",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"00"),
(x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24"),
(x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"49",x"6d",x"92",x"92",x"92",x"92",x"6d",x"49",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24"),
(x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"49",x"92",x"db",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"db",x"92",x"49",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24"),
(x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"92",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"92",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24"),
(x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"49",x"db",x"ff",x"ff",x"ff",x"ff",x"ff",x"f6",x"c0",x"c4",x"c4",x"c0",x"f6",x"ff",x"ff",x"ff",x"ff",x"ff",x"db",x"49",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24"),
(x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"49",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"f2",x"a0",x"a0",x"a0",x"a0",x"f2",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"49",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24"),
(x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"db",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"f2",x"a0",x"a0",x"a0",x"a0",x"f2",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"db",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24"),
(x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"92",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"f2",x"a0",x"a0",x"a0",x"a0",x"f2",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"92",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24"),
(x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"db",x"ff",x"ff",x"ff",x"fb",x"fb",x"fb",x"fb",x"ff",x"d2",x"a0",x"a0",x"a0",x"a0",x"d2",x"ff",x"fb",x"fb",x"fb",x"fb",x"ff",x"ff",x"ff",x"db",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24"),
(x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"49",x"ff",x"ff",x"ff",x"c9",x"a0",x"a0",x"a0",x"a0",x"a0",x"a0",x"a0",x"a0",x"a0",x"a0",x"a0",x"a0",x"a0",x"a0",x"a0",x"a0",x"c9",x"ff",x"ff",x"ff",x"49",x"24",x"24",x"24",x"24",x"24",x"24",x"24"),
(x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"6d",x"ff",x"ff",x"ff",x"c4",x"a0",x"a0",x"a0",x"a0",x"a0",x"a0",x"a0",x"a0",x"a0",x"a0",x"a0",x"a0",x"a0",x"a0",x"a0",x"a0",x"c4",x"ff",x"ff",x"ff",x"6d",x"24",x"24",x"24",x"24",x"24",x"24",x"24"),
(x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"49",x"ff",x"ff",x"ff",x"c4",x"a0",x"a0",x"a0",x"a0",x"a0",x"a0",x"a0",x"a0",x"a0",x"a0",x"a0",x"a0",x"a0",x"a0",x"a0",x"a0",x"c4",x"ff",x"ff",x"ff",x"49",x"24",x"24",x"24",x"24",x"24",x"24",x"24"),
(x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"ff",x"ff",x"ff",x"f6",x"cd",x"d2",x"d2",x"d2",x"d2",x"c9",x"a0",x"a0",x"a0",x"a0",x"c9",x"d2",x"d2",x"d2",x"d2",x"cd",x"f6",x"ff",x"ff",x"ff",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24"),
(x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"b6",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"f2",x"a0",x"a0",x"a0",x"a0",x"f2",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"b6",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24"),
(x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"49",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"f2",x"a0",x"a0",x"a0",x"a0",x"f2",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"49",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24"),
(x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"92",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"f2",x"a0",x"a0",x"a0",x"a0",x"f2",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"92",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24"),
(x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"92",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"f2",x"a0",x"a0",x"a0",x"a0",x"f2",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"92",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24"),
(x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"6d",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"f6",x"f6",x"f6",x"f6",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"6d",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24"),
(x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"92",x"db",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"db",x"92",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24"),
(x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"6d",x"92",x"b6",x"db",x"db",x"db",x"db",x"b6",x"92",x"6d",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24"),
(x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24"),
(x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24"),
(x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00")

) ;

type object_form is array (0 to object_Y_size - 1 , 0 to object_X_size - 1) of std_logic;
constant object : object_form := (
("0000000000000000000000000000000000000000"),
("0000000000000011111111111100000000000000"),
("0000000000000111000000001110000000000000"),
("0000000000000110000000000110000000000000"),
("0000000000000110000000000110000000000000"),
("0000000000000000000000000000000000000000"),
("0111111111111111111111111111111111111110"),
("1111111111111111111111111111111111111111"),
("1111111111111111111111111111111111111111"),
("1111111111111111111111111111111111111111"),
("1111111111111111111111111111111111111111"),
("1111111111111111111111111111111111111111"),
("1111111111111111111111111111111111111111"),
("1111111111111111111111111111111111111111"),
("1111111111111111111111111111111111111111"),
("1111111111111111111111111111111111111111"),
("1111111111111111111111111111111111111111"),
("1111111111111111111111111111111111111111"),
("1111111111111111111111111111111111111111"),
("1111111111111111111111111111111111111111"),
("1111111111111111111111111111111111111111"),
("1111111111111111111111111111111111111111"),
("1111111111111111111111111111111111111111"),
("1111111111111111111111111111111111111111"),
("1111111111111111111111111111111111111111"),
("1111111111111111111111111111111111111111"),
("1111111111111111111111111111111111111111"),
("1111111111111111111111111111111111111111"),
("1111111111111111111111111111111111111111"),
("0000000000000000000000000000000000000000")

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



  	variable counter : integer:= 0;
   constant MaxNum2 : integer := 45000000;
	variable flag : std_logic ; 
	
	--- i want to print a picture every 750000
 	
   begin
	
	if RESETn = '0' then
	    mVGA_RGB	<=  (others => '0') ; 	
		drawing_request	<=  '0' ;

		
		elsif rising_edge(CLK) then
		    
            if life ='1' then 
				    flag := '1' ; 
			    end if ; 
				if flag = '1' then   
				   if counter < MaxNum2/6 then 
					    drawing_request <= '0' ;
						 counter := counter +1 ;
					else 
					    counter := 0 ;
						 flag := '0' ;
					end if;
		
		      elsif ObjectStartX <=0 then 
			      	drawing_request <= '0' ;
				else	 	
			        drawing_request	<= object(bCoord_Y , bCoord_X) and drawing_X and drawing_Y ; 
				   	mVGA_RGB	<=  object_colors(bCoord_Y , bCoord_X);  
            end if;

			
	end if;

  end process;

		
end behav;		
		