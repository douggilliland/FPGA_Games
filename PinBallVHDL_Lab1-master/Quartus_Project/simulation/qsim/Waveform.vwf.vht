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
-- Generated on "05/28/2018 20:52:15"
                                                             
-- Vhdl Test Bench(with test vectors) for design  :          hp_down_counter
-- 
-- Simulation tool : 3rd Party
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY hp_down_counter_vhd_vec_tst IS
END hp_down_counter_vhd_vec_tst;
ARCHITECTURE hp_down_counter_arch OF hp_down_counter_vhd_vec_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL clk : STD_LOGIC;
SIGNAL died : STD_LOGIC;
SIGNAL enable : STD_LOGIC;
SIGNAL game_over : STD_LOGIC;
SIGNAL lives_num_current : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL lives_num_start : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL resetN : STD_LOGIC;
COMPONENT hp_down_counter
	PORT (
	clk : IN STD_LOGIC;
	died : IN STD_LOGIC;
	enable : IN STD_LOGIC;
	game_over : OUT STD_LOGIC;
	lives_num_current : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	lives_num_start : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	resetN : IN STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : hp_down_counter
	PORT MAP (
-- list connections between master ports and signals
	clk => clk,
	died => died,
	enable => enable,
	game_over => game_over,
	lives_num_current => lives_num_current,
	lives_num_start => lives_num_start,
	resetN => resetN
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

-- died
t_prcs_died: PROCESS
BEGIN
	FOR i IN 1 TO 11
	LOOP
		died <= '0';
		WAIT FOR 45000 ps;
		died <= '1';
		WAIT FOR 45000 ps;
	END LOOP;
	died <= '0';
WAIT;
END PROCESS t_prcs_died;

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
	WAIT FOR 30000 ps;
	resetN <= '1';
	WAIT FOR 700000 ps;
	resetN <= '0';
	WAIT FOR 50000 ps;
	resetN <= '1';
WAIT;
END PROCESS t_prcs_resetN;
-- lives_num_start[3]
t_prcs_lives_num_start_3: PROCESS
BEGIN
	lives_num_start(3) <= '0';
WAIT;
END PROCESS t_prcs_lives_num_start_3;
-- lives_num_start[2]
t_prcs_lives_num_start_2: PROCESS
BEGIN
	lives_num_start(2) <= '1';
WAIT;
END PROCESS t_prcs_lives_num_start_2;
-- lives_num_start[1]
t_prcs_lives_num_start_1: PROCESS
BEGIN
	lives_num_start(1) <= '0';
WAIT;
END PROCESS t_prcs_lives_num_start_1;
-- lives_num_start[0]
t_prcs_lives_num_start_0: PROCESS
BEGIN
	lives_num_start(0) <= '1';
WAIT;
END PROCESS t_prcs_lives_num_start_0;
END hp_down_counter_arch;
