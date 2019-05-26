----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:09:57 12/11/2015 
-- Design Name: 
-- Module Name:    AdderN - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: sumador modulo n
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity adder is
   generic (width : natural);
	port(a    : in std_logic_vector  (width-2 downto 0);
		  b    : in std_logic_vector  (width-1  downto 0);
		  cout : out std_logic_vector (width-1  downto 0));
		  
end adder;

architecture Behavioral of adder is
	
begin

	cout <= std_logic_vector(unsigned(a) + unsigned(b));

end Behavioral;

