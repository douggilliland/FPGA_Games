----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.02.2017 11:21:03
-- Design Name: 
-- Module Name: ClockManager - Behavioral
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

entity ClockManager is
Port ( CLK : in STD_LOGIC;
       CLK_btn_fast : in STD_LOGIC;
       CLK_btn_once : in STD_LOGIC;
       V_sync : in STD_LOGIC;
       CLK_gol : out STD_LOGIC);
end ClockManager;

architecture Behavioral of ClockManager is

signal A : integer := 0;

begin

process(V_sync, CLK_btn_fast, CLK_btn_once, CLK, A)
begin
if V_sync = '1' then
    if CLK_btn_fast = '1' then
       A <= A + 1;
--    elsif CLK_btn_once = '1' then
--       A<=11;
    end if;
elsif CLK'event and CLK = '1' then 
    if A>10 then
        A <= 0;
        CLK_gol <= '1';
    else
        CLK_gol <= '0';
    end if;
end if;
end process;

end Behavioral;




