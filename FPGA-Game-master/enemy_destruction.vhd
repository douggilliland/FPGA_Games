----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:17:26 05/09/2015 
-- Design Name: 
-- Module Name:    enemy_destruction - Behavioral 
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

entity enemy_destruction is
    Port ( VIDON : in  STD_LOGIC;
			  enable_game : in STD_LOGIC;
           laser_on : in  STD_LOGIC;
--			  enemy_on : in STD_LOGIC;
			  shoot_on : in STD_LOGIC;
 --          enemy_out : out  STD_LOGIC
           ball_out : out  STD_LOGIC
           );
end enemy_destruction;

architecture Behavioral of enemy_destruction is
--signal en_out : std_logic := '0';
signal ballout : std_logic := '0';
begin

--process(laser_on, enemy_on)
--begin
--			
--			if laser_on = '1' and enemy_on = '1' then
--				 en_out <= '1';
--			else
--			    en_out <= '0';
--			end if;
--	  
--	 
--end process;

process(laser_on, shoot_on)
begin
			ballout <= '0';
			
			if laser_on = '1' and shoot_on = '1' then
				 ballout <= '1';
			end if;
	 
end process;

--enemy_out <= en_out;
ball_out <= ballout;

end Behavioral;










