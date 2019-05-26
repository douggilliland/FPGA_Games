library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;
-- Alex Grinshpun March 24 2017 
-- Dudy Nov 13 2017


entity random_life is
port 	(
		CLK				: in std_logic; --	         // 27 MHz
		RESETn			: in std_logic; --			//	50 MHz
      random_startx  : out integer  ;
    	random_starty  : out integer  	

		
	);
end random_life ;

architecture behav of random_life is 
constant StartX : integer := 639;   -- starting point at the middle
constant max_num : integer := 400;
constant min_num : integer := 80 ; 
begin
	process (RESETn,CLK)
	   variable count_up : integer := 80 ;
	   variable count_down  : integer := 420 ;
      variable flag : std_logic := '1' ; 
		begin
		    if rising_edge(CLK ) then 
			 
	          count_up := count_up +12 ; 
		       if count_up >= max_num  then 
		           count_up := 80;
			     end if ;		
	
			    count_down := count_down -12 ;
		     	if count_down <= min_num then 
			       count_down := 400 ;
		     	end if;
				
				if flag = '0' then 
				    random_starty <= count_up ;
					 flag := '1' ;
				else 
				    random_starty <= count_down ;
					 flag := '0' ;
				end if ;
				
				 random_startx <= StartX ;
				 
				end if ;

            
			end process ;
end behav ;
				   
				    
	