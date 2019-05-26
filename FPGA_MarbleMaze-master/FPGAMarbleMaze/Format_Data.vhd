--/////////////////////////////////////////////////////////////////////////////////
-- Company: Digilent Inc.
-- Engineer: Josh Sackos
-- 
-- Create Date:    07/26/2012
-- Module Name:    Format_Data 
-- Project Name: 	 PmodACL_Demo
-- Target Devices: Nexys3
-- Tool versions:  ISE 14.1
-- Description: The purpose of this module is to calculate the "g" value of the
--					 the input data.  In this demo the accelerometer is configured for
--					 +/- 2g, this means that the input data must be divided by the LSB
--					 to get the "g" value of the current reading.
--
--					 The calculated/measured "g" value will range from 0.00 to 2.0X. The
--					 calculated "g" value is sent into a binary to BCD converter, and
--					 the BCD data is output for display on the SSD.
--
-- Revision History: 
-- 						Revision 0.01 - File Created (Josh Sackos)
--/////////////////////////////////////////////////////////////////////////////////
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  ===================================================================================
--  								Define Module, Inputs and Outputs
--  ===================================================================================
entity Format_Data is
    Port ( CLK : in  STD_LOGIC;
			  DCLK : in STD_LOGIC;
           RST : in  STD_LOGIC;
           DIN : in  STD_LOGIC_VECTOR (8 downto 0);
           BCDOUT : out  STD_LOGIC_VECTOR (11 downto 0));
end Format_Data;

architecture Behavioral of Format_Data is

--  ===================================================================================
-- 							  				  Components
--  ===================================================================================

		-- **********************************************
		-- 				1/100 of LSB Division
		-- **********************************************
		component Div port (
			clk: in std_logic;
			rfd: out std_logic;
			dividend: in std_logic_vector(14 downto 0);
			divisor: in std_logic_vector(7 downto 0);
			quotient: out std_logic_vector(14 downto 0);
			fractional: out std_logic_vector(7 downto 0)
		);
		end component;


		-- **********************************************
		-- 				Binary to BCD Converter
		-- **********************************************
		component Binary_To_BCD

			 Port ( CLK : in  STD_LOGIC;
					  RST : in  STD_LOGIC;
					  START : in STD_LOGIC;
					  BIN : in  STD_LOGIC_VECTOR(8 downto 0);
					  BCDOUT : inout STD_LOGIC_VECTOR(15 downto 0)
			 );

		end component;

--  ===================================================================================
-- 							  			Signals and Constants
--  ===================================================================================

			-- Scaled up divisor and scaling factor for "g" calculation to get hundredths place accuracy
			constant DIVISOR : STD_LOGIC_VECTOR(7 downto 0) := "10100011";
			constant SCALING : STD_LOGIC_VECTOR(6 downto 0) := "1000000";

			-- Signals for scaled division to determine "g" number
			signal tmpDIVIDEND : STD_LOGIC_VECTOR(15 downto 0);
			signal quo : STD_LOGIC_VECTOR(14 downto 0) := "000000000000000";
			signal rmd : STD_LOGIC_VECTOR(7 downto 0) := "00000000";
			signal rfd : STD_LOGIC;

			-- Input/Output data, binary to BCD converter
			signal inputBCD : STD_LOGIC_VECTOR(8 downto 0) := "000000000";
			signal outputBCD : STD_LOGIC_VECTOR(15 downto 0) := X"0000";

--  ===================================================================================
-- 							  				Implementation
--  ===================================================================================
begin

			-- Calculate scaled up dividend
			tmpDIVIDEND <= DIN*SCALING;
			
			-- Assign input data to binary to BCD converter
			inputBCD <= quo(8 downto 0);


			--------------------------------
			--		 	LSB Division
			--------------------------------
			Division : Div port map (
						clk => CLK,
						dividend => tmpDIVIDEND(14 downto 0),
						divisor => DIVISOR,
						rfd => rfd,
						quotient => quo,
						fractional => rmd
			);


			--------------------------------
			--		 	Binary to BCD
			--------------------------------
			BtoBCD : Binary_To_BCD port map (
						CLK => CLK,
						RST => RST,
						START => DCLK,
						BIN => inputBCD,
						BCDOUT => outputBCD
			);

			-- Assign output display data
			BCDOUT(11 downto 0) <= outputBCD(11 downto 8) & outputBCD(7 downto 4) & outputBCD(3 downto 0);

end Behavioral;

