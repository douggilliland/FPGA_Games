----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:13:32 04/22/2015 
-- Design Name: 
-- Module Name:    refresh_clock2 - Behavioral 
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

entity refresh_clock2 is
    Port ( clk_60  : in  STD_LOGIC;
           refresh : out  STD_LOGIC );
end refresh_clock2;

architecture Behavioral of refresh_clock2 is
signal count : std_logic_vector(19 downto 0);
signal new_clock : std_logic;
begin

process(clk_60)
begin
    
	 if rising_edge(clk_60) then
	     if count < "11110100001001000000" then -- 1.000.000
		      count <= count + 1;
		  else
		      count <= (others => '0');
				new_clock <= not new_clock;
		  end if;
	  end if;
	  
end process;

refresh <= new_clock;

end Behavioral;















