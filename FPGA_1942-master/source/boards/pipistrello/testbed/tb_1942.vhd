--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:13:13 07/07/2018
-- Design Name:   
-- Module Name:   tb_fpga_1942.vhd
-- Project Name:  1942_pipistrello
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: FPGA_1942
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
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;

ENTITY tb_1942 IS
END tb_1942;

ARCHITECTURE behavior OF tb_1942 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
	COMPONENT FPGA_1942
	PORT(
		I_CLK_12M,
		I_RESET	
								: IN  std_logic;
		I_P1,
		I_P2,
		I_DIP_A,
		I_DIP_B
								: IN std_logic_vector(7 downto 0);
		O_AUDIO_L,
		O_AUDIO_R
								: OUT std_logic_vector(7 downto 0);
		O_VIDEO_R,
		O_VIDEO_G,
		O_VIDEO_B
								: OUT std_logic_vector(3 downto 0);
		O_HSYNC,
		O_VSYNC,
		O_CSYNC
								: OUT  std_logic
	);
	END COMPONENT;

	--Inputs
	signal I_CLK_12M 	: std_logic := '0';
	signal I_RESET 	: std_logic := '0';
	signal I_P1 		: std_logic_vector(7 downto 0) := (others => '0');
	signal I_P2 		: std_logic_vector(7 downto 0) := (others => '0');
	signal I_DIP_A 	: std_logic_vector(7 downto 0) := (others => '0');
	signal I_DIP_B 	: std_logic_vector(7 downto 0) := (others => '0');

	--Outputs
	signal O_AUDIO_L 	: std_logic_vector(7 downto 0);
	signal O_AUDIO_R 	: std_logic_vector(7 downto 0);
	signal O_VIDEO_R 	: std_logic_vector(3 downto 0);
	signal O_VIDEO_G 	: std_logic_vector(3 downto 0);
	signal O_VIDEO_B 	: std_logic_vector(3 downto 0);
	signal O_HSYNC 	: std_logic;
	signal O_VSYNC 	: std_logic;
	signal O_CSYNC		: std_logic;

	constant clock_period : time := 83.333 ns;

begin
 	-- Instantiate the Unit Under Test (UUT)
	uut: FPGA_1942 port map (
		I_CLK_12M	=> I_CLK_12M,
		I_RESET		=> I_RESET,
		I_P1			=> I_P1,
		I_P2			=> I_P2,
		I_DIP_A		=> I_DIP_A,
		I_DIP_B		=> I_DIP_B,
		O_AUDIO_L	=> O_AUDIO_L,
		O_AUDIO_R	=> O_AUDIO_R,
		O_VIDEO_R	=> O_VIDEO_R,
		O_VIDEO_G	=> O_VIDEO_G,
		O_VIDEO_B	=> O_VIDEO_B,
		O_HSYNC		=> O_HSYNC,
		O_VSYNC		=> O_VSYNC,
		O_CSYNC		=> O_CSYNC
	);

	-- Clock process definitions
	clock_process :process
	begin
		I_CLK_12M <= '0';
		wait for clock_period/2;
		I_CLK_12M <= '1';
		wait for clock_period/2;
	end process;

	-- Stimulus process
	stim_proc: process
	begin		
		I_DIP_A	<= "01110111"; -- default settings x"77"
		I_DIP_B	<= "11111111"; -- default settings x"FF"
		I_P1		<= "11111111"; -- default settings x"FF"
		I_P2		<= "11111111"; -- default settings x"FF"
		-- reset system
		I_RESET <= '1';
		wait for clock_period*32;
		I_RESET <= '0';

		-- insert stimulus here 
		wait for 120ms;
		I_P1(7) <= '0'; -- COIN
		wait for 10ms;
		I_P1(7) <= '1';

--		wait for 10ms;
--		I_P1(6) <= '0'; -- P1 START
--		wait for 1ms;
--		I_P1(6) <= '1';

		wait;
	end process;

end;
