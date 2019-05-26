----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:39:15 12/03/2013 
-- Design Name: 
-- Module Name:    speedCalculator - Behavioral 
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

entity speedCalculator is
    Port ( xAxis : in STD_LOGIC_VECTOR(9 downto 0);
			  yAxis : in STD_LOGIC_VECTOR(9 downto 0);
			  sp_x : out STD_LOGIC_VECTOR(1 downto 0);
			  sp_y : out STD_LOGIC_VECTOR(1 downto 0)
			  --sp_l : out STD_LOGIC_VECTOR(1 downto 0);
			  --sp_r : out STD_LOGIC_VECTOR(1 downto 0)
	);
end speedCalculator;

architecture Behavioral of speedCalculator is

signal x_tmp : std_logic_vector(8 downto 0) := "000000000";
signal y_tmp : std_logic_vector(8 downto 0) := "000000000";

begin
	process
	begin
	
	if xAxis(9) = '1' then
		x_tmp <= NOT xAxis(8 downto 0);
	else 
		x_tmp <= xAxis(8 downto 0);
	end if;
	
	if yAxis(9) = '1' then
		y_tmp <= NOT yAxis(8 downto 0);
	else 
		y_tmp <= yAxis(8 downto 0);
	end if;
	
	if x_tmp(8 downto 0) < "000011000" then
		sp_x <= "00";
	elsif x_tmp(8 downto 0) >= "000011000" and x_tmp(8 downto 0) < "001000000" then
		sp_x <= "01";
	elsif x_tmp(8 downto 0) >= "001000000" and x_tmp(8 downto 0) < "010000000" then
		sp_x <= "10";
	elsif x_tmp(8 downto 0) >= "010000000" then 
		sp_x <= "11";
	else 
		sp_x <= "00";
	end if;
	
	
	if y_tmp(8 downto 0) < "000011000" then
		sp_y <= "00";
	elsif y_tmp(8 downto 0) >= "000011000" and y_tmp(8 downto 0) < "001000000" then
		sp_y <= "01";
	elsif y_tmp(8 downto 0) >= "001000000" and y_tmp(8 downto 0) < "010000000" then
		sp_y <= "10";
	elsif y_tmp(8 downto 0) >= "010000000" then 
		sp_y <= "11";
	else 
		sp_y <= "00";
	end if;

	
	end process;
	
end Behavioral;
