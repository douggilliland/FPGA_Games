
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY numpusherbottom IS
	GENERIC(
	
		X :	INTEGER := 900 
		
	);
			
	PORT(
		enable : IN STD_LOGIC;
		
		a		: 	OUT	INTEGER;
		b		: 	OUT	INTEGER;
		c		: 	OUT	INTEGER;
		
		d		: 	OUT	INTEGER;
		e		: 	OUT	INTEGER;
		f		: 	OUT	INTEGER;
		
		g		: 	OUT	INTEGER;
		h		: 	OUT	INTEGER;
		i		: 	OUT	INTEGER
		
		); --draws greaterthan
		
END numpusherbottom;

ARCHITECTURE behavior OF numpusherbottom IS
BEGIN

--sensitivity aka process(clk, ain, bin)	even an enable would do thats just hooked up to vcc. then everything may need to be in a if(enable='1') statement
	PROCESS(enable)
			BEGIN
			
			IF(enable ='1') THEN
				a <= X;
				b <= X;
				c <= X;
				d <= X;
				e <= X;
				f <= X;
				g <= X;
				h <= X;
				i <= X;

			END IF;
			
	END PROCESS;
END behavior;