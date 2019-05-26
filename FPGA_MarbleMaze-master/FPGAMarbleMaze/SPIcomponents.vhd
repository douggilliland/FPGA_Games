--///////////////////////////////////////////////////////////////////////////////////
-- Company: Digilent Inc.
-- Engineer: Andrew Skreen
--				 Josh Sackos
-- 
-- Create Date:    07/26/2012
-- Module Name:    SPIcomponent
-- Project Name: 	 PmodACL_Demo
-- Target Devices: Nexys3
-- Tool versions:  ISE 14.1
-- Description: The spi_master controls the state of the entire interface. Using 
--					 several signals to interact with the other modules. The spi_master
--					 selects the data to be transmitted and stores all data received
--					 from the PmodACL.  The data is then made available to the rest of
--					 the design on the xAxis, yAxis, and zAxis outputs.
--
--
--  Inputs:
--		CLK				100MHz onboard system clock
--		RST				Main Reset Controller
--		START				Signal to initialize a data transfer
--		SDI				Serial Data In
--
--  Outputs:
--		SDO				Serial Data Out
--		SCLK				Serial Clock
--		SS					Slave Select
--		xAxis				x-axis data received from PmodACL
--		yAxis				y-axis data received from PmodACL
--		zAxis				z-axis data received from PmodACL
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
entity SPIcomponent is
    Port ( CLK : in  STD_LOGIC;
			  RST : in  STD_LOGIC;
			  START : in STD_LOGIC;
           SDI : in  STD_LOGIC;
           SDO : out  STD_LOGIC;
           SCLK : out  STD_LOGIC;
           SS : out  STD_LOGIC;
			  xAxis : out STD_LOGIC_VECTOR(9 downto 0);
			  yAxis : out STD_LOGIC_VECTOR(9 downto 0);
			  zAxis : out STD_LOGIC_VECTOR(9 downto 0)
	);
end SPIcomponent;

architecture Behavioral of SPIcomponent is

-- ====================================================================================
-- 									Component Declarations
-- ====================================================================================
	
		-- **********************************************
		-- 		    Serial Port Interface RxTx
		-- **********************************************
		component SPIinterface 
			 Port ( txbuffer : in  STD_LOGIC_VECTOR ( 15 downto 0 );
					  rxbuffer : out  STD_LOGIC_VECTOR ( 7 downto 0 );
					  transmit : in STD_LOGIC;
					  done_out : out STD_LOGIC;
					  sdi : in STD_LOGIC;
					  sdo : out STD_LOGIC;
					  rst : in STD_LOGIC;
					  clk : in STD_LOGIC;
					  sclk : out  STD_LOGIC);
		end component;


		-- **********************************************
		-- 	Serial Port Interface Master Controller
		-- **********************************************
		component SPImaster
			Port (  rst : in  STD_LOGIC;
					  start : in  STD_LOGIC;
					  transmit : out  STD_LOGIC;
					  done : in STD_LOGIC;
					  clk : in STD_LOGIC;
					  txdata : out STD_LOGIC_VECTOR ( 15 downto 0 );
					  rxdata : in STD_LOGIC_VECTOR ( 7 downto 0 );
					  x_axis_data : out STD_LOGIC_VECTOR ( 9 downto 0 );
					  y_axis_data : out STD_LOGIC_VECTOR ( 9 downto 0 );
					  z_axis_data : out STD_LOGIC_VECTOR ( 9 downto 0 )
					  );
		end component;


		-- **********************************************
		-- 			 Slave Select Controller
		-- **********************************************
		component slaveSelect
			Port (  ss : out  STD_LOGIC;
					  clk : in STD_LOGIC;
					  done : in STD_LOGIC;
					  transmit : in STD_LOGIC;
					  rst : in STD_LOGIC);
		end component;

-- ====================================================================================
-- 							       Signals and Constants
-- ====================================================================================

	signal TxBuffer : std_logic_vector ( 15 downto 0 );
	signal RxBuffer : std_logic_vector ( 7 downto 0 );
	signal doneConfigure : std_logic;
	signal done : std_logic;
	signal transmit : std_logic;

--  ===================================================================================
-- 							  				Implementation
--  ===================================================================================
begin

			---------------------------------------------------------------------------
			--	Controls SPI Interface, Stores Received Data, and Controls Data to Send
			---------------------------------------------------------------------------
			C0: SPImaster port map ( RST => RST,
											 START => START,
											 CLK => CLK,
											 transmit => transmit,
											 TxData => txBuffer,
											 RxData => RxBuffer,
											 done => done,
											 x_axis_data => xAxis,
											 y_axis_data => yAxis,
											 z_axis_data => zAxis
			);
											 

			---------------------------------------------------------------------------
			--		 Produces Timing Signal, Reads ACL Data, and Writes Data to ACL
			---------------------------------------------------------------------------
			C1: SPIinterface port map ( SDI => SDI,
												 SDO => SDO,
												 RST => RST,
												 CLK => CLK,
												 SCLK => SCLK,
												 TxBuffer => TxBuffer,
												 RxBuffer => RxBuffer,
												 done_out => done,
												 transmit => transmit
			);
											
											
			---------------------------------------------------------------------------
			--		 			 	Enables/Disables PmodACL Communication
			---------------------------------------------------------------------------
			C2: slaveSelect port map ( clk => CLK,
												SS => SS,
												done => done,
												transmit => transmit,
												RST => RST
			);

end Behavioral;

