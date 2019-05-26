
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY numpusherLR IS

			
	PORT(
		Lin		: 	IN	INTEGER;
		L		: 	OUT	INTEGER;
		R		: 	OUT	INTEGER
		
		); --draws greaterthan
		
END numpusherLR;

ARCHITECTURE behavior OF numpusherLR IS
BEGIN
	PROCESS 
			BEGIN

				L <= Lin;
				R <= Lin+100;
				
			
	
			
	END PROCESS;
END behavior;