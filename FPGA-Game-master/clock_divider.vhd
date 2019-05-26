----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:47:03 04/15/2015 
-- Design Name: 
-- Module Name:    clock_divider - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clk_divider is
    Port ( clk : in  STD_LOGIC;
           pixel_clock : out  STD_LOGIC);
end clk_divider;

architecture Behavioral of clk_divider is
signal counter : STD_LOGIC_VECTOR(2 downto 0);
signal temp_clock : STD_LOGIC;

begin

    process(clk)
	 begin
	 
	     if RISING_EDGE(clk) then
		      
				if counter < "101" then
				    
					 counter <= counter + 1;
					 
				else
				    
					 counter <= (others => '0');
					 
					 temp_clock <= not temp_clock;
				
				end if;
		end if;
end process;

pixel_clock <= temp_clock;

end Behavioral;