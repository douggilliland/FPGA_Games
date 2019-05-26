----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:37:49 05/04/2015 
-- Design Name: 
-- Module Name:    spaceship4 - Behavioral 
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

entity spaceship4 is
    Port ( obj_on  : in  STD_LOGIC;
           obj_row : in  STD_LOGIC_VECTOR (10 downto 0);
           obj_col : in  STD_LOGIC_VECTOR (9 downto 0);
           obj_rgb : out  STD_LOGIC);
end spaceship4;

architecture Behavioral of spaceship4 is
type ROM is array(0 to 17) of std_logic_vector(49 downto 0);
constant content : ROM := (
      0 => "00000000000000000000000000000000000000000000000000",
      1 => "00000000000000000000000000000000000000011111111100",
      2 => "00010111110000000000000000001011110000111111110000",
      3 => "00110011111000011111111000010000111111111110000000",
      4 => "01100000011100000001111100001011111111111100000000",
		5 => "11000000001110000000111110000000000001100000111000",
		6 => "11000000000111111111111111111111111111110001111100",
		7 => "11000000000011100000000000000000000110011111011110",
		8 => "11000000000110000000000000000000000000000000001111",
		9 => "11000000000110000000000000000000000000000000001111",
	  10 => "11000000000011100000000000000000000110011111011110",
	  11 => "11000000000111111111111111111111111111110001111100",
	  12 => "11000000001110000000111110000000000001100000111000",
     13 => "01100000011100000001111100001011111111111100000000",
	  14 => "00110011111000011111111000010000111111111110000000",
	  15 => "00010111110000000000000000001011110000111111110000",
	  16 => "00000000000000000000000000000000000000011111111100",
	  17 => "00000000000000000000000000000000000000000000000000"
);
signal data_line : std_logic_vector(0 to 49);
signal object_rgb : std_logic;
constant rest : integer := 2;
begin

process(obj_on, obj_col, data_line, obj_row)
begin

    object_rgb <= '0';
    -- IMMAGE ONLY IF THE OBJECT IS ON
    if obj_on = '1' then
	     -- SCALING ALGORITHM
		  if (conv_integer(obj_col) rem rest) = 0 then
	         data_line <= content((conv_integer(obj_col)) / rest);
		  else
		      data_line <= content((conv_integer(obj_col) - (conv_integer(obj_col) rem rest)) / rest);
		  end if;
		  if (conv_integer(obj_row) rem rest) = 0 then
		      object_rgb <= data_line((conv_integer(obj_row)) / rest);
		  else
		  		object_rgb <= data_line((conv_integer(obj_row) - (conv_integer(obj_row) rem rest)) / rest);
		  end if;
	 end if;
	 
end process;

obj_rgb <= object_rgb;

end Behavioral;