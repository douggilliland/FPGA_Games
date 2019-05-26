--	(c) 2018 d18c7db(a)hotmail
--
--	This program is free software; you can redistribute it and/or modify it under
--	the terms of the GNU General Public License version 3 or, at your option,
--	any later version as published by the Free Software Foundation.
--
--	This program is distributed in the hope that it will be useful,
--	but WITHOUT ANY WARRANTY; without even the implied warranty of
--	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
--
-- For full details, see the GNU General Public License at www.gnu.org/licenses
----------------------------------------------------------------------------------
-- 1-wire bidirectional line, idle high
-- 0 bit = 3us low, 1us high
-- 1 bit = 1us low, 3us high
-- every sequence of bytes sent or received is followed by a 1 bit high idle
--	send 3 byte command x400302
-- receive 8 bytes as follows:
--	byte 0 : 0 0 0 Start Y    X      B       A
--	byte 1 : 1 L R Z     D-Up D-Down D-Right D-Left
--	byte 2 : Joy X
--	byte 3 : Joy Y
--	byte 4 : C-Stick X
--	byte 5 : C-Stick Y
--	byte 6 : Left Button
--	byte 7 : Right Button

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity gamecube is
	port (
		clk					: in std_logic;	-- 4MHz clock
		reset					: in std_logic;
		serio					: inout std_logic;

		ready					: out std_logic;	-- button Start

		but_S					: out std_logic;	-- button Start
		but_X					: out std_logic;	-- button X
		but_Y					: out std_logic;	-- button Y
		but_Z					: out std_logic;	-- button Z

		but_A					: out std_logic;	-- button A
		but_B					: out std_logic;	-- button B
		but_L					: out std_logic;	-- button Left
		but_R					: out std_logic;	-- button Right

		but_DU				: out std_logic;	-- button Dpad up
		but_DD				: out std_logic;	-- button Dpad down
		but_DL				: out std_logic;	-- button Dpad left
		but_DR				: out std_logic;	-- button Dpad right

		joy_X					: out std_logic_vector( 7 downto 0);	-- Joy X analog
		joy_Y					: out std_logic_vector( 7 downto 0);	-- Joy Y analog
		cst_X					: out std_logic_vector( 7 downto 0);	-- C-Stick X analog
		cst_Y					: out std_logic_vector( 7 downto 0);	-- C-Stick Y analog
		ana_L					: out std_logic_vector( 7 downto 0);	-- Left Button analog
		ana_R					: out std_logic_vector( 7 downto 0)		-- Right Button analog
	);
end gamecube;

architecture behavioral of gamecube is
	type machine is (
		init, idle, cmd0, cmd1, resp_wait, recv_bytes, store_bytes
	);
	constant GC_POLL		: std_logic_vector(23 downto 0) := x"400302";
	signal state			: machine;
	signal rxshift			: std_logic_vector(15 downto 0) := (others=>'0');
	signal txshift			: std_logic_vector(15 downto 0) := (others=>'0');
	signal rx				: std_logic_vector( 7 downto 0) := (others=>'0');
	signal rx_bit			: integer range 0 to 15 := 0;
	signal rx_byte			: integer range 0 to 15 := 0;
	signal counter			: integer range 0 to 63 := 0;
	signal txcount			: integer range 0 to 15 := 0;
begin
	process(clk, reset)
	begin
		if (reset = '1') then
			counter	<= 0;
			ready		<= '0';
			state		<= init;
			serio		<= 'Z';

			but_S		<= '0';
			but_X		<= '0';
			but_Y		<= '0';
			but_Z		<= '0';

			but_A		<= '0';
			but_B		<= '0';
			but_L		<= '0';
			but_R		<= '0';

			but_DU	<= '0';
			but_DD	<= '0';
			but_DL	<= '0';
			but_DR	<= '0';

			joy_X		<= (others=>'0');
			joy_Y		<= (others=>'0');
			cst_X		<= (others=>'0');
			cst_Y		<= (others=>'0');
			ana_L		<= (others=>'0');
			ana_R		<= (others=>'0');

		elsif (rising_edge(clk)) then
			-- shift in I/O
			rxshift <= rxshift(14 downto 0) & serio;

			case state is
				-------------------------------
				-- state machine initial state
				-------------------------------
				when init =>
					serio			<= 'Z';
					counter		<= 31;	-- timeout value
					rx_bit		<= 7;
					rx_byte		<= 8;
					ready			<= '1';
					state			<= idle;

				-------------------------------
				-- check that no other device is driving the I/O line by
				-- waiting for the line to be idle (high) for 32 clocks
				-------------------------------
				when idle =>
					if serio = '0' then
						-- restart timeout counter if I/O line is active
						counter <= 31;
					else
						-- else count down
						counter <= counter - 1;

						-- on time out, move to next state
						if counter = 0 then
							counter	<= 23;	-- number of command bits-1 to send
							txcount	<= 15;	-- number of clocks-1 per bit to transmit
							state		<= cmd0;
						end if;
					end if;

				-------------------------------
				-- send command
				-------------------------------
				when cmd0 =>
					if txcount = 0 then
						txcount <= 15;	-- number of clocks per bit to transmit
						if counter = 0 then
							-- after we've sent 24 bits we're done
							state <= cmd1;
						else
							-- count down bits sent
							counter <= counter - 1;
						end if;
					else
						txcount <= txcount - 1;
					end if;

					serio <= txshift(txcount);
					if GC_POLL(counter) = '1' then
						--	'1' is 1us low followed by 3 us high
						txshift <= x"0FFF";
					else
						-- '0' is 3us low followed by 1 us high
						txshift <= x"000F";
					end if;

				-------------------------------
				-- after every command we must send a '1'
				-------------------------------
				when cmd1 =>
					txshift <= x"0FFF";
					serio <= txshift(txcount);
					if txcount = 0 then
						state		<= resp_wait;
						-- restart timeout counter
						counter <= 63;
					else
						txcount	<= txcount - 1;
					end if;

				-------------------------------
				-- wait for a hi to low transition
				-------------------------------
				when resp_wait =>
					-- stop driving I/O line
					serio		<= 'Z';
					if counter = 0 then
						-- if timed out and no bit received
						-- abort and restart state machine
						state <= init;
					else
						-- timeout count down
						counter <= counter - 1;

						-- if hi to lo transition
						if (rxshift(0) = '1' and serio = '0') then
							-- indicate not ready state
							ready		<= '0';
							-- restart timeout counter
							counter <= 20;
							-- move to state for receiving bytes
							state <= recv_bytes;
						end if;
					end if;

				when recv_bytes =>

					if counter = 0 then
						-- if timed out and no transition received
						-- abort and restart state machine
						state <= init;
					else
						-- timeout count down
						counter <= counter - 1;

						-- if hi to lo transition
						if (rxshift(0) = '1' and serio = '0') then
							-- restart timeout counter
							counter <= 20;

							if rx_bit = 0 then
								-- every 8 bits received, assign the byte to the correct register
								state <= store_bytes;
								rx_bit	<= 7;

								if rx_byte = 0 then
									state	<= init;
								else
									rx_byte	<= rx_byte - 1;
								end if;
							else
								rx_bit	<= rx_bit - 1;
							end if;

							--	here we detect patterns for '1' and '0' but we also make allowance
							--	for speed of transmitter not exactly matching ours. Since we run off
							--	a 4MHz clock we can have a theoretical maximum deviation of one clock
							--	cycle (+/- 250ns) of the input signal before we lose sync, so while
							--	the ideal input signal has a 4us cycle we can deal with input signals
							--	cycles anywhere from 3.75us to 4.25us (verified in simulation)

							-- likely pattern is a '1'
							if    rxshift(7 downto 0) = x"FF" then
								rx <= rx(6 downto 0) & '1';
							-- likely pattern for a '0'
							elsif
								-- longer 0001 1111 0
								(rxshift(7 downto 0) = x"1F" ) or
								-- exact 0000 1111 0
								(rxshift(7 downto 0) = x"0F" ) or
								-- shorter 0000 0111 0
								(rxshift(7 downto 0) = x"07" ) then
								rx <= rx(6 downto 0) & '0';
							else
								-- invalid pattern, assume corrupt stream and restart state maching
								state <= init;
							end if;
						end if;
					end if;

				when store_bytes =>
					state <= recv_bytes;

					case rx_byte is
						when 7 =>
							but_S		<= rx(4);
							but_Y		<= rx(3);
							but_X		<= rx(2);
							but_B		<= rx(1);
							but_A		<= rx(0);
					ana_L		<= rx;
						when 6 =>
							but_L		<= rx(6);
							but_R		<= rx(5);
							but_Z		<= rx(4);
							but_DU	<= rx(3);
							but_DD	<= rx(2);
							but_DR	<= rx(1);
							but_DL	<= rx(0);
					ana_R		<= rx;
						when 5 =>
							joy_X		<= rx;
						when 4 =>
							joy_Y		<= rx;
						when 3 =>
							cst_X		<= rx;
						when 2 =>
							cst_Y		<= rx;
						when 1 =>
							ana_L		<= rx;
						when 0 =>
							ana_R		<= rx;
						when others => null;
					end case;

				when others =>
					state <= init;
			end case;
		end if;
	end process;
end behavioral;
