--///////////////////////////////////////////////////////////////////////////////////
-- Company: Digilent Inc.
-- Engineer: Andrew Skreen
--				 Josh Sackos
-- 
-- Create Date:    07/26/2012
-- Module Name:    SPImaster
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
--		rst							Device Reset Signal
--		clk 							Base system clock of 100 MHz
--		start 						start tied to external user input
--		done 							Signal from SPIinterface for completed transmission
--		rxdata 						Recieved data
--		
--  Outputs:
--		transmit 					Signal to SPIinterface for beginning of transmission
--		txdata						Data out for transmission
--		x_axis_data 				Collected x-Axis data
--		y_axis_data 				Collected y-Axis data
--		z_axis_data 				Collected z-Axis data
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
entity SPImaster is
    Port ( rst : in  STD_LOGIC;
			  clk : in  STD_LOGIC;
           start : in  STD_LOGIC;
           transmit : out  STD_LOGIC;
			  done : in STD_LOGIC;
			  txdata : out STD_LOGIC_VECTOR ( 15 downto 0 );
			  rxdata : in STD_LOGIC_VECTOR ( 7 downto 0 );
			  x_axis_data : out STD_LOGIC_VECTOR ( 9 downto 0 );
			  y_axis_data : out STD_LOGIC_VECTOR ( 9 downto 0 );
			  z_axis_data : out STD_LOGIC_VECTOR ( 9 downto 0 ));
end SPImaster;

architecture Behavioral of SPImaster is

-- ====================================================================================
-- 							       Signals and Constants
-- ====================================================================================
	
	-- Define FSM states
	type state_type is ( idle , configure , transmitting , recieving , finished , break , holding );
	-- STATE reg
	signal STATE : state_type;

	type data_type is ( x_axis , y_axis , z_axis );
	signal DATA : data_type;

	type configure_type is ( powerCtl , bwRate , dataFormat );
	signal CONFIGUREsel : configure_type;

	--Setting up Configuration Registers
	--POWER_CTL Bits 0x2D
	constant POWER_CTL : std_logic_vector ( 15 downto 0 ) := X"2D08";		
	--BW_RATE Bits 0x2C
	constant BW_RATE : std_logic_vector ( 15 downto 0 ) := X"2C08";		
	--CONFIG Bits 0x31
	constant DATA_FORMAT : std_logic_vector ( 15 downto 0 ) := X"3100";	

	--Axis registers set to only read and do it in single byte increments
	constant XAXIS0 : std_logic_vector ( 15 downto 0 ) := X"B200"; --10110010;
	constant XAXIS1 : std_logic_vector ( 15 downto 0 ) := X"B300"; --10110011;
	constant YAXIS0 : std_logic_vector ( 15 downto 0 ) := X"B400"; --10110100;
	constant YAXIS1 : std_logic_vector ( 15 downto 0 ) := X"B500"; --10110101;
	constant ZAXIS0 : std_logic_vector ( 15 downto 0 ) := X"B600"; --10110110;
	constant ZAXIS1 : std_logic_vector ( 15 downto 0 ) := X"B700"; --10110111;


	signal break_count : std_logic_vector ( 11 downto 0 );
	signal hold_count : std_logic_vector ( 20 downto 0 );
	signal end_configure : std_logic;
	signal done_configure : std_logic;
	signal register_select : std_logic;
	signal finish : std_logic;
	signal sample_done : std_logic;
	signal prevstart : std_logic_vector (3 downto 0);

--  ===================================================================================
-- 							  				Implementation
--  ===================================================================================
	begin

		spi_masterProcess : process ( clk ) begin
			
				if rising_edge( clk ) then 
					-- Debounce Start Button
					prevstart <= prevstart( 2 downto 0 ) & start;
					--Reset Condition
					if rst = '1' then 
						transmit<= '0';
						STATE<= idle;
						DATA<= x_axis;
						break_count<= ( others => '0' );
						hold_count<= ( others => '0' );
						done_configure<= '0';
						CONFIGUREsel<= powerCtl;
						txdata<= ( others => '0' );
						register_select<= '0';
						sample_done<= '0';
						finish<= '0';
						x_axis_data<= ( others => '0' );
						y_axis_data<= ( others => '0' );
						z_axis_data<= ( others => '0' );
						end_configure<= '0';
					else 
						--Main State, selects what the overall system is doing
						case STATE is
							when idle =>
								--If the system has not been configured, enter the configure state
								if done_configure = '0' then
									STATE<= configure;
									txdata<= POWER_CTL;
									Transmit<='1';
								--If the system has been configured, enter the transmission state when start is asserted
								elsif prevstart = "0011" and start = '1' and done_configure = '1' then
									STATE<= transmitting;
									finish<='0';
									txdata<= xAxis0;
									sample_done<='0';
								end if;
							when configure =>
								--Substate of configure selects what configuration is output
								case CONFIGUREsel is
									--Send power control address with desired configuration bits
									when powerCtl =>
										STATE<= finished;
										CONFIGUREsel<= bwRate;
										transmit<='1';
									--Send band width rate address with desired configuration bits
									when bwRate =>
										txdata<= BW_RATE;
										STATE<= finished;
										CONFIGUREsel<= dataFormat;
										transmit<='1';
									--Send data format address with desired configuration bits
									when dataFormat =>
										txdata<= DATA_FORMAT;
										STATE<= finished;
										transmit<='1';
										finish<= '1';
										end_configure<= '1';
									when others =>
										null;
								end case;
							
							--transmitting leads to the transmission of addresses of data to sample them
							when transmitting =>
								--Substate of transmitting selects which data register will be sampled
								case DATA is
									--Selects the x_axis data
									when x_axis =>
										--register_select chooses which of the two registers for each axis 
										--will be sampled
										case register_select is
											when '0' =>
												--in each case for data and register_select the state goes to 
												--recieving to accept data from SPIinterface and transmit goes
												--high to begin the transmission of data to the ACL
												STATE<= recieving;
												transmit<= '1';
											when others =>
												STATE<= recieving;
												transmit<= '1';
										end case;
									when y_axis =>
										case register_select is
											when '0' =>
												STATE<= recieving;
												transmit<= '1';
											when others =>
												STATE<= recieving;
												transmit<= '1';
										end case;
									when z_axis =>
										case register_select is
											when '0' =>
												STATE<= recieving;
												transmit<= '1';
											when others =>
												STATE<= recieving;
												transmit<= '1';
										end case;
									when others =>
										null;
								end case;
							
							--recieving controls the flow of data into the spi_master
							when recieving=>
								--Substate of Recieving, DATA controls where data will be stored
								case DATA is
									--Substate of DATA same as in transmitting
									when x_axis =>
										--register_select controls which half of the output register the 
										--collected data goes to
										case register_select is
											when '0' =>
												--transmit de-asserted as transmission has already be begun
												transmit<= '0';
												--when done is asserted, the register to be sampled next
												--changes with txdata, data is assigned to the desired output,
												--the overall state goes to finish, and register select is 
												--inverted to go to the other half. this same purpose is used
												--throughout DATA in recieving
												if done = '1' then
													txdata<= xAxis1;
													x_axis_data( 7 downto 0 )<= rxdata( 7 downto 0 );
													STATE<= finished;
													register_select<='1';
												end if;
											when others =>
												transmit<= '0';
												if done = '1' then
													txdata<= yAxis0;
													x_axis_data( 9 downto 8 )<= rxdata( 1 downto 0 );
													txdata<= yAxis0;
													register_select<= '0';
													DATA<= y_axis;
													STATE<= finished;
												end if;
										end case;
									when y_axis =>
										case register_select is
											when '0' =>
												transmit<= '0';
												if done = '1' then
													txdata<= yAxis1;
													y_axis_data( 7 downto 0 )<= rxdata( 7 downto 0 );
													txdata<= yAxis1;
													register_select<='1';
													STATE<= finished;
												end if;
											when others =>
												transmit<= '0';
												if done = '1' then
													txdata<= zAxis0;
													y_axis_data( 9 downto 8 )<= rxdata( 1 downto 0 );
													txdata<= zAxis0;
													register_select<= '0';
													DATA<= z_axis;
													STATE<= finished;
												end if;
										end case;
									when z_axis =>
										case register_select is
											when '0' =>
												transmit<= '0';
												if done = '1' then
													txdata<= zAxis1;
													z_axis_data( 7 downto 0 )<= rxdata( 7 downto 0 );
													txdata<= zAxis1;
													register_select<='1';
													STATE<= finished;
												end if;
											when others =>
												transmit<= '0';
												if done = '1' then
													txdata<= xAxis0;
													z_axis_data( 9 downto 8 )<= rxdata( 1 downto 0 );
													txdata<= xAxis0;
													register_select<= '0';
													DATA<= x_axis;
													STATE<= finished;
													sample_done<= '1';
												end if;
										end case;
									when others =>
										null;
								end case;
							
							--finished leads to the break state when transmission completed
							when finished =>
								transmit<= '0';
								if done = '1' then			
									STATE<= break;
									if end_configure = '1' then
										done_configure<='1';
									end if;
								end if;
							
							--the break state keeps an idle state long enough between transmissions 
							--to satisfy timing requirements. break can be decreased if desired
							when break =>
								if	break_count = X"FFF" then 
									break_count<= ( others => '0' );
									--only exit to idle if start has been de-asserted ( to keep from 
									--looping transmitting and recieving undesirably ) and finish and 
									--sample_done are high showing that the desired action has been 
									--completed
									if ( finish = '1' or sample_done = '1' ) and start = '0' then 
										STATE<= idle;
										txdata<= xAxis0;
									--if done configure is high, and sample done is low, the reception
									--has not been completed so the state goes back to transmitting
									elsif sample_done = '1' and start = '1' then
										STATE<= holding;
									elsif done_configure = '1' and sample_done = '0' then 
										STATE<= transmitting;
										transmit<= '1';
									--if the system has not finished configuration, then the state loops
									--back to configure
									elsif done_configure = '0' then
										STATE<= configure;
									end if;
								else
									break_count<= break_count + 1;
								end if;
							when holding =>
								if hold_count = X"1FFFFF" then
									hold_count<= ( others => '0' );
									STATE<= transmitting;
									sample_done<= '0';
								elsif start<= '0' then
									STATE<= idle;
									hold_count<= ( others => '0' );
								else 
									hold_count<= hold_count + 1;
								end if;
							when others =>
								null;
						end case;
					end if;
				end if;
		end process;

end Behavioral;

