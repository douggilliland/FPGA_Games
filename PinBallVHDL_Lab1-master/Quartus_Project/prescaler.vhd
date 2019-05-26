-- This module is dividing the 50MHz CLOCK OSC, and sends clock
-- enable it to the appropriate outputs in order to achieve
-- operation at slower rate of individual modules (this is done
-- to keep the whole system globally synchronous).
-- All DACs output are set to 100 KHz. 

 
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;


ENTITY prescaler IS
	PORT
		(
			CLK_IN					:	IN  STD_LOGIC				;	
			resetN					:  IN	 STD_LOGIC;
			count_limit          :  IN  INTEGER  RANGE 0 to 32768;
			prescaler_1	 		:	OUT STD_LOGIC ;
			prescaler_2	 		:	OUT STD_LOGIC 
		);
		
END prescaler;


ARCHITECTURE behave OF prescaler IS



SIGNAL PRESCALER_COUNTER		: INTEGER ;
SIGNAL prescaler_1_t					: STD_LOGIC						;

	BEGIN

		
	PROCESS (CLK_IN, resetN)
			BEGIN
				IF resetN = '0' then
					prescaler_1_t	<= '0';
					PRESCALER_COUNTER	<= 0;
				ELSIF (CLK_IN'EVENT AND CLK_IN = '1') THEN
					prescaler_2	<=	prescaler_1_t; -- 1 clk delay
					
					if  (PRESCALER_COUNTER >= count_limit) then
						prescaler_1_t <= '1' ;
					ELSE 
						prescaler_1_t <= '0';
					END IF;

					IF (PRESCALER_COUNTER >= count_limit) THEN
						PRESCALER_COUNTER <= 0;
					ELSE
						PRESCALER_COUNTER <= PRESCALER_COUNTER + 1;
					END IF;

				END IF;
		END PROCESS;

	prescaler_1	<=		prescaler_1_t;

	END behave;