--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:49:15 07/05/2018
-- Design Name:   
-- Module Name:   tb_audio.vhd
-- Project Name:  1942_pipistrello
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: SOUND
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
 
ENTITY tb_audio IS
END tb_audio;
 
ARCHITECTURE behavior OF tb_audio IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SOUND
    PORT(
         I_CLK_12M,
         I_PHI_B,
         I_OUT0,
         I_OUT1,
         I_ACL1n,
         I_SND_INT		: IN  std_logic;
         I_CPUB_RESn    : IN  std_logic;

         I_DB				: IN  std_logic_vector(7 downto 0);

         O_1PSG,
         O_2PSG			: OUT std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal I_DB				: std_logic_vector(7 downto 0) := (others => '0');
   signal
		I_SND_INT,
		I_CLK,
		I_ACL1n,
		I_OUT0,
		I_OUT1
								: std_logic := '0';
 
	signal clock : std_logic := '0';
	signal count : std_logic_vector(1 downto 0) := "00";
   constant clock_period : time := 83.333 ns; -- 12MHz
 
BEGIN

	-- Instantiate the Unit Under Test (UUT)
   uut: SOUND PORT MAP (
          I_DB				=> I_DB,
          I_CLK_12M		=> clock,
          I_PHI_B			=> I_CLK,
          I_OUT0			=> I_OUT0,
          I_OUT1			=> I_OUT1,
          I_ACL1n			=> I_ACL1n,
          I_CPUB_RESn	=> '1',
          I_SND_INT		=> I_SND_INT,
          O_1PSG			=> open,
          O_2PSG			=> open
        );

	I_CLK <= count(1) and count(0);

   -- Clock process definitions
   clock_process :process
   begin
		clock <= '0';
		wait for clock_period/2;
		clock <= '1';
		wait for clock_period/2;
   end process;

   count_process :process
   begin
		wait until rising_edge(clock);
		count <= count + 1;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin
		I_ACL1n <= '0';
		I_SND_INT <= '0';
		I_DB <= x"00";
      -- hold reset state
      wait for clock_period*128;
		I_ACL1n <= '1';

      -- insert stimulus here 
      wait for 15ms;
		I_DB <= x"11";
		I_OUT0 <= '1';
      wait for clock_period*8;
		I_OUT0 <= '0';

      wait for 1ms;
		I_SND_INT <= '1';
      wait for clock_period*8;
		I_SND_INT <= '0';

      wait;
   end process;

END;
