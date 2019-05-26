library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;
-- Alex Grinshpun March 24 2017 
-- Dudy Nov 13 2017


entity coin_move1 is
port 	(
		CLK				: in std_logic; --	         // 27 MHz
		RESETn			: in std_logic; --			//	50 MHz
		timer_done		: in std_logic; 
      random_startx  : in integer  ;
    	random_starty  : in integer ; 
	   coin_remove     : in std_logic ;
      stop_game       : in std_logic ; 		
		ObjectStartX	: out integer ;
		ObjectStartY	: out integer

	);
end coin_move1 ;

architecture behav of coin_move1 is 
constant StartX : integer := 639;   -- starting point at the middle
constant StartY : integer := 540; 
constant delay : integer := 20; 
 

signal ObjectStartX_t : integer ;  --vga screen size 
signal ObjectStartY_t : integer ;
signal ena : std_logic := '1' ;
signal first_ena : std_logic := '0' ; 

begin
	process (RESETn,CLK)
	 variable counter : integer := 0;
		begin
		if RESETn = '0' then
				ObjectStartX_t	<= StartX;
				ObjectStartY_t	<= StartY ;
				first_ena <= '0' ;
				counter := 0;
				ena <= '1';
				
				
	    elsif (rising_edge(CLK))  then
			  
                  if coin_remove = '1' then 
						   ObjectStartX_t <= random_startx  ; 
							ObjectStartY_t  <= random_starty ;
						end if; 

			         if timer_done = '1'then
						
						         if stop_game = '1' then 
									   ObjectStartY_t <= ObjectStartY_t ;
										ObjectStartX_t <= ObjectStartX_t ;
										
								   else	
					            counter := counter +1 ; 
								    if counter >= delay then 
									     first_ena <= '1' ;
									 else 
									      first_ena <= '0' ;
									 end if ;
									 
						        
						     if first_ena = '1' then 
						
						         if ena ='1' then 
									   ObjectStartX_t <= random_startx ;
								      ObjectStartY_t  <= random_starty ;
								      ena <= '0';		

		                      else  
										      
	                            ObjectStartX_t <= ObjectStartX_t - 3;
										 if ObjectStartX_t <= 0 then 
										     ena <= '1' ;
												 
									     end if ;
										 

								    end if; 
					      end if;
									
               						   
					  	end if;
               end if ;
	   	end if;
	end process;
ObjectStartX	<= ObjectStartX_t;		-- copy to outputs 	
ObjectStartY	<= ObjectStartY_t;	

end behav;

