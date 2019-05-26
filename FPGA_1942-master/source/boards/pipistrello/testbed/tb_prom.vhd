--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:14:35 09/12/2018
-- Design Name:   
-- Module Name:   tb_prom.vhd
-- Project Name:  gauntlet_pipistrello
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: PROM_M11
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
LIBRARY std;
	USE std.textio.ALL;

LIBRARY ieee;
	USE ieee.std_logic_1164.ALL;
	USE ieee.std_logic_textio.ALL;
	USE ieee.std_logic_unsigned.ALL;

ENTITY tb_prom IS
END tb_prom;
 
ARCHITECTURE behavior OF tb_prom IS 

	COMPONENT PROM_M11
	PORT(
		CLK  : IN	std_logic;
		ADDR : IN	std_logic_vector(8 downto 0);
		DATA : OUT	std_logic_vector(7 downto 0)
	);
	END COMPONENT;

	file logfile: TEXT open WRITE_MODE is "..\screens\M11.txt";
	signal CLK				: std_logic := '0';

	signal ADDR				: std_logic_vector(11 downto 0) := (others => '0');
	signal I_V				: std_logic_vector(11 downto 0) := (others => '0');
	signal ADDR_L			: std_logic_vector(11 downto 0) := (others => '0');

	signal DATA				: std_logic_vector(3 downto 0) := (others => '0');
	signal DATA_COMB		: std_logic_vector(3 downto 0) := (others => '0');

	-- Clock period definitions
	constant CLK_period	: time := 10 ns;
 
BEGIN
	-- M11 PROM
	prom : entity work.PROM_M11
	port map (
		CLK	=> CLK,
		ADDR	=> ADDR(7 downto 0),
		DATA	=> DATA
	);

   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;

	p_addr :process
	begin
		wait until rising_edge(CLK);
		ADDR		<= ADDR + 1;
		ADDR_L	<= ADDR;
		if (ADDR_L = x"FFF" and ADDR = x"000") then
			file_close(logfile);
			assert false report "Simulation Finished" severity failure;
		end if;
	end process;

	I_V <= ADDR;
	DATA_COMB(3) <= '0';
	DATA_COMB(2) <= '0';

	p_dump :process
		variable	s : line;
	begin
		wait until rising_edge(CLK);

		DATA_COMB(1) <=
			not (I_V(7) or  I_V(6) or  I_V(5) or  I_V(4) ) or
				 (I_V(7) and I_V(6) and I_V(5) and I_V(4));

		DATA_COMB(0) <=
			not ( I_V(7) or  I_V(6) or  I_V(5) or   I_V(4) or (I_V(3) and I_V(2) and I_V(1) and I_V(0))) or
				 ( I_V(7) and I_V(6) and I_V(5) and (I_V(4) or (I_V(3) and I_V(2) and I_V(1) and I_V(0))) ); 

		WRITE(s, " Addr: "); HWRITE(s, (ADDR));
		WRITE(s, " Expected: "); WRITE(s, DATA);
		WRITE(s, " Received: "); WRITE(s, DATA_COMB);
		if (DATA /= DATA_COMB) then
			WRITE(s, " MISMATCH "); WRITE(s, DATA xor DATA_COMB); 
		end if;
		WRITELINE(logfile,s);
   end process;

   -- Stimulus process
   stim_proc: process
   begin
      wait;
   end process;
END;
