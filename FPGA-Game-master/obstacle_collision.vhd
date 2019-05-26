----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:11:05 05/04/2015 
-- Design Name: 
-- Module Name:    obstacle_collision - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity obstacle_collision is
    Port ( spaceship_enable : in  STD_LOGIC;
			  obj_rgb          : in  STD_LOGIC;
           obstacle1_enable : in  STD_LOGIC;
			  obstacle1_rgb    : in  STD_LOGIC;
			  obstacle2_enable : in  STD_LOGIC;
			  obstacle2_rgb    : in  STD_LOGIC;
			  obstacle3_rgb    : in  STD_LOGIC;
			  obstacle3_enable : in  STD_LOGIC;
           obj_off          : out  STD_LOGIC );
end obstacle_collision;

architecture Behavioral of obstacle_collision is
-- SIGNAL FOR COLLISION
signal you_lose : std_logic := '0';
begin

process(obj_rgb, obstacle1_rgb, obstacle2_rgb, obstacle3_rgb)
begin

    you_lose <= '0';
	 
	 -- COLLISION WITH OBSTACLE 1
    if spaceship_enable = '1' and obstacle1_enable = '1' then
		  if obj_rgb = '1' and obstacle1_rgb = '1' then
				you_lose <= '1';
		  end if;
	 end if;
    -- COLLISION WITH OBSTACLE 2
	 if spaceship_enable = '1' and obstacle2_enable = '1' then
		  if obj_rgb = '1' and obstacle2_rgb = '1' then
				you_lose <= '1';
		  end if;
	 end if;
    -- COLLISION WITH OBSTACLE 3
	 if spaceship_enable = '1' and obstacle3_enable = '1' then
		  if obj_rgb = '1' and obstacle3_rgb = '1' then
				you_lose <= '1';
		  end if;
	 end if;
  
end process;

obj_off <= you_lose;

end Behavioral;






