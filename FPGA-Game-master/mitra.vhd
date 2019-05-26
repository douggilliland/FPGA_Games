----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:02:43 06/16/2015 
-- Design Name: 
-- Module Name:    mitra - Behavioral 
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

entity mitra is
    Port ( refresh : in  STD_LOGIC;
           VIDON : in  STD_LOGIC;
           enable_game : in  STD_LOGIC;
			  Hposition : in STD_LOGIC_VECTOR(10 downto 0);
			  Vposition : in STD_LOGIC_VECTOR(9 downto 0);
           mitra_trigger : in  STD_LOGIC;
			  enemy_on : in STD_LOGIC;
			  enemy_position : in STD_LOGIC_VECTOR(9 downto 0);
			  mitra_rgb : out STD_LOGIC);
end mitra;

architecture Behavioral of mitra is
signal ok : std_logic := '0';
signal rgb : std_logic;

signal Htop : std_logic_vector(10 downto 0);
constant Hbottom : std_logic_vector(4 downto 0) := "10000";
constant Vbottom : std_logic_vector(2 downto 0) := "100";
signal Vtop : std_logic_vector(9 downto 0);

constant delta : std_logic_vector(4 downto 0) := "10000";

begin

process(VIDON, enable_game, mitra_trigger)
begin

    rgb <= '0';

    if VIDON = '1' and enable_game = '1' then
	     
		  if ok = '0' and enemy_on = '1' then
		      if rising_edge(mitra_trigger) then
				    Vtop <= enemy_position;
					 Htop <= "11000100100"; --1572
		          ok <= '1';
		      end if;
		  end if;
		  
		  if ok = '1' then
		      
				 if rising_edge(refresh) then
						 Htop <= (Htop - delta);
			    end if;
			    
				 if (Hposition >= (Htop - Hbottom) and Hposition < Htop) and 
					 (Vposition >= (Vtop - Vbottom) and Vposition < Vtop) then
						 rgb <= '1';
		       end if;
				
				 if Htop < "00000001111" then
				     ok <= '0';
				 end if;
				
		  end if;
		  
		  
	 end if;

end process;

mitra_rgb <= rgb;

end Behavioral;



















