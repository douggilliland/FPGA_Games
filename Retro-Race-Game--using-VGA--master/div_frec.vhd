library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY div_frec IS
PORT(CLK: in std_logic;
	  LVL: in std_logic_vector(2 downto 0);
	  CLK_GAME:out std_logic;
     CLK_Prima: out std_logic);    
 END div_frec;

architecture RTL of div_frec is
	signal ciclos: std_logic;
	signal ciclos_game: std_logic_vector(25 downto 0);
	signal x: integer range 0 to 50000000;
	signal y: integer range 0 to 10;
begin

x <= conv_integer(ciclos_game);
y <= conv_integer(LVL);

Process(CLK)
begin
if(rising_edge(CLK)) then 

	if(ciclos < '1')then
		CLK_Prima <= '0';
		ciclos <= '1';
	else
		CLK_Prima <= '1';
		ciclos <= '0';
	end if;
	
	if(x<(50000000/((y+2)*4)))then
		CLK_GAME<='0';
		ciclos_game<=ciclos_game+'1';
	else
		CLK_GAME<='1';
		ciclos_game<="00000000000000000000000000";
	end if;
	
else null;	
end if;

end process;       
END RTL;

