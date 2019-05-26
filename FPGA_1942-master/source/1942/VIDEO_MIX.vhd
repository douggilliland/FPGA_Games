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

entity VIDEO_MIX is
	port(
		I_CLK_12M,
		I_6M,
		I_LVBL,
		I_LHBL
								: in		std_logic;
		I_CHR,
		I_OBJ
								: in		std_logic_vector( 3 downto 0);
		I_SCR
								: in		std_logic_vector( 5 downto 0);
		O_RED,
		O_GRN,
		O_BLU
								: out		std_logic_vector( 3 downto 0)
	);
end VIDEO_MIX;

architecture RTL of VIDEO_MIX is
	signal
		s_J11_5,
		s_J11_8
								: std_logic := '1';
	signal
		s_F5_sel
								: std_logic_vector( 1 downto 0) := (others => '1');
	signal
		char_bus,
		obj_bus
								: std_logic_vector( 3 downto 0) := (others => '1');
	signal
		HC_bus,
		F8_bus_in
								: std_logic_vector( 7 downto 0) := (others => '1');
begin
	-- ############################
	-- #### 84100-02A PAGE 4/8 ####
	-- ############################

	-- E5, F6 F/F
	E5_F6 : process
	begin
		wait until rising_edge(I_CLK_12M);
		if I_6M = '0' then -- active high clock (same as S6M)
			char_bus <= I_CHR;
			obj_bus	<= I_OBJ;
		end if;
	end process;

	-- F5 gate output 8
	s_F5_sel(1) <= not (char_bus(3) and char_bus(2) and char_bus(1) and char_bus(0) ); -- B
	-- F5 gate output 6
	s_F5_sel(0) <= not ( obj_bus(3) and  obj_bus(2) and  obj_bus(1) and  obj_bus(0) ); -- A

	-- J11 F/F
	J11 : process
	begin
		wait until rising_edge(I_CLK_12M);
		if I_6M = '1' then -- active high clock inverted by J7 (same as inverted S6M)
			s_J11_5 <= not (I_LVBL and I_LHBL);
			s_J11_8 <= not s_J11_5;
		end if;
	end process;

	-- E6, E7, F7 selectors
	-- video priority encoder takes three inputs
	-- SCR (background), OBJ (sprites) and CHAR (text)
	-- SCR is lowest layer, OBJ is overlaid on SCR and CHAR is on top of everything
	F8_bus_in(7) <= s_F5_sel(1);
	F8_bus_in(6) <= s_F5_sel(0);

	F8_bus_in(5 downto 0) <=
		I_SCR						when s_F5_sel = "00" else -- bottom video layer
		"00" & obj_bus			when s_F5_sel = "01" else -- middle video layer
		"00" & char_bus		when s_F5_sel = "10" else --    top video layer
		"00" & char_bus		when s_F5_sel = "11" else --    top video layer
		(others => '0');

	-- F8 latch
	F8 : process
	begin
		wait until rising_edge(I_CLK_12M);
		if s_J11_8 <= '0' then
			HC_bus <= (others => '0');
		elsif I_6M = '0' then -- active high clock (same as S6M)
			HC_bus <= F8_bus_in;
		end if;
	end process;

	-- E8 PROM
	PROM_E8 : entity work.PROM_E8
	port map (
		CLK	=> I_CLK_12M,
		ADDR	=> HC_bus,
		DATA	=> O_RED
	);

	-- E9 PROM
	PROM_E9 : entity work.PROM_E9
	port map (
		CLK	=> I_CLK_12M,
		ADDR	=> HC_bus,
		DATA	=> O_GRN
	);

	-- E10 PROM
	PROM_E10 : entity work.PROM_E10
	port map (
		CLK	=> I_CLK_12M,
		ADDR	=> HC_bus,
		DATA	=> O_BLU
	);

end RTL;
