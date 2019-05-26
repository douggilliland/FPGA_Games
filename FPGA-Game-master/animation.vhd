----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:57:58 05/04/2015 
-- Design Name: 
-- Module Name:    animation - Behavioral 
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

entity animation is
    Port ( obj_on1          : in  STD_LOGIC;
           obj_on2          : in  STD_LOGIC;
			  obj_on3          : in  STD_LOGIC;
			  obj_on4          : in  STD_LOGIC;
			  obj_on           : in  STD_LOGIC;
           clk              : in  STD_LOGIC;
			  spaceship_enable : out  STD_LOGIC;
           objrgb           : out  STD_LOGIC );
end animation;

architecture Behavioral of animation is
signal objrgb_sig : std_logic;
signal counter : std_logic_vector(2 downto 0) := "000";
signal new_clk : std_logic;
signal swclk : std_logic := '0';
signal enable : std_logic;
begin

process(clk, obj_on)
    begin
  
    enable <= '0';
    -- FIRST CLOCK
    if rising_edge(clk) then
	     if counter < "110" then
				 counter <= counter + 1;
		  else
				 counter <= (others => '0');
				 new_clk <= not new_clk;
		  end if;
	 end if;
	 -- SECOND CLOCK
	 if rising_edge(new_clk) then
			swclk <= not swclk;
	 end if;
    -- SWITCH ROMS, INTERSECTION OF THE TWO NEW CLOCKS
    if obj_on = '1' then
	     if new_clk = '1' and swclk = '0' then
			   objrgb_sig <= obj_on1;
	     elsif new_clk = '0' and swclk = '0' then
			   objrgb_sig <= obj_on2;
	     elsif new_clk = '1' and swclk = '1' then
			   objrgb_sig <= obj_on3;
	     elsif new_clk = '0' and swclk = '1' then
			   objrgb_sig <= obj_on4;
	     end if;
	     enable <= '1';
    end if;
     
end process;
  
objrgb <= objrgb_sig;
spaceship_enable <= enable;

end Behavioral;