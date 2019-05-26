----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:06:45 04/21/2015 
-- Design Name: 
-- Module Name:    top - Behavioral 
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

entity top is
    Port ( clk : in  STD_LOGIC;
	        buttons : in STD_LOGIC_VECTOR(3 downto 0);
			  switch : in STD_LOGIC;
			  switch2 : in STD_LOGIC;
           Hsync : out  STD_LOGIC;
           Vsync : out  STD_LOGIC;
           red : out  STD_LOGIC_VECTOR (4 downto 0);
           green : out  STD_LOGIC_VECTOR (5 downto 0);
			  blue : out std_logic_vector (4 downto 0));
end top;

architecture Behavioral of top is

    component clk_divider is
	 Port ( CLK_IN1 : in  STD_LOGIC;
           CLK_OUT1 : out  STD_LOGIC;
			  CLK_OUT2 : out STD_LOGIC);
end component;

    component vga_cont is
	 Port ( pixel_clock : in  STD_LOGIC;
           Hsync : out  STD_LOGIC;
           Vsync : out  STD_LOGIC;
           VIDON : out  STD_LOGIC;
           Hposition : out  STD_LOGIC_VECTOR (10 downto 0);
           Vposition : out  STD_LOGIC_VECTOR (9 downto 0));
end component;

    component screen is
	 Port ( Hposition : in  STD_LOGIC_VECTOR (10 downto 0);
           Vposition : in  STD_LOGIC_VECTOR (9 downto 0);
           VIDON : in  STD_LOGIC;
			  buttons : in STD_LOGIC_VECTOR(3 downto 0);
			  switch : in STD_LOGIC;
			  switch2 : in STD_LOGIC;
			  clk_60 : in STD_LOGIC;
           red : out  STD_LOGIC_VECTOR (4 downto 0);
           green : out  STD_LOGIC_VECTOR (5 downto 0);
           blue : out  STD_LOGIC_VECTOR (4 downto 0));
end component;

signal clk_pixel : std_logic;
signal clk_refr : std_logic;
signal hs : std_logic_vector(10 downto 0);
signal vs : std_logic_vector(9 downto 0);
signal von : std_logic;

begin

    A : clk_divider port map(CLK_IN1 => clk,
	                          CLK_OUT1 => clk_pixel,
									  CLK_OUT2 => clk_refr);
								 
    B : vga_cont port map(pixel_clock => clk_pixel,
	                       Hsync => Hsync,
                          Vsync => Vsync,
                          VIDON => von,
                          Hposition => hs,
                          Vposition => vs);

    C : screen port map(Hposition => hs,
                        Vposition => vs,
                        VIDON => von,
								buttons => buttons,
								switch => switch,
								switch2 => switch2,
								clk_60 => clk_refr,
                        red => red,
                        green => green,
                        blue => blue);

end Behavioral;