-- Architecture definition for the SimpleFSM entity

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY FSMgame IS
PORT(
		Lin	:	IN		STD_LOGIC;
		Rin	:	IN		STD_LOGIC;
		
		clk	:	IN		STD_LOGIC;
		reset	:	IN		STD_LOGIC;
		
		a		: 	OUT	STD_LOGIC;
		b		: 	OUT	STD_LOGIC;
		c		: 	OUT	STD_LOGIC;
		
		d		: 	OUT	STD_LOGIC;
		e		: 	OUT	STD_LOGIC;
		f		: 	OUT	STD_LOGIC;
		
		g		: 	OUT	STD_LOGIC;
		h		: 	OUT	STD_LOGIC;
		i		: 	OUT	STD_LOGIC
);
END FSMgame;

Architecture RTL of FSMgame is
TYPE State_type IS ( As, Bs, Cs, Ds, Es, Fs, Gs, Hs, Ist);  -- Define the states
	SIGNAL State : State_Type := Es;    -- Create a signal that uses 
	
							      -- the different states
BEGIN 
  PROCESS (clk,reset, Lin, Rin) 
  BEGIN 
   -- If (reset = '1') THEN            -- Upon reset, set the state to AState <= A;
				--State <= Es;
    IF rising_edge(clk) THEN    -- if there is a rising edge of the
			 -- clock, then do the stuff below
 
	-- The CASE statement checks the value of the State variable,
	-- and based on the value and any other control signals, changes
	-- to a new state.
	CASE State IS
 
		-- If the current state is A and P is set to 1, then the
		-- next state is B
		WHEN As => 
				a<= '1';
				b<= '0';
				c<= '0';
				d<= '0';
				e<= '0';
				f<= '0';
				g<= '0';
				h<= '0';
				i<= '0';
			IF Rin='1' THEN 
				State <= Bs; 
			ELSE
				State <= As;
			END IF; 
 
		-- If the current state is B and P is set to 1, then the
		-- next state is C
		WHEN Bs => 
				a<= '0';
				b<= '1';
				c<= '0';
				d<= '0';
				e<= '0';
				f<= '0';
				g<= '0';
				h<= '0';
				i<= '0';
			IF Rin='1' THEN 
				State <= Cs; 
			ELSIF Lin='1' THEN
				State <= As;
			ELSE
				State <= Bs;
			END IF; 
 
		-- If the current state is C and P is set to 1, then the
		-- next state is D
		WHEN Cs => 
				a<= '0';
				b<= '0';
				c<= '1';
				d<= '0';
				e<= '0';
				f<= '0';
				g<= '0';
				h<= '0';
				i<= '0';
			IF Rin='1' THEN 
				State <= Ds; 
			ELSIF(Lin='1') THEN
				State <=Bs;
			ELSE
				State <= Cs;
			END IF; 
		WHEN Ds=> 
				a<= '0';
				b<= '0';
				c<= '0';
				d<= '1';
				e<= '0';
				f<= '0';
				g<= '0';
				h<= '0';
				i<= '0';
			IF Rin='1' THEN 
				State <= Es; 
			ELSIF Lin='1' THEN
				State <= Cs; 
			ELSE
				State <= Ds;
			END IF; 
		WHEN Es=> 
				a<= '0';
				b<= '0';
				c<= '0';
				d<= '0';
				e<= '1';
				f<= '0';
				g<= '0';
				h<= '0';
				i<= '0';
			IF Rin='1' THEN 
				State <= Fs; 
			ELSIF Lin='1' THEN
				State <= Ds; 
			ELSE
				State <= Es;
			END IF; 
		WHEN Fs=> 
				a<= '0';
				b<= '0';
				c<= '0';
				d<= '0';
				e<= '0';
				f<= '1';
				g<= '0';
				h<= '0';
				i<= '0';
			IF Rin='1' THEN 
				State <= Gs; 
			ELSIF Lin='1' THEN
				State <= Es; 
			ELSE
				State <= Fs;
			END IF; 
		WHEN Gs=> 
				a<= '0';
				b<= '0';
				c<= '0';
				d<= '0';
				e<= '0';
				f<= '0';
				g<= '1';
				h<= '0';
				i<= '0';
			IF Rin='1' THEN 
				State <= Hs; 
			ELSIF Lin='1' THEN
				State <= Fs; 
			ELSE
				State <= Gs;
			END IF; 
		WHEN Hs=> 
				a<= '0';
				b<= '0';
				c<= '0';
				d<= '0';
				e<= '0';
				f<= '0';
				g<= '0';
				h<= '1';
				i<= '0';
			IF Rin='1' THEN 
				State <= Ist; 
			ELSIF Lin='1' THEN
				State <= Gs; 
			ELSE
				State <= Hs;
			END IF; 
		WHEN Ist=> 
				a<= '0';
				b<= '0';
				c<= '0';
				d<= '0';
				e<= '0';
				f<= '0';
				g<= '0';
				h<= '0';
				i<= '1';
			IF Lin='1' THEN
				State <= Hs; 
			ELSE
				State <= Ist;
			END IF; 
		WHEN others =>
			State <= As;
			
	END CASE; 
    END IF; 
	-- END IF;
  END PROCESS;

-- Decode the current state to create the output
-- if the current state is D, R is 1 otherwise R is 0
--R <= '1' WHEN State=D ELSE '0';
END rtl;