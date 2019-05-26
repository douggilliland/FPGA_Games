----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:41:45 04/30/2015 
-- Design Name: 
-- Module Name:    ball_collision - Behavioral 
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

entity ball_collision is
    Port ( laser_on : in STD_LOGIC;
           ball_on : in  STD_LOGIC;
			  ball_out : out STD_LOGIC);
end ball_collision;

architecture Behavioral of ball_collision is
signal ball_boom : std_logic := '0';
begin

process(ball_on, laser_on)
begin
    
	     if ball_on = '1' and laser_on = '1' then
	         ball_boom <= '1';
	     end if;
	 
end process;
ball_out <= ball_boom;
end Behavioral;

