library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity  BCDDownCounter is
   Port ( 
       
        startMin1,startMin0,startSec1,startSec0: in std_logic_vector(3 downto 0);
        Min1Out,Min0Out,Sec1Out,Sec0Out: out std_logic_vector(3 downto 0);
        frame_clk,Reset: in std_logic;        
        Over: out std_logic);       
        
end BCDDownCounter;




architecture Behavioral of BCDDownCounter is


signal clk,overSig: std_logic;
signal Min1Sig,Min0Sig,Sec1Sig,Sec0Sig: std_logic_vector(3 downto 0);
signal counter: std_logic_vector(6 downto 0);
begin------------------------------------------------

process_clk: process(frame_clk)

begin
    if(Reset = '1') then  
		counter<="0000000";
		clk<='0';
	elsif(rising_edge(frame_clk))then 
		counter<=counter+"0000001";
		if (counter="0011110") then -- adjust this line for counting speed
--		if (counter="0000001") then 
			clk<=not clk;
			counter<="0000000";
		end if;		
	end if;
end process;



  num_display: process(Reset,clk,Min1Sig,Min0Sig,Sec1Sig,Sec0Sig)

  begin		
      
    if(Reset = '1') then   --Asynchronous Reset
		Min1Sig<=startMin1;
		Min0Sig<=startMin0;
		Sec1Sig<=startSec1;
		Sec0Sig<=startSec0;
		overSig<='0';
    elsif(rising_edge(clk)) then
		
		if (Sec0Sig="0000")then --if sec0 becomes 0, reset sec0 to 9, and decrement sec1
		Sec1Sig<=Sec1Sig-"0001";
		Sec0Sig<="1001";
		else
		Sec0Sig<=Sec0Sig+ not "0001" + 1;
		end if;
		
		
		if (Sec1Sig="0000" and Sec0Sig="0000" )then -- if sec0/1 both are 0, reset sec1 to 9, and decrement min0
		Min0Sig<=Min0Sig-"0001";
		Sec1Sig<="0101";
		end if;
		
		if (Min0Sig="0000" and Sec1Sig="0000" and Sec0Sig="0000" )then --if sec0/1, min0 are 0, reset min0 to 9, and decrement min1
		Min1Sig<=Min1Sig-"0001";
		Min0Sig<="1001";
		end if;
    
		if (Min1Sig & Min0Sig & Sec1Sig & Sec0Sig="0000000000000000")then --flag overSig when the counting in is over
			overSig<='1';
		end if;
    
    
  
    end if;
      
      
      
      
      
  end process num_display;
  
  
   Min1Out<=Min1Sig;
   Min0Out<=Min0Sig;
   Sec1Out<=Sec1Sig;
   Sec0Out<=Sec0Sig;
   Over<=overSig;
  
  
end Behavioral;      
