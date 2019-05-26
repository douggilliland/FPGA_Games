----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:52:35 05/21/2015 
-- Design Name: 
-- Module Name:    laser_timer - Behavioral 
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


entity laser_timer is
    Port ( refresh       : in  STD_LOGIC;
	        VIDON         : in  STD_LOGIC;
           laser_enable  : in  STD_LOGIC;
           Hposition     : in  STD_LOGIC_VECTOR(10 downto 0);
           Vposition     : in  STD_LOGIC_VECTOR(9 downto 0);
           laser_off     : out  STD_LOGIC;
           laser_bar_on  : out  STD_LOGIC;
           laser_bar_rgb : out  STD_LOGIC );
end laser_timer;

architecture Behavioral of laser_timer is

-- SPEED
constant delta_minus : std_logic_vector(10 downto 0):= "00000000100"; -- 4
constant delta_plus : std_logic_vector(10 downto 0) := "00000000010"; -- 2
-- CONSTANTS
constant bar_width : std_logic_vector(9 downto 0):= "0000101000"; -- 40
constant bar_max_lenght : std_logic_vector(10 downto 0):= "10101111000"; -- 1400
constant h_bar_start : std_logic_vector (10 downto 0):= "10011100010"; -- 1250
constant v_bar_start : std_logic_vector(9 downto 0) := "0000110010"; -- 50
-- POSITION OF THE BAR
signal bar_pos : std_logic_vector(10 downto 0):= "00000000000";

signal rgb : std_logic;

signal bar_on : std_logic;

signal off : std_logic;

begin


process(refresh, VIDON, laser_enable)
begin

	 rgb <= '0';
	 bar_on <= '0';
	
    if VIDON = '1' then
		 if rising_edge(refresh) then
		     -- BAR INCREASE
           if laser_enable = '1' then
					off <= '0';
			      if (bar_pos + h_bar_start) < (bar_max_lenght - "00000000001") then
			          bar_pos <= bar_pos + delta_plus;
					else
					    off <= '1';
					end if;
			  -- BAR DECREASE		
			  else
			      if bar_pos > "00000000011" then
					    bar_pos <= bar_pos - delta_minus;
					elsif bar_pos > "00000000000" and bar_pos < "00000000100" then
					    bar_pos <= "00000000000";
					end if;
			  end if;
	    end if;
		 -- AREA OF THE BAR
		 if ( Hposition >= h_bar_start and Hposition < bar_max_lenght) and 
		    ( Vposition >= v_bar_start and Vposition < "0001011010") then
		       bar_on <= '1';
	    end if;
		 -- ACTUAL BAR
	    if ( Hposition >= h_bar_start and Hposition < (h_bar_start + bar_pos)) and 
		    ( Vposition >= v_bar_start and Vposition < "0001011010") then  
				     rgb <= '1';
	    end if;
	 end if;
		
end process;

laser_bar_rgb <= rgb;
laser_bar_on <= bar_on;
laser_off <= off;

end Behavioral;



