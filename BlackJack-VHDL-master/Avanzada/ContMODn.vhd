----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:40:22 12/11/2015 
-- Design Name: 
-- Module Name:    ContMODn - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: Contador modulo n
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ContMODn is
port ( c_enable : in std_logic;
       clk      : in std_logic;
		 rst      : in std_logic;
		 Y        : out std_logic_vector(5 downto 0));
end ContMODn;

architecture arch_ContMODn of ContMODn is


signal Y_aux : std_logic_vector(5 downto 0);
begin
		Y<= Y_aux;
contador: process(clk,c_enable,rst)
	begin
		if rst = '1' then
			Y_aux <= (others => '0');
		elsif rising_edge(clk) then
			if unsigned(Y_aux) = 52 then
				Y_aux <= (others => '0');
			elsif c_enable = '1' then
				Y_aux <= std_logic_vector(unsigned(Y_aux) + 1);
			end if;
		end if;
	end process contador;

end arch_ContMODn;

