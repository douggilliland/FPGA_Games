--------------------------------------------------------------------------------
--
--   FileName:         hw_image_generator.vhd
--   Dependencies:     none
--   Design Software:  Quartus II 64-bit Version 12.1 Build 177 SJ Full Version
--
--   HDL CODE IS PROVIDED "AS IS."  DIGI-KEY EXPRESSLY DISCLAIMS ANY
--   WARRANTY OF ANY KIND, WHETHER EXPRESS OR IMPLIED, INCLUDING BUT NOT
--   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
--   PARTICULAR PURPOSE, OR NON-INFRINGEMENT. IN NO EVENT SHALL DIGI-KEY
--   BE LIABLE FOR ANY INCIDENTAL, SPECIAL, INDIRECT OR CONSEQUENTIAL
--   DAMAGES, LOST PROFITS OR LOST DATA, HARM TO YOUR EQUIPMENT, COST OF
--   PROCUREMENT OF SUBSTITUTE GOODS, TECHNOLOGY OR SERVICES, ANY CLAIMS
--   BY THIRD PARTIES (INCLUDING BUT NOT LIMITED TO ANY DEFENSE THEREOF),
--   ANY CLAIMS FOR INDEMNITY OR CONTRIBUTION, OR OTHER SIMILAR COSTS.
--
--   Version History
--   Version 1.0 05/10/2013 Scott Larson
--     Initial Public Release
--    
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY pong IS
	--GENERIC(
		
		--pixels_y :	INTEGER := 478;    --row that first color will persist until
		--pixels_x	:	INTEGER := 600;   --column that first color will persist until
		
	--	b1topline : INTEGER := 0; --draws greaterthan
	--	b1bottomline : INTEGER := 200; --draws less than
	--	b1leftline : INTEGER := 0; -- draws greaterthan
	--	b1rightline : INTEGER := 200; -- draws lestthan
		
	--	b2topline : INTEGER := 900; --draws greaterthan
	--	b2bottomline : INTEGER := 1000; --draws less than
	--	b2leftline : INTEGER := 100; -- draws greaterthan
	--	b2rightline : INTEGER := 200); -- draws lestthan
		
	PORT(
		clk	:	IN		STD_LOGIC;
	
		disp_ena		:	IN		STD_LOGIC;	--display enable ('1' = display time, '0' = blanking time)
		row			:	IN		INTEGER;		--row pixel coordinate
		column		:	IN		INTEGER;		--column pixel coordinate
		
		--block 1
		b1topline		: 	IN	INTEGER; --draws greaterthan
		b1bottomline	:	IN INTEGER; --draws less than
		b1leftline 		:	IN INTEGER; -- draws greaterthan
		b1rightline 	:	IN INTEGER; -- draws lestthan
		
		--block 2
		b2topline		: 	IN	INTEGER; --draws greaterthan
		b2bottomline	:	IN INTEGER; --draws less than
		b2leftline 		:	IN INTEGER; -- draws greaterthan
		b2rightline 	:	IN INTEGER; -- draws lestthan
		
		b3topline : IN INTEGER;
		b3bottomline :IN INTEGER;
	b3leftline   :IN INTEGER;
	b3rightline  :IN INTEGER;

--block 4
b4topline    :IN INTEGER;
b4bottomline :IN INTEGER;
b4leftline   :IN INTEGER;
b4rightline  :IN INTEGER;

--block 5
b5topline    :IN INTEGER;
b5bottomline :IN INTEGER;
b5leftline   :IN INTEGER;
b5rightline  :IN INTEGER;

--block 6
b6topline    :IN INTEGER;
b6bottomline :IN INTEGER;
b6leftline   :IN INTEGER;
b6rightline  :IN INTEGER;

--block 7
b7topline    :IN INTEGER;
b7bottomline :IN INTEGER;
b7leftline   :IN INTEGER;
b7rightline  :IN INTEGER;

--block 8
b8topline    :IN INTEGER;
b8bottomline :IN INTEGER;
b8leftline   :IN INTEGER;
b8rightline  :IN INTEGER;

--block 9
b9topline    :IN INTEGER;
b9bottomline :IN INTEGER;
b9leftline   :IN INTEGER;
b9rightline  :IN INTEGER;


		
		red			:	OUT	STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');  --red magnitude output to DAC
		green			:	OUT	STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');  --green magnitude output to DAC
		blue			:	OUT	STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0')); --blue magnitude output to DAC
END pong;

ARCHITECTURE behavior OF pong IS
BEGIN
	PROCESS(clk, disp_ena, row, column, b1topline, b1bottomline, b1leftline, b1rightline, b2topline, b2bottomline, b2leftline, b2rightline,
	b3topline, b3bottomline, b3leftline, b3rightline,
b4topline, b4bottomline, b4leftline, b4rightline,
b5topline, b5bottomline, b5leftline, b5rightline,
b6topline, b6bottomline, b6leftline, b6rightline,
b7topline, b7bottomline, b7leftline, b7rightline,
b8topline, b8bottomline, b8leftline, b8rightline,
b9topline, b9bottomline, b9leftline, b9rightline
)
	
		
	BEGIN
	
		IF(clk'EVENT AND clk = '1') THEN
		
			IF(disp_ena = '1') THEN		--display time	
			

				IF(row> b1topline AND row<b1bottomline and column>b1leftline and column<b1rightline) THEN  --box 1
					red <= (OTHERS => '1');
					green	<= (OTHERS => '1');
					blue <= (OTHERS => '1');
					
				
				ELSIF (row> b2topline AND row<b2bottomline and column>b2leftline and column<b2rightline) THEN --box 2
						red <= (OTHERS => '1');
						green	<= (OTHERS => '1');
						blue <= (OTHERS => '1');
					
				--block 3
ELSIF (row> b3topline AND row<b3bottomline and column>b3leftline and column<b3rightline) THEN
red <= (OTHERS => '1');
green	<= (OTHERS => '1');
blue <= (OTHERS => '1');
--block 4
ELSIF (row> b4topline AND row<b4bottomline and column>b4leftline and column<b4rightline) THEN
red <= (OTHERS => '1');
green	<= (OTHERS => '1');
blue <= (OTHERS => '1');
--block 5
ELSIF (row> b5topline AND row<b5bottomline and column>b5leftline and column<b5rightline) THEN
red <= (OTHERS => '1');
green	<= (OTHERS => '1');
blue <= (OTHERS => '1');
--block 6
ELSIF (row> b6topline AND row<b6bottomline and column>b6leftline and column<b6rightline) THEN
red <= (OTHERS => '1');
green	<= (OTHERS => '1');
blue <= (OTHERS => '1');
--block 7
ELSIF (row> b7topline AND row<b7bottomline and column>b7leftline and column<b7rightline) THEN
red <= (OTHERS => '1');
green	<= (OTHERS => '1');
blue <= (OTHERS => '1');
--block 8
ELSIF (row> b8topline AND row<b8bottomline and column>b8leftline and column<b8rightline) THEN
red <= (OTHERS => '1');
green	<= (OTHERS => '1');
blue <= (OTHERS => '1');
--block 9
ELSIF (row> b9topline AND row<b9bottomline and column>b9leftline and column<b9rightline) THEN
red <= (OTHERS => '1');
green	<= (OTHERS => '1');
blue <= (OTHERS => '1');


--added wednsday 
ELSIF (row> 0 AND row<1100 and column>900 and column<1100) THEN
		red <= (OTHERS => '1');
		green	<= (OTHERS => '1');
		blue <= (OTHERS => '0');

			
			
			
					ELSE
						red <= (OTHERS => '0');
						green	<= (OTHERS => '0');
						blue <= (OTHERS => '0');
						
					
				END IF; --end of draw	
				
				
			ELSE
						red <= (OTHERS => '1');
						green	<= (OTHERS => '1');
						blue <= (OTHERS => '0');
						
						
			
			
		--	IF(row < pixels_y AND column < pixels_x) THEN
		--		red <= (OTHERS => '1');
		--		green	<= (OTHERS => '1');
		--		blue <= (OTHERS => '1');
		--	ELSIF (row > pixels_y AND column < pixels_x) THEN
		--		red <= (OTHERS => '1');
		--		green	<= (OTHERS => '1');
		--		blue <= (OTHERS => '1');
		--	ELSE
		--		red <= (OTHERS => '0');
		--		green	<= (OTHERS => '0');
		--		blue <= (OTHERS => '0');
		--	END IF;
			
			
			END IF; -- end of (if display enable)

		END IF; -- end of clk
		
	END PROCESS;
END behavior;