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

entity SYNC is
	port(
		I_CLK_12M		
								: in		std_logic;
		O_PHI_B,
		O_CSYNC,
		O_LVBL,
		O_LHBL,
		O_OH,
		O_4_3H,
		O_4H,
		O_6M
								: out		std_logic;
		O_V,
		O_H
								: out		std_logic_vector(8 downto 0)
	);
end SYNC;

architecture RTL of SYNC is
	signal
		s_J8_JK
								: std_logic_vector(1 downto 0) := (others => '1');
	signal
		s_V,
		s_H
								: std_logic_vector(8 downto 0) := (others => '1');
	signal
		s_X6M
								: std_logic := '0';
	signal
		s_L6M,
		s_K3_8,
		s_K5_6,
		s_K5_9,
		s_K8_5,
		s_K8_9,
		s_H7_8,
		s_J8_6,
		s_K7_5,
		s_K7_8,
		s_K7_8_last,
		s_H7_12
								: std_logic := '1';
begin
	-- O_PHI_B 3MHz clock enable is only for the CPUB (audio CPU)
	-- we want short duration clock enables so we gate with 6MHz
	O_PHI_B	<= not ( s_H(0) or s_L6M );

-- FIXME we tap OH earlier to account for the delay introduced by detecting OH edge via OH_last
-- Without this fix, a glitch is created halfway in s_2CLn, s_1CLn, causing the sprite at
--	position 0 (the player sprite - airplane) to have its Y position constantly zeroed so it
-- always appears at bottom of screen instead of being able to be moved around
--	O_OH		<= s_K7_8;
	O_OH		<= not s_K7_5;

	O_V		<= s_V;
	O_H		<= s_H;
	O_LVBL	<= s_K5_9;
	O_LHBL	<= s_J8_6;
	O_4_3H	<= s_K8_5;
	O_4H		<= s_K8_9;
	O_6M		<= ( not s_L6M );

	-- ############################
	-- #### 84100-01A PAGE 5/8 ####
	-- ############################

	-- J4, L4 decoders, H9, K9, K4 gates
	O_CSYNC	<=	-- A                 B                 C             G
		( ( not s_H(4) ) or ( not s_H(5) ) or (     s_H(6) ) or ( s_H(8) ) ) and	-- J4 1of8 decoder  
		( (     s_H(4) ) or (     s_H(5) ) or ( not s_H(6) ) or ( s_H(8) ) ) and	-- J4 1of8 decoder  
		( ( not s_V(3) ) or ( not s_V(7) ) or (     s_V(8) ) or ( s_K5_6 ) ) ;		-- L4 1of8 decoder  

	-- Half of J7 F/F outputs 5, 6
	-- divides 12MHz xtal to generate 6MHz and inverted 6MHz clock enables
	J7a : process
	begin
		wait until rising_edge(I_CLK_12M);
		s_L6M <=     s_X6M;
		s_X6M <= not s_X6M;
	end process;

	-- Half of J7 F/F output 9, together with H3 and J3 counters form a 9 bit horizontal counter clocked at 6Mhz
	-- page 5/8 unclear how J1 links are set so assume J3 is preloaded with "0010" on ABCD inputs
	-- this works to 384 counts up from 010000000 till overflow.
	-- 6Mhz/384=15625Hz horizontal freq which is a very typical horiz. freq. for that resolution

	-- Half of M2 output 5, together with L2 and L3 counters form a 9 bit vertical counter clocked at 15625Hz
	-- With a preset value of 011111010 this works out to 262 counts till overflow
	-- 15625/262=59.63Hz frame rate
	h_v_count : process
	begin
		wait until rising_edge(I_CLK_12M);
		if s_X6M = '0' then
			if s_H = "111111111" then
				s_H <= "010000000";
				-- vclk
				if s_V = "111111111" then
					s_V <= "011111010";
				else
					s_V <= s_V + 1;
				end if;
			else
				s_H <= s_H + 1;
			end if;
		end if;
	end process;

	K7_K8_a : process
	begin
		wait until rising_edge(I_CLK_12M);
		if s_L6M = '0' then
			-- K7 F/F output 5
			s_K7_5 <= s_H7_8;
			-- K8 F/F output 5
			s_K8_5 <= s_H(0) and s_H(1);	-- generates 4-3H
		end if;
	end process;

	K7_K8_b : process
	begin
		wait until rising_edge(I_CLK_12M);
		if s_X6M = '0' then
			-- K7 F/F output 8
			s_K7_8 <= not s_K7_5; -- generates OH
			-- K8 F/F output 9
			s_K8_9 <= s_K8_5 and ( not s_H(2) );	-- generates 4H
		end if;
	end process;

	-- H7 AND gate output 8
	-- generates low pulse every time low 3 bits of H counter are high
	s_H7_8 <= not (s_H(0) and s_H(1) and s_H(2));

	-- J9, K9 gate combos feeding J/K FF J8 
	s_J8_JK(1) <= ( not s_H7_8 ) and ( not s_H(8) ); -- J
	s_J8_JK(0) <= ( not s_H7_8 ) and       s_H(8)  ; -- K

	-- inputs are transfered to the outputs on negative edge of clock
	J8_6 : process
	begin
		wait until rising_edge(I_CLK_12M);
		if s_L6M = '1' then
			case s_J8_JK is
				when "10" => s_J8_6 <= '0';	-- generates LHBL
				when "01" => s_J8_6 <= '1';
				when others => null;
			end case;
		end if;
	end process;

	-- K3 gate output 8
	s_K3_8	<= not ( s_V(8) and       s_V(7)  and s_V(6) and s_V(5) and s_V(4) );

	-- H7 gate output 12
	s_H7_12	<= not ( s_V(8) and ( not s_V(7) )                      and s_V(4) );

	-- K5 F/F output 6
	K5_6 : process
	begin
		wait until rising_edge(I_CLK_12M);
		if s_K3_8 = '0' then
			s_K5_6 <= '0';	-- set (inverted)
		elsif s_H7_12 = '0' then
			s_K5_6 <= '1';	-- clear (inverted)
		end if;
	end process;

	-- K5 F/F output 9
	K5_9 : process
	begin
		wait until rising_edge(I_CLK_12M);
		s_K7_8_last <= s_K7_8;
		if s_K7_8 = '1' and s_K7_8_last='0' then
			s_K5_9 <= s_K5_6;	-- generates LVBL
		end if;
	end process;

end RTL;
