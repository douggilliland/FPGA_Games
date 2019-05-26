----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.01.2017 10:50:44
-- Design Name: 
-- Module Name: Echantilloneur - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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

entity Echantilloneur is
    Port ( S_E : in STD_LOGIC;
           CLK : in STD_LOGIC;
           Q_E : out STD_LOGIC :='0');
end Echantilloneur;

architecture Behavioral of Echantilloneur is

signal A : integer := 0;

begin

process(S_E, CLK)
begin
if CLK'event and CLK = '1' then 
    if A>100000 then
        A <= 0;
        Q_E <= S_E;
    else
        A <= A+1;
    end if;
end if;
end process;

end Behavioral;
