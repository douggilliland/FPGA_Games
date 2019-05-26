----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:40:17 04/20/2015 
-- Design Name: 
-- Module Name:    my_rom - Behavioral 
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

entity my_rom is
    port( Add : in std_logic_vector(5 downto 0);
	       enable : in std_logic;
			 position : in std_logic_vector(4 downto 0);
	       data : out std_logic);
end my_rom;

architecture Behavioral of my_rom is
type ROM is array(0 to 23) of std_logic_vector(27 downto 0);
constant content : ROM := (
     0 => "0000111111110000111111110000",
	  1 => "0000111111110000111111110000",
	  2 => "0000111111110000111111110000",
	  3 => "0000111111110000111111110000",
	  4 => "1111111111111111111111111111",
	  5 => "1111111111111111111111111111",
	  6 => "1111111111111111111111111111",
	  7 => "1111111111111111111111111111",
	  8 => "1111111111111111111111111111",
	  9 => "1111111111111111111111111111",
	 10 => "1111111111111111111111111111",
	 11 => "1111111111111111111111111111",
	 12 => "0000111111111111111111110000",
	 13 => "0000111111111111111111110000",
	 14 => "0000111111111111111111110000",
	 15 => "0000111111111111111111110000",
	 16 => "0000000011111111111100000000",
	 17 => "0000000011111111111100000000",
	 18 => "0000000011111111111100000000",
	 19 => "0000000011111111111100000000",
	 20 => "0000000000001111000000000000",
	 21 => "0000000000001111000000000000",
	 22 => "0000000000001111000000000000",
	 23 => "0000000000001111000000000000"
);
signal data_line : std_logic_vector(27 downto 0);
signal final_data : std_logic;
begin

    process
	 begin
	 
        if enable <= '1' then

            data_line <= content(CONV_INTEGER(Add));
				
				final_data <= data_line(conv_integer(position));
		  
        end if;
end process;
final_data <= data;
end Behavioral;



















