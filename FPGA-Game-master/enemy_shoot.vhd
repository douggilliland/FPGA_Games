----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:35:38 05/08/2015 
-- Design Name: 
-- Module Name:    enemy_shoot - Behavioral 
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

entity enemy_shoot is
    Port ( Hposition      : in  STD_LOGIC_VECTOR (10 downto 0);
           Vposition      : in  STD_LOGIC_VECTOR (9 downto 0);
           VIDON          : in  STD_LOGIC;
           refresh        : in  STD_LOGIC;
			  enable_game    : in  STD_LOGIC;
           enemy_on       : in  STD_LOGIC;
           enemy_position : in  STD_LOGIC_VECTOR (9 downto 0);
			  laser_on       : in  STD_LOGIC;
			  shoot_row      : out  STD_LOGIC_VECTOR(10 downto 0);
			  shoot_col      : out  STD_LOGIC_VECTOR(9 downto 0);
           shoot_on       : out  STD_LOGIC );
end enemy_shoot;

architecture Behavioral of enemy_shoot is
-- SCREEN BOUNDARIES
constant Hmax : std_logic_vector(10 downto 0) := "11010001000"; -- 1672
constant Hmin : std_logic_vector(10 downto 0) := "00011101000"; -- 232
constant Vmax : std_logic_vector(9 downto 0) := "1110100000"; -- 928
constant Vmin : std_logic_vector(9 downto 0) := "0001101100"; -- 108
-- BOUNDARIES FOR THE BALL
constant ball_top : std_logic_vector(5 downto 0) := "101000"; -- 40
signal Hball_bottom : std_logic_vector(10 downto 0) := "11000100100"; -- 1572
signal Hball_bottom_new : std_logic_vector(10 downto 0) := "11000100100";
signal Vball_bottom : std_logic_vector(9 downto 0) := "0001101110"; -- 110
signal Vball_bottom_new : std_logic_vector(9 downto 0) := "0001101110";
-- SPEED
constant delta : std_logic_vector(5 downto 0)  := "000110"; -- 6
constant deltah : std_logic_vector(5 downto 0) := "001100"; -- 12
-- STATE OF EXISTANCE OF THE BALL
signal fire : std_logic := '0';
--signal new_fire : std_logic := '0';
-- STATE OF MOVEMENT OF THE BALL
signal state : std_logic;
signal new_state : std_logic := '1';
-- BALL IS ON
signal ballon : std_logic := '0';
-- SIGNALS FOR THE ROM
signal row : std_logic_vector(10 downto 0);
signal col : std_logic_vector(9 downto 0);

--signal start : std_logic := '0';

begin

process(VIDON, enable_game, enemy_on) -- FSM fire
begin

    ballon <= '0';
	 
	 if enable_game = '0' then
	     fire <= '0';
	 elsif VIDON = '1' and enable_game = '1' then
	     
        if fire = '0' then
				    if enemy_on = '1' then
						  Hball_bottom <= "11000100100";
		              Vball_bottom <= enemy_position;
						  fire <= '1';
		          end if;
		  end if;
		  
		  if fire = '1' then
				  if rising_edge(refresh) then
						state <= new_state;
                  if state = '0' then
								  Hball_bottom <= Hball_bottom - delta;
								  Vball_bottom <= Vball_bottom - deltah;
								  if Vball_bottom < "00001111010" then -- 122
										new_state <= '1';
								  end if;
						end if;
						if state = '1' then
								  Hball_bottom <= Hball_bottom - delta;
								  Vball_bottom <= Vball_bottom + deltah;
								  if Vball_bottom >= "01101111000" then -- 888
										new_state <= '0';
								  end if;
						end if;
				  end if;
				  
				  
				  if (Hposition >= Hball_bottom and Hposition < Hball_bottom + ball_top) and 
					  (Vposition >= Vball_bottom and Vposition < Vball_bottom + ball_top) then
						ballon <= '1';
						col <= (Vposition - Vball_bottom);
						row <= (Hposition - Hball_bottom);
				  end if;
				  
--              	 if laser_on = '1' and ballon = '1' then
--					     
----						  if enemy_on = '1' then
--						  Hball_bottom <= "11000100100";
--						  Vball_bottom <= enemy_position;
--						  fire <= '0';
----						  fire <= '1';
----						  end if;
--					 end if;
					 if Hball_bottom < "00000010000" then
--					 	  
----						  if enemy_on = '1' then
						  Hball_bottom <= "11000100100";
						  Vball_bottom <= enemy_position;
						  fire <= '0';
----						  fire <= '1';
----						  end if;
					 end if;
--					 if Hball_bottom < "10000" then
--					     fire <= '0';
--						  Hball_bottom <= "11000100100";
--					 end if;
--					 if enable_game = '0' then
--					     fire <= '0';
--					 end if;
				  
		  end if;
		  
	 end if;
	 
end process;

--process(refresh, new_fire, start) -- movement, display
--begin
--
--    ballon <= '0';
--	 
--    if new_fire = '1' then
--	     if start = '1' then
--	         Hball_bottom <= "11000100100";
--		      Vball_bottom <= enemy_position;
--	     end if;
--	     if rising_edge(refresh) then
--		      state <= new_state;
--		      case state is
--			       when '0' =>
--					     Hball_bottom <= Hball_bottom - delta;
--					     Vball_bottom <= Vball_bottom - deltah;
--					     if Vball_bottom < "1111010" then -- 122
--						      new_state <= '1';
--					     end if;
--			       when '1' =>
--					     Hball_bottom <= Hball_bottom - delta;
--					     Vball_bottom <= Vball_bottom + deltah;
--					     if Vball_bottom >= "1101111000" then -- 888
--						      new_state <= '0';
--					     end if;
--			       when others =>
--	                 Hball_bottom <= "11000100100";
--		              Vball_bottom <= enemy_position;
--		      end case;
--		  end if;
--		  
----		  Hball_bottom <= Hball_bottom_new;
----		  Vball_bottom <= Vball_bottom_new;
--		  
--		  if (Hposition >= Hball_bottom and Hposition < Hball_bottom + ball_top) and 
--			  (Vposition >= Vball_bottom and Vposition < Vball_bottom + ball_top) then
--		      ballon <= '1';
--			   col <= (Vposition - Vball_bottom);
--		 		row <= (Hposition - Hball_bottom);
--	 	  end if;
--	 elsif new_fire = '0' then
--	     ballon <= '0';
--	 end if;
--
--end process;

shoot_on <= ballon;
shoot_row <= row;
shoot_col <= col;

end Behavioral;

--
--	 -- ENABLE OFF, RESET FINAL STATE MACHINE OF CREATION BALL TO '0'
--	 if enable_game = '0' then
----	     Hball_bottom <= "11000100100";
----		  Vball_bottom <= enemy_position;
--	     new_fire <= '0';
--	 elsif enable_game = '1' and VIDON = '1' then
--		        -- FINAL STATE MACHINE OF CREATION BALL
--		        fire <= new_fire;
--				  case fire is
--						when '0' =>
--							 if enemy_on = '1' then
--								  Hball_bottom_new <= "11000100100";
--								  Vball_bottom_new <= enemy_position;
--								  new_fire <= '1';
--							 end if;
--						when '1' =>
--						    -- FINAL STATE MACHINE FOE MOVEMENT
--						    if rising_edge(refresh) then
--							    Hball_bottom <= Hball_bottom_new;
--								 Vball_bottom <= Vball_bottom_new;
--							    state <= new_state;
--								 case state is
--									  when '0' =>
--											Hball_bottom <= Hball_bottom - delta;
--											Vball_bottom <= Vball_bottom - deltah;
--											if Vball_bottom < "1111010" then -- 122
--												 new_state <= '1';
--											end if;
--									  when '1' =>
--											Hball_bottom <= Hball_bottom - delta;
--											Vball_bottom <= Vball_bottom + deltah;
--											if Vball_bottom >= "1101111000" then -- 888
--												 new_state <= '0';
--											end if;
--									  when others =>
--											Hball_bottom <= Hball_bottom - delta;
--											Vball_bottom <= Vball_bottom - deltah;
--											if Vball_bottom < "1111010" then
--												 new_state <= '1';
--											end if;
--								  end case;
--								  Hball_bottom_new <= Hball_bottom;
--								  Vball_bottom_new <= Vball_bottom;
--							  end if;
----							  Hball_bottom <= Hball_bottom_new;
----				           Vball_bottom <= Vball_bottom_new;
--							  -- BALL IS ON
--			              if (Hposition >= Hball_bottom and Hposition < Hball_bottom + ball_top) and 
--				              (Vposition >= Vball_bottom and Vposition < Vball_bottom + ball_top) then
--				 		         ballon <= '1';
--			 			         col <= (Vposition - Vball_bottom);
--		 				         row <= (Hposition - Hball_bottom);
--	 		              end if;
--							  -- CONDITIONS FOR THE BALL TO GO OFF
--							  if ballon = '1' and laser_on = '1' then
----							      Hball_bottom <= "11000100100";
----								   Vball_bottom <= enemy_position;
--									new_fire <= '0';
--							  end if;
--							  if Hball_bottom < "10000" then
----							      Hball_bottom <= "11000100100";
----								   Vball_bottom <= enemy_position;
--									new_fire <= '0';
--							  end if;
--						when others =>
--							 if enemy_on = '1' then
--								  Hball_bottom_new <= "11000100100";
--								  Vball_bottom_new <= enemy_position;
--								  new_fire <= '1';
--							 end if;
--				  end case;
--	 end if;
							
					  
							









