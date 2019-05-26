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

--------------------------------------------------------------------------------
-- v0.1	Initial release
--	This is a VHDL implementation of the arcade game "1942" (c) 1984 Capcom
--	Implemented Jul 2018 from schematic to VHDL
--
--
--	Known Issues
-- SCR (Background) and CHR (Text) works but OBJ (Sprites) do now show
--

-- Memmory Map
--
--	MAIN CPU:
--	0000-BFFF ROM (8000-bfff is banked)
--	Read Only				Write Only:
--		C000  IN0	= FF		C800      command for the audio CPU
--		C001  IN1	= FF		C802-C803 background scroll
--		C002  IN2	= FF		C804      bit 7: flip screen, bit 4: cpu B reset, bit 0: coin counter
--		C003  DSW0	= 77		C805      background palette bank selector
--		C004  DSW1	= FF		C806      bit 0-1 ROM bank selector 00=1-N5.BIN 01=1-N6.BIN 10=1-N7.BIN
--	CC00-CC7F Sprites
--	D000-D3FF Video RAM
--	D400-D7FF Color RAM
--	D800-DBFF Background RAM (groups of 32 bytes, 16 code, 16 color/attribute)
--	E000-EFFF RAM
--
--	SOUND CPU:
--	0000-3FFF ROM
--	4000-47FF RAM
--	6000      command from the main CPU
--	8000      8910 #1 control
--	8001      8910 #1 write
--	C000      8910 #2 control
--	C001      8910 #2 write
--

--	Page 1/8 Scroll Position
--	INPUTS			From
--		FLIBOB1		MAIN
--		OH				MAIN
--		OUT2			MAIN
--		OUT3			MAIN
--		ACL2			MAIN
--		DB7..DB0		MAIN
--		 H256..H1	MAIN
--		 V128..V1	MAIN
--	OUTPUTS			To
--		SCRADO		MAIN
--		S1H			MAIN
--		S3H			2/8, 3/8
--		S7H			2/8, 3/8
--		SV128..SV1	2/8, 3/8
--		SH256..SH1	2/8
--		V128F..V1F	2/8, 3/8

--	Page 2/8 Scroll Video RAM
--	INPUTS			From
--		6M				MAIN
--		AB9..AB0		MAIN
--		SCRWR			MAIN
--		RDB			MAIN
--		SCRGOP		MAIN
--		DB7..DB0		MAIN
--		6M				MAIN
--		BR0			MAIN
--		BR1			MAIN
--		BR2			MAIN
--		SH256..SH1	1/8
--		S1H			1/8
--		S3H			1/8
--		S7H			1/8
--		SCRZ			3/8
--		SCRY			3/8
--		SCRX			3/8
--	OUTPUTS			To
--		SCR5..SCR0	4/8
--		S6M			3/8, 4/8
--		AS8..AS0		3/8
--		SVFLIP		3/8
--		SHFLIP		3/8

--	Page 3/8 Scroll ROM
--	INPUTS			From
--		AS8..AS0		2/8
--		SH8			1/8
--		SV8..SV1		1/8
--		SVFLIP		2/8
--		FLIPOB1		1/8
--		SHFLIPa		2/8
--		S7H			1/8
--		S6M			2/8
--	OUTPUTS			To
--		SCRZ			2/8
--		SCRY			2/8
--		SCRX			2/8

--	Page 4/8 Video Signal Mixer
--	INPUTS			From
--		LHBL			MAIN
--		LVBL			MAIN
--		CHAR3..0		MAIN
--		OBJ3..0		8/8
--		SCR5..0		2/8
--		S6M			2/8
--	OUTPUTS			To
--		RED			EXTERNAL
--		GRN			EXTERNAL
--		BLU			EXTERNAL

--	Page 5/8 Objects Data RAM
--	INPUTS			From
--		DB7..0		MAIN
--		OBJCE			MAIN
--		AB6..0		2/8
--		H256..1		1/8
--		SEATM			7/8
--		V128			1/8
--		V128F..V1F	1/8
--		4H				MAIN
--		FLIPOB1		1/8
--		OH				1/8
--	OUTPUTS			To
--		DB7..0		MAIN
--		DF7..0		8/8
--		LVb7..0		6/8
--		Va7..0		6/8
--		HOVER			8/8
--		VOVER			8/8
--		AD7..AD0		6/8
--		TR3			7/8
--		CD3..0		7/8

--	Page 6/8 Objects Char Gen ROM
--	INPUTS			From
--		AD7..0		5/8
--		VLEN1..0		5/8
--		LVb7..0		5/8
--		Va7..0		5/8
--		VOVER			5/8
--		H8				1/8
--		H4				1/8
--		6M				2/8
--		4-3H			MAIN
--	OUTPUTS			To
--		VINZONE		7/8
--		OBJW			7/8
--		OBJX			7/8
--		OBJY			7/8
--		OBJZ			7/8

--	Page 7/8 Objects Timing
--	INPUTS			From
--		CD3..0		5/8
--		OBJW			6/8
--		OBJX			6/8
--		OBJY			6/8
--		OBJZ			6/8
--		SEATM			5/8
--		VINZONE		6/8
--		LHBL			4/8
--		L6MB			8/8
--		6MBB			8/8
--		TR3			5/8
--		FLIBOB1		1/8
--	OUTPUTS			To
--		OBFL1			8/8
--		OBFL2			8/8
--		1LOAD			8/8
--		2LOAD			8/8
--		1ST			8/8
--		2ST			8/8
--		1CL			8/8
--		2CL			8/8
--		1WR			8/8
--		2WR			8/8
--		DISPTMa		8/8
--		COL3..0		8/8

--	Page 8/8 
--	INPUTS			From
--		COL3..0		7/8
--		OBFL1			7/8
--		OBFL2			7/8
--		1LOAD			7/8
--		2LOAD			7/8
--		1ST			7/8
--		2ST			7/8
--		1CL			7/8
--		2CL			7/8
--		1WR			7/8
--		2WR			7/8
--		OB6M			6/8
--		HOVER			5/8
--		6MBB			7/8
--		DF7..0		5/8
--	OUTPUTS			To
--		OBJ3..0		4/8
--		L6MB			7/8

-- 84100 Inter-Board Connectors, 01A is Main board, 02A is the video board
--     01A 02A Name              01A 02A Name          01A 02A Name          01A 02A Name
-- A1  1/8 2/8 AB0           B1                    C1  6/8 1/8 SCRAD0    D1  6/8 1/8 SH1
-- A2  1/8 2/8 AB1           B2                    C2  6/8 1/8 S3H       D2  6/8 1/8 S7H
-- A3  1/8 2/8 AB2           B3                    C3  6/8 2/8 SCRGOP    D3  6/8 2/8 SCRWR
-- A4  1/8 2/8 AB3           B4                    C4  5/8 2/8 6M        D4  5/8 1/8 OH
-- A5  1/8 2/8 AB4           B5                    C5  5/8 6/8 4-3H      D5  5/8 5/8 4H
-- A6  1/8 2/8 AB5           B6                    C6  6/8 1/8 H1        D6  6/8 1/8 H2
-- A7  1/8 2/8 AB6           B7                    C7  6/8 1/8 H4        D7  6/8 1/8 H8
-- A8  1/8 2/8 AB7           B8                    C8  6/8 1/8 H16       D8  6/8 1/8 H32
-- A9  1/8 2/8 AB8           B9                    C9  6/8 1/8 H64       D9  6/8 1/8 H128
-- A10 1/8 2/8 AB9           B10                   C10 6/8 1/8 H256      D10 5/8 4/8 LHBL
-- A11 1/8 1/8 DB0           B11                   C11 8/8 4/8 R         D11 8/8 4/8 G
-- A12 1/8 1/8 DB1           B12                   C12 8/8 4/8 B         D12 5/8 4/8 LVBL
-- A13 1/8 1/8 DB2           B13                   C13 6/8 1/8 V1        D13 6/8 1/8 V2
-- A14 1/8 1/8 DB3           B14                   C14 6/8 1/8 V4        D14 6/8 1/8 V8
-- A15 1/8 1/8 DB4           B15                   C15 6/8 1/8 V16       D15 6/8 1/8 V32
-- A16 1/8 1/8 DB5           B16                   C16 6/8 1/8 V64       D16 6/8 1/8 V128
-- A17 1/8 1/8 DB6           B17
-- A18 1/8 1/8 DB7           B18
-- A19 1/8 1/8 ACL2          B19 1/8     AB10
-- A20 2/8 1/8 OUT2          B20 2/8 1/8 OUT3
-- A21 1/8 2/8 RDB           B21 2/8 5/8 OBJCE
-- A22 6/8 1/8 FLIPOB1       B22 2/8 2/8 BRT-0
-- A23 2/8 2/8 BRT-1         B23 2/8 2/8 BRT-2
-- A24 8/8 4/8 CHAR0         B24 8/8 4/8 CHAR1
-- A25 8/8 4/8 CHAR2         B25 8/8 4/8 CHAR3

--	Notes from simulation on long term signals:
--	CPUB_RES   asserted at 93.314ms CPU address 2D0D
--	CPUB_RES deasserted at 93.356ms CPU address 2D0F
--	BRT0,1,2   asserted at 93.329ms CPU address 119E
--	BNKD0,1    asserted at 93.329ms CPU address 119E

library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_arith.all;
	use ieee.std_logic_unsigned.all;
	use ieee.numeric_std.all;

library unisim;
	use unisim.vcomponents.all;

entity FPGA_1942 is
	port(
		-- System Clock
		I_CLK_12M,

		-- Active high external input
		I_RESET				: in		std_logic := '0';

		-- player 1 and 2 control inputs 
		I_P1,		-- COIN    & P1_START & P1_LOOP & P1_FIRE & P1_U & P1_D & P1_L & P1_R
		I_P2,		-- SERVICE & P2_START & P2_LOOP & P2_FIRE & P2_U & P2_D & P2_L & P2_R
		-- DIP switch game settings, see manual
		I_DIP_A,
		I_DIP_B
								: in		std_logic_vector( 7 downto 0);
		-- Audio outputs
		O_AUDIO_L,
		O_AUDIO_R
								: out		std_logic_vector( 7 downto 0);
		-- VGA monitor output
		O_VIDEO_R			: out		std_logic_vector(3 downto 0);
		O_VIDEO_G			: out		std_logic_vector(3 downto 0);
		O_VIDEO_B			: out		std_logic_vector(3 downto 0);
		O_HSYNC				: out		std_logic;
		O_VSYNC				: out		std_logic;
		O_CSYNC				: out		std_logic
	);
end FPGA_1942;

architecture RTL of FPGA_1942 is
	-- for correct palette selection during debugging without CPU module connected we need BRT0=0, BTR1=1, BRT2=0 
	signal
		s_BRT0,
		s_BRT2,
		s_OH,
		s_SEATMn,
		s_FLIP
								: std_logic := '0';
	signal
		s_phi_B,
		s_4_3H,
		s_4H,
		s_6M,
		s_WAITn,
		s_LHBL,
		s_LVBL,

		s_SH1,
		s_S3Hn,
		s_S7Hn,
		s_BRT1,
		s_ACLn,
		s_OBJCEn,
		s_SND_INT,
		s_SCRAD0n,
		s_SCRGOPn,
		s_HOVER,
		s_CPUB_RESn,
		s_D0CSn,
		s_SCRWRn,
		s_SCRCEn,
		s_PHI_SC,
		s_TR3n,
		s_RDBn,
		s_OBJW,
		s_OBJX,
		s_OBJY,
		s_OBJZ
								: std_logic := '1';
	signal
		CHR_bus,
		OBJ_bus,
		COL_bus,
		s_OUT
								: std_logic_vector( 3 downto 0) := (others => '1');
	signal
		SCR_bus
								: std_logic_vector( 5 downto 0) := (others => '1');
	signal
		DF_bus,
		data_bus
								: std_logic_vector( 7 downto 0) := (others => '1');
	signal
		s_V,
		s_H
								: std_logic_vector( 8 downto 0) := (others => '1');
	signal
		addr_bus
								: std_logic_vector(10 downto 0) := (others => '1');
begin
	O_HSYNC		<= s_LHBL;
	O_VSYNC		<= s_LVBL;
	s_ACLn		<= not I_RESET;

	-- ############################
	-- #### 84100-01A PAGE 1/8 ####
	-- #### 84100-01A PAGE 2/8 ####
	-- ############################
	-- Main CPUA, ROMs, RAMs, Inputs
	CPUA_IO : entity WORK.CPUA_IO
	port map (
		I_CLK_12M		=> I_CLK_12M,
		I_ACL1n			=>	s_ACLn,
		I_WAITn			=> s_WAITn,
		I_PHI_SC			=> s_PHI_SC,
		I_LHBL			=> s_LHBL,
		I_H1				=> s_H(0),
		I_V				=> s_V(7 downto 0),

		I_P1				=> I_P1,
		I_P2				=> I_P2,
		I_DIP_A			=> I_DIP_A,
		I_DIP_B			=> I_DIP_B,

		O_DB				=>	data_bus,
		O_AB				=>	addr_bus,
		O_OUT				=> s_OUT,
		O_RDBn			=> s_RDBn,
		O_BRT0			=> s_BRT0,
		O_BRT1			=> s_BRT1,
		O_BRT2			=> s_BRT2,
		O_FLIP			=> s_FLIP,
		O_SND_INT		=> s_SND_INT,
		O_D0CSn			=> s_D0CSn,
		O_SCRCEn			=> s_SCRCEn,
		O_OBJCEn			=> s_OBJCEn,
		O_CPUB_RESn		=> s_CPUB_RESn
	);

	-- ############################
	-- #### 84100-01A PAGE 3/8 ####
	-- #### 84100-01A PAGE 4/8 ####
	-- ############################
	-- Audio CPUB, ROMs, RAMs, PSGs
	CPUB_PSG: entity WORK.CPUB_PSG
	port map (
		I_DB				=> data_bus,
		I_CLK_12M		=> I_CLK_12M,
		I_PHI_B			=> s_phi_B,
		I_OUT0			=> s_OUT(0),
		I_OUT1			=> s_OUT(1),
		I_ACL1n			=> s_ACLn,
		I_CPUB_RESn		=> s_CPUB_RESn,
		I_SND_INT		=> s_SND_INT,

		O_1PSG			=> O_AUDIO_L,
		O_2PSG			=> O_AUDIO_R
	);

	-- ############################
	-- #### 84100-01A PAGE 5/8 ####
	-- ############################
	-- Generates various sync signals from system clock
	SYNC: entity WORK.SYNC
	port map (
		I_CLK_12M		=> I_CLK_12M,

		O_phi_B			=> s_phi_B,
		O_6M				=> s_6M,
		O_CSYNC			=> O_CSYNC,
		O_LVBL			=> s_LVBL,
		O_LHBL			=> s_LHBL,
		O_OH				=> s_OH,
		O_4_3H			=> s_4_3H,
		O_4H				=> s_4H,
		O_V				=> s_V,
		O_H				=> s_H
	);

	-- ############################
	-- #### 84100-02A PAGE 4/8 ####
	-- ############################
	-- Mixes background, character and object layers
	VIDEO_MIX: entity WORK.VIDEO_MIX
	port map (
		I_CLK_12M	=> I_CLK_12M,
		I_6M			=> s_6M,
		I_LVBL		=> s_LVBL,
		I_LHBL		=> s_LHBL,
		I_CHR			=> CHR_bus,	-- characters/text	- top layer, highest priority
		I_OBJ			=> OBJ_bus,	-- objects/sprites	- middle layer
		I_SCR			=> SCR_bus,	-- scroll/background - bottom layer, lowest priority

		O_RED			=> O_VIDEO_R,
		O_GRN			=> O_VIDEO_G,
		O_BLU			=> O_VIDEO_B
	);

	-- ############################
	-- #### 84100-01A PAGE 6/8 ####
	-- #### 84100-01A PAGE 7/8 ####
	-- #### 84100-01A PAGE 8/8 ####
	-- ############################
	-- character generation
	CHR_GEN: entity WORK.CHR_GEN
	port map (
		I_CLK_12M	=> I_CLK_12M,
		I_6M			=> s_6M,
		I_D0CSn		=> s_D0CSn,
		I_4_3H		=> s_4_3H,
		I_4H			=> s_4H,
		I_OH			=> s_OH,
		I_H1			=> s_H(0),
		I_H2			=> s_H(1),
		I_H4			=> s_H(2),
		I_RDBn		=> s_RDBn,
		I_FLIPCH		=> s_FLIP,
		I_V			=> s_V(7 downto 0),
		I_H			=> s_H(7 downto 0),
		I_DB			=> data_bus,
		I_AB			=> addr_bus,

		O_CHR			=> CHR_bus,
		O_WAITn		=> s_WAITn
	);

	-- ############################
	-- #### 84100-01A PAGE 6/8 ####
	-- ############################
	-- #### 84100-02A PAGE 1/8 ####
	-- #### 84100-02A PAGE 2/8 ####
	-- #### 84100-02A PAGE 3/8 ####
	-- ############################
	-- scroll background generation
	SCR_GEN: entity WORK.SCR_GEN
	port map (
		I_CLK_12M	=> I_CLK_12M,
		I_6M			=> s_6M,
		I_OH			=> s_OH,
		I_ACL1n		=> s_ACLn,
		I_BRT0		=> s_BRT0,
		I_BRT1		=> s_BRT1,
		I_BRT2		=> s_BRT2,
		I_FLIPOB1	=> s_FLIP,
		I_OUT2		=> s_OUT(2),
		I_OUT3		=> s_OUT(3),
		I_H1			=> s_H(0),		-- from sync
		I_RDBn		=> s_RDBn,		-- from main 1,2
		I_SCRCEn		=> s_SCRCEn,	-- from main 1,2
		I_V			=> s_V,
		I_H			=> s_H,
		I_DB			=> data_bus,
		I_AB			=> addr_bus(9 downto 0),

		O_PHI_SC		=> s_PHI_SC,	-- to main 1,2
		O_SCR			=> SCR_bus
	);

	-- ############################
	-- #### 84100-02A PAGE 5/8 ####
	-- #### 84100-02A PAGE 6/8 ####
	-- ############################
	-- object generation
	OBJ_GEN: entity WORK.OBJ_GEN
	port map (
		I_CLK_12M	=> I_CLK_12M,
		I_6M			=> s_6M,
		I_4_3H		=> s_4_3H,
		I_4H			=> s_4H,
		I_FLIPOB1	=> s_FLIP,
		I_SEATMn		=> s_SEATMn,
		I_OH			=> s_OH,
		I_OBJCEn		=> s_OBJCEn,
		I_V			=> s_V,
		I_H			=> s_H,
		I_DB			=> data_bus,
		I_AB			=> addr_bus(6 downto 0),

		O_HOVER		=> s_HOVER,
		O_TR3n		=> s_TR3n,
		O_DF			=> DF_bus,
		O_COL			=> COL_bus
	);

	-- ############################
	-- #### 84100-02A PAGE 7/8 ####
	-- #### 84100-02A PAGE 8/8 ####
	-- ############################
	-- object line buffer
	OBJ_LINE_BUF: entity WORK.OBJ_LINE_BUF
	port map (
		I_CLK_12M	=> I_CLK_12M,
		I_6M			=> s_6M,
		I_FLIPOB1	=> s_FLIP,
		I_LHBL		=> s_LHBL,
		I_OH			=> s_OH,
		I_TR3n		=> s_TR3n,
		I_HOVER		=> s_HOVER,
		I_COL			=> COL_bus,
		I_V			=> s_V(7 downto 0),
		I_DF			=> DF_bus,

		O_SEATMn		=> s_SEATMn,
		O_OBJ			=> OBJ_bus
	);

end RTL;
