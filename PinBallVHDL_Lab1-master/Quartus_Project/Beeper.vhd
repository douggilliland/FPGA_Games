library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Beeper is
	port(
			CLK : in std_logic;
			resetN : in std_logic;
			enable : in std_logic;
			endOfFrame: in std_logic;
			beep_en : in std_logic;
			beep_data : in std_logic_vector (2 downto 0);
			beep : out std_logic
	);
end entity;


architecture behave of Beeper is
	
	signal sigBeep : std_logic;
	
begin
	
	beep <= sigBeep;
	
	process (CLK, resetN)
	
	variable frameCount : integer range 0 to 4;
	
	begin
		
		if resetN = '0' then
		
			frameCount := 0;
			sigBeep <= '0';
			
		elsif rising_edge(CLK) then
		
			if enable = '1' then
				
				if endOfFrame ='1' then
				
					if beep_en = '1'  and frameCount = 0 then
						frameCount := frameCount +1;
					end if;
					
					if frameCount /= 0  then
						frameCount := frameCount +1;
						sigBeep <= '1';
					else
						sigBeep <= '0';
					end if;
						
					
				end if;--end of frame;
				
			end if;--enable;
		
		end if;--CLK

	end process;

end architecture;