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

-- Implements video schematic "84100-01A-2" pages 1 through 8

library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_arith.all;
	use ieee.std_logic_unsigned.all;
	use ieee.numeric_std.all;

library unisim;
	use unisim.vcomponents.all;

entity CHR_GEN is
	port(
		I_CLK_12M,
		I_6M,
		I_D0CSn,
		I_4_3H,
		I_4H,
		I_OH,
		I_H1,
		I_H2,
		I_H4,
		I_RDBn,
		I_FLIPCH
								: in	std_logic;
		I_V,
		I_H,
		I_DB
								: in	std_logic_vector( 7 downto 0);
		I_AB
								: in	std_logic_vector(10 downto 0);
		O_CHR
								: out	std_logic_vector( 3 downto 0);
		O_WAITn
								: out	std_logic
	);
end CHR_GEN;

architecture RTL of CHR_GEN is
	signal
		s_H1_last,
		s_A0,
		s_A1,
		s_C7_0,
		s_C7_0_last,
		s_C7_1,
		s_C7_1_last,
		s_C7_2,
		s_E5_3,
		s_E5_6,
		s_E5_8,
		s_E5_11,
		s_D2_we,
		s_E6_5,
		s_E6_9,
		s_H4_last,
		s_F5_5,
		s_F5_15,
		s_F5_2,
		s_VFLIP,
		s_OH_last,
		s_4H_last,

		s_H4E,
		s_H8E,
		s_H16E,
		s_H32E,
		s_H64E,
		s_H128E,

		s_V1E,
		s_V2E,
		s_V4E,
		s_V8E,
		s_V16E,
		s_V32E,
		s_V64E,
		s_V128E

								: std_logic := '1';
	signal
		s_sel
								: std_logic_vector( 1 downto 0) := (others => '1');
	signal
		shifter_E4,
		shifter_F4
								: std_logic_vector( 3 downto 0) := (others => '1');
	signal
		CC_bus,
		DD_bus
								: std_logic_vector( 5 downto 0) := (others => '1');
	signal
		C3_bus,
		DC_bus,
		rom_data_bus_F2,
		D2_data_bus_out
								: std_logic_vector( 7 downto 0) := (others => '1');
	signal
		AC_bus
								: std_logic_vector( 8 downto 0) := (others => '1');
	signal
		D2_addr_bus
								: std_logic_vector(10 downto 0) := (others => '1');
begin
	-- ############################
	-- #### 84100-01A PAGE 6/8 ####
	-- ############################

	-- H1 just buffers the FLIP signal to increase drive strength
	-- and splits FLIP into FLIPCH and FLIPOB1 (same signal)

	-- J1, J2
	s_H4E		<= I_FLIPCH xor I_H(2);
	s_H8E		<= I_FLIPCH xor I_H(3);
	s_H16E	<= I_FLIPCH xor I_H(4);
	s_H32E	<= I_FLIPCH xor I_H(5);
	s_H64E	<= I_FLIPCH xor I_H(6);
	s_H128E	<= I_FLIPCH xor I_H(7);

	-- K1, K2
	s_V1E		<= I_FLIPCH xor I_V(0);
	s_V2E		<= I_FLIPCH xor I_V(1);
	s_V4E		<= I_FLIPCH xor I_V(2);
	s_V8E		<= I_FLIPCH xor I_V(3);
	s_V16E	<= I_FLIPCH xor I_V(4);
	s_V32E	<= I_FLIPCH xor I_V(5);
	s_V64E	<= I_FLIPCH xor I_V(6);
	s_V128E	<= I_FLIPCH xor I_V(7);

	-- ############################
	-- #### 84100-01A PAGE 7/8 ####
	-- ############################

	-- E6 F/F a
	E6a : process
	begin
		wait until falling_edge(I_CLK_12M);
		s_H1_last <= I_H1;
		if (s_E6_9 and I_RDBn) = '0' then
			s_E6_5 <= '1';
		elsif I_H1 = '1' and s_H1_last = '0' then
			s_E6_5 <= not s_E6_5;
		end if;
	end process;

	-- E6 F/F b
	E6b : process
	begin
		wait until falling_edge(I_CLK_12M);
		s_H4_last <= I_H4;
		if I_D0CSn = '1' then
			s_E6_9 <= '0';
		elsif I_H4 = '1' and s_H4_last = '0' then
			s_E6_9 <= '1';
		end if;
	end process;

	-- D2 RAM
	RAM_D2 : RAMB16_S9
	port map (
		do   => D2_data_bus_out,
		dop  => open,
		addr => D2_addr_bus,
		clk  => I_CLK_12M,
		di   => I_DB,
		dip  => "0",
		en   => '1',
		ssr  => '0',
		we   => s_D2_we
	);

	-- D2 ROM (FAKE RAM at D000-D7FF for testing) DEBUG disable this, enable RAM
-- pragma translate_off
	ROM_D2 : entity work.ROM_D2
	port map (
		CLK	=> I_CLK_12M,
		ADDR	=> D2_addr_bus, -- A10..A0
		DATA	=> D2_data_bus_out
	);
-- pragma translate_on

	s_D2_we		<= not s_E6_5; -- Xilinx RAM needs active high WE

	-- C5 RAM DB transceiver (DIR 1=AtoB, 0=BtoA)
--	DC_bus		<= D2_data_bus_out when s_RAM_OEn = '0' else I_DB;
	DC_bus		<= I_DB when s_E6_9 = '1' and I_RDBn = '0' else D2_data_bus_out;

	-- C1, D1, E1 multiplexers
	D2_addr_bus	<= I_H2 & s_V128E & s_V64E & s_V32E & s_V16E & s_V8E & s_H128E & s_H64E & s_H32E & s_H16E & s_H8E when I_H4 = '0' else I_AB(10 downto 0);
--	s_RAM_OEn	<= '0' when I_H4 = '0' else I_RDBn;

	-- C2,C4 latches
	C2_C4 : process
	begin
		wait until falling_edge(I_CLK_12M);
		s_C7_1_last <= s_C7_1;
		if s_C7_1 = '1' and s_C7_1_last = '0' then
			DD_bus	<= DC_bus(5 downto 0);
			s_VFLIP	<= DC_bus(6);
			AC_bus	<= DC_bus(7) & C3_bus;
		end if;
	end process;

	-- C3 latch
	C3 : process
	begin
		wait until falling_edge(I_CLK_12M);
		s_C7_0_last <= s_C7_0;
		if s_C7_0 = '1' and s_C7_0_last = '0' then
			C3_bus <= DC_bus;
		end if;
	end process;

	-- D4 latch
	D4 : process
	begin
		wait until falling_edge(I_CLK_12M);
		s_OH_last <= I_OH;
		if I_OH = '1' and s_OH_last = '0' then
			CC_bus <= DD_bus;
		end if;
	end process;

	-- C7 1of4 decoder
	s_C7_0 <= (    I_H4 ) or (     I_H2 );
	s_C7_1 <= (    I_H4 ) or ( not I_H2 );
	s_C7_2 <= (not I_H4 ) or (     I_H2 );
--	s_C7_3 <= (not I_H4 ) or ( not I_H2 );

	-- D7 NAND gates
	O_WAITn	<= (not s_C7_2) or I_D0CSn;

	-- ############################
	-- #### 84100-01A PAGE 8/8 ####
	-- ############################

	-- F5 latch
	F5 : process
	begin
		wait until falling_edge(I_CLK_12M);
		s_4H_last <= I_4H;
		if I_4H = '1' and s_4H_last = '0' then
			s_F5_5	<= s_V4E;
			s_F5_15	<= s_V2E;
			s_F5_2	<= s_V1E;
		end if;
	end process;

	-- E5 XOR gates
	s_E5_3	<= s_F5_5	xor s_VFLIP;
	s_E5_8	<= s_F5_15	xor s_VFLIP;
	s_E5_6	<= s_F5_2	xor s_VFLIP;
	s_E5_11	<= not s_H4E;

	-- F2 ROM
	ROM_F2 : entity work.ROM_F2
	port map (
		CLK					=> I_CLK_12M,
		ENA					=> '1',
		ADDR(12 downto 4)	=> AC_bus,
		ADDR(3)				=> s_E5_3,
		ADDR(2)				=> s_E5_8,
		ADDR(1)				=> s_E5_6,
		ADDR(0)				=> s_E5_11,
		DATA					=> rom_data_bus_F2
	);

	-- F1 PROM
	PROM_F1 : entity work.PROM_F1
	port map (
		CLK					=> I_CLK_12M,
		ADDR(7 downto 2)	=> CC_bus,
		ADDR(1)				=> s_A1,
		ADDR(0)				=> s_A0,
		DATA					=> O_CHR
	);

	-- H4, H9 gates
	s_sel(0) <= I_4_3H or     I_FLIPCH;
	s_sel(1) <= I_4_3H or not I_FLIPCH;

	-- E4, F4 shifters
	E4_F4 : process
	begin
		wait until falling_edge(I_CLK_12M);
		if I_6M = '1' then
			case s_sel is
				when "11" => -- load
					shifter_E4 <= rom_data_bus_F2(7 downto 4);
					shifter_F4 <= rom_data_bus_F2(3 downto 0);
				when "10" => -- left
					shifter_E4 <= shifter_E4(2 downto 0) & "0";
					shifter_F4 <= shifter_F4(2 downto 0) & "0";
				when "01" => -- right
					shifter_E4 <= "0" & shifter_E4(3 downto 1);
					shifter_F4 <= "0" & shifter_F4(3 downto 1);
				when "00" => -- inhibit
				when others => null;
			end case;
		end if;
	end process;

	-- F3 selector SEL 0=A, 1=B
	s_A0 <= ( shifter_E4(0) and I_FLIPCH ) or ( shifter_E4(3) and ( not I_FLIPCH) );
	s_A1 <= ( shifter_F4(0) and I_FLIPCH ) or ( shifter_F4(3) and ( not I_FLIPCH) );
end RTL;
