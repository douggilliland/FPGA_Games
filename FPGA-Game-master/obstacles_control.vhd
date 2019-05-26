----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:30:59 04/23/2015 
-- Design Name: 
-- Module Name:    obstacles_control - Behavioral 
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

entity obstacles_control is
    Port ( Hposition     : in  STD_LOGIC_VECTOR (10 downto 0);
           Vposition     : in  STD_LOGIC_VECTOR (9 downto 0);
           VIDON         : in  STD_LOGIC;
           refresh       : in  STD_LOGIC;
			  enable_game   : in  STD_LOGIC;
           obstacle1_on  : out  STD_LOGIC;
			  obstacle1_row : out  STD_LOGIC_VECTOR(10 downto 0);
			  obstacle1_col : out  STD_LOGIC_VECTOR(9 downto 0);
           obstacle2_on  : out  STD_LOGIC;
			  obstacle2_row : out  STD_LOGIC_VECTOR(10 downto 0);
			  obstacle2_col : out  STD_LOGIC_VECTOR(9 downto 0);
			  obstacle3_on  : out  STD_LOGIC;
			  obstacle3_row : out  STD_LOGIC_VECTOR(10 downto 0);
			  obstacle3_col : out  STD_LOGIC_VECTOR(9 downto 0) );
end obstacles_control;


architecture Behavioral of obstacles_control is
-- BOUNDARIES OBSTACLE 1
signal Htop1 : std_logic_vector(10 downto 0) :=     "11011011000"; --1752
constant Hbottom1 : std_logic_vector(10 downto 0):= "00001100100"; --100
constant Vtop1 : std_logic_vector(9 downto 0) :=     "1000100110"; -- 550
constant Vbottom1 : std_logic_vector(9 downto 0) :=  "0111000010";--450
--OBSTACLE 1 ROM SIGNALS
signal obs1_col : std_logic_vector (9 downto 0);
signal obs1_row : std_logic_vector (10 downto 0); 
-- BOUNDARIES OBSTACLE 2
signal Htop2 : std_logic_vector(10 downto 0) := "11011011000"; -- 1752
constant Hbottom2 : std_logic_vector(10 downto 0) := "00001100100"; -- 100
constant Vtop2 : std_logic_vector(9 downto 0) := "0110010000"; --400
constant Vbottom2 : std_logic_vector(9 downto 0) := "0100101100"; --300 
-- OBSTACLE 2 ROM SIGNALS
signal obs2_col : std_logic_vector(9 downto 0);
signal obs2_row : stD_logic_vector(10 downto 0);
--BOUNDARIES OBSTACLE 3
signal Htop3 : std_logic_vector(10 downto 0) := "11011011000"; -- 1752
constant Hbottom3 : std_logic_vector(10 downto 0) := "00001100100"; --100
constant Vtop3 : std_logic_vector(9 downto 0) := "1010011000"; -- 664
constant Vbottom3 : std_logic_vector(9 downto 0) := "1000110100"; -- 564
-- OBSTACLE 3 ROM SIGNALS
signal obs3_col : std_logic_vector(9 downto 0);
signal obs3_row : std_logic_vector(10 downto 0);
-- SPEED
constant delta : std_logic_vector(9 downto 0) := "0000000101"; -- 5
-- SCREEN BOUNDARIES
constant Hmax : std_logic_vector(10 downto 0) := "11010001000"; -- 1672
constant Hmin : std_logic_vector(10 downto 0) := "00011101000"; -- 232
-- OBSTACLES ON
signal obs_1 : std_logic;
signal obs_2 : std_logic;
signal obs_3 : std_logic;
-- COUNTER AND GENERATION SIGNALS OBSTACLE 1
signal count1 : std_logic_vector(8 downto 0) := "000000000";
signal obs1_gen : std_logic := '0';
-- COUNTER AND GENERATION SIGNALS OBSTACLE 2
signal count2 : std_logic_vector(8 downto 0) := "000000000";
signal obs2_gen : std_logic := '0';
-- COUNTER AND GENERATION SIGNALS OBSTACLE 3
signal count3 : std_logic_vector(8 downto 0) := "000000000";
signal obs3_gen : std_logic := '0';

begin
-- OBSTACLE 1
process(refresh, Hposition, enable_game)
begin

    	 obs_1 <= '0';
		 
	 -- IF ENABLE OFF OR OBSTACLE OVER BOUNDARIES, RESET INITIAL POSITION
    if enable_game = '0' or Htop1 < "00000000110" then
	     obs1_gen <= '0';
		  Htop1 <= "11011011000";
        count1 <= (others => '0');
	 elsif VIDON = '1' and enable_game = '1' then
		  -- COUNTER GENERATION OBSTACLE
		  if rising_edge(refresh) and obs1_gen = '0' then
					if count1 <= "000111100" then
						 count1 <= count1 + 1;
					else
						 count1 <= (others => '0');
						 Htop1 <= "11011011000";
						 obs1_gen <= '1';
					end if;
		   end if;
			-- OBSTACLE GENERATED
			if obs1_gen = '1' then
			    -- MOVEMENT
			    if rising_edge(refresh) then
						 Htop1 <= (Htop1 - delta);
			    end if;
			    -- OBSTACLE ON
				 if (Hposition >= (Htop1 - Hbottom1) and Hposition < Htop1) and 
					 (Vposition >= Vbottom1 and Vposition < Vtop1) then
						 obs_1 <= '1';
						 obs1_col <= (Vposition - Vbottom1);
						 obs1_row <= (Hposition - (Htop1 - Hbottom1));
		       end if;
	     end if;
    end if;
		 
end process;
-- OBSTACLE 2
process(refresh, Hposition, enable_game)
begin

    	 obs_2 <= '0';
		 
	 -- IF ENABLE OFF OR OBSTACLE OVER BOUNDARIES, RESET INITIAL POSITION
    if enable_game = '0' or Htop2 < "00000000110" then
	     obs2_gen <= '0';
		  Htop2 <= "11011011000";
        count2 <= (others => '0');
	 elsif VIDON = '1' and enable_game = '1' then
		  -- COUNTER GENERATION OBSTACLE
		  if rising_edge(refresh) and obs2_gen = '0' then
					if count2 <= "001111100" then
						 count2 <= count2 + 1;
					else
						 count2 <= (others => '0');
						 Htop2 <= "11011011000";
						 obs2_gen <= '1';
					end if;
		   end if;
			-- OBSTACLE GENERATED
			if obs2_gen = '1' then
			    -- MOVEMENT
			    if rising_edge(refresh) then
						 Htop2 <= (Htop2 - delta);
			    end if;
			    -- OBSTACLE ON
				 if (Hposition >= (Htop2 - Hbottom2) and Hposition < Htop2) and 
					 (Vposition >= Vbottom2 and Vposition < Vtop2) then
						 obs_2 <= '1';
						 obs2_col <= (Vposition - Vbottom2);
						 obs2_row <= (Hposition - (Htop2 - Hbottom2));
		       end if;
	     end if;
    end if;
	 
end process;
-- OBSTACLE 3
process(refresh, Hposition, enable_game)
begin

    	 obs_3 <= '0';
		 
	 -- IF ENABLE OFF OR OBSTACLE OVER BOUNDARIES, RESET INITIAL POSITION
    if enable_game = '0' or Htop3 < "00000000110" then
	     obs3_gen <= '0';
		  Htop3 <= "11011011000";
        count3 <= (others => '0');
	 elsif VIDON = '1' and enable_game = '1' then
		  -- COUNTER GENERATION OBSTACLE
		  if rising_edge(refresh) and obs3_gen = '0' then
					if count3 <= "011111100" then
						 count3 <= count3 + 1;
					else
						 count3 <= (others => '0');
						 Htop3 <= "11011011000";
						 obs3_gen <= '1';
					end if;
		   end if;
			-- OBSTACLE GENERATED
			if obs3_gen = '1' then
			    -- MOVEMENT
			    if rising_edge(refresh) then
						 Htop3 <= (Htop3 - delta);
			    end if;
			    -- OBSTACLE ON
				 if (Hposition >= (Htop3 - Hbottom3) and Hposition < Htop3) and 
					 (Vposition >= Vbottom3 and Vposition < Vtop3) then
						 obs_3 <= '1';
						 obs3_col <= (Vposition - Vbottom3);
						 obs3_row <= (Hposition - (Htop3 - Hbottom3));
		       end if;
	     end if;
    end if;
	 
end process;

obstacle1_on <= obs_1;
obstacle2_on <= obs_2;
obstacle3_on <= obs_3;

obstacle1_row <= obs1_row;
obstacle1_col <= obs1_col;

obstacle2_row <= obs2_row;
obstacle2_col <= obs2_col;

obstacle3_row <= obs3_row;
obstacle3_col <= obs3_col;

end Behavioral;











