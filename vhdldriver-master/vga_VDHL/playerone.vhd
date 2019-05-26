
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY playerone IS
			
	PORT(
	
		enable 	: 	IN 	STD_LOGIC;
		TOUT		: 	OUT	INTEGER; --draws greaterthan
		BOUT		:	OUT 	INTEGER; --draws less than
		LOUT 		:	OUT 	INTEGER; -- draws greaterthan
		ROUT		:	OUT 	INTEGER; -- draws lestthan
		
		
		T : IN INTEGER; --draws greaterthan
		B : IN INTEGER; --draws less than
		L : IN INTEGER; -- draws greaterthan
		R : IN INTEGER); -- draws lestthan
		
END playerone;

ARCHITECTURE behavior OF playerone IS
BEGIN
	PROCESS (enable)
		BEGIN
		
			IF(enable = '1') THEN
		
				TOUT <= T;
				BOUT <= B;
				LOUT <= L;
				ROUT <= R;
				
			ELSE
				
				TOUT <= 0;
				BOUT <= 0;
				LOUT <= 0;
				ROUT <= 0;
			
			END IF;
			
	END PROCESS;
END behavior;