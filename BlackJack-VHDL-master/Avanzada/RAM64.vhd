----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:37:23 12/11/2015 
-- Design Name: 
-- Module Name:    RAM64 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: RAM de 64 bits para baraja
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

entity ram_memory is
port ( clk  : in std_logic;
       we   : in std_logic;
		 addr : in std_logic_vector  (5 downto 0);
       din  : in std_logic_vector  (3 downto 0);
       dout : out std_logic_vector (3 downto 0));
end ram_memory ;

architecture arch_ram of ram_memory is
	type ram_type is array (0 to 63) of std_logic_vector (3 downto 0) ;
	signal RAM : ram_type :=(
	X"1", X"2", X"3", X"4", X"5", X"6", X"7", X"8", X"9", X"A", X"A", X"A", X"A",
	X"1", X"2", X"3", X"4", X"5", X"6", X"7", X"8", X"9", X"A", X"A", X"A", X"A",
	X"1", X"2", X"3", X"4", X"5", X"6", X"7", X"8", X"9", X"A", X"A", X"A", X"A",
	X"1", X"2", X"3", X"4", X"5", X"6", X"7", X"8", X"9", X"A", X"A", X"A", X"A",
	X"0", X"0", X"0", X"0", X"0", X"0", X"0", X"0", X"0", X"0", X"0", X"0" ) ;
	begin

	memory_update : process ( clk )
		begin
			if rising_edge ( clk ) then
				if we = '1' then
					RAM ( to_integer ( unsigned ( addr ) )) <= din ;
				else
					dout <= RAM ( to_integer ( unsigned ( addr ) ) ) ;
				end if;
			end if;
		end process memory_update ;
end arch_ram ;

