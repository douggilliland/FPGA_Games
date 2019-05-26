
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY lrpusherVTWO IS

			
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
		i		: 	OUT	INTEGER;
		
		j		: 	OUT	INTEGER;
		k		: 	OUT	INTEGER;
		l		: 	OUT	INTEGER;
		
		m		: 	OUT	INTEGER;
		n		: 	OUT	INTEGER;
		o		: 	OUT	INTEGER;
		
		p		: 	OUT	INTEGER;
		q		: 	OUT	INTEGER;
		r		: 	OUT	INTEGER
		
		); --draws greaterthan
		
END lrpusherVTWO;

ARCHITECTURE behavior OF lrpusherVTWO IS
BEGIN
	PROCESS(enable)
			BEGIN
			
			IF(enable='1') THEN
			
			--need 18 bottim starts at 0 rest increment up by 100
				a <= 900; --usaully1700
				b <= 800;--usaully1600
				c <= 800;--usaully1500
				d <= 700;--usaully1400
				e <= 700;--usaully1300
				f <= 600;--usaully1200
				g <= 600;--usaully1100
				h <= 500;--usaully1000
				i <= 500;--usaully900
				
				j <= 400;--usaully800
				k <= 400;--usaully700
				l <= 300;--usaully600
				m <= 300;--usaully500
				n <= 200;--usaully400
				o <= 200;--usaully300
				p <= 100;--usaully200
				q <= 100;--usaully100
				r <= 0;--usaully0
				
			END IF;
	
			
	END PROCESS;
END behavior;