----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:58:18 04/28/2015 
-- Design Name: 
-- Module Name:    game_controll - Behavioral 
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

entity game_controll is
    Port ( game_over   : in  STD_LOGIC;
	        switch2     : in  STD_LOGIC;
			  start       : out STD_LOGIC;
			  start_game  : out STD_LOGIC;
           enable_game : out  STD_LOGIC );
end game_controll;

architecture Behavioral of game_controll is
-- CHANGE STATE SIGNALS
signal enable_game_sig : std_logic := '0';
signal start_game_sig : std_logic;
-- FNM
signal state : std_logic;
signal new_state : std_logic := '1';
-- FIRST GAME SIGNAL
signal beginning : std_logic := '1';
begin
	 
process(switch2, game_over)
begin
	 
	 -- FIRST TIME THE GAME START
    if switch2 = '0' and beginning = '1' then
	     enable_game_sig <= '0';
		  start_game_sig <= '0';
	 elsif switch2 = '1' and beginning = '1' then
		  beginning <= '0';
		  start_game_sig <= '0';
		  else
		      -- FINAL STATE MACHINE
		      state <= new_state;
			   case state is
				    when '0' =>
						  enable_game_sig <= '0';
						  start_game_sig <= '0';
						  if switch2 = '1' then
							   new_state <= '1';
						  end if;
				    when '1' =>
						  enable_game_sig <= '1';
						  start_game_sig <= '1';
						  if rising_edge(game_over) then
							   new_state <= '0';
						  end if;
				    when others =>
						  enable_game_sig <= '0';
						  start_game_sig <= '0';
						  if switch2 = '1' then
							   new_state <= '1';
						  end if;
	         end case;
    end if;
		 
end process;
	 
enable_game <= enable_game_sig;
start_game <= start_game_sig;
start <= beginning;

end Behavioral;











