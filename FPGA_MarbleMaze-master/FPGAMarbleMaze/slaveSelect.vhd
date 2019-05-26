--///////////////////////////////////////////////////////////////////////////////////
-- Company: Digilent Inc.
-- Engineer: Andrew Skreen
--				 Josh Sackos
-- 
-- Create Date:    07/26/2012
-- Module Name:    slaveSelect
-- Project Name: 	 PmodACL_Demo
-- Target Devices: Nexys3
-- Tool versions:  ISE 14.1
-- Description: A simple module involving the switching of the slave select line
--					 during transmission and idle states. 
--
--  Inputs:
--		rst 					User input Reset
--		transmit 			signal from SPImaster causing ss line to go low
--								( enable )
--		done 					signal from SPIinterface causing ss line to go 
--								high ( disable )
--
--  Outputs:
--		ss 					ss output to ACL
--
-- Revision History: 
-- 						Revision 0.01 - File Created (Andrew Skreen)
--							Revision 1.00 - Added comments and modified code (Josh Sackos)
--//////////////////////////////////////////////////////////////////////////////////
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--  ===================================================================================
--  								Define Module, Inputs and Outputs
--  ===================================================================================
entity slaveSelect is
    Port (  rst : in STD_LOGIC;
				clk : in STD_LOGIC;
				transmit : in STD_LOGIC;
				done : in STD_LOGIC;
				ss : out  STD_LOGIC);
end slaveSelect;

architecture Behavioral of slaveSelect is

--  ===================================================================================
--  											Implementation
--  ===================================================================================
	begin

		ssprocess : process ( clk ) begin 
			if rising_edge( clk ) then 
				--reset state, ss goes high ( disabled )
				if rst = '1' then 
					ss<= '1';
				--if transmitting, then ss goes low ( enabled )
				elsif transmit = '1' then 
					ss<= '0';
				--if done, then ss goes high ( disabled )
				elsif done = '1' then
					ss<= '1';
				end if;
			end if;
		end process;


end Behavioral;

