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

entity OBJ_LINE_BUF is
	port(
		I_CLK_12M,
		I_6M,
		I_FLIPOB1,
		I_LHBL,
		I_OH,
		I_TR3n,
		I_HOVER
								: in	   std_logic;
		I_COL
								: in		std_logic_vector( 3 downto 0);
		I_V,
		I_DF
								: in		std_logic_vector( 7 downto 0);
		O_SEATMn
								: out	   std_logic;
		O_OBJ
								: out		std_logic_vector( 3 downto 0)
	);
end OBJ_LINE_BUF;

architecture RTL of OBJ_LINE_BUF is
	signal
		inv_12M,
		s_1CLn,
		s_1LOADn,
		s_1STn,
		s_1WR,
		s_2CLn,
		s_2LOADn,
		s_2STn,
		s_2WR,
		J4_ram_CE,
		F2_ram_CE,
		s_N11_12,
		s_N11_15,
--		s_N11_2,
		s_N11_5,
		s_OBFL1,
		s_OBFL2,
		s_OH_last,
		s_SEATMn
								: std_logic := '1';
	signal
		E1_bus,
		F1_bus,
		H1_bus,
		H3_bus,
		J3_bus,
		dummy1,
		dummy2,
		F2_ram_data_bus,
		J4_ram_data_bus
								: std_logic_vector( 3 downto 0) := (others => '1');
	signal
		M11_prom_data_bus
								: std_logic_vector( 1 downto 0) := (others => '1');
	signal
		F2_ram_addr_bus,
		J4_ram_addr_bus
								: std_logic_vector( 7 downto 0) := (others => '1');
	signal
		LBCTR1,
		LBCTR2
								: std_logic_vector( 8 downto 0) := (others => '1');
begin
	O_SEATMn <= s_SEATMn;
	inv_12M <= not I_CLK_12M;

	-- ############################
	-- #### 84100-02A PAGE 7/8 ####
	-- ############################

	-- M11 PROM
--	PROM_M11 : entity work.PROM_M11
--	port map (
--		CLK					=> I_CLK_12M,
--		ADDR					=> I_V(7 downto 0),
--		DATA					=> M11_prom_data_bus
--	);

	-- these equations replace the M11 PROM
	M11_prom_data_bus(1) <=
		not (I_V(7) or  I_V(6) or  I_V(5) or  I_V(4) ) or
		    (I_V(7) and I_V(6) and I_V(5) and I_V(4));

	M11_prom_data_bus(0) <=
		not ( I_V(7) or  I_V(6) or  I_V(5) or   I_V(4) or (I_V(3) and I_V(2) and I_V(1) and I_V(0))) or
		    ( I_V(7) and I_V(6) and I_V(5) and (I_V(4) or (I_V(3) and I_V(2) and I_V(1) and I_V(0))) );

	s_SEATMn <= M11_prom_data_bus(0);

	-- N11 latch
	N11 : process
	begin
		wait until falling_edge(I_CLK_12M);
		s_OH_last <= I_OH;
		if I_OH = '1' and s_OH_last = '0' then -- active high clock
			s_N11_15 <= M11_prom_data_bus(0);	-- SEATMn
			s_N11_5  <= M11_prom_data_bus(1);	-- DISPTM alpha
			s_N11_12 <= I_V(0);						-- V1 alpha
		end if;
	end process;

	-- N9 decoder
	s_2LOADn	<= s_SEATMn or I_TR3n or (     I_V(0)   );
	s_1LOADn	<= s_SEATMn or I_TR3n or ( not I_V(0)   );

	-- N10 decoder
	s_2STn	<= s_N11_15 or I_6M   or (     s_N11_12 );
	s_1STn	<= s_N11_15 or I_6M   or ( not s_N11_12 );

	s_1CLn	<= s_N11_5  or I_LHBL or (     s_N11_12 );
	s_2CLn	<= s_N11_5  or I_LHBL or ( not s_N11_12 );

	-- N8 and gates
	s_1WR <= (s_1CLn and not I_6M);
	s_2WR <= (s_2CLn and not I_6M);

	-- L10, N7 gates
	s_OBFL1 <= I_FLIPOB1 and (not s_N11_12);
	s_OBFL2 <= I_FLIPOB1 and (    s_N11_12);

	-- ############################
	-- #### 84100-02A PAGE 8/8 ####
	-- ############################

	-- F2 RAM
	F2 : RAMB16_S9
	port map (
		do( 7 downto 4)	=> dummy1,
		do( 3 downto 0)	=> F2_ram_data_bus,
		dop					=> open,
		addr(10 downto 8)	=> "000",
		addr( 7 downto 0)	=> F2_ram_addr_bus,
		di( 7 downto 4)	=> "1111",
		di( 3 downto 0)	=> F1_bus,
		dip					=> "0",
		en						=> F2_ram_CE,
		ssr					=> '0',
		we						=> s_1WR,
		clk					=> inv_12M
	);

	-- J4 RAM
	J4 : RAMB16_S9
	port map (
		do( 7 downto 4)	=> dummy2,
		do( 3 downto 0)	=> J4_ram_data_bus,
		dop					=> open,
		addr(10 downto 8)	=> "000",
		addr( 7 downto 0)	=> J4_ram_addr_bus,
		di( 7 downto 4)	=> "1111",
		di( 3 downto 0)	=> J3_bus,
		dip					=> "0",
		en						=> J4_ram_CE,
		ssr					=> '0',
		we						=> s_2WR,
		clk					=> inv_12M
	);

	-- Xilinx RAMs active high
	F2_ram_CE <= not LBCTR1(8);
	J4_ram_CE <= not LBCTR2(8);

	O_OBJ <= H1_bus;

	-- H1 selector SEL 0=A, 1=B
	H1_bus <=	--								 ST                SEL   
		E1_bus				when s_N11_5 = '0' and s_N11_12 = '0' else
		H3_bus				when s_N11_5 = '0' and s_N11_12 = '1' else
		(others => '1');

	-- F1 selector SEL 0=A, 1=B
	F1_bus <= --								ST                                                               SEL    
		E1_bus				when s_1STn = '0' and ( E1_bus(3) and E1_bus(2) and E1_bus(1) and E1_bus(0) ) = '0' else
		I_COL					when s_1STn = '0' and ( E1_bus(3) and E1_bus(2) and E1_bus(1) and E1_bus(0) ) = '1' else
		F2_ram_data_bus	when s_1STn = '1' and F2_ram_CE = '1' and s_1WR = '0' else
		(others => '1');

	-- J3 selector SEL 0=A, 1=B
	J3_bus <= --								ST                                                               SEL    
		H3_bus				when s_2STn = '0' and ( H3_bus(3) and H3_bus(2) and H3_bus(1) and H3_bus(0) ) = '0' else
		I_COL					when s_2STn = '0' and ( H3_bus(3) and H3_bus(2) and H3_bus(1) and H3_bus(0) ) = '1' else
		J4_ram_data_bus	when s_2STn = '1' and J4_ram_CE = '1' and s_2WR = '0' else
		(others => '1');

	-- E1, H3 latches
	E1_H3 : process
	begin
		wait until rising_edge(I_CLK_12M);

		if s_1CLn = '0' then
			E1_bus <= (others => '0');
		elsif I_6M = '1' then	-- same as L6MB
			E1_bus <= F1_bus;
		end if;

		if s_2CLn = '0' then
			H3_bus <= (others => '0');
		elsif I_6M = '1' then	-- same as L6MB
			H3_bus <= J3_bus;
		end if;

	end process;

	-- E3, F3 xor gates
	F2_ram_addr_bus <= LBCTR1(7 downto 0) when ( s_OBFL1 = '0') else not LBCTR1(7 downto 0);
	-- H5, J5 xor gates
	J4_ram_addr_bus <= LBCTR2(7 downto 0) when ( s_OBFL2 = '0') else not LBCTR2(7 downto 0);

	-- E4, F4, E2 counters
	E4_F4_E2 : process
	begin
		wait until rising_edge(I_CLK_12M);
		if I_6M = '0' then	-- same as OB6M
			if s_1CLn = '0' then
				LBCTR1 <= (others => '0');		-- clear counter
			elsif s_1LOADn = '0' then
				LBCTR1 <= I_HOVER & I_DF;	-- load counter
			else
				LBCTR1 <= LBCTR1 + 1;			-- count
			end if;
		end if;
	end process;

	-- H6, J6, H4 counters
	H6_J6_H4 : process
	begin
		wait until rising_edge(I_CLK_12M);
		if I_6M = '0' then	-- same as OB6M
			if s_2CLn = '0' then
				LBCTR2 <= (others => '0');		-- clear counter
			elsif s_2LOADn = '0' then
				LBCTR2 <= I_HOVER & I_DF;	-- load counter
			else
				LBCTR2 <= LBCTR2 + 1;			-- count
			end if;
		end if;
	end process;

end RTL;
