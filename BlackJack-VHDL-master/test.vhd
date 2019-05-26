--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:22:35 12/15/2015
-- Design Name:   
-- Module Name:   C:/hlocal/BlackJack/test.vhd
-- Project Name:  BlackJack
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: BlackJack
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
 
    COMPONENT BlackJack
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         comenzar : IN  std_logic;
         otra_carta : IN  std_logic;
         me_planto : IN  std_logic;
         maquina_lista : OUT  std_logic;
         carta_incorrecta : OUT  std_logic;
         partida_perdida : OUT  std_logic;
         carta_actual : OUT  std_logic_vector(6 downto 0);
         valor_acumulado : OUT  std_logic_vector(13 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal comenzar : std_logic := '0';
   signal otra_carta : std_logic := '0';
   signal me_planto : std_logic := '0';

 	--Outputs
   signal maquina_lista : std_logic;
   signal carta_incorrecta : std_logic;
   signal partida_perdida : std_logic;
   signal carta_actual : std_logic_vector(6 downto 0);
   signal valor_acumulado : std_logic_vector(13 downto 0);

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: BlackJack PORT MAP (
          clk => clk,
          reset => reset,
          comenzar => comenzar,
          otra_carta => otra_carta,
          me_planto => me_planto,
          maquina_lista => maquina_lista,
          carta_incorrecta => carta_incorrecta,
          partida_perdida => partida_perdida,
          carta_actual => carta_actual,
          valor_acumulado => valor_acumulado
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
      reset <= '1';
		wait for 100 ns;	

		reset <='0';
		
      wait for clk_period*2;
		
		otra_carta <= '1';
		
		wait for clk_period*2;
		
		otra_carta <= '0';
		me_planto <='1';
		
		wait for clk_period*2;
		
		me_planto <='0';
		
		wait for clk_period*2;
		
		comenzar <='1';
		
		wait for clk_period*2;
		
		comenzar <='0';
		otra_carta <='1';
		
		wait for clk_period*10;
		
		me_planto <='1';
		otra_carta <='0';
		


      wait;
   end process;

END;
