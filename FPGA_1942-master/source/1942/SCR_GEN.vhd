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

library ieee;                       
	use ieee.std_logic_1164.all;
	use ieee.std_logic_arith.all;
	use ieee.std_logic_unsigned.all;
	use ieee.numeric_std.all;

library unisim;
	use unisim.vcomponents.all;

entity SCR_GEN is
	port(
		I_CLK_12M,
		I_6M,
		I_OH,
		I_ACL1n,
		I_BRT0,
		I_BRT1,
		I_BRT2,

		I_FLIPOB1,
		I_OUT2,
		I_OUT3,

		I_H1,
		I_RDBn,
		I_SCRCEn
								: in	   std_logic;
		I_V,
		I_H
								: in		std_logic_vector( 8 downto 0);
		I_DB
								: in		std_logic_vector( 7 downto 0);
		I_AB
								: in		std_logic_vector(9 downto 0);
		O_PHI_SC
								: out	   std_logic;
		O_SCR
								: out		std_logic_vector( 5 downto 0)
	);
end SCR_GEN;

architecture RTL of SCR_GEN is
	signal
		s_A9_WE,
		s_A9_WEn,
		s_F11_11,
		s_OH_last,
		s_S1Hn,
		s_S3Hn,
		s_S7Hn,
		s_SCRX,
		s_SCRY,
		s_SCRZ,
		s_SHFLIP,
		s_SHFLIP_alpha,
		s_SVFLIP,
		s_out2_last,
		s_out3_last,
		s_E8_8,
		s_E8_8_last,
		s_F6_5,
		s_F7_6,
		s_H6_2,
		s_H6_5,
		s_H6_7,
		s_H7_6,
		s_J5_2,
		s_J5_5,
		s_J5_7,
		s_J5_10,
		s_SCRWRn
								: std_logic := '1';
	signal
		s_D7_sel
								: std_logic_vector( 1 downto 0) := (others => '1');
	signal
		D5_bus,
		D6_bus
								: std_logic_vector( 3 downto 0) := (others => '1');
	signal
		SCD_bus
								: std_logic_vector( 4 downto 0) := (others => '1');
	signal
		A8_bus,
		C8_bus,
		H_flip_bus,
		V_flip_bus,
		SV_bus,
		SCR_bus,				-- top 2 bits unused
		C1_C2_bus,
		C3_C4_bus,
		C5_C6_bus,
		X_rom_data_bus,
		Y_rom_data_bus,
		Z_rom_data_bus,
		A1_rom_data_bus,
		A2_rom_data_bus,
		A3_rom_data_bus,
		A4_rom_data_bus,
		A5_rom_data_bus,
		A6_rom_data_bus,
		A9_ram_data_bus
								: std_logic_vector( 7 downto 0) := (others => '1');
	signal
		C11_bus,
		AS_bus,
		SH_bus,
		adder_bus_A,
		adder_bus_B
								: std_logic_vector( 8 downto 0) := (others => '1');
	signal
		A9_ram_addr_bus
								: std_logic_vector( 9 downto 0) := (others => '1');
	signal
		scroll_ROM_addr_bus
								: std_logic_vector(12 downto 0) := (others => '1');
begin
	O_SCR		<= SCR_bus(5 downto 0);

	O_PHI_SC		<= not (s_H6_7 or I_6M); -- we want short pulses

	-- ############################
	-- #### 84100-01A PAGE 6/8 ####
	-- ############################

	-- H6
	H6 : process
	begin
		wait until falling_edge(I_CLK_12M);
		if I_6M = '0' then
			s_H6_2 <= s_S3Hn or I_SCRCEn;
			s_H6_5 <= s_S7Hn;
			s_H6_7 <= s_H7_6;
		end if;
	end process;

	-- F6 generates SCRGOP
	F6 : process
	begin
		wait until falling_edge(I_CLK_12M);
		if s_H6_2 = '0' then
			s_F6_5 <= '1';		-- set
		elsif	s_H6_5 = '0' then
			s_F6_5 <= '0';		-- clear
		end if;
	end process;

	-- J5
	J5 : process
	begin
		wait until falling_edge(I_CLK_12M);
		if I_6M = '1' then
			s_J5_2	<= (I_FLIPOB1 xor SH_bus(0));	-- SH1*
			s_J5_5	<= s_S7Hn;							-- S7H*
			s_J5_7	<= s_F6_5;							-- SCRACK
			s_J5_10	<= I_H1;								-- H1*
		end if;
	end process;

	-- F7a generates SCRWAIT
	F7a : process
	begin
		wait until falling_edge(I_CLK_12M);
		if ( I_ACL1n and ( not s_J5_7) ) = '0' then
			s_F7_6 <= '1';	-- clear (inverted)
		elsif I_SCRCEn = '0' then
			s_F7_6 <= '0';	-- set (inverted)
		end if;
	end process;

	-- F7b generates SCRWR
	F7b : process
	begin
		wait until falling_edge(I_CLK_12M);
		s_E8_8_last <= s_E8_8;
		if (I_RDBn and s_F6_5) = '0' then
			s_SCRWRn <= '1';
		elsif s_E8_8 = '1' and s_E8_8_last = '0' then
			s_SCRWRn <= not s_SCRWRn;
		end if;
	end process;

	s_E8_8 <= C11_bus(0) xor I_H1;

	-- J6, H7, H8
	s_H7_6 <= (not s_F7_6 ) or ( s_J5_2 and s_J5_5 and s_J5_7 ) or ( s_J5_10 and ( not ( s_J5_5 and s_J5_7 ) ) ) ;

-- ####################

	-- ############################
	-- #### 84100-02A PAGE 1/8 ####
	-- ############################

	-- J10, H11 xor gates
	H_flip_bus <= I_H(7 downto 0) when I_FLIPOB1 = '0' else not I_H(7 downto 0);

	-- M10, L11 xor gates
	V_flip_bus <= I_V(7 downto 0) when I_FLIPOB1 = '0' else not I_V(7 downto 0);

	-- K10 latch
	K10 : process
	begin
		wait until falling_edge(I_CLK_12M);
		s_OH_last <= I_OH;
		if I_OH = '1' and s_OH_last = '0' then
			SV_bus <= V_flip_bus;
		end if;
	end process;

	-- B10, C10, D11 4-bit adders
	adder_bus_a <= C11_bus;
	adder_bus_b <= ( not I_H(8) ) & ( H_flip_bus(7) xor ( (not I_H(8)) and ( (not I_FLIPOB1) xor (H_flip_bus(6) ) ) ) ) & H_flip_bus(6 downto 0);

	B10_C10_D11 : process
	begin
		wait until falling_edge(I_CLK_12M);
		if I_6M = '1' then
			SH_bus <= adder_bus_a + adder_bus_b;
		end if;
	end process;

	-- J8a F/F
	J8a : process
	begin
		wait until falling_edge(I_CLK_12M);
		s_OUT3_last <= I_OUT3;
		if I_ACL1n = '0' then
			C11_bus(8) <= '0';
		elsif I_OUT3 = '1' and s_OUT3_last = '0' then
			C11_bus(8) <= I_DB(0);
		end if;
	end process;

	-- C11 latch
	C11 : process
	begin
		wait until falling_edge(I_CLK_12M);
		s_OUT2_last <= I_OUT2;
		if I_ACL1n = '0' then
			C11_bus(7 downto 0) <= (others => '0');
		elsif I_OUT2 = '1' and s_OUT2_last = '0' then
			C11_bus(7 downto 0) <= I_DB;
		end if;
	end process;

	-- D10 xor, E11 decoder
	s_S1Hn <= (     (I_FLIPOB1 xor SH_bus(2)) ) or (     (I_FLIPOB1 xor SH_bus(1)) ) or ( not (I_FLIPOB1 xor SH_bus(0)) );
	s_S3Hn <= (     (I_FLIPOB1 xor SH_bus(2)) ) or ( not (I_FLIPOB1 xor SH_bus(1)) ) or ( not (I_FLIPOB1 xor SH_bus(0)) );
	s_S7Hn <= ( not (I_FLIPOB1 xor SH_bus(2)) ) or ( not (I_FLIPOB1 xor SH_bus(1)) ) or ( not (I_FLIPOB1 xor SH_bus(0)) );

	-- ############################
	-- #### 84100-02A PAGE 2/8 ####
	-- ############################

	-- The top half of the PROMS are not used (A7 tied low)
	-- also top 2 data bits are unused so only 128x6 is used
	PROM_D1_D2 : entity work.PROM_D1_D2
	port map (
		CLK					=> I_CLK_12M,
		ADDR(6)				=> I_BRT2,
		ADDR(5)				=> I_BRT1,
		ADDR(4)				=> I_BRT0,
		ADDR(3 downto 0)	=> D5_bus,
		DATA					=> SCR_bus
	);

	-- D5 latch
	D5 : process
	begin
		wait until falling_edge(I_CLK_12M);
		if I_6M = '1' then
			D5_bus <= D6_bus;
		end if;
	end process;

	-- D6 PROM
	PROM_D6 : entity work.PROM_D6
	port map (
		CLK					=> I_CLK_12M,
		ADDR(7 downto 3)	=> SCD_bus(4 downto 0),
		ADDR(2)				=> s_SCRX,
		ADDR(1)				=> s_SCRY,
		ADDR(0)				=> s_SCRZ,
		DATA					=> D6_bus
	);

	-- C7 latch
	C7 : process
	begin
		wait until falling_edge(I_CLK_12M);
		if I_6M = '1' and s_S7Hn = '0' then
			SCD_bus			<= C8_bus(4 downto 0);
			s_SHFLIP_alpha <= C8_bus(5);
		end if;
	end process;

	-- C9 tranceiver DIR 1=AtoB, 0= BtoA
	-- RAM has separate in and out data bausses so no need for this transceiver

	-- A8 latch
	A8 : process
	begin
		wait until falling_edge(I_CLK_12M);
		if I_6M = '1' and s_S1Hn = '0' then
			A8_bus <= A9_ram_data_bus;
		end if;
	end process;

	-- C8 latch
	C8 : process
	begin
		wait until falling_edge(I_CLK_12M);
		if I_6M = '1' and s_S3Hn = '0' then
			C8_bus <= A9_ram_data_bus;
		end if;
	end process;

	s_SHFLIP	<= C8_bus(5);
	s_SVFLIP	<= C8_bus(6);
	AS_bus	<= C8_bus(7) & A8_bus;

	-- A9 RAM
	RAM_A9 : RAMB16_S9
	port map (
		do						=> A9_ram_data_bus,
		dop					=> open,
		addr(10)				=> '0', -- top addr bit unused
		addr( 9 downto 0)	=> A9_ram_addr_bus,
		clk					=> I_CLK_12M,
		di						=> I_DB,
		dip					=> "0",
		en						=> '1',
		ssr					=> '0',
		we						=> s_A9_WE
	);

	-- A9 (FAKE RAM at D800-DBFF for testing) DEBUG disable this, enable RAM
-- pragma translate_off
	ROM_A9 : entity work.ROM_A9
	port map (
		CLK	=> I_CLK_12M,
		ADDR	=> A9_ram_addr_bus,
		DATA	=> A9_ram_data_bus
	);
-- pragma translate_on

	-- A10, A11, B11 multiplexers, SEL 0=A 1=B
	s_A9_WE				<= not ( s_A9_WEn or I_6M or I_H(0) );
	s_A9_WEn				<= s_SCRWRn	when s_F6_5 = '1' else '1';
	A9_ram_addr_bus	<= I_AB		when s_F6_5 = '1' else SH_bus(8 downto 4) & SH_bus(1) & SV_bus(7 downto 4);

	-- ############################
	-- #### 84100-02A PAGE 3/8 ####
	-- ############################

	-- concatenate signals into a single bus for the ROMs
	scroll_ROM_addr_bus(12 downto 5)	<= AS_bus( 7 downto 0);
	-- D3, D10 xor gates
	scroll_ROM_addr_bus(4)				<= SH_bus(3) xor s_SHFLIP;
	scroll_ROM_addr_bus(3)				<= SV_bus(3) xor s_SVFLIP;
	scroll_ROM_addr_bus(2)				<= SV_bus(2) xor s_SVFLIP;
	scroll_ROM_addr_bus(1)				<= SV_bus(1) xor s_SVFLIP;
	scroll_ROM_addr_bus(0)				<= SV_bus(0) xor s_SVFLIP;

	-- A1 ROM
	ROM_A1 : entity work.ROM_A1
	port map (
		CLK	=> I_CLK_12M,
		ENA	=> '1',
		ADDR	=> scroll_ROM_addr_bus,
		DATA	=> A1_rom_data_bus
	);

	-- A2 ROM
	ROM_A2 : entity work.ROM_A2
	port map (
		CLK	=> I_CLK_12M,
		ENA	=> '1',
		ADDR	=> scroll_ROM_addr_bus,
		DATA	=> A2_rom_data_bus
	);

	-- A3 ROM
	ROM_A3 : entity work.ROM_A3
	port map (
		CLK	=> I_CLK_12M,
		ENA	=> '1',
		ADDR	=> scroll_ROM_addr_bus,
		DATA	=> A3_rom_data_bus
	);

	-- A4 ROM
	ROM_A4 : entity work.ROM_A4
	port map (
		CLK	=> I_CLK_12M,
		ENA	=> '1',
		ADDR	=> scroll_ROM_addr_bus,
		DATA	=> A4_rom_data_bus
	);

	-- A5 ROM
	ROM_A5 : entity work.ROM_A5
	port map (
		CLK	=> I_CLK_12M,
		ENA	=> '1',
		ADDR	=> scroll_ROM_addr_bus,
		DATA	=> A5_rom_data_bus
	);

	-- A6 ROM
	ROM_A6 : entity work.ROM_A6
	port map (
		CLK	=> I_CLK_12M,
		ENA	=> '1',
		ADDR	=> scroll_ROM_addr_bus,
		DATA	=> A6_rom_data_bus
	);

	-- F11 xor gate output 11
	s_F11_11 <= I_FLIPOB1 xor s_SHFLIP_alpha;

	-- D7, F11 gates
	s_D7_sel(0) <=      s_F11_11   or (not s_S7Hn);
	s_D7_sel(1) <= (not s_F11_11 ) or (not s_S7Hn);

	-- AS8 selects if odd or even ROMs feed the X, Y, Z shift registers
	X_rom_data_bus <= A1_rom_data_bus when AS_bus(8) = '0' else A2_rom_data_bus;
	Y_rom_data_bus <= A3_rom_data_bus when AS_bus(8) = '0' else A4_rom_data_bus;
	Z_rom_data_bus <= A5_rom_data_bus when AS_bus(8) = '0' else A6_rom_data_bus;

	--	C1, C2, C3, C4, C5, C6 shift registers
	XYZ_shift_regs : process
	begin
		wait until falling_edge(I_CLK_12M);
		if I_6M = '1' then -- active high clock (same as S6M)
			case s_D7_sel is
				when "11"	=> -- load
					C1_C2_bus <= X_rom_data_bus;
					C3_C4_bus <= Y_rom_data_bus;
					C5_C6_bus <= Z_rom_data_bus;
				when "10"	=> -- left
					C1_C2_bus <= C1_C2_bus(6 downto 0) & "0";
					C3_C4_bus <= C3_C4_bus(6 downto 0) & "0";
					C5_C6_bus <= C5_C6_bus(6 downto 0) & "0";
				when "01"	=> -- right
					C1_C2_bus <= "0" & C1_C2_bus(7 downto 1);
					C3_C4_bus <= "0" & C3_C4_bus(7 downto 1);
					C5_C6_bus <= "0" & C5_C6_bus(7 downto 1);
				when "00"	=> -- no shift
				when others	=> null;
			end case;
		end if;
	end process;

	-- D4 selector SEL 0=A 1=B
	s_SCRX <= C1_C2_bus(7) when s_F11_11 = '0' else C1_C2_bus(0);
	s_SCRY <= C3_C4_bus(7) when s_F11_11 = '0' else C3_C4_bus(0);
	s_SCRZ <= C5_C6_bus(7) when s_F11_11 = '0' else C5_C6_bus(0);

end RTL;
