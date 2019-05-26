--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:57:44 04/21/2015
-- Design Name:   
-- Module Name:   E:/xilinx/projects/vga2/test.vhd
-- Project Name:  vga2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: screen
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
 
ENTITY test IS
END test;
 
ARCHITECTURE behavior OF test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT screen
    PORT(
         Hposition : IN  std_logic_vector(10 downto 0);
         Vposition : IN  std_logic_vector(9 downto 0);
         VIDON : IN  std_logic;
         red : OUT  std_logic_vector(4 downto 0);
         green : OUT  std_logic_vector(5 downto 0);
         blue : OUT  std_logic_vector(4 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Hposition : std_logic_vector(10 downto 0) := (others => '0');
   signal Vposition : std_logic_vector(9 downto 0) := (others => '0');
   signal VIDON : std_logic := '0';

 	--Outputs
   signal red : std_logic_vector(4 downto 0);
   signal green : std_logic_vector(5 downto 0);
   signal blue : std_logic_vector(4 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: screen PORT MAP (
          Hposition => Hposition,
          Vposition => Vposition,
          VIDON => VIDON,
          red => red,
          green => green,
          blue => blue
        );

   -- Clock process definitions
   <clock>_process :process
   begin
		<clock> <= '0';
		wait for <clock>_period/2;
		<clock> <= '1';
		wait for <clock>_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for <clock>_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
