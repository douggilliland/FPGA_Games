library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TopModule is
 Port ( clk : in STD_LOGIC;
        PS2Clk, PS2Data : in STD_LOGIC;
        Hsync, Vsync : out STD_LOGIC;
        vgaRed, vgaGreen, vgaBlue : out STD_LOGIC_VECTOR(3 downto 0);
        sw : in STD_LOGIC_VECTOR ( 11 downto 0));
end TopModule;

architecture Behavioral of TopModule is

component VGAPixelDriver
      port ( clk : in STD_LOGIC;
          red_in, blue_in, green_in : in STD_LOGIC_VECTOR( 3 downto 0);
          Hsync, Vsync, display_o : out STD_LOGIC;
          pixel_x, pixel_y : out integer;
          refresh : out std_logic;
          red, blue, green : out STD_LOGIC_VECTOR( 3 downto 0));
end component;

component VideoMemory 
  port ( display : in STD_LOGIC;
        pixel_x, pixel_y : in integer;
        refresh : in std_logic;
--        difficulty : in std_logic;
        red, green, blue : out std_logic_vector( 3 downto 0);
        sw : in STD_LOGIC_VECTOR (11 downto 0);
        input : in STD_LOGIC_VECTOR (7 downto 0));
end component;

component ps2_keyboard
GENERIC(
    clk_freq              : INTEGER := 50_000_000; --system clock frequency in Hz
    debounce_counter_size : INTEGER := 8);         --set such that (2^size)/clk_freq = 5us (size = 8 for 50MHz)
  PORT(
    clk          : IN  STD_LOGIC;                     --system clock
    PS2clk      : IN  STD_LOGIC;                     --clock signal from PS/2 keyboard
    PS2data     : IN  STD_LOGIC;                     --data signal from PS/2 keyboard
--    ps2_code_new : OUT STD_LOGIC;                     --flag that new PS/2 code is available on ps2_code bus
    ps2_code     : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)); --code received from PS/2
END component;

signal red, green, blue : std_logic_vector( 3 downto 0) := "0000";
signal display :std_logic := '0';
signal pixel_x, pixel_y : integer := -1;
signal temp, temp2, temp3 : std_logic := '0';
signal temp1 : std_logic_vector(7 downto 0) := "00000000";

begin
    pixel_driver : VGAPixelDriver port map
		(  clk => clk, 
		red_in => red, 
		blue_in => blue, 
		green_in => green, 
		Hsync => Hsync, 
		Vsync => Vsync, 
		display_o => display, 
		pixel_x => pixel_x, 
		pixel_y => pixel_y, 
		refresh => temp, 
		red => vgaRed, 
		blue => vgaBlue, 
		green => vgaGreen);
    
	 video_memory : VideoMemory port map
	 ( 
	 display => display, 
	 pixel_x => pixel_x, 
	 pixel_y => pixel_y, 
	 refresh => temp, 
	 red => red, 
	 green => green, 
	 blue => blue, 
	 sw => sw, 
	 input => temp1);
    
	 keyboard_driver : ps2_keyboard port map
	 ( 
	 clk => clk, 
	 PS2Clk => PS2Clk, 
	 PS2Data => PS2Data, 
	 ps2_code => temp1);
	 
end Behavioral;
