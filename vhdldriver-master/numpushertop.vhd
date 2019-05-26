
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY numpushertop IS
	GENERIC(
	
		X :	INTEGER := 700 
		
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
		
END numpushertop;

ARCHITECTURE behavior OF numpushertop IS
BEGIN
	PROCESS(enable)
			BEGIN
			
			IF(enable='1') THEN
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