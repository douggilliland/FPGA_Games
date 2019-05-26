----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.01.2017 11:32:32
-- Design Name: 
-- Module Name: TablePackage - Behavioral
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


package TableType is 
    type TABLE is array (natural range <>, natural range <>) of STD_LOGIC;
    procedure extract (internalState : IN TABLE; i,j : IN integer;  signal result: OUT std_logic_vector (7 downto 0));
end TableType;

PACKAGE BODY TableType IS
procedure extract (internalState : IN TABLE; i,j : IN integer; signal result: OUT std_logic_vector (7 downto 0)) is
-- variable tmp: std_logic_vector(7 downto 0);
BEGIN
    result <= internalState(i+1,j)&internalState(i+1,j+1)&internalState(i,j+1)&internalState(i-1,j+1)&internalState(i-1,j)&internalState(i-1,j-1)&internalState(i,j-1)&internalState(i+1,j-1);
END procedure extract;

END;