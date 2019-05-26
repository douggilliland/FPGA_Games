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

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 17.0.0 Build 595 04/25/2017 SJ Lite Edition"

-- DATE "05/28/2018 21:25:51"

-- 
-- Device: Altera 5CSXFC6D6F31C6 Package FBGA896
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY ALTERA_LNSIM;
LIBRARY CYCLONEV;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE ALTERA_LNSIM.ALTERA_LNSIM_COMPONENTS.ALL;
USE CYCLONEV.CYCLONEV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	score_up_counter IS
    PORT (
	clk : IN std_logic;
	resetN : IN std_logic;
	enable : IN std_logic;
	score_in : IN std_logic_vector(3 DOWNTO 0);
	scored : IN std_logic;
	score_out : OUT std_logic_vector(16 DOWNTO 0)
	);
END score_up_counter;

-- Design Ports Information
-- score_out[0]	=>  Location: PIN_AF29,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- score_out[1]	=>  Location: PIN_AA24,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- score_out[2]	=>  Location: PIN_AG28,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- score_out[3]	=>  Location: PIN_AA28,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- score_out[4]	=>  Location: PIN_V23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- score_out[5]	=>  Location: PIN_Y23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- score_out[6]	=>  Location: PIN_AE27,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- score_out[7]	=>  Location: PIN_AC27,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- score_out[8]	=>  Location: PIN_AH30,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- score_out[9]	=>  Location: PIN_AF30,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- score_out[10]	=>  Location: PIN_AG30,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- score_out[11]	=>  Location: PIN_Y24,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- score_out[12]	=>  Location: PIN_W24,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- score_out[13]	=>  Location: PIN_AB25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- score_out[14]	=>  Location: PIN_AB26,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- score_out[15]	=>  Location: PIN_AE28,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- score_out[16]	=>  Location: PIN_AF28,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clk	=>  Location: PIN_Y27,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- resetN	=>  Location: PIN_W25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- enable	=>  Location: PIN_AC28,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- scored	=>  Location: PIN_AB30,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- score_in[0]	=>  Location: PIN_V25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- score_in[1]	=>  Location: PIN_AC29,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- score_in[2]	=>  Location: PIN_AA30,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- score_in[3]	=>  Location: PIN_AD26,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF score_up_counter IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_clk : std_logic;
SIGNAL ww_resetN : std_logic;
SIGNAL ww_enable : std_logic;
SIGNAL ww_score_in : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_scored : std_logic;
SIGNAL ww_score_out : std_logic_vector(16 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \clk~input_o\ : std_logic;
SIGNAL \clk~inputCLKENA0_outclk\ : std_logic;
SIGNAL \score_in[0]~input_o\ : std_logic;
SIGNAL \Add0~1_sumout\ : std_logic;
SIGNAL \resetN~input_o\ : std_logic;
SIGNAL \enable~input_o\ : std_logic;
SIGNAL \scored~input_o\ : std_logic;
SIGNAL \score_keeper[0]~0_combout\ : std_logic;
SIGNAL \score_in[1]~input_o\ : std_logic;
SIGNAL \Add0~2\ : std_logic;
SIGNAL \Add0~5_sumout\ : std_logic;
SIGNAL \score_in[2]~input_o\ : std_logic;
SIGNAL \Add0~6\ : std_logic;
SIGNAL \Add0~9_sumout\ : std_logic;
SIGNAL \score_in[3]~input_o\ : std_logic;
SIGNAL \Add0~10\ : std_logic;
SIGNAL \Add0~13_sumout\ : std_logic;
SIGNAL \Add0~14\ : std_logic;
SIGNAL \Add0~17_sumout\ : std_logic;
SIGNAL \Add0~18\ : std_logic;
SIGNAL \Add0~21_sumout\ : std_logic;
SIGNAL \Add0~22\ : std_logic;
SIGNAL \Add0~25_sumout\ : std_logic;
SIGNAL \Add0~26\ : std_logic;
SIGNAL \Add0~29_sumout\ : std_logic;
SIGNAL \Add0~30\ : std_logic;
SIGNAL \Add0~33_sumout\ : std_logic;
SIGNAL \Add0~34\ : std_logic;
SIGNAL \Add0~37_sumout\ : std_logic;
SIGNAL \Add0~38\ : std_logic;
SIGNAL \Add0~41_sumout\ : std_logic;
SIGNAL \Add0~42\ : std_logic;
SIGNAL \Add0~45_sumout\ : std_logic;
SIGNAL \Add0~46\ : std_logic;
SIGNAL \Add0~49_sumout\ : std_logic;
SIGNAL \Add0~50\ : std_logic;
SIGNAL \Add0~53_sumout\ : std_logic;
SIGNAL \Add0~54\ : std_logic;
SIGNAL \Add0~57_sumout\ : std_logic;
SIGNAL \Add0~58\ : std_logic;
SIGNAL \Add0~61_sumout\ : std_logic;
SIGNAL \Add0~62\ : std_logic;
SIGNAL \Add0~65_sumout\ : std_logic;
SIGNAL score_keeper : std_logic_vector(16 DOWNTO 0);
SIGNAL \ALT_INV_score_in[3]~input_o\ : std_logic;
SIGNAL \ALT_INV_score_in[2]~input_o\ : std_logic;
SIGNAL \ALT_INV_score_in[1]~input_o\ : std_logic;
SIGNAL \ALT_INV_score_in[0]~input_o\ : std_logic;
SIGNAL \ALT_INV_scored~input_o\ : std_logic;
SIGNAL \ALT_INV_enable~input_o\ : std_logic;
SIGNAL ALT_INV_score_keeper : std_logic_vector(16 DOWNTO 0);

BEGIN

ww_clk <= clk;
ww_resetN <= resetN;
ww_enable <= enable;
ww_score_in <= score_in;
ww_scored <= scored;
score_out <= ww_score_out;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
\ALT_INV_score_in[3]~input_o\ <= NOT \score_in[3]~input_o\;
\ALT_INV_score_in[2]~input_o\ <= NOT \score_in[2]~input_o\;
\ALT_INV_score_in[1]~input_o\ <= NOT \score_in[1]~input_o\;
\ALT_INV_score_in[0]~input_o\ <= NOT \score_in[0]~input_o\;
\ALT_INV_scored~input_o\ <= NOT \scored~input_o\;
\ALT_INV_enable~input_o\ <= NOT \enable~input_o\;
ALT_INV_score_keeper(16) <= NOT score_keeper(16);
ALT_INV_score_keeper(15) <= NOT score_keeper(15);
ALT_INV_score_keeper(14) <= NOT score_keeper(14);
ALT_INV_score_keeper(13) <= NOT score_keeper(13);
ALT_INV_score_keeper(12) <= NOT score_keeper(12);
ALT_INV_score_keeper(11) <= NOT score_keeper(11);
ALT_INV_score_keeper(10) <= NOT score_keeper(10);
ALT_INV_score_keeper(9) <= NOT score_keeper(9);
ALT_INV_score_keeper(8) <= NOT score_keeper(8);
ALT_INV_score_keeper(7) <= NOT score_keeper(7);
ALT_INV_score_keeper(6) <= NOT score_keeper(6);
ALT_INV_score_keeper(5) <= NOT score_keeper(5);
ALT_INV_score_keeper(4) <= NOT score_keeper(4);
ALT_INV_score_keeper(3) <= NOT score_keeper(3);
ALT_INV_score_keeper(2) <= NOT score_keeper(2);
ALT_INV_score_keeper(1) <= NOT score_keeper(1);
ALT_INV_score_keeper(0) <= NOT score_keeper(0);

-- Location: IOOBUF_X89_Y15_N39
\score_out[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => score_keeper(0),
	devoe => ww_devoe,
	o => ww_score_out(0));

-- Location: IOOBUF_X89_Y11_N45
\score_out[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => score_keeper(1),
	devoe => ww_devoe,
	o => ww_score_out(1));

-- Location: IOOBUF_X89_Y13_N39
\score_out[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => score_keeper(2),
	devoe => ww_devoe,
	o => ww_score_out(2));

-- Location: IOOBUF_X89_Y21_N56
\score_out[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => score_keeper(3),
	devoe => ww_devoe,
	o => ww_score_out(3));

-- Location: IOOBUF_X89_Y15_N5
\score_out[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => score_keeper(4),
	devoe => ww_devoe,
	o => ww_score_out(4));

-- Location: IOOBUF_X89_Y13_N5
\score_out[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => score_keeper(5),
	devoe => ww_devoe,
	o => ww_score_out(5));

-- Location: IOOBUF_X89_Y11_N79
\score_out[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => score_keeper(6),
	devoe => ww_devoe,
	o => ww_score_out(6));

-- Location: IOOBUF_X89_Y16_N22
\score_out[7]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => score_keeper(7),
	devoe => ww_devoe,
	o => ww_score_out(7));

-- Location: IOOBUF_X89_Y16_N39
\score_out[8]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => score_keeper(8),
	devoe => ww_devoe,
	o => ww_score_out(8));

-- Location: IOOBUF_X89_Y15_N56
\score_out[9]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => score_keeper(9),
	devoe => ww_devoe,
	o => ww_score_out(9));

-- Location: IOOBUF_X89_Y16_N56
\score_out[10]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => score_keeper(10),
	devoe => ww_devoe,
	o => ww_score_out(10));

-- Location: IOOBUF_X89_Y13_N22
\score_out[11]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => score_keeper(11),
	devoe => ww_devoe,
	o => ww_score_out(11));

-- Location: IOOBUF_X89_Y15_N22
\score_out[12]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => score_keeper(12),
	devoe => ww_devoe,
	o => ww_score_out(12));

-- Location: IOOBUF_X89_Y11_N62
\score_out[13]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => score_keeper(13),
	devoe => ww_devoe,
	o => ww_score_out(13));

-- Location: IOOBUF_X89_Y9_N56
\score_out[14]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => score_keeper(14),
	devoe => ww_devoe,
	o => ww_score_out(14));

-- Location: IOOBUF_X89_Y11_N96
\score_out[15]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => score_keeper(15),
	devoe => ww_devoe,
	o => ww_score_out(15));

-- Location: IOOBUF_X89_Y13_N56
\score_out[16]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => score_keeper(16),
	devoe => ww_devoe,
	o => ww_score_out(16));

-- Location: IOIBUF_X89_Y25_N21
\clk~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clk,
	o => \clk~input_o\);

-- Location: CLKCTRL_G10
\clk~inputCLKENA0\ : cyclonev_clkena
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	disable_mode => "low",
	ena_register_mode => "always enabled",
	ena_register_power_up => "high",
	test_syn => "high")
-- pragma translate_on
PORT MAP (
	inclk => \clk~input_o\,
	outclk => \clk~inputCLKENA0_outclk\);

-- Location: IOIBUF_X89_Y20_N61
\score_in[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_score_in(0),
	o => \score_in[0]~input_o\);

-- Location: LABCELL_X88_Y15_N0
\Add0~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~1_sumout\ = SUM(( score_keeper(0) ) + ( \score_in[0]~input_o\ ) + ( !VCC ))
-- \Add0~2\ = CARRY(( score_keeper(0) ) + ( \score_in[0]~input_o\ ) + ( !VCC ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000110011001100110000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_score_in[0]~input_o\,
	datad => ALT_INV_score_keeper(0),
	cin => GND,
	sumout => \Add0~1_sumout\,
	cout => \Add0~2\);

-- Location: IOIBUF_X89_Y20_N44
\resetN~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_resetN,
	o => \resetN~input_o\);

-- Location: IOIBUF_X89_Y20_N78
\enable~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_enable,
	o => \enable~input_o\);

-- Location: IOIBUF_X89_Y21_N4
\scored~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_scored,
	o => \scored~input_o\);

-- Location: LABCELL_X88_Y15_N54
\score_keeper[0]~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \score_keeper[0]~0_combout\ = ( \enable~input_o\ & ( \scored~input_o\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000001111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datae => \ALT_INV_enable~input_o\,
	dataf => \ALT_INV_scored~input_o\,
	combout => \score_keeper[0]~0_combout\);

-- Location: FF_X88_Y15_N2
\score_keeper[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add0~1_sumout\,
	clrn => \resetN~input_o\,
	ena => \score_keeper[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => score_keeper(0));

-- Location: IOIBUF_X89_Y20_N95
\score_in[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_score_in(1),
	o => \score_in[1]~input_o\);

-- Location: LABCELL_X88_Y15_N3
\Add0~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~5_sumout\ = SUM(( score_keeper(1) ) + ( \score_in[1]~input_o\ ) + ( \Add0~2\ ))
-- \Add0~6\ = CARRY(( score_keeper(1) ) + ( \score_in[1]~input_o\ ) + ( \Add0~2\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101010101000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_score_in[1]~input_o\,
	datad => ALT_INV_score_keeper(1),
	cin => \Add0~2\,
	sumout => \Add0~5_sumout\,
	cout => \Add0~6\);

-- Location: FF_X88_Y15_N5
\score_keeper[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add0~5_sumout\,
	clrn => \resetN~input_o\,
	ena => \score_keeper[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => score_keeper(1));

-- Location: IOIBUF_X89_Y21_N21
\score_in[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_score_in(2),
	o => \score_in[2]~input_o\);

-- Location: LABCELL_X88_Y15_N6
\Add0~9\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~9_sumout\ = SUM(( \score_in[2]~input_o\ ) + ( score_keeper(2) ) + ( \Add0~6\ ))
-- \Add0~10\ = CARRY(( \score_in[2]~input_o\ ) + ( score_keeper(2) ) + ( \Add0~6\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000110011001100110000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_score_keeper(2),
	datad => \ALT_INV_score_in[2]~input_o\,
	cin => \Add0~6\,
	sumout => \Add0~9_sumout\,
	cout => \Add0~10\);

-- Location: FF_X88_Y15_N8
\score_keeper[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add0~9_sumout\,
	clrn => \resetN~input_o\,
	ena => \score_keeper[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => score_keeper(2));

-- Location: IOIBUF_X89_Y16_N4
\score_in[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_score_in(3),
	o => \score_in[3]~input_o\);

-- Location: LABCELL_X88_Y15_N9
\Add0~13\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~13_sumout\ = SUM(( \score_in[3]~input_o\ ) + ( score_keeper(3) ) + ( \Add0~10\ ))
-- \Add0~14\ = CARRY(( \score_in[3]~input_o\ ) + ( score_keeper(3) ) + ( \Add0~10\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111100001111000000000000000000000101010101010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_score_in[3]~input_o\,
	datac => ALT_INV_score_keeper(3),
	cin => \Add0~10\,
	sumout => \Add0~13_sumout\,
	cout => \Add0~14\);

-- Location: FF_X88_Y15_N11
\score_keeper[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add0~13_sumout\,
	clrn => \resetN~input_o\,
	ena => \score_keeper[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => score_keeper(3));

-- Location: LABCELL_X88_Y15_N12
\Add0~17\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~17_sumout\ = SUM(( score_keeper(4) ) + ( GND ) + ( \Add0~14\ ))
-- \Add0~18\ = CARRY(( score_keeper(4) ) + ( GND ) + ( \Add0~14\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_score_keeper(4),
	cin => \Add0~14\,
	sumout => \Add0~17_sumout\,
	cout => \Add0~18\);

-- Location: FF_X88_Y15_N14
\score_keeper[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add0~17_sumout\,
	clrn => \resetN~input_o\,
	ena => \score_keeper[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => score_keeper(4));

-- Location: LABCELL_X88_Y15_N15
\Add0~21\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~21_sumout\ = SUM(( score_keeper(5) ) + ( GND ) + ( \Add0~18\ ))
-- \Add0~22\ = CARRY(( score_keeper(5) ) + ( GND ) + ( \Add0~18\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_score_keeper(5),
	cin => \Add0~18\,
	sumout => \Add0~21_sumout\,
	cout => \Add0~22\);

-- Location: FF_X88_Y15_N17
\score_keeper[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add0~21_sumout\,
	clrn => \resetN~input_o\,
	ena => \score_keeper[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => score_keeper(5));

-- Location: LABCELL_X88_Y15_N18
\Add0~25\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~25_sumout\ = SUM(( score_keeper(6) ) + ( GND ) + ( \Add0~22\ ))
-- \Add0~26\ = CARRY(( score_keeper(6) ) + ( GND ) + ( \Add0~22\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_score_keeper(6),
	cin => \Add0~22\,
	sumout => \Add0~25_sumout\,
	cout => \Add0~26\);

-- Location: FF_X88_Y15_N20
\score_keeper[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add0~25_sumout\,
	clrn => \resetN~input_o\,
	ena => \score_keeper[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => score_keeper(6));

-- Location: LABCELL_X88_Y15_N21
\Add0~29\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~29_sumout\ = SUM(( score_keeper(7) ) + ( GND ) + ( \Add0~26\ ))
-- \Add0~30\ = CARRY(( score_keeper(7) ) + ( GND ) + ( \Add0~26\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_score_keeper(7),
	cin => \Add0~26\,
	sumout => \Add0~29_sumout\,
	cout => \Add0~30\);

-- Location: FF_X88_Y15_N23
\score_keeper[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add0~29_sumout\,
	clrn => \resetN~input_o\,
	ena => \score_keeper[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => score_keeper(7));

-- Location: LABCELL_X88_Y15_N24
\Add0~33\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~33_sumout\ = SUM(( score_keeper(8) ) + ( GND ) + ( \Add0~30\ ))
-- \Add0~34\ = CARRY(( score_keeper(8) ) + ( GND ) + ( \Add0~30\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_score_keeper(8),
	cin => \Add0~30\,
	sumout => \Add0~33_sumout\,
	cout => \Add0~34\);

-- Location: FF_X88_Y15_N26
\score_keeper[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add0~33_sumout\,
	clrn => \resetN~input_o\,
	ena => \score_keeper[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => score_keeper(8));

-- Location: LABCELL_X88_Y15_N27
\Add0~37\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~37_sumout\ = SUM(( score_keeper(9) ) + ( GND ) + ( \Add0~34\ ))
-- \Add0~38\ = CARRY(( score_keeper(9) ) + ( GND ) + ( \Add0~34\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_score_keeper(9),
	cin => \Add0~34\,
	sumout => \Add0~37_sumout\,
	cout => \Add0~38\);

-- Location: FF_X88_Y15_N29
\score_keeper[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add0~37_sumout\,
	clrn => \resetN~input_o\,
	ena => \score_keeper[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => score_keeper(9));

-- Location: LABCELL_X88_Y15_N30
\Add0~41\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~41_sumout\ = SUM(( score_keeper(10) ) + ( GND ) + ( \Add0~38\ ))
-- \Add0~42\ = CARRY(( score_keeper(10) ) + ( GND ) + ( \Add0~38\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_score_keeper(10),
	cin => \Add0~38\,
	sumout => \Add0~41_sumout\,
	cout => \Add0~42\);

-- Location: FF_X88_Y15_N32
\score_keeper[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add0~41_sumout\,
	clrn => \resetN~input_o\,
	ena => \score_keeper[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => score_keeper(10));

-- Location: LABCELL_X88_Y15_N33
\Add0~45\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~45_sumout\ = SUM(( score_keeper(11) ) + ( GND ) + ( \Add0~42\ ))
-- \Add0~46\ = CARRY(( score_keeper(11) ) + ( GND ) + ( \Add0~42\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000101010101010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_score_keeper(11),
	cin => \Add0~42\,
	sumout => \Add0~45_sumout\,
	cout => \Add0~46\);

-- Location: FF_X88_Y15_N35
\score_keeper[11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add0~45_sumout\,
	clrn => \resetN~input_o\,
	ena => \score_keeper[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => score_keeper(11));

-- Location: LABCELL_X88_Y15_N36
\Add0~49\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~49_sumout\ = SUM(( score_keeper(12) ) + ( GND ) + ( \Add0~46\ ))
-- \Add0~50\ = CARRY(( score_keeper(12) ) + ( GND ) + ( \Add0~46\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_score_keeper(12),
	cin => \Add0~46\,
	sumout => \Add0~49_sumout\,
	cout => \Add0~50\);

-- Location: FF_X88_Y15_N38
\score_keeper[12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add0~49_sumout\,
	clrn => \resetN~input_o\,
	ena => \score_keeper[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => score_keeper(12));

-- Location: LABCELL_X88_Y15_N39
\Add0~53\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~53_sumout\ = SUM(( score_keeper(13) ) + ( GND ) + ( \Add0~50\ ))
-- \Add0~54\ = CARRY(( score_keeper(13) ) + ( GND ) + ( \Add0~50\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_score_keeper(13),
	cin => \Add0~50\,
	sumout => \Add0~53_sumout\,
	cout => \Add0~54\);

-- Location: FF_X88_Y15_N41
\score_keeper[13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add0~53_sumout\,
	clrn => \resetN~input_o\,
	ena => \score_keeper[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => score_keeper(13));

-- Location: LABCELL_X88_Y15_N42
\Add0~57\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~57_sumout\ = SUM(( score_keeper(14) ) + ( GND ) + ( \Add0~54\ ))
-- \Add0~58\ = CARRY(( score_keeper(14) ) + ( GND ) + ( \Add0~54\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_score_keeper(14),
	cin => \Add0~54\,
	sumout => \Add0~57_sumout\,
	cout => \Add0~58\);

-- Location: FF_X88_Y15_N44
\score_keeper[14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add0~57_sumout\,
	clrn => \resetN~input_o\,
	ena => \score_keeper[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => score_keeper(14));

-- Location: LABCELL_X88_Y15_N45
\Add0~61\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~61_sumout\ = SUM(( score_keeper(15) ) + ( GND ) + ( \Add0~58\ ))
-- \Add0~62\ = CARRY(( score_keeper(15) ) + ( GND ) + ( \Add0~58\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_score_keeper(15),
	cin => \Add0~58\,
	sumout => \Add0~61_sumout\,
	cout => \Add0~62\);

-- Location: FF_X88_Y15_N47
\score_keeper[15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add0~61_sumout\,
	clrn => \resetN~input_o\,
	ena => \score_keeper[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => score_keeper(15));

-- Location: LABCELL_X88_Y15_N48
\Add0~65\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~65_sumout\ = SUM(( score_keeper(16) ) + ( GND ) + ( \Add0~62\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_score_keeper(16),
	cin => \Add0~62\,
	sumout => \Add0~65_sumout\);

-- Location: FF_X88_Y15_N50
\score_keeper[16]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add0~65_sumout\,
	clrn => \resetN~input_o\,
	ena => \score_keeper[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => score_keeper(16));

-- Location: LABCELL_X7_Y7_N3
\~QUARTUS_CREATED_GND~I\ : cyclonev_lcell_comb
-- Equation(s):

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
;
END structure;


