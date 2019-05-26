library IEEE;
use IEEE.STD_LOGIC_1164.all;
--use IEEE.std_logic_unsigned.all;
--use ieee.numeric_std.all;
--use ieee.std_logic_arith.all;
-- Alex Grinshpun April 2017
-- Dudy Nov 13 2017


entity ahlamrandom is
port 	(
		--////////////////////	Clock Input	 	////////////////////	
	   CLK  		: in std_logic;
		timer_done		: in std_logic;
		ObjectStartX	: out integer;
		ObjectStartY 	: out integer;
		draw_order : out std_logic 
		); 
end ahlamrandom;

architecture behav of ahlamrandom is 
		constant max_num : integer := 400;
		constant min_num : integer := 80 ;
begin 
      process(CLK ) 
		variable count_up : integer := 80 ;
		variable count_down  : integer := 400 ;
		variable flag : std_logic := '1' ; 
		variable counter : integer := 0 ;
		begin 
		if rising_edge(CLK ) then
		
	      count_up := count_up +1 ; 
		   if count_up >= max_num  then 
		      count_up := 80;
			end if ;
			
			count_down := count_down -1 ;
			if count_down <= min_num then 
			    count_down := 400 ;
			end if; 
			
			if timer_done='1' then 
			
			   counter:= counter +1 ; 
				
			   if counter >= 1000 then 
			         counter :=0;
			   end if;
				
			
			   if (counter)mod(200) =0 then 
				 
		         if flag='1' then 
			          ObjectStartY <= count_up ;
				       flag := '0' ;
			      else 
			         ObjectStartY <= count_down ;
				      flag := '1' ;
		        	end if ;
					
					
			        ObjectStartX <= 550 ;
				     draw_order <= '1' ;
				  else 
				      draw_order <='0' ;
				  end if ;
				  
				  
			end if; 
		end if ;
		end process ;
end behav;
				  
		
			    
		   
		   
		
		
		
		
		
		
		
		
		
		