
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY farrightpush IS
	GENERIC(
	
		X :	INTEGER := 1700 
		
	);
			
	PORT(
	
		q		: 	OUT	INTEGER

		
		); --draws greaterthan
		
END farrightpush;

ARCHITECTURE behavior OF farrightpush IS
BEGIN
	PROCESS 
			BEGIN

				q <= X;

			
	
			
	END PROCESS;
END behavior;