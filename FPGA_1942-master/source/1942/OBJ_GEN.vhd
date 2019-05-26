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

entity OBJ_GEN is
	port(
		I_CLK_12M,
		I_6M,
		I_4_3H,
		I_4H,
		I_FLIPOB1,
		I_SEATMn,
		I_OH,
		I_OBJCEn
								: in	   std_logic;
		I_V,
		I_H
								: in		std_logic_vector( 8 downto 0);
		I_DB
								: in		std_logic_vector( 7 downto 0);
		I_AB
								: in		std_logic_vector( 6 downto 0);
		O_HOVER,
		O_TR3n
								: out	   std_logic;
		O_DF
								: out		std_logic_vector( 7 downto 0);
		O_COL
								: out		std_logic_vector( 3 downto 0)
	);
end OBJ_GEN;

architecture RTL of OBJ_GEN is
	signal
		H9_H10_ram_we,
		s_4H_last,
		s_N11_2,
		s_M5_5,
		s_J9_8,
		s_K9_8,
		s_K9_11,
		s_OH_last,
		s_TR0n,
		s_TR0n_last,
		s_TR1n,
		s_TR1n_last,
		s_TR2n,
		s_TR2n_last,
		s_VINZONE,
		s_VOVER
								: std_logic := '1';
	signal
		VLEN_bus
								: std_logic_vector( 1 downto 0) := (others => '1');
	signal
		K3_data,
		J1_bus,
		J2_bus,
		K1_bus,
		K2_bus,
		K6_bus,
		L3_bus
								: std_logic_vector( 3 downto 0) := (others => '1');
	signal
		H9_H10_ram_addr_bus
								: std_logic_vector( 6 downto 0) := (others => '1');
	signal
		DE_bus,
		V_flip_bus,
		DF_bus,
		K4_bus,
		K5_bus,
		M8_L8_bus,
		M9_L9_bus,
		Valpha_bus,
		K7_bus,
		Vbeta_bus,
		LVbeta_bus,
		L1_rom_data_bus,
		L2_rom_data_bus,
		N1_rom_data_bus,
		N2_rom_data_bus
								: std_logic_vector( 7 downto 0) := (others => '1');
	signal
		chargen_ROM_addr_bus
								: std_logic_vector(12 downto 0) := (others => '1');
begin
	O_DF <= DF_bus;

	-- ############################
	-- #### 84100-02A PAGE 7/8 ####
	-- ############################

	-- K3 PROM
	PROM_K3 : entity work.PROM_K3
	port map (
		CLK					=> I_CLK_12M,
		ADDR(7 downto 4)	=> L3_bus,
		ADDR(3)				=> K2_bus(3), -- OBJW
		ADDR(2)				=> J2_bus(3), -- OBJX
		ADDR(1)				=> K1_bus(3), -- OBJY
		ADDR(0)				=> J1_bus(3), -- OBJZ
		DATA					=> K3_data
	);

	-- N11 latch
	N11 : process
	begin
		wait until falling_edge(I_CLK_12M);
		s_OH_last <= I_OH;
		if I_OH = '1' and s_OH_last = '0' then -- active high clock
			s_N11_2  <= s_VINZONE;
		end if;
	end process;

	-- simulate the pullups on K3 output
	O_COL <= K3_data when s_N11_2 = '0' else (others => '1');

	-- ############################
	-- #### 84100-02A PAGE 5/8 ####
	-- ############################
	-- H7, H8 buffers
	DF_bus <= I_DB when (I_OBJCEn = '0' and I_SEATMn = '1') else DE_bus;

	-- F9, F10 selectors, SEL 0=A, 1=B
	H9_H10_ram_we			<= (not I_OBJCEn) and I_SEATMn ; -- inverted because of active high Xilinx RAM WE
	H9_H10_ram_addr_bus	<=
		I_AB(6 downto 0) when I_SEATMn = '1' else
		s_K9_11 & s_K9_8 & I_H(6 downto 4) & I_H(2 downto 1);

	-- K9, J9, K8 gates
	s_K9_11 <= I_H(8) xor ( not I_H(7) );
	s_K9_8  <= s_J9_8 xor ( not I_H(7) );
	s_J9_8  <= I_V(7) and s_K9_11;

	-- H9, H10 RAMs
	RAM_H9_H10 : RAMB16_S9
	port map (
		do						=> DE_bus,
		dop					=> open,
		addr(10 downto 7)	=> "0000",
		addr( 6 downto 0)	=> H9_H10_ram_addr_bus,
		di						=> I_DB,
		dip					=> "0",
		en						=> '1',
		ssr					=> '0',
		we						=> H9_H10_ram_we,
		clk					=> I_CLK_12M
	);

	-- H9_H10 ROM (FAKE RAM at CC00-CC7F for testing) DEBUG disable this, enable RAM
--	pragma translate_off
	ROM_H9_H10 : entity work.ROM_H9_H10
	port map (
		CLK	=> I_CLK_12M,
		ADDR	=> H9_H10_ram_addr_bus,
		DATA	=> DE_bus
	);
--	pragma translate_on

	-- N9 decoder
	s_TR0n <= ( I_H(3) or (     I_H(2) ) or (     I_H(1) ) );
	s_TR1n <= ( I_H(3) or (     I_H(2) ) or ( not I_H(1) ) );
	s_TR2n <= ( I_H(3) or ( not I_H(2) ) or (     I_H(1) ) );
	O_TR3n <= ( I_H(3) or ( not I_H(2) ) or ( not I_H(1) ) ) or (not I_H(0)); -- N7, N8 gates

	-- K5 latch
	K5 : process
	begin
		wait until falling_edge(I_CLK_12M);
		s_TR0n_last <= s_TR0n;
		if s_TR0n = '1' and s_TR0n_last = '0' then
			K5_bus <= DF_bus;
		end if;
	end process;

	-- K4, K6 latch
	K4_K6 : process
	begin
		wait until falling_edge(I_CLK_12M);
		s_TR1n_last <= s_TR1n;
		if s_TR1n = '1' and s_TR1n_last = '0' then
			K4_bus		<= K5_bus;
			VLEN_bus(1)	<= DF_bus(7);
			VLEN_bus(0)	<= DF_bus(6);
			s_VOVER		<= DF_bus(5);
			O_HOVER		<= DF_bus(4);
			K6_bus		<= DF_bus(3 downto 0);
		end if;
	end process;

	-- K7 latch - transparent when clock is high, latch when low
	K7 : process
	begin
		wait until falling_edge(I_CLK_12M);
		s_TR2n_last <= s_TR2n;
		if s_TR2n = '1' and s_TR2n_last = '0' then -- inverted by K8, so rising edge!
			K7_bus <= DF_bus;
		end if;
	end process;

	Valpha_bus <= DF_bus when s_TR2n='0' else K7_bus;

	-- L3 latch
	L3 : process
	begin
		wait until falling_edge(I_CLK_12M);
		s_OH_last <= I_OH;
		if I_OH = '1' and s_OH_last = '0' then
			L3_bus <= K6_bus;
		end if;
	end process;

	-- M10, L11 xor gates on page 1/8
	V_flip_bus <= I_V(7 downto 0) when I_FLIPOB1 = '0' else not I_V(7 downto 0);

	-- M9, L9 latches (inverted outputs!)
	M9_L9 : process
	begin
		wait until falling_edge(I_CLK_12M);
		s_4H_last <= I_4H;
		if I_4H = '1' and s_4H_last = '0' then
			M9_L9_bus <= not V_flip_bus;
		end if;
	end process;

	-- M8, L8 adders
		M8_L8_bus  <= M9_L9_bus + ( not (I_FLIPOB1 & I_FLIPOB1 & I_FLIPOB1 & I_FLIPOB1 & I_FLIPOB1 & I_FLIPOB1 & I_FLIPOB1) & "1" ); -- K8 inverts them
	-- M7, L7 adders
		LVbeta_bus <= M8_L8_bus + Valpha_bus;

	-- ############################
	-- #### 84100-02A PAGE 6/8 ####
	-- ############################

	-- L1 ROM
	ROM_L1 : entity work.ROM_L1
	port map (
		CLK	=> I_CLK_12M,
		ENA	=> '1',
		ADDR(13)	=> s_VOVER,
		ADDR(12 downto 0)	=> chargen_ROM_addr_bus,
		DATA	=> L1_rom_data_bus
	);

	-- L2 ROM
	ROM_L2 : entity work.ROM_L2
	port map (
		CLK	=> I_CLK_12M,
		ENA	=> '1',
		ADDR(13)	=> s_VOVER,
		ADDR(12 downto 0)	=> chargen_ROM_addr_bus,
		DATA	=> L2_rom_data_bus
	);

	-- N1 ROM
	ROM_N1 : entity work.ROM_N1
	port map (
		CLK	=> I_CLK_12M,
		ENA	=> '1',
		ADDR(13)	=> s_VOVER,
		ADDR(12 downto 0)	=> chargen_ROM_addr_bus,
		DATA	=> N1_rom_data_bus
	);

	-- N2 ROM
	ROM_N2 : entity work.ROM_N2
	port map (
		CLK	=> I_CLK_12M,
		ENA	=> '1',
		ADDR(13)	=> s_VOVER,
		ADDR(12 downto 0)	=> chargen_ROM_addr_bus,
		DATA	=> N2_rom_data_bus
	);

	-- concatenate signals into a single bus for the ROMs
	chargen_ROM_addr_bus(12 downto 10) <= K4_bus(6 downto 4);
	chargen_ROM_addr_bus( 9 downto  6) <=
		K4_bus(3 downto 0) 									when VLEN_bus = "00" else
		K4_bus(3 downto 1) & Vbeta_bus(4)				when VLEN_bus = "01" else
		K4_bus(3 downto 2) & Vbeta_bus(5 downto 4)	when VLEN_bus = "10" else
									Vbeta_bus(7 downto 4)	when VLEN_bus = "11" else
		(others => '0');
	chargen_ROM_addr_bus( 5) <= ((not I_H(2)) xor I_H(3));
	chargen_ROM_addr_bus( 4 downto 1) <= Vbeta_bus(3 downto 0);
	chargen_ROM_addr_bus( 0) <= not I_H(2);

	-- J1, K1, J2, K2  shift registers
	J1_K1_J2_K2 : process
	begin
		wait until falling_edge(I_CLK_12M);
		if I_6M = '1' then -- active high clock (same as OB6M)
			if I_4_3H = '1' then -- load
				if K4_bus(7) = '0' then
					J1_bus <= L1_rom_data_bus(7 downto 4);
					K1_bus <= L1_rom_data_bus(3 downto 0);
					J2_bus <= N1_rom_data_bus(7 downto 4);
					K2_bus <= N1_rom_data_bus(3 downto 0);
				else
					J1_bus <= L2_rom_data_bus(7 downto 4);
					K1_bus <= L2_rom_data_bus(3 downto 0);
					J2_bus <= N2_rom_data_bus(7 downto 4);
					K2_bus <= N2_rom_data_bus(3 downto 0);
				end if;
			else -- shift left
				J1_bus <= J1_bus(2 downto 0) & "0"; -- OBJZ
				K1_bus <= K1_bus(2 downto 0) & "0"; -- OBJY
				J2_bus <= J2_bus(2 downto 0) & "0"; -- OBJX
				K2_bus <= K2_bus(2 downto 0) & "0"; -- OBJW
			end if;
		end if;
	end process;

	-- L6, M6 inverters
	Vbeta_bus <= not LVbeta_bus;

	-- L5, M5 magnitude comparators
	s_M5_5 <= '1' when (Vbeta_bus > (not Valpha_bus)) else '0';

	-- N5, M4, N4, L4, N6, N4 gates
	s_VINZONE <= not ( 
		(          LVbeta_bus(7) or ( VLEN_bus(1) and     VLEN_bus(0) ) ) and 
		(          LVbeta_bus(6) or ( VLEN_bus(1) and     VLEN_bus(0) ) ) and 
		(          LVbeta_bus(5) or ( VLEN_bus(1)                     ) ) and 
		(          LVbeta_bus(4) or ( VLEN_bus(1) or      VLEN_bus(0) ) ) and 
		( not s_M5_5) -- FIXME whis is a hack to get sprites working, term below is as per schematic, why?!
		-- FIXME not as per schematic, comparison below fails and spites don't show, find out why
--		( ( s_M5_5 and s_VOVER ) or ( ( not s_M5_5) and ( not s_VOVER ) ) ) -- same as not (s_M5_5 xor s_VOVER)
	);
end RTL;
