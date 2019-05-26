----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.02.2017 11:26:49
-- Design Name: 
-- Module Name: RisingEdgeDetector - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

--Source: http://surf-vhdl.com/how-to-design-a-good-edge-detector/

entity RisingEdgeDetector is
port (
  i_clk                       : in  std_logic;
  i_input                     : in  std_logic;
  o_pulse                     : out std_logic);
end RisingEdgeDetector;

architecture Behavioral of RisingEdgeDetector is
signal r0_input                           : std_logic;
signal r1_input                           : std_logic;
begin
p_rising_edge_detector : process(i_clk)
begin

  if(rising_edge(i_clk)) then
    r0_input           <= i_input;
    r1_input           <= r0_input;
  end if;
end process p_rising_edge_detector;
o_pulse            <= not r1_input and r0_input;
end Behavioral;
