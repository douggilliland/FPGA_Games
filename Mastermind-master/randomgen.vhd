library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity randomgen is
  Port (
   clk:in std_logic;
   a:out std_logic_vector(11 downto 0));
end randomgen;

architecture Behavioral of randomgen is

begin

    Gen:process is
    variable temp:std_logic_vector(11 downto 0) := "000000000001";
    begin
        temp := temp( 10 downto 0 )  & ( temp(11) xor temp(10) );
        a <= temp;
        wait until (clk = '0');
    end process Gen;

end Behavioral;
