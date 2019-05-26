----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:42:04 05/07/2015 
-- Design Name: 
-- Module Name:    enemy_control - Behavioral 
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

entity enemy_control is
    Port ( Hposition      : in  STD_LOGIC_VECTOR (10 downto 0);
	        Vposition      : in  STD_LOGIC_VECTOR (9 downto 0);
           VIDON          : in  STD_LOGIC;
           refresh        : in  STD_LOGIC;
			  enable_game    : in  STD_LOGIC;
			  laser_on       : in  STD_LOGIC;
			  enemy_out      : out  STD_LOGIC;
			  enemy_position : out  STD_LOGIC_VECTOR (9 downto 0);
           enemy_on       : out  STD_LOGIC );
end enemy_control;

architecture Behavioral of enemy_control is
-- SCREEN BOUNDARIES
constant Hmax : std_logic_vector(10 downto 0) := "11010001000"; -- 1672
constant Hmin : std_logic_vector(10 downto 0) := "00011101000"; -- 232
constant Vmax : std_logic_vector(9 downto 0)  := "1110100000";  -- 928
constant Vmin : std_logic_vector(9 downto 0)  := "0001101100";  -- 108
-- ENEMY BOUNDARIES
signal Venemy_bottom : std_logic_vector(9 downto 0)    := "0001101111"; -- 111
signal Venemy_bottom_new : std_logic_vector(9 downto 0) := "0001101111"; -- 111
--signal Vtemporary : std_logic_vector(9 downto 0);
constant Venemy_top : std_logic_vector(9 downto 0)     := "0000111100"; -- 60
constant Henemy_bottom : std_logic_vector(10 downto 0) := "11001001100"; -- 1612
constant Henemy_top : std_logic_vector(10 downto 0)    := "11010001000"; -- 1672
-- SPEED
constant delta : std_logic_vector(2 downto 0) := "100"; -- 4
-- COUNTER
signal counter : std_logic_vector(6 downto 0) := "0000000";
-- FSM
signal state : std_logic;
signal new_state : std_logic := '0';
-- ENEMY IS GENERATED AND IS ON
signal en_on : std_logic := '0';
signal en_on_new : std_logic := '0';
signal enemyon : std_logic;
-- POSITION OF THE ENEMY FOR THE SHOOT MODULE
signal enemy_pos : std_logic_vector(9 downto 0) := "0001101110";
-- ENEMY IS OFF
signal en_out : std_logic;

begin

process(laser_on, enable_game, VIDON, refresh)
begin

	 enemyon <= '0';
	 en_out <= '0';
    
	 if enable_game = '0' then
--	     Venemy_bottom_new <= "0001101111";
		  counter <= (others => '0');
	     en_on_new <= '0';
	 elsif VIDON = '1' and enable_game = '1' then
	 
	     en_on <= en_on_new;
		  
		  case en_on is
		      when '0' =>
				    -- TIMER CREATION ENEMY
				    if rising_edge(refresh) then
					     if counter < "1011000" then
						      counter <= counter + 1;
					     else
					         counter <= (others => '0');
--								Vtemporary <= "0001101111";
						      en_on_new <= '1';
					     end if;
  		          end if;
					 Venemy_bottom_new <= "0001101111";
--					 if en_on_new = '1' then
--					     Venemy_bottom <= "0001101111";
--					 end if;
			   when '1' =>
				    -- FINAL STATE MACHINE FOR THE MOVEMENT
				    if rising_edge(refresh) then
					     state <= new_state;
					     case state is
					         when '0' =>
						          Venemy_bottom_new <= Venemy_bottom + delta;
								    if Venemy_bottom_new >= "1101100111" then -- 871
								        new_state <= '1';
								    end if;
						      when '1' =>
						          Venemy_bottom_new <= Venemy_bottom - delta;
								    if Venemy_bottom_new < "0001110011" then -- 115
								        new_state <= '0';
								    end if;
						      when others =>
						          Venemy_bottom_new <= Venemy_bottom + delta;
								    if Venemy_bottom_new >= "1101100111" then
								        new_state <= '1';
								    end if;
					      end case;
				    end if;
					 Venemy_bottom <= Venemy_bottom_new;
				    if (Hposition >= Henemy_bottom and Hposition < Henemy_top) and 
					    (Vposition >= Venemy_bottom and Vposition < (Venemy_bottom + Venemy_top)) then
					     enemyon <= '1';
					     enemy_pos <= (Venemy_bottom + "1111");
				    end if;
				    -- ENEMY IS DESTROYED BY THE LASER
				    if enemyon = '1' and laser_on = '1' then
--					     Venemy_bottom_new <= "0001101111";
--						  counter <= (others => '0');
                    counter <= (others => '0');
					     en_out <= '1';
						  en_on_new <= '0';
				    end if;
				when others =>
				    if rising_edge(refresh) then
					     if counter < "1011000" then
						      counter <= counter + 1;
					     else
					         counter <= (others => '0');
--								Vtemporary <= "0001101111";
						      en_on_new <= '1';
					     end if;
  		          end if;
					 Venemy_bottom_new <= "0001101111";
--                if en_on_new = '1' then
--					     Venemy_bottom <= "0001101111";
--					 end if;
		  end case;
	 end if;
	 
end process;

enemy_on <= enemyon;
enemy_position <= enemy_pos;
enemy_out <= en_out;

end Behavioral;


---- RESET INITIAL CONDITIONS IF ENABLE IS OFF
--	 if VIDON = '1' and enable_game = '0' then
--		  counter <= (others => '0');
--		  en_on <= '0';
--		  Venemy_bottom <= "0001101111";
--	 elsif VIDON = '1' and enable_game = '1' then
--	     -- WHEN ENEMY IS OFF SET TIMER
--		  if en_on = '0' then
--		      -- TIMER CREATION ENEMY
--				if rising_edge(refresh) then
--					 if counter < "1011000" then
--						  counter <= counter + 1;
--					 else
--					     counter <= (others => '0');
--						  en_on <= '1';
--					 end if;
--  		      end if;
--		  end if;
--		  -- ENEMY IS ON
--		  if en_on = '1' then
--		      -- RESET COUNTER
--		      counter <= (others => '0');
--		      -- FINEL STATE MACHINE FOR THE MOVEMENT
--				if rising_edge(refresh) then
--					 state <= new_state;
--					 case state is
--					     when '0' =>
--						      Venemy_bottom <= Venemy_bottom + delta;
--								if (Venemy_bottom + Venemy_top) >= "1110100011" then
--								    new_state <= '1';
--								end if;
--						  when '1' =>
--						      Venemy_bottom <= Venemy_bottom - delta;
--								if Venemy_bottom < "0001110011" then
--								    new_state <= '0';
--								end if;
--						  when others =>
--						      Venemy_bottom <= Venemy_bottom + delta;
--								if (Venemy_bottom + Venemy_top) >= "1110100011" then
--								    new_state <= '1';
--								end if;
--					  end case;
--				end if;
--				if (Hposition >= Henemy_bottom and Hposition < Henemy_top)
--				     and (Vposition >= Venemy_bottom and Vposition < Venemy_bottom + Venemy_top) then
--					  enemyon <= '1';
--					  enemy_pos <= Venemy_bottom + "1111";
--				end if;
--				-- ENEMY IS DESTROYED BY THE LASER
--				if enemyon = '1' and laser_on = '1' then
--				    en_on <= '0';
--					 en_out <= '1';
--				end if;
--		  end if;
--	 end if;
--	 -- IF ENEMY IS OFF RESET V POSITION
--	 if en_out = '1' then
--	     Venemy_bottom <= "0001101111";
--	 end if;







