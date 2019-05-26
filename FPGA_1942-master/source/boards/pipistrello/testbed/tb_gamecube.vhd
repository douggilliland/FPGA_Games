--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:10:03 10/06/2018
-- Design Name:
-- Module Name:   tb_gamecube.vhd
-- Project Name:  1942_pipistrello
-- Target Device:
-- Tool versions:
-- Description:
-- 
-- VHDL Test Bench Created by ISE for module: gamecube
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
library ieee;
	use ieee.std_logic_1164.all;
entity tb_gamecube is
end tb_gamecube;
 
architecture behavior of tb_gamecube is 

	component gamecube
	port(
		clk		: in		std_logic;
		reset		: in		std_logic;
		serio		: inout	std_logic;
		but_S		: out		std_logic;
		but_X		: out		std_logic;
		but_Y		: out		std_logic;
		but_Z		: out		std_logic;
		but_A		: out		std_logic;
		but_B		: out		std_logic;
		but_L		: out		std_logic;
		but_R		: out		std_logic;
		but_DU	: out		std_logic;
		but_DD	: out		std_logic;
		but_DL	: out		std_logic;
		but_DR	: out		std_logic;
		joy_X		: out		std_logic_vector(7 downto 0);
		joy_Y		: out		std_logic_vector(7 downto 0);
		cst_X		: out		std_logic_vector(7 downto 0);
		cst_Y		: out		std_logic_vector(7 downto 0);
		ana_L		: out		std_logic_vector(7 downto 0);
		ana_R		: out		std_logic_vector(7 downto 0)
	);
	end component;

   signal
		clk,
		reset
								: std_logic := '0';
   signal
		serio
								: std_logic;
   signal
		but_S,
		but_X,
		but_Y,
		but_Z,
		but_A,
		but_B,
		but_L,
		but_R,
		but_DU,
		but_DD,
		but_DL,
		but_DR
								: std_logic;
   signal
		joy_X,
		joy_Y,
		cst_X,
		cst_Y,
		ana_L,
		ana_R
								: std_logic_vector(7 downto 0);

   constant clk_period : time := 1 us;
 
begin
	uut: gamecube PORT MAP (
		clk		=> clk,
		reset		=> reset,
		serio		=> serio,
		but_S		=> but_S,
		but_X		=> but_X,
		but_Y		=> but_Y,
		but_Z		=> but_Z,
		but_A		=> but_A,
		but_B		=> but_B,
		but_L		=> but_L,
		but_R		=> but_R,
		but_DU	=> but_DU,
		but_DD	=> but_DD,
		but_DL	=> but_DL,
		but_DR	=> but_DR,
		joy_X		=> joy_X,
		joy_Y		=> joy_Y,
		cst_X		=> cst_X,
		cst_Y		=> cst_Y,
		ana_L		=> ana_L,
		ana_R		=> ana_R
	);

	-- Clock process definitions
	clk_process :process
	begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
	end process;

	-- Stimulus process
	stim_proc: process
	begin		
		-- hold reset state for 100 ns.
		serio <= 'Z';
		reset <= '1';
		wait for clk_period*4;
		reset <= '0';

		wait for clk_period*123;

		-- b0
		serio <= '0'; wait for clk_period*1; serio <= '1'; wait for clk_period*3; -- 1
		serio <= '0'; wait for clk_period*3; serio <= '1'; wait for clk_period*1; -- 0
		serio <= '0'; wait for clk_period*1; serio <= '1'; wait for clk_period*3; -- 1
		serio <= '0'; wait for clk_period*3; serio <= '1'; wait for clk_period*1; -- 0
		serio <= '0'; wait for clk_period*1; serio <= '1'; wait for clk_period*3; -- 1
		serio <= '0'; wait for clk_period*3; serio <= '1'; wait for clk_period*1; -- 0
		serio <= '0'; wait for clk_period*1; serio <= '1'; wait for clk_period*3; -- 1
		serio <= '0'; wait for clk_period*3; serio <= '1'; wait for clk_period*1; -- 0

		-- b1
		serio <= '0'; wait for clk_period*3; serio <= '1'; wait for clk_period*1; -- 0
		serio <= '0'; wait for clk_period*3; serio <= '1'; wait for clk_period*1; -- 0
		serio <= '0'; wait for clk_period*3; serio <= '1'; wait for clk_period*1; -- 0
		serio <= '0'; wait for clk_period*3; serio <= '1'; wait for clk_period*1; -- 0
		serio <= '0'; wait for clk_period*1; serio <= '1'; wait for clk_period*3; -- 1
		serio <= '0'; wait for clk_period*1; serio <= '1'; wait for clk_period*3; -- 1
		serio <= '0'; wait for clk_period*1; serio <= '1'; wait for clk_period*3; -- 1
		serio <= '0'; wait for clk_period*1; serio <= '1'; wait for clk_period*3; -- 1

		-- b2
		serio <= '0'; wait for clk_period*3; serio <= '1'; wait for clk_period*1; -- 0
		serio <= '0'; wait for clk_period*1; serio <= '1'; wait for clk_period*3; -- 1
		serio <= '0'; wait for clk_period*3; serio <= '1'; wait for clk_period*1; -- 0
		serio <= '0'; wait for clk_period*1; serio <= '1'; wait for clk_period*3; -- 1
		serio <= '0'; wait for clk_period*3; serio <= '1'; wait for clk_period*1; -- 0
		serio <= '0'; wait for clk_period*1; serio <= '1'; wait for clk_period*3; -- 1
		serio <= '0'; wait for clk_period*3; serio <= '1'; wait for clk_period*1; -- 0
		serio <= '0'; wait for clk_period*1; serio <= '1'; wait for clk_period*3; -- 1

		-- b3
		serio <= '0'; wait for clk_period*1; serio <= '1'; wait for clk_period*3; -- 1
		serio <= '0'; wait for clk_period*1; serio <= '1'; wait for clk_period*3; -- 1
		serio <= '0'; wait for clk_period*3; serio <= '1'; wait for clk_period*1; -- 0
		serio <= '0'; wait for clk_period*3; serio <= '1'; wait for clk_period*1; -- 0
		serio <= '0'; wait for clk_period*1; serio <= '1'; wait for clk_period*3; -- 1
		serio <= '0'; wait for clk_period*1; serio <= '1'; wait for clk_period*3; -- 1
		serio <= '0'; wait for clk_period*3; serio <= '1'; wait for clk_period*1; -- 0
		serio <= '0'; wait for clk_period*3; serio <= '1'; wait for clk_period*1; -- 0

		-- b4
		serio <= '0'; wait for clk_period*3; serio <= '1'; wait for clk_period*1; -- 0
		serio <= '0'; wait for clk_period*3; serio <= '1'; wait for clk_period*1; -- 0
		serio <= '0'; wait for clk_period*1; serio <= '1'; wait for clk_period*3; -- 1
		serio <= '0'; wait for clk_period*1; serio <= '1'; wait for clk_period*3; -- 1
		serio <= '0'; wait for clk_period*3; serio <= '1'; wait for clk_period*1; -- 0
		serio <= '0'; wait for clk_period*3; serio <= '1'; wait for clk_period*1; -- 0
		serio <= '0'; wait for clk_period*1; serio <= '1'; wait for clk_period*3; -- 1
		serio <= '0'; wait for clk_period*1; serio <= '1'; wait for clk_period*3; -- 1

		-- b5
		serio <= '0'; wait for clk_period*1; serio <= '1'; wait for clk_period*3; -- 1
		serio <= '0'; wait for clk_period*3; serio <= '1'; wait for clk_period*1; -- 0
		serio <= '0'; wait for clk_period*1; serio <= '1'; wait for clk_period*3; -- 1
		serio <= '0'; wait for clk_period*3; serio <= '1'; wait for clk_period*1; -- 0
		serio <= '0'; wait for clk_period*1; serio <= '1'; wait for clk_period*3; -- 1
		serio <= '0'; wait for clk_period*1; serio <= '1'; wait for clk_period*3; -- 1
		serio <= '0'; wait for clk_period*1; serio <= '1'; wait for clk_period*3; -- 1
		serio <= '0'; wait for clk_period*1; serio <= '1'; wait for clk_period*3; -- 1

		-- b6
		serio <= '0'; wait for clk_period*1; serio <= '1'; wait for clk_period*3; -- 1
		serio <= '0'; wait for clk_period*1; serio <= '1'; wait for clk_period*3; -- 1
		serio <= '0'; wait for clk_period*1; serio <= '1'; wait for clk_period*3; -- 1
		serio <= '0'; wait for clk_period*1; serio <= '1'; wait for clk_period*3; -- 1
		serio <= '0'; wait for clk_period*1; serio <= '1'; wait for clk_period*3; -- 1
		serio <= '0'; wait for clk_period*3; serio <= '1'; wait for clk_period*1; -- 0
		serio <= '0'; wait for clk_period*1; serio <= '1'; wait for clk_period*3; -- 1
		serio <= '0'; wait for clk_period*3; serio <= '1'; wait for clk_period*1; -- 0

		-- b7
		serio <= '0'; wait for clk_period*1; serio <= '1'; wait for clk_period*3; -- 1
		serio <= '0'; wait for clk_period*1; serio <= '1'; wait for clk_period*3; -- 1
		serio <= '0'; wait for clk_period*1; serio <= '1'; wait for clk_period*3; -- 1
		serio <= '0'; wait for clk_period*3; serio <= '1'; wait for clk_period*1; -- 0
		serio <= '0'; wait for clk_period*1; serio <= '1'; wait for clk_period*3; -- 1
		serio <= '0'; wait for clk_period*3; serio <= '1'; wait for clk_period*1; -- 0
		serio <= '0'; wait for clk_period*1; serio <= '1'; wait for clk_period*3; -- 1
		serio <= '0'; wait for clk_period*1; serio <= '1'; wait for clk_period*3; -- 1

		serio <= '0'; wait for clk_period*1; serio <= '1'; wait for clk_period*3; -- 1
		serio <= 'Z';

		wait;
	end process;

end;
