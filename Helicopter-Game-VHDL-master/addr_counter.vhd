library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all ;
--constant count_size 			: integer := 15;
entity addr_counter is 
	
	port( 
				CLK_IN : in std_logic; 
				resetN : in std_logic; 
				en : in std_logic ; 
				en1 : in std_logic ;
				addr : out std_logic_vector(14 downto 0 )
			); 
end addr_counter;
architecture arc_addr_counter of addr_counter is 
	signal tmp_out : std_logic_vector(14 downto 0 ); 
	begin 
			process(CLK_IN , resetN) 
				begin 
					if(resetN = '0') then 
						tmp_out<=(others => '0') ;
					elsif(rising_edge(CLK_IN)) then 
						if(en = '0' ) then 
							tmp_out<=tmp_out; 
						else 
							if(en1 ='1' ) then 
								tmp_out <= tmp_out + '1' ;
							else 
								tmp_out<=tmp_out; 
							end if ; 
						end if ; 
					end if ;
				end process; 
				addr<=tmp_out; 
end arc_addr_counter; 
					