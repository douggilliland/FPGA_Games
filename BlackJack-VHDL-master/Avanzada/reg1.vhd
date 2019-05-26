----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:56:33 12/11/2015 
-- Design Name: 
-- Module Name:    RegPG - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: Registro con carga en paralelo
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

entity RegPG1 is
port ( a   : in  std_logic;
       clk : in  std_logic;
		 load: in  std_logic;
		 rst : in  std_logic;
       Y   : out std_logic);
end RegPG1;

architecture arch_RegPG1 of RegPG1 is

begin

carga: process (clk,rst,load)
	begin
		if rst = '1' then
			Y <= '0';
		elsif rising_edge(clk) then
			if load = '1' then
				Y <= a;
			end if;
		end if;
	end process carga;
end arch_RegPG1;
