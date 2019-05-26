----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:26:28 04/21/2015 
-- Design Name: 
-- Module Name:    controll - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity controll is
    Port ( Hposition   : in  STD_LOGIC_VECTOR (10 downto 0);
           Vposition   : in  STD_LOGIC_VECTOR (9 downto 0);
           VIDON       : in  STD_LOGIC;
			  buttons     : in  STD_LOGIC_VECTOR(3 downto 0);
			  refresh     : in  STD_LOGIC;
			  enable_game : in  STD_LOGIC;
           obj_on      : out  STD_LOGIC;
			  Hobj_top    : out  STD_LOGIC_VECTOR(10 downto 0);
			  Vobj_center : out  STD_LOGIC_VECTOR(9 downto 0);
			  obj_col     : out  STD_LOGIC_VECTOR (9 downto 0);
			  obj_row     : out  STD_LOGIC_VECTOR (10 downto 0) );
end controll;

architecture Behavioral of controll is

-- SCREEN BOUNDARIES
constant Hmax : std_logic_vector(10 downto 0) := "11010001000"; -- 1672
constant Hmin : std_logic_vector(10 downto 0) := "00011101000"; -- 232
constant Vmax : std_logic_vector(9 downto 0) := "1110100000"; -- 928
constant Vmin : std_logic_vector(9 downto 0) := "0001101100"; -- 108
-- BOUNDARIES HEART
signal HminHe : std_logic_vector(10 downto 0)      := "01101101010"; -- 874
signal HminHe_next : std_logic_vector(10 downto 0) := "01101101010";
constant HmaxHe : std_logic_vector(10 downto 0)    := "00001100100"; -- 100
signal VminHe : std_logic_vector(9 downto 0)       := "0110110100"; -- 436
signal VminHe_next : std_logic_vector(9 downto 0)  := "0110110100";
constant VmaxHe : std_logic_vector(9 downto 0)     := "0000100100"; -- 36
-- SIGNALS FOR ROM HEART
signal object_on : std_logic;
signal object_col : std_logic_vector(9 downto 0);
signal object_row : std_logic_vector(10 downto 0);
-- CONSTANT FOR MOVEMENT
constant delta : std_logic_vector(9 downto 0) := "0000010000";

begin
process (VIDON, Hposition, Vposition, buttons, enable_game,refresh)
	 begin
	     
		  -- INITIAL CONDITIONS
	     object_on <= '0';
		  object_col <= (others => '0');
		  object_row <= (others =>'0');
		  -- IF ENABLE IS OF RESET CONDITIONS TO INITIALS
		  if VIDON = '1' and enable_game = '0' then
		      HminHe_next <= "01101101010";
		   	VminHe_next <= "0110110100";
		  end if;	  
		  -- IF THE VIDEO IS ON
		  if VIDON = '1' and enable_game = '1' then
		      HminHe<= HminHe_next;
            VminHe <= VminHe_next;	
		      -- CONDITIONS FOR THE BUTTONS, IT CHANGES THE BOUNDARIES OF THE SQUERE OF THE IMMAGE (HEART)
				if rising_edge(refresh) then
				    if buttons(0) = '1' and (HminHe + HmaxHe) < Hmax then
						  HminHe_next <= HminHe + delta;
					 end if;
				    if buttons(1) = '1' and HminHe > Hmin then
				        HminHe_next <= HminHe - delta;
					 end if;
				    if buttons(2) = '1' and (VminHe + VmaxHe) < Vmax then
					     VminHe_next <= VminHe + delta;
					 end if;
				    if buttons(3) = '1' and vminHe > Vmin then
				        VminHe_next <= VminHe - delta;
					 end if;
				 end if;
				 -- REGION WHERE THE IMMAGE IS DISPLAYED (HEART)
				 if (Hposition >= HminHe and Hposition < (HminHe + HmaxHe)) and 
				    (Vposition >= VminHe and Vposition < (VminHe + VmaxHe)) then
					   object_on <= '1';
					   object_col <= (Vposition - VminHe_next);
					   object_row <= (Hposition - HminHe_next);
				 end if;
		   end if;
		  
end process;

obj_on <= object_on;
obj_col <= object_col;
obj_row <= object_row;
Hobj_top <= (HminHe + HmaxHe);
Vobj_center <= VminHe + "10000";

end Behavioral;














