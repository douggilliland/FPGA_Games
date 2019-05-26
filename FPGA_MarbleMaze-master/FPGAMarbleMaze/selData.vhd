--/////////////////////////////////////////////////////////////////////////////////////////
-- Company: Digilent Inc.
-- Engineer: Josh Sackos
-- 
-- Create Date:    07/26/2012
-- Module Name:    selData
-- Project Name: 	 PmodACL_Demo
-- Target Devices: Nexys3
-- Tool versions:  ISE 14.1
-- Description: This module converts axis data from 2's compliment to its magnitude
--					 representation.  Based upon the input switches SW(1) and SW(0) either
--					 the x-axis, y-axis, or z-axis data will be output on the DOUT output.
--
-- Revision History: 
-- 						Revision 0.01 - File Created (Josh Sackos)
--/////////////////////////////////////////////////////////////////////////////////////////
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_arith.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity sel_Data is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
			  SW : in STD_LOGIC_VECTOR(1 downto 0);
           xAxis : in  STD_LOGIC_VECTOR (9 downto 0);
           yAxis : in  STD_LOGIC_VECTOR (9 downto 0);
           zAxis : in  STD_LOGIC_VECTOR (9 downto 0);
           DOUT : out  STD_LOGIC_VECTOR (9 downto 0);
           LED : out  STD_LOGIC_VECTOR (2 downto 0));
end sel_Data;

architecture Behavioral of sel_Data is

begin

			-------------------------------------------------
			--	Select Display Data and Convert to Magnitude
			-------------------------------------------------
			process(CLK, RST) begin
					if(RST = '1') then
							LED <= "000";
							DOUT <= "0000000000";
					elsif rising_edge(CLK) then
							if(SW = "00") then
									LED <= "001";
									if(xAxis(9) = '1') then
											DOUT <= xAxis(9) & ("000000000" - xAxis(8 downto 0));
									else
											DOUT <= xAxis;
									end if;
							elsif(SW = "01") then
									LED <= "010";
									if(yAxis(9) = '1') then
											DOUT <= yAxis(9) & ("000000000" - yAxis(8 downto 0));
									else
											DOUT <= yAxis;
									end if;
							elsif(SW = "10") then
									LED <= "100";
									if(zAxis(9) = '1') then
											DOUT <= zAxis(9) & ("000000000" - zAxis(8 downto 0));
									else
											DOUT <= zAxis;
									end if;
							else
									LED <= "001";
									if(xAxis(9) = '1') then
											DOUT <= xAxis(9) & ("000000000" - xAxis(8 downto 0));
									else
											DOUT <= xAxis;
									end if;
							end if;
					end if;
			end process;

end Behavioral;

