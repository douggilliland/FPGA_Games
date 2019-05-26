library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

package vga_package is

	subtype   xy_coord_type is integer range 0 to 512;

	subtype   color_type    is std_logic_vector(11 downto 0);
	
	constant  COLOR_BROWN   : color_type := X"850";
		
	constant  COLOR_ORANGE  : color_type := X"F80";
	constant  COLOR_RED     : color_type := X"F00";
	constant  COLOR_GREEN   : color_type := X"0F0";
	constant  COLOR_BLUE    : color_type := X"00F";
	constant  COLOR_YELLOW  : color_type := X"FF0";
	constant  COLOR_CYAN		: color_type := X"0FF";
	constant  COLOR_MAGENTA	: color_type := X"F0F";
	constant  COLOR_PURPLE  : color_type := X"80F";
	
	constant  COLOR_BLACK   : color_type := X"000";
	constant  COLOR_WHITE   : color_type := X"FFF";

end package;

