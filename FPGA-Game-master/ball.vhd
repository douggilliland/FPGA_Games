----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:17:58 04/25/2015 
-- Design Name: 
-- Module Name:    ball - Behavioral 
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

entity ball is
    Port ( Hposition : in  STD_LOGIC_VECTOR (10 downto 0);
           Vposition : in  STD_LOGIC_VECTOR (9 downto 0);
           VIDON : in  STD_LOGIC;
           refresh : in  STD_LOGIC;
			  enable_game : in STD_LOGIC;
			  ball_out : in STD_LOGIC;
           ball_on : out  STD_LOGIC);
end ball;

architecture Behavioral of ball is
-- SCREEN BOUNDARIES
constant Hmax : std_logic_vector(10 downto 0) := "11010001000";
constant Hmin : std_logic_vector(10 downto 0) := "00011101000";
constant Vmax : std_logic_vector(9 downto 0) := "1110100000";
constant Vmin : std_logic_vector(9 downto 0) := "0001101100";
-- BOUNDARIES FOR THE BALL
signal Hball_top : std_logic_vector(10 downto 0) := "01111010100";
signal Hball_bottom : std_logic_vector(10 downto 0) := "01110011100";
signal Vball_top : std_logic_vector(9 downto 0) := "0111110110";
signal Vball_bottom : std_logic_vector(9 downto 0) := "0111000110";
-- SPEED
constant delta : std_logic_vector(5 downto 0) := "001000";
-- STATES
signal state : std_logic_vector(1 downto 0);
signal new_state : std_logic_vector(1 downto 0) := "00";
-- INTERNAL SIGNAL BALL ON
signal ballon : std_logic;
begin

process(VIDON, refresh, Hposition, Vposition, ball_out, enable_game)
begin
    
	 ballon <= '0';
	 
	 if VIDON = '1' and ball_out = '0' and enable_game = '1' then
	     
		  if rising_edge(refresh) then
		      
				state <= new_state;
				
				case state is
				    
					 when "00" =>
					     Hball_top <= Hball_top + delta;
						  Hball_bottom <= Hball_bottom + delta;
						  Vball_top <= Vball_top - delta;
						  Vball_bottom <= Vball_bottom - delta;
						  if Hball_top >= Hmax then
						      new_state <= "01";
						  elsif Vball_bottom < Vmin + "1110" then
						      new_state <= "10";
						  end if;
					 when "01" =>
					     Hball_top <= Hball_top - delta;
						  Hball_bottom <= Hball_bottom - delta;
						  Vball_top <= Vball_top - delta;
						  Vball_bottom <= Vball_bottom - delta;
						  if Hball_bottom < Hmin then
						      new_state <= "00";
						  elsif Vball_bottom < Vmin + "1110" then
						      new_state <= "11";
						  end if;
					 when "10" =>
					     Hball_top <= Hball_top + delta;
						  Hball_bottom <= Hball_bottom + delta;
						  Vball_top <= Vball_top + delta;
						  Vball_bottom <= Vball_bottom + delta;
						  if Hball_top >= Hmax then
						      new_state <= "11";
						  elsif Vball_top >= Vmax then
						      new_state <= "00";
						  end if;
					 when "11" =>
					     Hball_top <= Hball_top - delta;
						  Hball_bottom <= Hball_bottom - delta;
						  Vball_top <= Vball_top + delta;
						  Vball_bottom <= Vball_bottom + delta;
						  if Hball_bottom < Hmin then
						      new_state <= "10";
						  elsif Vball_top >= Vmax then
						      new_state <= "01";
						  end if;
					 when others =>
					     Hball_top <= Hball_top + delta;
						  Hball_bottom <= Hball_bottom + delta;
						  Vball_top <= Vball_top - delta;
						  Vball_bottom <= Vball_bottom - delta;
						  if Hball_top >= Hmax then
						      new_state <= "01";
						  elsif Vball_bottom < Vmin + "1110" then
						      new_state <= "10";
						  end if;
				end case;
				
		  end if;
		  
		  -- BALL IS ON
		  if (Hposition >= Hball_bottom and Hposition < Hball_top)
				     and (Vposition >= Vball_bottom and Vposition < Vball_top) then
					  ballon <= '1';
				end if;
		  
	 end if;
	 
end process;

ball_on <= ballon;

end Behavioral;
























