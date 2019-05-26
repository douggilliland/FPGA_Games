--///////////////////////////////////////////////////////////////////////////////////
-- Company: Digilent Inc.
-- Engineer: Andrew Skreen
--				 Josh Sackos
-- 
-- Create Date:    07/26/2012
-- Module Name:    SPIinterface
-- Project Name: 	 PmodACL_Demo
-- Target Devices: Nexys3
-- Tool versions:  ISE 14.1
-- Description: This module involves the control of the SPI interface with three 
--				 	 processes including the reception of data, the transmission of data,
--					 and finally the production of the serial data clock used in the SPI
--					 interface.
--
-- 	 Inputs:
--			transmit 			Signal from SPImaster	
--			txbuffer 			Transmission Buffer, holds signal from SPImaster
--			rst					User input RESET
--			clk 					100 MHz clock signal
--			sdi 					Serial Data In from ACL
--		
--  	Outputs:
--			rxbuffer 			Recieve Buffer, holds signal from sdi
--			done_out 				signal that goes to SPImaster signalling end of Transmission
--			sdo 					Serial Data Out to ACL
--			sclk 					Serial Clock out to ACL
--
-- Revision History: 
-- 						Revision 0.01 - File Created (Andrew Skreen)
--							Revision 1.00 - Added comments and modified code (Josh Sackos)
--//////////////////////////////////////////////////////////////////////////////////
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


--  ===================================================================================
--  								Define Module, Inputs and Outputs
--  ===================================================================================
entity SPIinterface is
    Port ( txbuffer : in  STD_LOGIC_VECTOR ( 15 downto 0 );
           rxbuffer : out  STD_LOGIC_VECTOR ( 7 downto 0 );
			  transmit : in STD_LOGIC;
			  done_out : out STD_LOGIC;
			  sdi : in STD_LOGIC;
			  sdo : out STD_LOGIC;
			  rst : in STD_LOGIC;
			  clk : in STD_LOGIC;
           sclk : out  STD_LOGIC);
end SPIinterface;

architecture Behavioral of SPIinterface is

-- ====================================================================================
-- 							       Signals and Constants
-- ====================================================================================
	
	constant CLKDIVIDER : std_logic_vector ( 7 downto 0 ) := X"FF"; --leads to sclk of about 98kHz
	signal clk_count : std_logic_vector ( 7 downto 0 );
	signal clk_edge_buffer : std_logic;

	signal sck_previous : std_logic;
	signal sck_buffer : std_logic;
	

	signal tx_shift_register : STD_LOGIC_VECTOR ( 15 downto 0 );
	signal rx_shift_register : STD_LOGIC_VECTOR ( 7 downto 0 );

	signal tx_count : std_logic_vector ( 3 downto 0 );
	signal rx_count : std_logic_vector ( 3 downto 0 );
	signal done : std_logic;
	type TxType is ( idle , transmitting );
	signal TxSTATE : TxType;

	type RxType is ( idle , recieving );
	signal RxSTATE : RxType;


	type SCLKType is ( idle , running );
	signal SCLKSTATE : SCLKType;
	

--  ===================================================================================
-- 							  				Implementation
--  ===================================================================================
	begin

		--Transmission controller
		TxProcess : process ( clk ) begin
			--Reset state
			if rising_edge( clk ) then
				if rst = '1' then 
					tx_shift_register<= ( others => '0' );
					tx_count<= ( others => '0' );
					sdo<= '1';
					TxSTATE<= idle;
				else
					case TxSTATE is
						--when idle, if transmit goes high, then the state goes into 
						--transmitting. during idle state, sdo is held high
						when idle =>
							tx_shift_register<= txbuffer;
							--sdo<='1';
							if transmit = '1' then 
								TxSTATE<= transmitting;
							elsif done = '1' then 
								sdo<= '1';
							end if;
						when transmitting =>
							if sck_previous = '1' and sck_buffer = '0' then 
								--when count is 15, then cycles out to idle state again. 
								--otherwise, the TxData is shifted out on the falling edge
								--of the serial clock
								if tx_count = "1111" then 
									TxSTATE<= idle;
									tx_count<= ( others => '0' );
									sdo<= tx_shift_register( 15 );
								else
									tx_count<= tx_count + "0001";
									sdo<= tx_shift_register( 15 );
									tx_shift_register<= tx_shift_register( 14 downto 0 ) & '0';
								end if;
							end if;
						when others =>
							null;
					end case;
				end if;
			end if;
		end process;

		--Reception Controller
		RxProcess : process ( clk ) begin
			--Reset state
			if rising_edge( clk ) then 
				if rst = '1' then 
					rx_shift_register<= ( others => '0' );
					rx_count<= ( others => '0' );
					done<= '0';
				else
					case RxSTATE is
						when idle =>
							--when transmit goes high from the SPImaster, the state
							--goes to recieving and rx_shift_register is zeroed
							if transmit = '1' then 
								RxSTATE<= recieving;
								rx_shift_register<= ( others => '0' );
							elsif SCLKSTATE = idle then
								done<= '0';
							end if;
						when recieving =>
							if sck_previous = '0' and sck_buffer = '1' then 
								--sdi is sampled on the rising edge and after the 16 rising edge, 
								--the state goes back to idle and done is asserted
								if rx_count = "1111" then 
									RxSTATE<= idle;
									rx_count<= ( others => '0' );
									rx_shift_register<= rx_shift_register ( 6 downto 0 ) & sdi;
									done<='1';
								else
									rx_count<= rx_count + "0001";
									rx_shift_register<= rx_shift_register ( 6 downto 0 ) & sdi;
								end if;
							end if;
						when others =>
							null;
					end case;
				end if;
			end if;
		end process;

		--The rxbuffer is tied to the rx_shift_register and is ouput to the SPImaster
		rxbuffer<= rx_shift_register;

		--sclk generating process
		SCLKgen : process ( clk ) begin 
			--Reset State with SCK held high
			if rising_edge( clk ) then
				if rst = '1' then 
					clk_count<= ( others => '0' );
					SCLKSTATE<= idle;
					sck_previous<= '1';
					sck_buffer<='1';
				else
					case SCLKSTATE is
						when idle =>
							sck_previous<= '1';
							sck_buffer<='1';
								--when transmit is high, the state goes to running
								if transmit = '1' then 
									SCLKSTATE<= running;
									clk_count<= ( others => '0' );
									clk_edge_buffer<= '0';
									sck_previous<= '1';
									sck_buffer<='1';
								end if;
						when running =>
								--when done is high, the state goes back to idle
								if done = '1' then 
									SCLKSTATE<= idle;
								--if done is nto asserted, the clock continues to be 
								--generated
								elsif clk_count = CLKDIVIDER then 
									if clk_edge_buffer = '0' then
										sck_buffer<= '1';
										clk_edge_buffer<= '1';
									else
										sck_buffer<= not sck_buffer;
										clk_count<= ( others => '0' );
									end if;
								else
									sck_previous<= sck_buffer;
									clk_count<= clk_count + 1;
								end if;
						when others =>
							null;
					end case;
				end if;
			end if;
		end process;

		--the signal SCK is tied to the output sclk
		sclk<= sck_buffer;
		--done_out, to the SPImaster, is tied to the signal done produced in the recieving state machine
		done_out<= done;


end Behavioral;

