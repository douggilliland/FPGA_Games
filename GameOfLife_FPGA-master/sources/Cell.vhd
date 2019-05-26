----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.01.2017 10:06:34
-- Design Name: 
-- Module Name: Cell - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity Cell is
    Generic (CELL_INIT : STD_LOGIC := '0');
    Port ( CLK : in STD_LOGIC;
           CLK_E : in STD_LOGIC;
           PROX : in STD_LOGIC_VECTOR(7 downto 0);
           RST : in STD_LOGIC;
           RST_VALUE : in STD_LOGIC;
           STATE : out STD_LOGIC);
end Cell;

architecture Behavioral of Cell is

-- The state of the cell needs to be read and written so an internal signal is used
signal internalState : STD_LOGIC := CELL_INIT;
signal count : integer range 0 to 8 := 0;

signal count0 : integer range 0 to 1 := 0;
signal count1 : integer range 0 to 1 := 0;
signal count2 : integer range 0 to 1 := 0;
signal count3 : integer range 0 to 1 := 0;
signal count4 : integer range 0 to 1 := 0;
signal count5 : integer range 0 to 1 := 0;
signal count6 : integer range 0 to 1 := 0;
signal count7 : integer range 0 to 1 := 0;

begin

STATE <= internalState;

count0 <= 1 when PROX(0)='1' else 0;
count1 <= 1 when PROX(1)='1' else 0;
count2 <= 1 when PROX(2)='1' else 0;
count3 <= 1 when PROX(3)='1' else 0;
count4 <= 1 when PROX(4)='1' else 0;
count5 <= 1 when PROX(5)='1' else 0;
count6 <= 1 when PROX(6)='1' else 0;
count7 <= 1 when PROX(7)='1' else 0;

count <= count0+count1+count2+count3+count4+count5+count6+count7;

process(CLK, CLK_E, RST, RST_VALUE, PROX)  --the rules for every cell of the GoL
begin
if (RST = '1') then
    internalState <= RST_VALUE;
elsif (CLK_E'event and CLK_E='1') then
    if (count=3) then
        internalState <= '1';
    elsif (count=2 and internalState = '1') then
        internalState <= '1';
    else
        internalState <= '0';
    end if;
end if;
end process;


end Behavioral;

