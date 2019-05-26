library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;
-- Alex Grinshpun March 24 2017 
-- Dudy Nov 13 2017


entity ceiling_move is
port 	(
		CLK				: in std_logic; --	         // 27 MHz
		RESETn			: in std_logic; --			//	50 MHz
		timer_done		: in std_logic;
	    -- make			: in std_logic;
		-- break			: in std_logic;
--		keyIN		    : in std_logic_vector(8 downto 0);        
		ObjectStartX	: out integer ;
		ObjectStartY	: out integer
		
	);
end ceiling_move;

architecture behav of ceiling_move is 
constant StartX : integer := 0;   -- starting point at the middle
constant StartY : integer := 0;   


signal ObjectStartX_t : integer range 0 to 640;  --vga screen size 
signal ObjectStartY_t : integer range 0 to 480;


begin
	process (RESETn,CLK)
	variable flag : std_logic := '0' ;
		begin
		if RESETn = '0' then
				ObjectStartX_t	<= StartX;
				ObjectStartY_t	<= StartY ;
				
	    elsif (rising_edge(CLK))  then
			  


			         if timer_done = '1'then  

					         
							             if (ObjectStartX_t>0) then
											     ObjectStartX_t <= ObjectStartX_t - 3;
												  
												else  
												ObjectStartX_t <= ObjectStartX_t + 640;
												
												end if; 
                          						   
					  end if;		


	   	end if;
	end process;
ObjectStartX	<= ObjectStartX_t;		-- copy to outputs 	
ObjectStartY	<= ObjectStartY_t;	

end behav;

