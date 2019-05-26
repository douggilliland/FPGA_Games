----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:47:19 04/15/2015 
-- Design Name: 
-- Module Name:    vga_controller - Behavioral 
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

entity VGA_CONT is
    Port ( pixel_clock : in  STD_LOGIC;
           Hsync : out  STD_LOGIC;
           Vsync : out  STD_LOGIC;
           VIDON : out  STD_LOGIC;
           Hposition : out  STD_LOGIC_VECTOR (10 downto 0);
           Vposition : out  STD_LOGIC_VECTOR (9 downto 0));
end VGA_CONT;

architecture Behavioral of VGA_CONT is
-- HORIZONTAL CONSTANTS
constant hdisp : std_logic_vector(10 downto 0) := "10110100000";
constant hfporch : std_logic_vector(6 downto 0) := "1010000";
constant hsyncp : std_logic_vector(7 downto 0) := "10011000";
constant hbporch : std_logic_vector(7 downto 0) := "11101000";
constant htotal : std_logic_vector(10 downto 0) := "11101110000";
-- VERTICAL CONSTANTS
constant vdisp : std_logic_vector(9 downto 0) := "1110000100";
constant vfporch : std_logic := '1';
constant vsyncp : std_logic_vector(1 downto 0) := "11";
constant vbporch : std_logic_vector(4 downto 0) := "11100";
constant vtotal : std_logic_vector(9 downto 0) := "1110100100";
-- COUNTERS
signal hcount : std_logic_vector(10 downto 0);
signal vcount : std_logic_vector(9 downto 0);
-- VERTICAL ENABLE
signal venable : std_logic;
-- ARCHITECTURE
begin

-- HORIZONTAL PART
	 process(pixel_clock)
	 begin
	 
	     if rising_edge(pixel_clock) then
		  
		      if hcount < htotal then
				
				    hcount <= hcount + 1;
					 venable <= '0';
				
				else
				
				    hcount <= (others => '0');
					 venable <= '1';
				end if;
		end if;
end process;

Hsync <= '1' when hcount < (hbporch + hdisp + hfporch) else '0';

-- VERTICAL PART
    process(pixel_clock, venable)
	 begin
	 
	     if (rising_edge(pixel_clock) and venable = '1') then
		  
		      if vcount < vtotal then
				    
					 vcount <= vcount + 1;
					 
				else
				
				    vcount <= (others => '0');
				end if;
		end if;
end process;

Vsync <= '1' when vcount < (vbporch + vdisp + vfporch) else '0';

-- VIDEO ON

VIDON <= '1' when ((hcount >= hbporch) and (hcount < (hbporch + hdisp))) 
                   and ((vcount >= vbporch) and (vcount < (vbporch + vdisp))) else '0';
						 
-- PIXEL POSITION

    Hposition <= hcount;
	 Vposition <= vcount;

end Behavioral;
