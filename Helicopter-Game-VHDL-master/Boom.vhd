library IEEE;
use IEEE.STD_LOGIC_1164.all;
--use IEEE.std_logic_unsigned.all;
--use ieee.numeric_std.all;
--use ieee.std_logic_arith.all;
-- Alex Grinshpun April 2017
-- Dudy Nov 13 2017


entity Boom  is
port 	(  
         CLK  		: in std_logic;
		   RESETn		: in std_logic;
		   timer_done		: in std_logic;
			obst1_draw_request : in std_logic ;
			obst2_draw_request : in std_logic ; 
			obst3_draw_request : in std_logic ;
			coin1_draw_request : in std_logic ;
         coin2_draw_request : in std_logic ; 
        	life_draw_request   : in std_logic ;		
			helicopter_draw_request : in std_logic ; 
			cieling_draw_request   : in std_logic ; 
			Bom  : out std_logic  ;
			coin1  : out std_logic ;
			coin2   : out std_logic ; 
			life   : out std_logic  ;
			cieling : out std_logic 
		); 
end Boom;

architecture behav of Boom is
begin
     process(CLK,resetN) 
	  begin
     if resetN = '0' then 
	     Bom <= '0' ;
	
	  elsif rising_edge(CLK) then 
 
			 
			    if helicopter_draw_request='1' and obst1_draw_request='1' then 
				     Bom <= '1' ;
			    elsif helicopter_draw_request='1' and obst2_draw_request='1' then 
				     Bom <= '1' ;
			    elsif helicopter_draw_request='1' and obst3_draw_request='1' then 
				     Bom <= '1' ;				  
				 else 
				     Bom <= '0';
				     
				 end if;
				 
				 if helicopter_draw_request='1' and coin1_draw_request='1' then 
				     coin1 <= '1'; 
				 elsif  helicopter_draw_request='1' and coin2_draw_request='1' then 
				      coin2 <= '1' ;
			   	else 
				    coin1 <= '0' ;
					 coin2<= '0' ; 
				  end if; 
				 
				  if helicopter_draw_request='1' and life_draw_request='1' then 
				     life <= '1' ;
					else 
					   life <= '0' ;
				  end if ;
				  
				  if helicopter_draw_request='1' and cieling_draw_request='1' then 
				     cieling <= '1' ;
					else 
					   cieling <= '0' ;
				  end if ;

	  end if ;

	  end process ;
end behav;


