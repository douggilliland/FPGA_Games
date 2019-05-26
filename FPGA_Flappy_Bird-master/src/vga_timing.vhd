library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vga_timing is

	port(
		clk, rst: in std_logic;
		HS, VS: out std_logic;
		pixel_x, pixel_y: out std_logic_vector(9 downto 0);
		last_column, last_row, blank: out std_logic
	);
end vga_timing;

architecture arch of vga_timing is
	signal pixel_en: std_logic;
	signal horizontal_pixel_counter: unsigned(9 downto 0);  --to count to 800
	signal horizontal_pixel_counter_next: unsigned(9 downto 0);
	signal vertical_pixel_counter: unsigned(9 downto 0);  --to count to 521
	signal vertical_pixel_counter_next: unsigned(9 downto 0);
begin

	process(clk, rst)
	begin
		if (rst='1') then
			pixel_en <= '0';
			horizontal_pixel_counter <= (others=>'0');
			vertical_pixel_counter <= (others=>'0');
		elsif (clk'event and clk='1') then
			pixel_en <= not pixel_en;
			horizontal_pixel_counter <= horizontal_pixel_counter_next;
			vertical_pixel_counter <= vertical_pixel_counter_next;
		end if;
	end process;

	
	horizontal_pixel_counter_next <= (others=>'0') when (horizontal_pixel_counter = 799 and pixel_en='1') else  --0 is first pixel 639 is last pixel
											horizontal_pixel_counter + 1 when pixel_en='1' else
											horizontal_pixel_counter;
											
	vertical_pixel_counter_next <= (others=>'0') when (vertical_pixel_counter = 520 and pixel_en='1' and horizontal_pixel_counter = 799) else  --0 is first row 479 is last row
											vertical_pixel_counter + 1 when (pixel_en='1' and horizontal_pixel_counter = 799) else
											vertical_pixel_counter;
											
	HS <= '0' when (horizontal_pixel_counter > 639+16 and horizontal_pixel_counter < 800-48) else '1';
	VS <= '0' when (vertical_pixel_counter > 479+10 and vertical_pixel_counter < 521-29) else '1';
	
	pixel_x <= std_logic_vector(horizontal_pixel_counter);
	pixel_y <= std_logic_vector(vertical_pixel_counter);
											
	last_column <= '1' when horizontal_pixel_counter = 639 else '0';
	last_row <= '1' when vertical_pixel_counter = 479 else '0';
	
	blank <= '1' when (horizontal_pixel_counter >= 640 or vertical_pixel_counter >= 480) else '0';
	
end arch;