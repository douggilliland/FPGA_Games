--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:18:21 07/01/2018
-- Design Name:   
-- Module Name:   tb_sync.vhd
-- Project Name:  1942_pipistrello
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: SYNC
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
	use ieee.std_logic_arith.all;
	use ieee.std_logic_unsigned.all;
	use ieee.numeric_std.all;

library unisim;
	use unisim.vcomponents.all;
 
ENTITY tb_sync IS
END tb_sync;
 
ARCHITECTURE behavior OF tb_sync IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SYNC
    PORT(
         I_CLK_12M 		: IN   std_logic;
         O_phi_B 	: OUT  std_logic;
			O_CSYNC	: OUT  std_logic;
			O_LHBL	: OUT  std_logic;
			O_LVBL	: OUT  std_logic;
         O_OH 		: OUT  std_logic;
         O_4H 		: OUT  std_logic;
         O_6M 		: OUT  std_logic;
         O_V 		: OUT  std_logic_vector(8 downto 0);
         O_H 		: OUT  std_logic_vector(8 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal I_CLK_12M		: std_logic := '0';

	--Outputs
	signal O_phi_B	: std_logic;
	signal O_CSYNC	: std_logic;
	signal O_LHBL	: std_logic;
	signal O_LVBL	: std_logic;
	signal O_OH		: std_logic;
	signal O_4H		: std_logic;
	signal O_6M		: std_logic;
	signal O_V		: std_logic_vector(8 downto 0);
	signal O_H		: std_logic_vector(8 downto 0);
	signal video	: std_logic_vector(15 downto 0) := (others=>'0');
 
   constant clock_period : time := 83 ns;	-- 12MHz
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
	p_sync: SYNC PORT MAP (
		I_CLK_12M	=> I_CLK_12M,
		O_phi_B		=> O_phi_B,
		O_CSYNC		=> O_CSYNC,
		O_LHBL		=> O_LHBL,
		O_LVBL		=> O_LVBL,
		O_OH			=> O_OH,
		O_4H			=> O_4H,
		O_6M			=> O_6M,
		O_V			=> O_V,
		O_H			=> O_H
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
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clock_period*16;
      -- insert stimulus here 

      wait;
   end process;

END;
