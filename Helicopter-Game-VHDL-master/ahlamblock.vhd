library IEEE;
use IEEE.STD_LOGIC_1164.all;
--use IEEE.std_logic_unsigned.all;
--use ieee.numeric_std.all;
--use ieee.std_logic_arith.all;
-- Alex Grinshpun April 2017
-- Dudy Nov 13 2017


entity ahlamblock is
port 	(
		--////////////////////	Clock Input	 	////////////////////	
	   	CLK  		: in std_logic;
		RESETn		: in std_logic;
		oCoord_X	: in integer;
		oCoord_Y	: in integer;
		ObjectStartX	: in integer;
		ObjectStartY 	: in integer;
		draw_order : in std_logic ; 
		drawing_request	: out std_logic ;
		mVGA_RGB 	: out std_logic_vector(7 downto 0);
		MaxNum		: in integer
		
	); 
end ahlamblock;

architecture behav of ahlamblock is 

constant object_X_size : integer := 85;
constant object_Y_size : integer := 30;
--constant R_high		: integer := 7;
--constant R_low		: integer := 5;
--constant G_high		: integer := 4;
--constant G_low		: integer := 2;
--constant B_high		: integer := 1;
--constant B_low		: integer := 0;





type ram_array1 is array(0 to object_Y_size - 1 , 0 to object_X_size - 1) of std_logic_vector(7 downto 0);  

-- 8 bit - color definition : "RRRGGGBB"  
constant object_colors1: ram_array1 := ( 


(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"fd",x"fd",x"fd",x"fd",x"ba",x"92",x"92",x"92",x"92",x"92",x"92",x"92",x"92",x"92",x"92",x"92",x"92",x"92",x"92",x"92",x"92",x"92",x"92",x"92",x"92",x"92",x"92",x"92",x"00",x"6d",x"92",x"92",x"92",x"92",x"92",x"92",x"d9",x"fd",x"fd",x"fd",x"fd",x"92",x"92",x"92",x"92",x"92",x"92",x"92",x"92",x"92",x"92",x"92",x"92",x"92",x"92",x"92",x"92",x"db",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"fd",x"fd",x"fd",x"fd",x"de",x"db",x"db",x"db",x"db",x"db",x"db",x"db",x"db",x"db",x"db",x"db",x"db",x"db",x"db",x"db",x"db",x"db",x"b6",x"92",x"6d",x"6d",x"92",x"49",x"00",x"49",x"92",x"6d",x"6d",x"92",x"b6",x"b6",x"dd",x"fd",x"fd",x"fd",x"fe",x"db",x"db",x"db",x"db",x"db",x"db",x"db",x"db",x"db",x"db",x"db",x"db",x"db",x"db",x"db",x"db",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"db",x"b6",x"ff",x"92",x"24",x"6d",x"ff",x"db",x"b6",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"b6",x"6d",x"92",x"92",x"49",x"92",x"92",x"92",x"92",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"49",x"6d",x"6d",x"6d",x"4d",x"6d",x"6d",x"6d",x"91",x"db",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"92",x"24",x"49",x"24",x"b6",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"24",x"28",x"24",x"24",x"29",x"24",x"49",x"6d",x"71",x"71",x"b6",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"db",x"49",x"24",x"24",x"24",x"24",x"24",x"92",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"db",x"db",x"db",x"49",x"6d",x"6d",x"49",x"6d",x"6d",x"6d",x"71",x"6d",x"db",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"db",x"b6",x"b6",x"b6",x"b6",x"b6",x"b6",x"b6",x"b6",x"b6",x"49",x"49",x"6d",x"6d",x"6d",x"6d",x"49",x"49",x"6d",x"b6",x"b6",x"b6",x"b6",x"b6",x"db",x"db",x"db",x"db",x"db",x"db",x"db",x"db",x"db",x"db",x"db",x"db",x"db",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"92",x"49",x"6d",x"6d",x"6d",x"49",x"72",x"6d",x"6d",x"71",x"b6",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"b6",x"b6",x"6d",x"4d",x"6d",x"6d",x"6d",x"6d",x"6d",x"6d",x"6d",x"6d",x"92",x"92",x"6d",x"49",x"49",x"49",x"49",x"49",x"49",x"49",x"49",x"49",x"72",x"6d",x"24",x"24",x"24",x"49",x"29",x"29",x"29",x"29",x"29",x"29",x"49",x"49",x"49",x"92",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"db",x"48",x"6d",x"6d",x"92",x"6d",x"49",x"6d",x"71",x"6d",x"72",x"72",x"db",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"db",x"92",x"92",x"92",x"24",x"6d",x"6e",x"92",x"6d",x"6d",x"6d",x"6d",x"49",x"6d",x"49",x"6d",x"49",x"92",x"92",x"92",x"92",x"92",x"92",x"92",x"92",x"92",x"24",x"92",x"24",x"49",x"29",x"77",x"97",x"9b",x"9b",x"9b",x"9b",x"9b",x"bb",x"bb",x"4d",x"db",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"49",x"69",x"6d",x"6d",x"92",x"6d",x"49",x"49",x"72",x"6d",x"71",x"71",x"b6",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"b6",x"6d",x"4d",x"24",x"72",x"49",x"6d",x"6e",x"6d",x"6d",x"49",x"49",x"49",x"49",x"6d",x"49",x"4d",x"6d",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"49",x"49",x"49",x"6d",x"6d",x"72",x"9b",x"9b",x"9b",x"9b",x"9b",x"9b",x"9b",x"df",x"97",x"92",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"b6",x"48",x"49",x"49",x"92",x"92",x"92",x"6d",x"49",x"6d",x"71",x"6d",x"71",x"91",x"b6",x"b6",x"b6",x"b6",x"b6",x"b6",x"b6",x"b6",x"b6",x"b6",x"b6",x"6d",x"49",x"49",x"49",x"25",x"6e",x"25",x"6e",x"6d",x"6c",x"4c",x"4c",x"48",x"48",x"24",x"6d",x"49",x"6d",x"6d",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"b6",x"24",x"6d",x"6d",x"92",x"4d",x"9b",x"97",x"9b",x"9b",x"97",x"97",x"97",x"97",x"df",x"96",x"b6",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"48",x"91",x"92",x"92",x"92",x"92",x"92",x"72",x"4d",x"4d",x"72",x"6d",x"6d",x"49",x"49",x"49",x"49",x"49",x"49",x"29",x"24",x"24",x"24",x"24",x"24",x"25",x"6d",x"6d",x"49",x"6d",x"24",x"6d",x"4d",x"70",x"70",x"70",x"70",x"6c",x"24",x"6d",x"49",x"6d",x"6d",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"24",x"6d",x"49",x"92",x"6d",x"73",x"9b",x"bb",x"97",x"72",x"72",x"76",x"72",x"bb",x"df",x"72",x"db",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"6d",x"49",x"49",x"49",x"49",x"92",x"b6",x"92",x"92",x"6d",x"4d",x"49",x"49",x"49",x"49",x"24",x"24",x"29",x"49",x"49",x"49",x"28",x"28",x"24",x"25",x"49",x"6d",x"6d",x"24",x"6d",x"29",x"6d",x"6d",x"6c",x"6c",x"70",x"70",x"70",x"24",x"6d",x"49",x"6d",x"6d",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"6d",x"49",x"4d",x"6e",x"24",x"25",x"29",x"29",x"25",x"29",x"29",x"29",x"29",x"29",x"49",x"29",x"24",x"6d",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"6d",x"4d",x"92",x"92",x"92",x"92",x"92",x"6d",x"92",x"92",x"92",x"6d",x"72",x"6d",x"6d",x"6d",x"6d",x"6d",x"92",x"49",x"49",x"49",x"6d",x"6d",x"24",x"6d",x"49",x"6e",x"72",x"6d",x"4d",x"4c",x"6c",x"6c",x"49",x"6d",x"49",x"6d",x"6d",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"b6",x"24",x"6d",x"6d",x"92",x"49",x"72",x"72",x"4e",x"6e",x"6e",x"4d",x"4e",x"72",x"97",x"b7",x"72",x"49",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"b6",x"49",x"49",x"49",x"49",x"49",x"49",x"49",x"49",x"4d",x"4d",x"6d",x"92",x"6d",x"6d",x"6d",x"92",x"6d",x"92",x"6d",x"24",x"49",x"6d",x"6d",x"49",x"6d",x"24",x"6d",x"92",x"92",x"6d",x"6d",x"49",x"49",x"49",x"6d",x"49",x"6d",x"6d",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"24",x"6d",x"49",x"96",x"6d",x"72",x"97",x"72",x"96",x"92",x"72",x"72",x"96",x"97",x"bb",x"ff",x"97",x"b6",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"b6",x"92",x"b6",x"6d",x"29",x"49",x"49",x"6d",x"6d",x"6d",x"6d",x"49",x"24",x"49",x"6e",x"6d",x"25",x"4d",x"24",x"6e",x"92",x"92",x"6e",x"6e",x"6d",x"6d",x"6d",x"6d",x"49",x"6d",x"6d",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"6d",x"49",x"49",x"72",x"72",x"4d",x"76",x"52",x"4e",x"4e",x"4e",x"4d",x"92",x"72",x"72",x"df",x"db",x"49",x"92",x"b6",x"db",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"db",x"6d",x"6d",x"6d",x"6d",x"24",x"25",x"49",x"6d",x"6d",x"25",x"6d",x"25",x"6d",x"6e",x"92",x"72",x"6d",x"6d",x"6d",x"6d",x"6d",x"49",x"49",x"6d",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"b6",x"24",x"6d",x"49",x"92",x"49",x"72",x"72",x"52",x"4e",x"6e",x"6e",x"92",x"b7",x"bb",x"92",x"49",x"49",x"69",x"72",x"6d",x"db",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"db",x"49",x"49",x"49",x"4d",x"29",x"6d",x"24",x"49",x"6d",x"6d",x"6d",x"6d",x"6d",x"6d",x"6d",x"6d",x"49",x"4d",x"6d",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"24",x"6d",x"49",x"72",x"29",x"4d",x"4d",x"4d",x"4d",x"4d",x"4d",x"6e",x"6e",x"4e",x"49",x"49",x"6d",x"92",x"96",x"6d",x"b6",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"db",x"92",x"49",x"49",x"49",x"49",x"49",x"49",x"49",x"49",x"6d",x"6d",x"6e",x"6d",x"6e",x"49",x"49",x"6d",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"6d",x"49",x"6d",x"6d",x"49",x"49",x"49",x"49",x"49",x"25",x"25",x"49",x"29",x"49",x"49",x"92",x"92",x"49",x"49",x"49",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"db",x"92",x"49",x"49",x"49",x"49",x"49",x"49",x"49",x"6d",x"6d",x"6e",x"49",x"49",x"6d",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"db",x"24",x"6d",x"6d",x"92",x"6d",x"6d",x"92",x"92",x"49",x"69",x"6a",x"92",x"92",x"92",x"b6",x"b6",x"49",x"49",x"b6",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"db",x"92",x"49",x"49",x"49",x"49",x"49",x"49",x"49",x"29",x"49",x"6d",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"24",x"49",x"6d",x"92",x"6d",x"6d",x"92",x"b7",x"69",x"84",x"69",x"b7",x"96",x"92",x"b6",x"96",x"6d",x"49",x"49",x"db",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"db",x"92",x"49",x"49",x"49",x"49",x"49",x"49",x"44",x"69",x"69",x"69",x"69",x"69",x"69",x"69",x"69",x"69",x"69",x"69",x"69",x"49",x"24",x"49",x"6d",x"6d",x"49",x"4d",x"6d",x"92",x"92",x"6e",x"6e",x"92",x"92",x"72",x"92",x"92",x"92",x"92",x"49",x"db",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"db",x"ff",x"ff",x"ff",x"ff",x"ff",x"db",x"b6",x"6d",x"49",x"49",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"20",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"20",x"00",x"00",x"24",x"db",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"49",x"6d",x"92",x"b6",x"db",x"db",x"ff",x"ff",x"ff",x"49",x"00",x"49",x"24",x"24",x"24",x"49",x"49",x"49",x"49",x"49",x"49",x"49",x"49",x"49",x"49",x"49",x"49",x"49",x"24",x"00",x"49",x"49",x"49",x"24",x"24",x"49",x"49",x"49",x"49",x"24",x"24",x"6d",x"6d",x"92",x"ff",x"db",x"92",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"92",x"49",x"49",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"24",x"04",x"24",x"24",x"24",x"24",x"00",x"24",x"24",x"24",x"24",x"24",x"6d",x"96",x"92",x"92",x"92",x"49",x"92",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"92",x"49",x"6d",x"6d",x"6d",x"6d",x"6d",x"49",x"49",x"49",x"49",x"49",x"49",x"4d",x"6d",x"6d",x"6d",x"6d",x"6d",x"6d",x"6d",x"6d",x"6d",x"6d",x"6d",x"6d",x"6d",x"49",x"49",x"49",x"49",x"49",x"49",x"49",x"6d",x"6d",x"49",x"49",x"49",x"49",x"6d",x"db",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff"),
(x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff",x"ff")
);


-- one bit mask  0 - off 1 dispaly 
type object_form is array (0 to object_Y_size - 1 , 0 to object_X_size - 1) of std_logic;
constant object1 : object_form := (

("0000000000000000000000000000000000000000000000000000000000000000000000000000000000000"),
("0000000000000000000000000000000000000000000000000000000000000000000000000000000000000"),
("0000000000000000000001111111111111111111111111111111111111111111111111111111111000000"),
("0000000000000000000001111111111111111111111111111111111111111111111111111111110000000"),
("0000000000000000000000000000000000000000000001101110110000000000000000000000000000000"),
("0000000000000000000000000000000000000000000001111111110000000000000000000000000000000"),
("0111111111100000000000000000000000000000000000011111000000000000000000000000000000000"),
("0111111111110000000000000000000000000000000001111111100000000000000000000000000000000"),
("0111111111111100000000000000000000011111111111111111111111111111111111110000000000000"),
("0000111111111110000000000000000000111111111111111111111111111111111111111100000000000"),
("0000111111111111100000000000000011111111111111111111111111111111111111111100000000000"),
("0000011111111111110000000000000111111111111111111000000000111111111111111100000000000"),
("0000011111111111111111111111111111111111111111111000000000111111111111111110000000000"),
("0000001111111111111111111111111111111111111111111000000000011111111111111111000000000"),
("0000001111111111111111111111111111111111111111111000000000011111111111111111100000000"),
("0000000000111111111111111111111111111111111111111000000000011111111111111111100000000"),
("0000000000111111111111111111111111111111111111111000000000001111111111111110110000000"),
("0000000000000000001111111111111111111111111111111000000000001111111111111111111110000"),
("0000000000000000000000001111111111111111111111111000000000001111111111111111111111000"),
("0000000000000000000000000000011111111111111111111000000000000111111111111111111111000"),
("0000000000000000000000000000000111111111111111111000000000000111111111111111111110000"),
("0000000000000000000000000000000000111111111111111000000000000111111111111111111110000"),
("0000000000000000000000000000000000000111111111111000000000000011111111111111111111000"),
("0000000000000000000000000000000000000000111111111111111111111111111111111111111111000"),
("0000000000000000000000000000000000000100000111111111111111111111111111111111111111000"),
("0000000000000000000000000000000000000111111000111111111111111111111111111111111110110"),
("0000000000000000000000000000000000000011111111111111111111111111111111111111111111110"),
("0000000000000000000000000000000000000000011111111111111111111111111111111111111111100"),
("0000000000000000000000000000000000000000000000000000000000000000000000000000000000000"),
("0000000000000000000000000000000000000000000000000000000000000000000000000000000000000")


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
	
	--- i want to print a picture every 750000
 	
   begin
	
	if RESETn = '0' then
	    mVGA_RGB	<=  (others => '0') ; 	
		drawing_request	<=  '0' ;

		elsif rising_edge(CLK) then
				mVGA_RGB	<=  object_colors1(bCoord_Y , bCoord_X);	--get from colors table 
			   drawing_request	<= object1(bCoord_Y , bCoord_X) and drawing_X and drawing_Y and draw_order; -- get from mask table if inside rectangle 			

	end if;

  end process;

		
end behav;		
		