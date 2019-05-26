----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:39:42 05/05/2015 
-- Design Name: 
-- Module Name:    game_over_ROM - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity game_over_ROM is
    Port ( start_game       : in  STD_LOGIC;
           Hposition        : in  STD_LOGIC_VECTOR (10 downto 0);
           Vposition        : in  STD_LOGIC_VECTOR (9 downto 0);
			  game_over_enable : out  STD_LOGIC;
           game_over_on     : out  STD_LOGIC;
           game_over_rgb    : out  STD_LOGIC );
end game_over_ROM;

architecture Behavioral of game_over_ROM is

signal go_on : std_logic := '0';
-- STARTING POINT FOR GAME OVER TEXT
constant Hstart : std_logic_vector(10 downto 0) := "01100100000"; -- 800
constant Vstart : std_logic_vector(9 downto 0) := "0111000010"; -- 450
-- ROWS AND COLUMNS
signal go_row : std_logic_vector(10 downto 0);
signal go_col : std_logic_vector(9 downto 0);
-- ROM
type ROM is array(0 to 15) of std_logic_vector(79 downto 0);
constant content : ROM := (
   0 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000",
   1 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000",
   2 => "00011110000001100000110000110011111110000000000110000011000110011111110011111100",
   3 => "00110011000011110000111001110001100110000000011111100011000110001100110001100110",
   4 => "01100001000110011000111111110001100010000000110000110011000110001100010001100110",
   5 => "01100000001100001100111111110001101000000000110000110011000110001101000001100110",
   6 => "01100000001100001100110110110001111000000000110000110011000110001111000001111100",
   7 => "01100111001111111100110000110001101000000000110000110011000110001101000001101100",
   8 => "01100001001100001100110000110001100000000000110000110011000110001100000001100110",
   9 => "01100011001100001100110000110001100010000000110000110001101100001100010001100110",
  10 => "00110011001100001100110000110001100110000000011111100000111000001100110001100110",
  11 => "00011101001100001100110000110011111110000000000110000000010000011111110011100111",
  12 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000",
  13 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000",
  14 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000",
  15 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000"
);
signal data_line : std_logic_vector(0 to 79) := "00000000000000000000000000000000000000000000000000000000000000000000000000000000";
signal go_rgb : std_logic := '0';
signal enable_game_over : std_logic := '0';
constant rest : integer := 4;
begin

-- PROCESS 1, FIND THE AREA WHERE ROM IS ON
process(Hposition, Vposition, start_game)
begin

    go_on <= '0';
	 
	 if start_game = '0' then
		  if (Hposition >= Hstart and Hposition < Hstart + "101000000") and -- 320
		     (Vposition >= Vstart and Vposition < Vstart + "1000000") then -- 64
					  go_on <= '1';
					  go_row <= Hposition - Hstart;
					  go_col <= Vposition - Vstart;
		end if;
   end if;
	
end process;

-- PROCESS 2, SCALING ALGORITHM AND ROM DATA
process(go_on, go_col, go_row)
begin

    enable_game_over <= '0';
    go_rgb <= '0';
	 
	 -- OBJECT IS ON
    if go_on = '1' then	
	     -- SCALING ALGORITHM
        if (conv_integer(go_col) rem rest) = 0 then
				data_line <= content((conv_integer(go_col)) / rest);
		  else
				data_line <= content((conv_integer(go_col) - (conv_integer(go_col) rem rest)) / rest);
		  end if;
		  if (conv_integer(go_row) rem rest) = 0 then
				go_rgb <= data_line((conv_integer(go_row)) / rest);
		  else
		      go_rgb <= data_line((conv_integer(go_row) - (conv_integer(go_row) rem rest)) / rest);
		  end if;
		  -- ENABLE ON
		  enable_game_over <= '1';
    end if;

end process;

game_over_rgb <= go_rgb;
game_over_on <= go_on;
game_over_enable <= enable_game_over;

end Behavioral;















