
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY testbox IS
	GENERIC(
	
		T : INTEGER := 0; --draws greaterthan
		B : INTEGER := 100; --draws less than
		L : INTEGER := 100; -- draws greaterthan
		R : INTEGER := 200); -- draws lestthan
		
	PORT(
		enable : IN STD_LOGIC;
		TOUT		: 	OUT	INTEGER; --draws greaterthan
		BOUT	:	OUT INTEGER; --draws less than
		LOUT 		:	OUT INTEGER; -- draws greaterthan
		ROUT	:	OUT INTEGER); -- draws lestthan
		
END testbox;

ARCHITECTURE behavior OF testbox IS
BEGIN
	PROCESS (enable)
		BEGIN
		
			IF(enable = '1') THEN
		
				TOUT <= T;
				BOUT <= B;
				LOUT <= L;
				ROUT <= R;
		
			END IF;
			
	END PROCESS;
END behavior;