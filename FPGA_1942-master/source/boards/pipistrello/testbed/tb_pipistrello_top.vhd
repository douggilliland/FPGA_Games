--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:19:37 07/12/2018
-- Design Name:   
-- Module Name:   tb_pipistrello_top.vhd
-- Project Name:  1942_pipistrello
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: PIPISTRELLO_TOP
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_pipistrello_top IS
END tb_pipistrello_top;
 
ARCHITECTURE behavior OF tb_pipistrello_top IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
	COMPONENT PIPISTRELLO_TOP
	PORT(
		I_RESET			: IN   std_logic;
--		O_VIDEO_R		: OUT  std_logic_vector(3 downto 0);
--		O_VIDEO_G		: OUT  std_logic_vector(3 downto 0);
--		O_VIDEO_B		: OUT  std_logic_vector(3 downto 0);
--		O_HSYNC			: OUT  std_logic;
--		O_VSYNC			: OUT  std_logic;
		TMDS_P			: OUT  std_logic_vector(3 downto 0);
		TMDS_N			: OUT  std_logic_vector(3 downto 0);
		O_AUDIO_L		: OUT  std_logic;
		O_AUDIO_R		: OUT  std_logic;
		BUTTON0			: IN   std_logic;
		BUTTON1			: IN   std_logic;
		CLK_IN			: IN   std_logic
	);
	END COMPONENT;
    

	--Inputs
	signal I_RESET		: std_logic := '0';
	signal BUTTON0		: std_logic := '0';
	signal BUTTON1		: std_logic := '0';
	signal CLK_IN		: std_logic := '0';

	--Outputs
--	signal O_VIDEO_R	: std_logic_vector(3 downto 0);
--	signal O_VIDEO_G	: std_logic_vector(3 downto 0);
--	signal O_VIDEO_B	: std_logic_vector(3 downto 0);
--	signal O_HSYNC		: std_logic;
--	signal O_VSYNC		: std_logic;
	signal O_AUDIO_L	: std_logic;
	signal O_AUDIO_R	: std_logic;
	
	signal TMDS_P		: std_logic_vector(3 downto 0);
	signal TMDS_N		: std_logic_vector(3 downto 0);

	-- Clock period definitions
	constant clock_period : time := 20 ns;
 
begin
	-- Instantiate the Unit Under Test (UUT)
	uut: PIPISTRELLO_TOP port map (
		I_RESET		=> I_RESET,
--		O_VIDEO_R	=> O_VIDEO_R,
--		O_VIDEO_G	=> O_VIDEO_G,
--		O_VIDEO_B	=> O_VIDEO_B,
--		O_HSYNC		=> O_HSYNC,
--		O_VSYNC		=> O_VSYNC,
		TMDS_P		=> TMDS_P,
		TMDS_N		=> TMDS_N,
		O_AUDIO_L	=> O_AUDIO_L,
		O_AUDIO_R	=> O_AUDIO_R,
		BUTTON0		=> BUTTON0,
		BUTTON1		=> BUTTON1,
		CLK_IN		=> CLK_IN
	);

	-- Clock process definitions
	clock_process :process
	begin
		CLK_IN <= '0';
		wait for clock_period/2;
		CLK_IN <= '1';
		wait for clock_period/2;
	end process;

	-- Stimulus process
	stim_proc: process
	begin		
		BUTTON0 <= '1';
		BUTTON1 <= '1';
		-- hold reset state
		I_RESET <= '1';
		wait for clock_period*64;
		I_RESET <= '0';

		-- insert stimulus here 
		wait for 120 ms;	
		BUTTON0 <= '0'; -- COIN
		wait for 10 ms;	
		BUTTON0 <= '1';

		wait for 10 ms;	
		BUTTON1 <= '0'; -- P1 START
		wait for 10 ms;	
		BUTTON1 <= '1';

		wait;
	end process;

end;
