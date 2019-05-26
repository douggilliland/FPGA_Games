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

entity CPUB_PSG is
	port(
		I_DB					: in		std_logic_vector(7 downto 0);

		I_CLK_12M,
		I_PHI_B,
		I_OUT0,
		I_OUT1,
		I_ACL1n,
		I_CPUB_RESn
								: in		std_logic;
		I_SND_INT
								: in		std_logic;
		O_1PSG,
		O_2PSG
								: out		std_logic_vector(7 downto 0)
	);
end CPUB_PSG;

architecture RTL of CPUB_PSG is
	signal
		cpu_addr_bus
								: std_logic_vector(15 downto 0) := (others => '1');
	signal
		cpu_data_bus_in,
		cpu_data_bus_out,
		d8_bus,
		c8_bus,
		ram_data_bus,
		rom_data_bus
								: std_logic_vector( 7 downto 0) := (others => '1');

	signal
		s_OUT0,
		s_OUT0_last,
		s_OUT1,
		s_OUT1_last,
		s_A10_BC1,
		s_A10_BDIR,
		s_A11_BC1,
		s_A11_BDIR,
		s_6000H,
		s_6001H,
		s_ram_WR,
		s_snd_int,
		s_snd_int_last,
		s_psg_clk_en,
		s_phi_d,

		s_F8_6,
		s_F8_9,
		s_F9_9,

		s_CS0n,
		s_CS2n,
		s_CS4n,
		s_CS6n,
		s_CS8n,
		s_CSCn,

		s_cpu_IORQn,
		s_cpu_RDn,
		s_cpu_WRn,
		s_cpu_RFSHn,
		s_cpu_MREQn,
		s_cpu_RESETn,
		s_cpu_INTn,
		s_cpu_WAITn
								: std_logic := '1';

begin
	s_phi_d			<= I_PHI_B;
	s_snd_int		<= I_SND_INT;
	s_cpu_RESETn	<= I_ACL1n and I_CPUB_RESn; -- open collectors wired together

	-- ############################
	-- #### 84100-01A PAGE 3/8 ####
	-- ############################

	--------------------------
	-- CPUB Z80 on audio board
	--------------------------
	CPU_E11 : entity work.T80sed
	port map (
		-- inputs
		WAIT_n		=> s_cpu_WAITn,
		NMI_n			=> '1',  -- unused
		DI				=> cpu_data_bus_in,
		RESET_n		=> s_cpu_RESETn,
		CLK_n			=> I_CLK_12M,
		CLKEN			=> s_phi_d,
		INT_n			=> s_cpu_INTn,
		BUSRQ_n		=> '1',  -- unused
		-- outputs
		RFSH_n		=> s_cpu_RFSHn,
		MREQ_n		=> s_cpu_MREQn,
		RD_n			=> s_cpu_RDn,
		WR_n			=> s_cpu_WRn,
		A				=> cpu_addr_bus,
		DO				=> cpu_data_bus_out,
		M1_n			=> open, -- unused
		IORQ_n		=> s_cpu_IORQn,
		HALT_n		=> open, -- unused
		BUSAK_n		=> open  -- unused
	);

	-- C10 RAM
	RAM_3K : RAMB16_S9
	port map (
		do   => ram_data_bus,
		dop  => open,
		addr => cpu_addr_bus(10 downto 0),
		clk  => I_CLK_12M,
		di   => cpu_data_bus_out,
		dip  => "0",
		en   => s_phi_d,
		ssr  => '0',
		we   => s_ram_WR
	);

	-- C11 ROM
	-- Schematic shows C11 as only one 2764 (8KB) ROM but the MAME ROM dumps matching C11 are 16KB in size.
	ROM_C11 : entity work.ROM_C11
	port map (
		CLK	=> I_CLK_12M,
		ENA	=> '1',
		ADDR	=> cpu_addr_bus(13 downto 0),
		DATA	=> rom_data_bus
	);

	-- A10 PSG2
	PSG_A10 : entity work.ym2149
	port map (
		-- data bus
		I_DA			=> cpu_data_bus_out,
		O_DA			=> open,
--		O_DA_OE_L	=> open,
		-- control
		I_A9_L		=> '0',
		I_A8			=> '1',
		I_BDIR		=> s_A10_BDIR,
		I_BC2			=> '1',
		I_BC1			=> s_A10_BC1,
		I_SEL_L		=> '1', -- low to halve the 3Mhz clock
		O_AUDIO		=> O_2PSG,

		I_CHEN		=> "111",
--		I_IOA			=> (others => '0'),
--		O_IOA			=> open,
--		O_IOA_OE_L	=> open,
--		I_IOB			=> (others => '0'),
--		O_IOB			=> open,
--		O_IOB_OE_L	=> open,

		ENA			=> s_psg_clk_en,
		RESET_L		=> s_cpu_RESETn,
		CLK			=> I_CLK_12M
	);

	-- A11 PSG1
	PSG_A11 : entity work.ym2149
	port map (
		-- data bus
		I_DA			=> cpu_data_bus_out,
		O_DA			=> open,
--		O_DA_OE_L	=> open,
		-- control
		I_A9_L		=> '0',
		I_A8			=> '1',
		I_BDIR		=> s_A11_BDIR,
		I_BC2			=> '1',
		I_BC1			=> s_A11_BC1,
		I_SEL_L		=> '1', -- low to halve the 3Mhz clock
		O_AUDIO		=> O_1PSG,

		I_CHEN		=> "111",
--		I_IOA			=> (others => '0'),
--		O_IOA			=> open,
--		O_IOA_OE_L	=> open,
--		I_IOB			=> (others => '0'),
--		O_IOB			=> open,
--		O_IOB_OE_L	=> open,

		ENA			=> s_psg_clk_en,
		RESET_L		=> s_cpu_RESETn,
		CLK			=> I_CLK_12M
	);

	-- F8 F/F
	F8 : process
	begin
		wait until falling_edge(I_CLK_12M);
		if s_phi_d = '1' then -- active high clock
			s_F8_9 <= s_CSCn and s_CS8n; -- E7 output 8
			s_F8_6 <= not s_F8_9;
		end if;
	end process;

	-- D6 output 8
	s_cpu_WAITn <= s_F8_9 or s_F8_6;

	-- F9 output 5, F10
	-- halves phi_d (3MHz) clock to generate 1.5MHz clock enable for PSGs
	F9_9 : process
	begin
		wait until falling_edge(I_CLK_12M);
		if s_phi_d = '1' then -- active high clock
			s_F9_9 <= not s_F9_9;
		end if;
	end process;

	-- the clock enable needs to be narrow (one 12MHz cycle)
	s_psg_clk_en <= s_F9_9 and s_phi_d;

	-- F9 output 5, F10
	F9_5 : process
	begin
		wait until falling_edge(I_CLK_12M);
		s_snd_int_last <= s_snd_int;
		if s_cpu_IORQn = '0' then
			s_cpu_INTn <= '1';	-- preset takes precedence
		elsif s_snd_int = '1' and s_snd_int_last = '0' then
			s_cpu_INTn <= '0';	-- else assert interrupt
		end if;
	end process;

	-- E9 1of8 decoder
	s_CS0n <= '0' when ( ( s_cpu_RFSHn = '1') and ( s_cpu_MREQn = '0') and ( cpu_addr_bus(15 downto 13) = "000") ) else '1';
	s_CS2n <= '0' when ( ( s_cpu_RFSHn = '1') and ( s_cpu_MREQn = '0') and ( cpu_addr_bus(15 downto 13) = "001") ) else '1'; -- not used in schematic
	s_CS4n <= '0' when ( ( s_cpu_RFSHn = '1') and ( s_cpu_MREQn = '0') and ( cpu_addr_bus(15 downto 13) = "010") ) else '1';
	s_CS6n <= '0' when ( ( s_cpu_RFSHn = '1') and ( s_cpu_MREQn = '0') and ( cpu_addr_bus(15 downto 13) = "011") ) else '1';
	s_CS8n <= '0' when ( ( s_cpu_RFSHn = '1') and ( s_cpu_MREQn = '0') and ( cpu_addr_bus(15 downto 13) = "100") ) else '1';
	s_CSCn <= '0' when ( ( s_cpu_RFSHn = '1') and ( s_cpu_MREQn = '0') and ( cpu_addr_bus(15 downto 13) = "110") ) else '1';

	-- CPU input data bus selector
	cpu_data_bus_in <=
		rom_data_bus	when s_CS0n  = '0' and s_cpu_RDn = '0' else
		rom_data_bus	when s_CS2n  = '0' and s_cpu_RDn = '0' else -- not in schematic
		ram_data_bus	when s_CS4n  = '0' and s_cpu_RDn = '0' else
		C8_bus 			when s_6001H = '0' and s_cpu_RDn = '0' else
		D8_bus 			when s_6000H = '0' and s_cpu_RDn = '0' else
		(others => '0');

	s_ram_WR <= not ( s_CS4n or s_cpu_WRn );

	-- D9 AND gates
	s_A10_BDIR	<= not (s_CSCn or s_cpu_WRn);
	s_A10_BC1	<= s_A10_BDIR and not cpu_addr_bus(0);

	-- C9 AND gates
	s_A11_BDIR	<= not (s_CS8n or s_cpu_WRn);
	s_A11_BC1	<= s_A11_BDIR and not cpu_addr_bus(0);

	-- B9 AND gates
	s_6000H <= ( s_CS6n or s_cpu_RDn or     cpu_addr_bus(0) );
	s_6001H <= ( s_CS6n or s_cpu_RDn or not cpu_addr_bus(0) );

	-- C8 latch
	C8 : process
	begin
		wait until falling_edge(I_CLK_12M);
		s_OUT1_last <= s_OUT1;
		if s_OUT1 = '1' and s_OUT1_last = '0' then -- active high clock
			C8_bus <= I_DB;
		end if;
	end process;

	-- D8 latch
	s_OUT0 <= I_OUT0;
	s_OUT1 <= I_OUT1;
	D8 : process
	begin
		wait until falling_edge(I_CLK_12M);
		s_OUT0_last <= s_OUT0;
		if s_OUT0 = '1' and s_OUT0_last = '0' then -- active high clock
			D8_bus <= I_DB;
		end if;
	end process;

	-- ############################
	-- #### 84100-01A PAGE 4/8 ####
	-- ############################
	-- analog amplifier, external to FPGA

end RTL;
