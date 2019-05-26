library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;
-- Alex Grinshpun March 24 2017 
-- Dudy Nov 13 2017


entity helicoptermove is
port 	(
		CLK				: in std_logic; --	         // 27 MHz
		RESETn			: in std_logic; --			//	50 MHz
		timer_done		: in std_logic;
	    -- make			: in std_logic;
		-- break			: in std_logic;
		Move            : in std_logic;
--		keyIN		    : in std_logic_vector(8 downto 0);  
       stop_game      : in std_logic ;  
		ObjectStartX	: out integer ;
		ObjectStartY	: out integer
		
	);
end helicoptermove;

architecture behav of helicoptermove is 
constant StartX : integer := 150;   -- starting point at the middle
constant StartY : integer := 100;   


signal ObjectStartX_t : integer range 0 to 640;  --vga screen size 
signal ObjectStartY_t : integer range 0 to 480;


begin
	process (RESETn,CLK,stop_game)
	variable flag : std_logic := '0' ;
		begin
		if RESETn = '0' then
				ObjectStartX_t	<= StartX;
				ObjectStartY_t	<= StartY ;
				
	    elsif (rising_edge(CLK))  then



			         if timer_done = '1'then  
						
						         if stop_game = '1' then 
									   ObjectStartY_t <= ObjectStartY_t ;
										ObjectStartX_t <= ObjectStartX_t ;
										
								   else 		
				           
					            if  Move='1' then --75 up arrow //keyIN(8 downto 0) = "001110101" and
							               ObjectStartY_t <= ObjectStartY_t - 5;

		                        else  
										      
	                                 ObjectStartY_t <= ObjectStartY_t + 2;
								 
						         end if;
									end if ; 
                          						   
					  end if;		


	   	end if;
					     ObjectStartX	<= ObjectStartX_t;		-- copy to outputs 	
              ObjectStartY	<= ObjectStartY_t;		
			
	end process;


end behav;

