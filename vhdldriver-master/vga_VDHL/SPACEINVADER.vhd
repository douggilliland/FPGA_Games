LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY SPACEINVADER IS
	GENERIC(
		
		SCREEN_WIDTH : INTEGER := 1280;
		SCREEN_HEIGHT : INTEGER := 1040;
		pos_y :	INTEGER := (0*(1040/15));    --row that first color will persist until
		pos_x	:	INTEGER := (0*(1280/15));   --column that first color will persist until
		SIZE_Y : INTEGER :=(1040/15);
		SIZE_X : INTEGER :=(1280/15));
		
	PORT(
		disp_ena		:	IN		STD_LOGIC;	--display enable ('1' = display time, '0' = blanking time)
		row			:	IN		INTEGER;		--row pixel coordinate
		column		:	IN		INTEGER;		--column pixel coordinate
		red			:	OUT	STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');  --red magnitude output to DAC
		green			:	OUT	STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');  --green magnitude output to DAC
		blue			:	OUT	STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0')); --blue magnitude output to DAC
END SPACEINVADER;

ARCHITECTURE behavior OF SPACEINVADER IS
type matrix is array(15 downto 0, 15 downto 0) of INTEGER range 0 to 5; --the map! "1" if enemy, "0" if empty
BEGIN
	PROCESS(disp_ena, row, column)
	variable gamemap : matrix;
	
	BEGIN
		gamemap(0,2) := 1;
		IF(disp_ena = '1') THEN		--display time
		--test box
			IF((row > pos_x) AND (row < (pos_x+SIZE_X)) AND (column > pos_y) AND (column < (pos_y+SIZE_Y))) THEN
				red <= (OTHERS => '0');
				green	<= (OTHERS => '1');
				blue <= (OTHERS => '0');
			
			ELSE
				red <= (OTHERS => '0');
				green	<= (OTHERS => '0');
				blue <= (OTHERS => '0');
			END IF;
		ELSE								--blanking time
			red <= (OTHERS => '0');
			green <= (OTHERS => '0');
			blue <= (OTHERS => '0');
		END IF;
	
	END PROCESS;
END behavior;