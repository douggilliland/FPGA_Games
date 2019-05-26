----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:38:28 04/27/2015 
-- Design Name: 
-- Module Name:    laser_controll - Behavioral 
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

entity laser_controll is
    Port ( Hposition    : in  STD_LOGIC_VECTOR (10 downto 0);
           Vposition    : in  STD_LOGIC_VECTOR (9 downto 0);
			  refresh      : in  STD_LOGIC;
           VIDON        : in  STD_LOGIC;
           Hobj_top     : in  STD_LOGIC_VECTOR(10 downto 0);
			  Vobj_center  : in  STD_LOGIC_VECTOR(9 downto 0);
           switch       : in  STD_LOGIC;
			  laser_off    : in  STD_LOGIC;
			  enable_game  : in  STD_LOGIC;
			  laser_enable : out  STD_LOGIC;
           laser_on     : out  STD_LOGIC );
end laser_controll;

architecture Behavioral of laser_controll is
-- LASER BOUNDARIES
constant Vlaser_wid : std_logic_vector(9 downto 0) := "0000000100"; -- 4
-- SCREEN BOUNDARIES
constant Hmax : std_logic_vector(10 downto 0) := "11010001000"; -- 1672
constant Hmin : std_logic_vector(10 downto 0) := "00011101000"; -- 232
constant Vmax : std_logic_vector(9 downto 0) := "1110100000"; -- 928
constant Vmin : std_logic_vector(9 downto 0) := "0001101100"; -- 108
-- INTERNAL SIGNAL LASER ON, COUNTER AND STOP SIGNAL
signal laseron : std_logic;
signal go : std_logic := '0';
signal counter : std_logic_vector(5 downto 0);
signal stop : std_logic := '0';
begin

process(VIDON, switch, Hposition, Vposition, enable_game, refresh, laser_off)
begin
    
	 laseron <= '0';
	 
	 if VIDON = '1' and enable_game = '1' then
	     -- LASER HAS TO BE STOPPED
	     if rising_edge(laser_off) then
				stop <= '1';
		  end if;
		  -- TIMER LASER IS OFF
		  if stop = '1' then
		      if rising_edge(refresh) then
		          if counter < "111100" then
				        counter <= counter + 1;
				    else
				        counter <= (others => '0');
					     stop <= '0';
				    end if;
		      end if;
		  end if;
		  -- LASER IS ON
		  if switch = '1' and stop = '0' then
		         go <= '1';
					counter <= (others => '0');
					if (Hposition >= Hobj_top and Hposition < Hmax) and 
					   (Vposition >= Vobj_center and Vposition < Vobj_center + Vlaser_wid) then
					     laseron <= '1';
				   end if;
        else
		      go <= '0';
		  end if;
	 end if;
	 
end process;

laser_on <= laseron;
laser_enable <= go;

end Behavioral;




























