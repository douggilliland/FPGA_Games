----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:04:31 06/16/2015 
-- Design Name: 
-- Module Name:    counter_mitra - Behavioral 
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

entity counter_mitra is
    Port ( refresh : in  STD_LOGIC;
           VIDON : in  STD_LOGIC;
           enable_game : in  STD_LOGIC;
           mitra_trigger : out  STD_LOGIC_VECTOR (3 downto 0));
end counter_mitra;

architecture Behavioral of counter_mitra is
signal counter_max : std_logic_vector(9 downto 0);
signal counter : std_logic_vector(4 downto 0);
signal mitra_on : std_logic_vector(3 downto 0);
signal i : std_logic_vector(2 downto 0) := "000";
signal ok : std_logic := '0';
begin

process(VIDON, enable_game, refresh)
begin
	 
    if VIDON = '1' and enable_game = '1' then
	 
	     if ok = '0' then
	     if rising_edge(refresh) then
		      if counter_max < "0000000100" then
				    counter_max <= counter_max + 1;
				else
				    counter_max <= (others => '0');
					 ok <= '1';
			   end if;
	      end if;
			end if;
			
			if ok = '1' then
				
				if rising_edge(refresh) then
				     if counter < "00110" then
					      counter <= counter + 1;
					  else
					      counter <= (others => '0');
							mitra_on(conv_integer(i)) <= '1';
							i <= i + 1;
				    end if;
				end if;
				
				if i = "100" then
				    ok <= '0';
					 mitra_on <= (others => '0');
					 i <= "000";
				end if;
		end if;
			
	 end if;

end process;

mitra_trigger <= mitra_on;

end Behavioral;



















