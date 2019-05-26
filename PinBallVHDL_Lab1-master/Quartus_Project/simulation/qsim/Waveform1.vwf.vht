-- Copyright (C) 2017  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel MegaCore Function License Agreement, or other 
-- applicable license agreement, including, without limitation, 
-- that your use is for the sole purpose of programming logic 
-- devices manufactured by Intel and sold by Intel or its 
-- authorized distributors.  Please refer to the applicable 
-- agreement for further details.

-- *****************************************************************************
-- This file contains a Vhdl test bench with test vectors .The test vectors     
-- are exported from a vector file in the Quartus Waveform Editor and apply to  
-- the top level entity of the current Quartus project .The user can use this   
-- testbench to simulate his design using a third-party simulation tool .       
-- *****************************************************************************
-- Generated on "05/28/2018 21:25:49"
                                                             
-- Vhdl Test Bench(with test vectors) for design  :          score_up_counter
-- 
-- Simulation tool : 3rd Party
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY score_up_counter_vhd_vec_tst IS
END score_up_counter_vhd_vec_tst;
ARCHITECTURE score_up_counter_arch OF score_up_counter_vhd_vec_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL clk : STD_LOGIC;
SIGNAL enable : STD_LOGIC;
SIGNAL resetN : STD_LOGIC;
SIGNAL score_in : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL score_out : STD_LOGIC_VECTOR(16 DOWNTO 0);
SIGNAL scored : STD_LOGIC;
COMPONENT score_up_counter
	PORT (
	clk : IN STD_LOGIC;
	enable : IN STD_LOGIC;
	resetN : IN STD_LOGIC;
	score_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	score_out : OUT STD_LOGIC_VECTOR(16 DOWNTO 0);
	scored : IN STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : score_up_counter
	PORT MAP (
-- list connections between master ports and signals
	clk => clk,
	enable => enable,
	resetN => resetN,
	score_in => score_in,
	score_out => score_out,
	scored => scored
	);

-- clk
t_prcs_clk: PROCESS
BEGIN
	FOR i IN 1 TO 33
	LOOP
		clk <= '0';
		WAIT FOR 15000 ps;
		clk <= '1';
		WAIT FOR 15000 ps;
	END LOOP;
	clk <= '0';
WAIT;
END PROCESS t_prcs_clk;

-- enable
t_prcs_enable: PROCESS
BEGIN
	enable <= '1';
WAIT;
END PROCESS t_prcs_enable;

-- resetN
t_prcs_resetN: PROCESS
BEGIN
	resetN <= '0';
	WAIT FOR 40000 ps;
	resetN <= '1';
	WAIT FOR 640000 ps;
	resetN <= '0';
	WAIT FOR 50000 ps;
	resetN <= '1';
WAIT;
END PROCESS t_prcs_resetN;

-- scored
t_prcs_scored: PROCESS
BEGIN
	FOR i IN 1 TO 12
	LOOP
		scored <= '0';
		WAIT FOR 40000 ps;
		scored <= '1';
		WAIT FOR 40000 ps;
	END LOOP;
	scored <= '0';
WAIT;
END PROCESS t_prcs_scored;
-- score_in[3]
t_prcs_score_in_3: PROCESS
BEGIN
	score_in(3) <= '0';
	WAIT FOR 390000 ps;
	score_in(3) <= '1';
	WAIT FOR 220000 ps;
	score_in(3) <= '0';
WAIT;
END PROCESS t_prcs_score_in_3;
-- score_in[2]
t_prcs_score_in_2: PROCESS
BEGIN
	score_in(2) <= '0';
	WAIT FOR 100000 ps;
	score_in(2) <= '1';
	WAIT FOR 130000 ps;
	score_in(2) <= '0';
WAIT;
END PROCESS t_prcs_score_in_2;
-- score_in[1]
t_prcs_score_in_1: PROCESS
BEGIN
	score_in(1) <= '0';
	WAIT FOR 10000 ps;
	score_in(1) <= '1';
	WAIT FOR 90000 ps;
	score_in(1) <= '0';
	WAIT FOR 290000 ps;
	score_in(1) <= '1';
	WAIT FOR 220000 ps;
	score_in(1) <= '0';
	WAIT FOR 290000 ps;
	score_in(1) <= '1';
	WAIT FOR 90000 ps;
	score_in(1) <= '0';
WAIT;
END PROCESS t_prcs_score_in_1;
-- score_in[0]
t_prcs_score_in_0: PROCESS
BEGIN
	score_in(0) <= '0';
	WAIT FOR 10000 ps;
	score_in(0) <= '1';
	WAIT FOR 380000 ps;
	score_in(0) <= '0';
WAIT;
END PROCESS t_prcs_score_in_0;
END score_up_counter_arch;
