library IEEE;
use IEEE.STD_LOGIC_1164.all;
--use IEEE.std_logic_unsigned.all;
--use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
-- Alex Grinshpun April 2017
-- Dudy Nov 13 2017


entity address_coordinates is
port 	(
		--////////////////////	Clock Input	 	////////////////////	
	   	CLK  		: in std_logic;
		RESETn		: in std_logic;
		oCoord_X	: in integer;
		oCoord_Y	: in integer;
		Address		: out std_logic_vector(18 downto 0)
	);
end address_coordinates;

architecture behav of address_coordinates is 

signal adrr_out : integer;

begin


process ( RESETn, CLK)
begin

	
	adrr_out <= 640*oCoord_Y + oCoord_X;
	
	
end  process;
Address <= conv_std_logic_vector(adrr_out,19);

end behav;
