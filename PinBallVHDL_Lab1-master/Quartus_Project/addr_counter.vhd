LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

ENTITY addr_counter IS
GENERIC ( COUNT_SIZE		: INTEGER := 8);
PORT (
			CLK_IN			:	IN	STD_LOGIC;	
			resetN			:	IN	STD_LOGIC;
			en					: 	in  std_logic ;
			en1				: 	in  std_logic ;
			addr				: 	out std_logic_vector(COUNT_SIZE - 1 downto 0)
		);

END addr_counter;


	
architecture addr_counter_arch of 		addr_counter is

	constant count_limit : std_logic_vector(COUNT_SIZE - 1 downto 0) := ( others => '1'); -- max value 
	signal addr_helper : std_logic_vector(COUNT_SIZE - 1 downto 0);
begin
	
	process (CLK_IN, resetN, en, en1)
	
		variable counter : integer;
	
	begin
	
		if (resetN = '0') then
			counter := 0;
			addr <= ( others => '0');
			addr_helper <= ( others => '0');

		elsif rising_edge(CLK_IN) then
		
			if en = '1' and en1 = '1' then
				addr <= conv_std_logic_vector(counter, COUNT_SIZE);
				addr_helper <= conv_std_logic_vector(counter, COUNT_SIZE);
				if (addr_helper = count_limit) then
					counter := 0;
				else
					counter := counter + 1;
				end if;
			end if;
		end if;
	end process;
end addr_counter_arch ;