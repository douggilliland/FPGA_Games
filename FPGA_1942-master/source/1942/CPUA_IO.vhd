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

entity CPUA_IO is
	port(
		I_CLK_12M,
		I_ACL1n,
		I_WAITn,
		I_PHI_SC,
		I_LHBL,
		I_H1
								: in	std_logic;
		I_P1,
		I_P2,
		I_DIP_A,
		I_DIP_B,

		I_V
								: in	std_logic_vector( 7 downto 0);
		O_DB
								: out	std_logic_vector( 7 downto 0);
		O_AB
								: out	std_logic_vector(10 downto 0);
		O_OUT
								: out	std_logic_vector( 3 downto 0);
		O_RDBn,
--		O_WRBn,
		O_BRT0,
		O_BRT1,
		O_BRT2,
		O_FLIP,
		O_D0CSn,
		O_SND_INT,
		O_SCRCEn,
		O_OBJCEn,
		O_CPUB_RESn
								: out	std_logic
	);
end CPUA_IO;

architecture RTL of CPUA_IO is
	signal
		s_cpu_RDn,
		s_cpu_WR,
		s_cpu_WRn,
		s_cpu_RFSHn,
		s_cpu_MREQn,
		s_cpu_INTn,
		s_cpu_IORQn,
		s_cpu_M1n,
		s_CPUB_RESn,
		s_IORQ_M1,
		s_CS03n,
		s_CS47n,
		s_CS8Bn,
		s_CSCDn,
		s_CSEFn,
		s_C0CSn,
		s_C8CSn,
		s_D0CSn,
		s_D8CSn,
		s_BNKD0,
		s_BNKD1,
		s_OUT4_last,
		s_OUT5_last,
		s_OUT6_last,
		s_L5_2,
		s_L5_2_last,
		s_L6_9,
		s_H1_last,
		s_L8_0,
		s_L8_1,
		s_F6_5,
		s_LHBL_last,
		s_SND_INT
								: std_logic := '1';

	signal		s_BRT0				: std_logic := '0';
	signal		s_BRT1				: std_logic := '1';
	signal		s_BRT2				: std_logic := '0';
	signal		s_FLIP				: std_logic := '0';

	signal
		K6_bus,
		s_BANK
								: std_logic_vector( 3 downto 0) := (others => '1');
	signal
		s_INn
								: std_logic_vector( 4 downto 0) := (others => '1');
	signal
		s_OUT
								: std_logic_vector( 6 downto 0) := (others => '1');
	signal
		K10_bus,
		IO_bus,
		cpu_data_bus_in,
		cpu_data_bus_out,
		rom_data_bus_n3,
		rom_data_bus_n4,
		rom_data_bus_n5,
		rom_data_bus_n6,
		rom_data_bus_n7,
		ram_data_bus_n9,
		ram_data_bus_n10
								: std_logic_vector( 7 downto 0) := (others => '1');
	signal
		cpu_addr_bus
								: std_logic_vector(15 downto 0) := (others => '1');

begin
	O_OUT			<= s_OUT(3 downto 0);
	O_AB			<= cpu_addr_bus(10 downto 0);
	O_DB			<= cpu_data_bus_out;
	O_RDBn		<= s_cpu_RDn;
--	O_WRBn		<= s_cpu_WRn;
	O_FLIP		<= s_FLIP;
	O_BRT0		<= s_BRT0;
	O_BRT1		<= s_BRT1;
	O_BRT2		<= s_BRT2;
	O_D0CSn		<= s_D0CSn;
	O_SCRCEn		<= s_D8CSn;
	O_SND_INT	<= s_SND_INT;
	O_CPUB_RESn	<= s_CPUB_RESn;

	s_cpu_WR		<= not s_cpu_WRn;

	-- ############################
	-- #### 84100-01A PAGE 1/8 ####
	-- ############################

	-------------------------
	-- CPUA Z80 on main board
	-------------------------
	CPU_K11 : entity work.T80sed
	port map (
		-- inputs
		WAIT_n		=> I_WAITn,
		NMI_n			=> '1',  -- unused
		DI				=> cpu_data_bus_in,
		RESET_n		=> I_ACL1n,
		CLK_n			=> I_CLK_12M,
		CLKEN			=> I_PHI_SC,
		INT_n			=> s_cpu_INTn,
		BUSRQ_n		=> '1',  -- unused
		-- outputs
		RFSH_n		=> s_cpu_RFSHn,
		MREQ_n		=> s_cpu_MREQn,
		RD_n			=> s_cpu_RDn,
		WR_n			=> s_cpu_WRn,
		A				=> cpu_addr_bus,
		DO				=> cpu_data_bus_out,
		M1_n			=> s_cpu_M1n,
		IORQ_n		=> s_cpu_IORQn,
		HALT_n		=> open, -- unused
		BUSAK_n		=> open  -- unused
	);

	-- K6 PROM - only 4 bit data bus
	PROM_K6 : entity work.PROM_K6
	port map (
		CLK	=> I_CLK_12M,
		ADDR	=> I_V(7 downto 0),
		DATA	=> K6_bus
	);

	-- N3 ROM
	ROM_N3 : entity work.ROM_M3
	port map (
		CLK	=> I_CLK_12M,
		ENA	=> '1',
		ADDR	=> cpu_addr_bus(13 downto 0),
		DATA	=> rom_data_bus_N3
	);

	-- N4 ROM
	ROM_N4 : entity work.ROM_M4
	port map (
		CLK	=> I_CLK_12M,
		ENA	=> '1',
		ADDR	=> cpu_addr_bus(13 downto 0),
		DATA	=> rom_data_bus_N4
	);

	-- N5 ROM
	ROM_N5 : entity work.ROM_M5
	port map (
		CLK	=> I_CLK_12M,
		ENA	=> '1',
		ADDR	=> cpu_addr_bus(13 downto 0),
		DATA	=> rom_data_bus_N5
	);

	-- N6 ROM
	ROM_N6 : entity work.ROM_M6
	port map (
		CLK	=> I_CLK_12M,
		ENA	=> '1',
		ADDR	=> cpu_addr_bus(12 downto 0),
		DATA	=> rom_data_bus_N6
	);

	-- N7 ROM
	ROM_N7 : entity work.ROM_M7
	port map (
		CLK	=> I_CLK_12M,
		ENA	=> '1',
		ADDR	=> cpu_addr_bus(13 downto 0),
		DATA	=> rom_data_bus_N7
	);

	-- N8 ROM - doesn't exist
--	ROM_N8 : entity work.ROM_M8
--	port map (
--		CLK	=> I_CLK_12M,
--		ENA	=> '1',
--		ADDR	=> cpu_addr_bus(13 downto 0),
--		DATA	=> rom_data_bus_N8
--	);

	-- N9 RAM
	RAM_N9 : RAMB16_S9
	port map (
		do   => ram_data_bus_N9,
		dop  => open,
		addr => cpu_addr_bus(10 downto 0),
		clk  => I_CLK_12M,
		di   => cpu_data_bus_out,
		dip  => "0",
		en   => s_L8_0,
		ssr  => '0',
		we   => s_cpu_WR
	);

	-- N10 RAM
	RAM_N10 : RAMB16_S9
	port map (
		do   => ram_data_bus_N10,
		dop  => open,
		addr => cpu_addr_bus(10 downto 0),
		clk  => I_CLK_12M,
		di   => cpu_data_bus_out,
		dip  => "0",
		en   => s_L8_1,
		ssr  => '0',
		we   => s_cpu_WR
	);

	-- L10, L9
	s_CS03n  <=		 ( ( not s_cpu_RFSHn ) or s_cpu_MREQn or (     cpu_addr_bus(15) ) or (     cpu_addr_bus(14) ) or (     cpu_addr_bus(13) ) )	-- CS01
					and ( ( not s_cpu_RFSHn ) or s_cpu_MREQn or (     cpu_addr_bus(15) ) or (     cpu_addr_bus(14) ) or ( not cpu_addr_bus(13) ) );	-- CS23
	s_CS47n <=		 ( ( not s_cpu_RFSHn ) or s_cpu_MREQn or (     cpu_addr_bus(15) ) or ( not cpu_addr_bus(14) ) or (     cpu_addr_bus(13) ) )	-- CS45
					and ( ( not s_cpu_RFSHn ) or s_cpu_MREQn or (     cpu_addr_bus(15) ) or ( not cpu_addr_bus(14) ) or ( not cpu_addr_bus(13) ) );	-- CS67
	s_CS8Bn <=		 ( ( not s_cpu_RFSHn ) or s_cpu_MREQn or ( not cpu_addr_bus(15) ) or (     cpu_addr_bus(14) ) or (     cpu_addr_bus(13) ) )	-- CS89
					and ( ( not s_cpu_RFSHn ) or s_cpu_MREQn or ( not cpu_addr_bus(15) ) or (     cpu_addr_bus(14) ) or ( not cpu_addr_bus(13) ) );	-- CSAB
	s_CSCDn <=		 ( ( not s_cpu_RFSHn ) or s_cpu_MREQn or ( not cpu_addr_bus(15) ) or ( not cpu_addr_bus(14) ) or (     cpu_addr_bus(13) ) );	-- CSCD
	s_CSEFn <=		 ( ( not s_cpu_RFSHn ) or s_cpu_MREQn or ( not cpu_addr_bus(15) ) or ( not cpu_addr_bus(14) ) or ( not cpu_addr_bus(13) ) );	-- CSEF

	-- L3
	s_BANK(0) <= s_CS8Bn or (     s_BNKD1 ) or (     s_BNKD0 );
	s_BANK(1) <= s_CS8Bn or (     s_BNKD1 ) or ( not s_BNKD0 );
	s_BANK(2) <= s_CS8Bn or ( not s_BNKD1 ) or (     s_BNKD0 );
	s_BANK(3) <= s_CS8Bn or ( not s_BNKD1 ) or ( not s_BNKD0 );

	-- L8
	s_L8_0 <= not ( s_CSEFn or (     cpu_addr_bus(12) ) or (     cpu_addr_bus(11) ) ); -- xilinx RAMs need these inverted
	s_L8_1 <= not ( s_CSEFn or (     cpu_addr_bus(12) ) or ( not cpu_addr_bus(11) ) );

	-- D6
	s_IORQ_M1 <= s_cpu_IORQn or s_cpu_M1n;

	-- L5
	L5 : process
	begin
		wait until falling_edge(I_CLK_12M);
		s_H1_last <= I_H1 ;
		if I_H1 = '1' and s_H1_last = '0' then
			s_L5_2		<= s_L6_9;
			s_SND_INT	<= K6_bus(2);
		end if;
	end process;

	-- L6a
	L6a : process
	begin
		wait until falling_edge(I_CLK_12M);
		s_L5_2_last <= s_L5_2;
		if s_IORQ_M1 = '0' then
			s_cpu_INTn <= '1';
		elsif s_L5_2 = '1' and s_L5_2_last = '0' then
			s_cpu_INTn <= '0';
		end if;
	end process;

	-- L6b
	L6b : process
	begin
		wait until falling_edge(I_CLK_12M);
		s_LHBL_last <= I_LHBL;
		if s_IORQ_M1 = '0' then
			s_L6_9 <= '0';
		elsif I_LHBL = '1' and s_LHBL_last = '0' then 
			s_L6_9 <= K6_bus(3);
		end if;
	end process;

	-- K10
	K10 : process
	begin
		wait until falling_edge(I_CLK_12M);
		if I_H1 = '1' and s_H1_last = '0' then
			K10_bus <= "110" & K6_bus(1 downto 0) & "111";
		end if;
	end process;

	-- CPU data bus multiplexer
	cpu_data_bus_in <=
		rom_data_bus_N3	when s_cpu_RDn = '0' and s_CS03n		= '0' else -- ROM
		rom_data_bus_N4	when s_cpu_RDn = '0' and s_CS47n		= '0' else -- ROM
--		rom_data_bus_N5	when s_cpu_RDn = '0' and s_CS8Bn		= '0' else -- jumper J2 position 101, alternate setting
		IO_bus				when s_cpu_RDn = '0' and s_CSCDn		= '0' else -- player inputs and switches
		rom_data_bus_N5	when s_cpu_RDn = '0' and s_BANK(0)	= '0' else -- jumper J2 position 100, default setting
		rom_data_bus_N6	when s_cpu_RDn = '0' and s_BANK(1)	= '0' else -- ROM
		rom_data_bus_N7	when s_cpu_RDn = '0' and s_BANK(2)	= '0' else -- ROM
--		rom_data_bus_N8	when s_cpu_RDn = '0' and s_BANK(3)	= '0' else -- this ROM doesn't exist
		ram_data_bus_N9	when s_cpu_RDn = '0' and s_L8_0		= '1' else -- RAM
		ram_data_bus_N10	when s_cpu_RDn = '0' and s_L8_1		= '1' else -- RAM
		K10_bus				when                     s_IORQ_M1	= '0' else -- preset vector
		(others => '0');

	-- ############################
	-- #### 84100-01A PAGE 2/8 ####
	-- ############################

	-- D6, H10 gates
	O_OBJCEn	<= ( not cpu_addr_bus(10) ) or (s_C8CSn);

	-- C7 1of4 decoder
	s_C0CSn		<= s_CSCDn or (     cpu_addr_bus(12) ) or (     cpu_addr_bus(11) );
	s_C8CSn		<= s_CSCDn or (     cpu_addr_bus(12) ) or ( not cpu_addr_bus(11) );
	s_D0CSn		<= s_CSCDn or ( not cpu_addr_bus(12) ) or (     cpu_addr_bus(11) );
	s_D8CSn		<= s_CSCDn or ( not cpu_addr_bus(12) ) or ( not cpu_addr_bus(11) );

	-- C6 1of8 decoder
	s_INn(0)		<= s_C0CSn or s_cpu_RDn or (     cpu_addr_bus(2) ) or (     cpu_addr_bus(1) ) or (     cpu_addr_bus(0) );
	s_INn(1)		<= s_C0CSn or s_cpu_RDn or (     cpu_addr_bus(2) ) or (     cpu_addr_bus(1) ) or ( not cpu_addr_bus(0) );
	s_INn(2)		<= s_C0CSn or s_cpu_RDn or (     cpu_addr_bus(2) ) or ( not cpu_addr_bus(1) ) or (     cpu_addr_bus(0) );
	s_INn(3)		<= s_C0CSn or s_cpu_RDn or (     cpu_addr_bus(2) ) or ( not cpu_addr_bus(1) ) or ( not cpu_addr_bus(0) );
	s_INn(4)		<= s_C0CSn or s_cpu_RDn or ( not cpu_addr_bus(2) ) or (     cpu_addr_bus(1) ) or (     cpu_addr_bus(0) );

	-- B6 1of8 decoder
	s_OUT(0)	<= s_C8CSn or s_cpu_WRn or cpu_addr_bus(10) or (     cpu_addr_bus(2) ) or (     cpu_addr_bus(1) ) or (     cpu_addr_bus(0) );
	s_OUT(1)	<= s_C8CSn or s_cpu_WRn or cpu_addr_bus(10) or (     cpu_addr_bus(2) ) or (     cpu_addr_bus(1) ) or ( not cpu_addr_bus(0) );
	s_OUT(2)	<= s_C8CSn or s_cpu_WRn or cpu_addr_bus(10) or (     cpu_addr_bus(2) ) or ( not cpu_addr_bus(1) ) or (     cpu_addr_bus(0) );
	s_OUT(3)	<= s_C8CSn or s_cpu_WRn or cpu_addr_bus(10) or (     cpu_addr_bus(2) ) or ( not cpu_addr_bus(1) ) or ( not cpu_addr_bus(0) );
	s_OUT(4)	<= s_C8CSn or s_cpu_WRn or cpu_addr_bus(10) or ( not cpu_addr_bus(2) ) or (     cpu_addr_bus(1) ) or (     cpu_addr_bus(0) );
	s_OUT(5)	<= s_C8CSn or s_cpu_WRn or cpu_addr_bus(10) or ( not cpu_addr_bus(2) ) or (     cpu_addr_bus(1) ) or ( not cpu_addr_bus(0) );
	s_OUT(6)	<= s_C8CSn or s_cpu_WRn or cpu_addr_bus(10) or ( not cpu_addr_bus(2) ) or ( not cpu_addr_bus(1) ) or (     cpu_addr_bus(0) );
--	s_OUT(7)	<= s_C8CSn or s_cpu_WRn or cpu_addr_bus(10) or ( not cpu_addr_bus(2) ) or ( not cpu_addr_bus(1) ) or ( not cpu_addr_bus(0) );

	-- B4 latch
	B4 : process
	begin
		wait until falling_edge(I_CLK_12M);
		s_OUT4_last <= s_OUT(4);
		if s_OUT(4) = '1' and s_OUT4_last = '0' then
			s_FLIP		<= cpu_data_bus_out(7);			-- Flip screen bit
			s_CPUB_RESn	<= not cpu_data_bus_out(4);	-- inverted due to transistor TR2
--			O_COINMETER	<= cpu_data_bus_out(0);			-- doesn't seem to be used
		end if;
	end process;

	-- B5 latch
	B5 : process
	begin
		wait until falling_edge(I_CLK_12M);
		s_OUT5_last <= s_OUT(5);
		if s_OUT(5) = '1' and s_OUT5_last = '0' then
			s_BRT0 <= cpu_data_bus_out(0);
			s_BRT1 <= cpu_data_bus_out(1);
			s_BRT2 <= cpu_data_bus_out(2);
		end if;
	end process;

	-- L7 F/F
	L7 : process
	begin
		wait until falling_edge(I_CLK_12M);
		s_OUT6_last <= s_OUT(6);
		if s_OUT(6) = '1' and s_OUT6_last = '0' then
			s_BNKD0 <= cpu_data_bus_out(0);
			s_BNKD1 <= cpu_data_bus_out(1);
		end if;
	end process;

	-- A4, A5, A6, A7, A8 buffers to CPU data bus
	IO_bus <=
		I_P1(7) & I_P2(7) & "1111" & I_P1(6) & I_P2(6)	when s_INn(0) = '0' else -- COIN, SERVICE, X, X, X, X, P1_START, P2_START
		"11" & I_P1(5 downto 0)									when s_INn(1) = '0' else -- X, X, P1_LOOP, P1_FIRE, P1_U, P1_D, P1_L, P1_R
		"11" & I_P2(5 downto 0)									when s_INn(2) = '0' else -- X, X, P2_LOOP, P2_FIRE, P2_U, P2_D, P2_L, P2_R
		I_DIP_A														when s_INn(3) = '0' else
		I_DIP_B														when s_INn(4) = '0' else
		(others => '1');
end RTL;
