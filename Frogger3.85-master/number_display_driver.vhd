library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity  NumberDriver is
   Port ( 
       
        Num: in std_logic_vector(3 downto 0); -- 0-9,L,E,N,U display
        Xcenter,Ycenter: in std_logic_vector(9 downto 0); -- 0-9,L,E,N,U display
        
        X: in std_logic_vector(9 downto 0); 
        Y: in std_logic_vector(9 downto 0); 
        
        DoDisplay: out std_logic);
        
        
end NumberDriver;

architecture Behavioral of NumberDriver is


constant NumHeight : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(20, 10);
constant NumWidth : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(15, 10);
constant little  : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(5, 10);

signal DisplaySig : std_logic;

begin------------------------------------------------


  num_display: process(X,Y,Num,Xcenter,Ycenter)
  variable upleft,upup,upright,middle,downleft,downdown,downright: boolean;
  begin		
      
	--set none of the segments is lit by default
    upleft:=false;
    upup:=false;
    upright:=false;
    middle:=false;
    downleft:=false;
    downdown:=false;
    downright:=false;
    
  --start setting each segment according to the x,y centers and (Draw)X, and (Draw)Y
  if (Y>=(Ycenter-NumHeight) and Y<=Ycenter and X<=(Xcenter-NumWidth+little) and X>=(Xcenter-NumWidth)) then
  upleft:=true;
  end if;
  if (Y>=(Ycenter-NumHeight) and Y<=(Ycenter-NumHeight+little) and X<=(Xcenter+NumWidth) and X>=(Xcenter-NumWidth)) then
  upup:=true;
  end if;
  if (Y>=(Ycenter-NumHeight) and Y<=Ycenter and X<=(Xcenter+NumWidth) and X>=(Xcenter+NumWidth-little))then
  upright:=true;
  end if;
  if (Y>=(Ycenter-little+CONV_STD_LOGIC_VECTOR(2, 10)) and Y<=(Ycenter+little-CONV_STD_LOGIC_VECTOR(3, 10)) 
				and X<=(Xcenter+NumWidth) and X>=(Xcenter-NumWidth))then
  middle:=true;
  end if;
  if (Y>=(Ycenter) and Y<=(Ycenter+NumHeight) and X<=(Xcenter-NumWidth+little) and X>=(Xcenter-NumWidth)) then
  downleft:=true;
  end if;
  if (Y<=(Ycenter+NumHeight) and Y>=(Ycenter+NumHeight-little) and X<=(Xcenter+NumWidth) and X>=(Xcenter-NumWidth))then
  downdown:=true;
  end if;
  if (Y>=(Ycenter) and Y<=(Ycenter+NumHeight) and X<=(Xcenter+NumWidth) and X>=(Xcenter+NumWidth-little)) then
  downright:=true;
  end if;
  
		--set the displaySig according to the segments the number needs
		if (Num="0000") then
				if ( upleft or upup or upright or downleft or downdown or downright) then
					DisplaySig<='1';
				else
					DisplaySig<='0';
				end if;				
		elsif	(Num="0001") then
				if  ( upright or downright)then					
					DisplaySig<='1';
				else
					DisplaySig<='0';
				end if;			
	    elsif	(Num="0010") then	
				if  ( upup or upright or middle or downleft or downdown )then					
					DisplaySig<='1';
				else 
					DisplaySig<='0';
				end if;		
				
	    elsif	(Num="0011") then	
				if  ( upup or middle or downdown or downright or upright)then					
					DisplaySig<='1';
				else 
					DisplaySig<='0';
				end if;					
	    elsif	(Num="0100") then	
				if  ( upleft or middle or upright or downright)then					
					DisplaySig<='1';
				else 
					DisplaySig<='0';
				end if;	
		elsif	(Num="0101") then	
				if  ( upup or upleft or middle or downright or downdown)then					
					DisplaySig<='1';
				else 
					DisplaySig<='0';
				end if;	
		elsif	(Num="0110") then	
				if  ( upup or upleft or downleft or middle or downright or downdown)then					
					DisplaySig<='1';
				else 
					DisplaySig<='0';
				end if;	
		elsif	(Num="0111") then	
				if  ( upup or upright or downright)then					
					DisplaySig<='1';
				else 
					DisplaySig<='0';
				end if;	
		elsif	(Num="1000") then	
				if  ( upleft or upup or upright or middle or downleft or downdown or downright)then					
					DisplaySig<='1';
				else 
					DisplaySig<='0';
				end if;	
		elsif	(Num="1001") then	
				if  ( upleft or upup or upright or middle or downdown or downright)then					
					DisplaySig<='1';
				else 
					DisplaySig<='0';
				end if;	
		elsif	(Num="1010") then	--letter L
				if  ( upleft or downleft or downdown)then					
					DisplaySig<='1';
				else 
					DisplaySig<='0';
				end if;	
		elsif	(Num="1011") then	--letter E
				if  ( upup or upleft or middle or downleft or downdown)then					
					DisplaySig<='1';
				else 
					DisplaySig<='0';
				end if;
		elsif	(Num="1100") then	--letter U
				if  ( upleft or downleft or downdown or downright or upright)then					
					DisplaySig<='1';
				else 
					DisplaySig<='0';
				end if;		
		elsif	(Num="1101") then	--letter N
				if  ( downleft or upleft or upup or upright or downright)then					
					DisplaySig<='1';
				else 
					DisplaySig<='0';
				end if;			
		else 
				DisplaySig <='0';
		end if;   
  end process num_display;

DoDisplay<=DisplaySig;
  
end Behavioral;      
