library ieee ;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;
 -----------------------------------------------------------------------
 -- turbo_counter
 -----------------------------------------------------------------------


 entity TCounter is
	port (CLK , RESETN , Turbo : in std_logic;
		   OneSec : out std_logic;
			duty50 : out std_logic );
	end entity ;

 architecture TCounter_arch of TCounter is
	begin
		process(CLK,RESETN,Turbo)
			variable counter : integer ;
			variable t : integer;
			constant sec: integer := 50000000 ; -- for Real operation
			constant half_sec : integer := 25000000;
		-- constant sec: integer := 5 ; -- for simulation
		begin
			if RESETN = '0' then
				counter := 0 ;
				OneSec <= '0' ;
			elsif rising_edge(CLK) then
				if Turbo = '1' then
					t := 10;
				else
					t := 1;
				end if;
				counter := counter + t ;
				if (counter >= sec) then
					OneSec <= '1' ;
					counter := 0 ;
				else
					OneSec <= '0';
				end if;
				if (counter >= half_sec) then
					duty50 <= '1';
				else
					duty50 <= '0';
				end if;
			end if;
		end process;
 end TCounter_arch; 
 
 
 
 
 
 
 
 