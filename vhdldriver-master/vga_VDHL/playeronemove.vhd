
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY playeronemove IS

	
		
		
		
		
	PORT(
	
		Lin : IN STD_LOGIC;
		Rin : IN STD_LOGIC;
		
		enable : IN STD_LOGIC;
		TOUT		: 	OUT	INTEGER; --draws greaterthan
		BOUT	:	OUT INTEGER; --draws less than
		LOUT 		:	OUT INTEGER; -- draws greaterthan
		ROUT	:	OUT INTEGER; -- draws lestthan
		
		clk : IN STD_LOGIC);
		
END playeronemove;

ARCHITECTURE behavior OF playeronemove IS

		signal movespeed : INTEGER := 1;
		
		signal T : INTEGER ; --draws greaterthan
		signal B : INTEGER ; --draws less than
		signal L : INTEGER ; -- draws greaterthan
		signal R : INTEGER ; -- draws lestthan
BEGIN
	DRAW:PROCESS (enable, T, B, L, R, clk, Rin)
		BEGIN
					T <= 800;
					B <= 900;
					L <= 100;
					R <= 200;
					
			--IF(enable = '1') THEN
				
			
				IF(clk = '1') THEN
				
					TOUT <= T;
					BOUT <= B;
					LOUT <= L;
					ROUT <= R;
				ELSE
					IF((Rin = '1')) THEN
						R <= R+10;
					END IF;
				END IF;
				
		--	ELSE
					
		--		TOUT <= 0;
		--		BOUT <= 0;
		--		LOUT <= 0;
		--		ROUT <= 0;
			
			--END IF;

		
	END PROCESS; --end draw

END behavior;