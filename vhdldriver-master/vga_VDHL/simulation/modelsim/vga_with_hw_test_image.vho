-- Copyright (C) 1991-2014 Altera Corporation. All rights reserved.
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, the Altera Quartus II License Agreement,
-- the Altera MegaCore Function License Agreement, or other 
-- applicable license agreement, including, without limitation, 
-- that your use is for the sole purpose of programming logic 
-- devices manufactured by Altera and sold by Altera or its 
-- authorized distributors.  Please refer to the applicable 
-- agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus II 64-Bit"
-- VERSION "Version 14.0.0 Build 200 06/17/2014 SJ Web Edition"

-- DATE "12/06/2017 13:41:59"

-- 
-- Device: Altera EP4CE115F29C7 Package FBGA780
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY CYCLONEIVE;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE CYCLONEIVE.CYCLONEIVE_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	vga_with_hw_test_image IS
    PORT (
	pixel_clk : OUT std_logic;
	clk : IN std_logic;
	h_sync : OUT std_logic;
	v_sync : OUT std_logic;
	n_blank : OUT std_logic;
	n_sync : OUT std_logic;
	blue : OUT std_logic_vector(7 DOWNTO 0);
	P1Left : IN std_logic;
	p1Right : IN std_logic;
	p1reset : IN std_logic;
	green : OUT std_logic_vector(7 DOWNTO 0);
	red : OUT std_logic_vector(7 DOWNTO 0)
	);
END vga_with_hw_test_image;

-- Design Ports Information
-- pixel_clk	=>  Location: PIN_A12,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- h_sync	=>  Location: PIN_G13,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- v_sync	=>  Location: PIN_C13,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- n_blank	=>  Location: PIN_F11,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- n_sync	=>  Location: PIN_C10,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- blue[7]	=>  Location: PIN_D12,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- blue[6]	=>  Location: PIN_D11,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- blue[5]	=>  Location: PIN_C12,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- blue[4]	=>  Location: PIN_A11,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- blue[3]	=>  Location: PIN_B11,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- blue[2]	=>  Location: PIN_C11,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- blue[1]	=>  Location: PIN_A10,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- blue[0]	=>  Location: PIN_B10,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- p1reset	=>  Location: PIN_Y23,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- green[7]	=>  Location: PIN_C9,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- green[6]	=>  Location: PIN_F10,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- green[5]	=>  Location: PIN_B8,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- green[4]	=>  Location: PIN_C8,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- green[3]	=>  Location: PIN_H12,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- green[2]	=>  Location: PIN_F8,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- green[1]	=>  Location: PIN_G11,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- green[0]	=>  Location: PIN_G8,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- red[7]	=>  Location: PIN_H10,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- red[6]	=>  Location: PIN_H8,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- red[5]	=>  Location: PIN_J12,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- red[4]	=>  Location: PIN_G10,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- red[3]	=>  Location: PIN_F12,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- red[2]	=>  Location: PIN_D10,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- red[1]	=>  Location: PIN_E11,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- red[0]	=>  Location: PIN_E12,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- clk	=>  Location: PIN_Y2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- P1Left	=>  Location: PIN_AC28,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- p1Right	=>  Location: PIN_AB28,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default


ARCHITECTURE structure OF vga_with_hw_test_image IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_pixel_clk : std_logic;
SIGNAL ww_clk : std_logic;
SIGNAL ww_h_sync : std_logic;
SIGNAL ww_v_sync : std_logic;
SIGNAL ww_n_blank : std_logic;
SIGNAL ww_n_sync : std_logic;
SIGNAL ww_blue : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_P1Left : std_logic;
SIGNAL ww_p1Right : std_logic;
SIGNAL ww_p1reset : std_logic;
SIGNAL ww_green : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_red : std_logic_vector(7 DOWNTO 0);
SIGNAL \inst2|altpll_component|auto_generated|pll1_INCLK_bus\ : std_logic_vector(1 DOWNTO 0);
SIGNAL \inst2|altpll_component|auto_generated|pll1_CLK_bus\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \inst8|CLK_1HZ~clkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \p1reset~input_o\ : std_logic;
SIGNAL \clk~input_o\ : std_logic;
SIGNAL \inst2|altpll_component|auto_generated|wire_pll1_fbout\ : std_logic;
SIGNAL \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\ : std_logic;
SIGNAL \inst1|Add0~0_combout\ : std_logic;
SIGNAL \inst1|h_count~8_combout\ : std_logic;
SIGNAL \inst1|Add0~1\ : std_logic;
SIGNAL \inst1|Add0~3\ : std_logic;
SIGNAL \inst1|Add0~4_combout\ : std_logic;
SIGNAL \inst1|h_count~1_combout\ : std_logic;
SIGNAL \inst1|Add0~5\ : std_logic;
SIGNAL \inst1|Add0~6_combout\ : std_logic;
SIGNAL \inst1|h_count~0_combout\ : std_logic;
SIGNAL \inst1|Add0~7\ : std_logic;
SIGNAL \inst1|Add0~8_combout\ : std_logic;
SIGNAL \inst1|h_count~6_combout\ : std_logic;
SIGNAL \inst1|Add0~9\ : std_logic;
SIGNAL \inst1|Add0~10_combout\ : std_logic;
SIGNAL \inst1|h_count~5_combout\ : std_logic;
SIGNAL \inst1|Add0~11\ : std_logic;
SIGNAL \inst1|Add0~12_combout\ : std_logic;
SIGNAL \inst1|h_count~4_combout\ : std_logic;
SIGNAL \inst1|Add0~13\ : std_logic;
SIGNAL \inst1|Add0~14_combout\ : std_logic;
SIGNAL \inst1|h_count~3_combout\ : std_logic;
SIGNAL \inst1|Add0~15\ : std_logic;
SIGNAL \inst1|Add0~16_combout\ : std_logic;
SIGNAL \inst1|h_count~10_combout\ : std_logic;
SIGNAL \inst1|Add0~17\ : std_logic;
SIGNAL \inst1|Add0~18_combout\ : std_logic;
SIGNAL \inst1|h_count~9_combout\ : std_logic;
SIGNAL \inst1|process_0~4_combout\ : std_logic;
SIGNAL \inst1|Add0~19\ : std_logic;
SIGNAL \inst1|Add0~20_combout\ : std_logic;
SIGNAL \inst1|h_count~2_combout\ : std_logic;
SIGNAL \inst1|process_0~2_combout\ : std_logic;
SIGNAL \inst1|process_0~3_combout\ : std_logic;
SIGNAL \inst1|process_0~5_combout\ : std_logic;
SIGNAL \inst1|h_count~7_combout\ : std_logic;
SIGNAL \inst1|Add0~2_combout\ : std_logic;
SIGNAL \inst1|process_0~6_combout\ : std_logic;
SIGNAL \inst1|process_0~0_combout\ : std_logic;
SIGNAL \inst1|process_0~1_combout\ : std_logic;
SIGNAL \inst1|process_0~7_combout\ : std_logic;
SIGNAL \inst1|h_sync~q\ : std_logic;
SIGNAL \inst1|Add1~1_combout\ : std_logic;
SIGNAL \inst1|Add1~30_combout\ : std_logic;
SIGNAL \inst1|Add1~2\ : std_logic;
SIGNAL \inst1|Add1~3_combout\ : std_logic;
SIGNAL \inst1|Add1~31_combout\ : std_logic;
SIGNAL \inst1|Add1~4\ : std_logic;
SIGNAL \inst1|Add1~5_combout\ : std_logic;
SIGNAL \inst1|Add1~29_combout\ : std_logic;
SIGNAL \inst1|Add1~6\ : std_logic;
SIGNAL \inst1|Add1~7_combout\ : std_logic;
SIGNAL \inst1|Add1~28_combout\ : std_logic;
SIGNAL \inst1|Add1~8\ : std_logic;
SIGNAL \inst1|Add1~9_combout\ : std_logic;
SIGNAL \inst1|Add1~25_combout\ : std_logic;
SIGNAL \inst1|LessThan1~0_combout\ : std_logic;
SIGNAL \inst1|Add1~10\ : std_logic;
SIGNAL \inst1|Add1~11_combout\ : std_logic;
SIGNAL \inst1|Add1~26_combout\ : std_logic;
SIGNAL \inst1|LessThan1~1_combout\ : std_logic;
SIGNAL \inst1|Add1~12\ : std_logic;
SIGNAL \inst1|Add1~13_combout\ : std_logic;
SIGNAL \inst1|Add1~27_combout\ : std_logic;
SIGNAL \inst1|Add1~14\ : std_logic;
SIGNAL \inst1|Add1~15_combout\ : std_logic;
SIGNAL \inst1|Add1~33_combout\ : std_logic;
SIGNAL \inst1|Add1~16\ : std_logic;
SIGNAL \inst1|Add1~17_combout\ : std_logic;
SIGNAL \inst1|Add1~32_combout\ : std_logic;
SIGNAL \inst1|Add1~18\ : std_logic;
SIGNAL \inst1|Add1~20\ : std_logic;
SIGNAL \inst1|Add1~22_combout\ : std_logic;
SIGNAL \inst1|Add1~24_combout\ : std_logic;
SIGNAL \inst1|LessThan1~2_combout\ : std_logic;
SIGNAL \inst1|Add1~0_combout\ : std_logic;
SIGNAL \inst1|Add1~19_combout\ : std_logic;
SIGNAL \inst1|Add1~21_combout\ : std_logic;
SIGNAL \inst1|process_0~8_combout\ : std_logic;
SIGNAL \inst1|process_0~9_combout\ : std_logic;
SIGNAL \inst1|process_0~10_combout\ : std_logic;
SIGNAL \inst1|process_0~11_combout\ : std_logic;
SIGNAL \inst1|v_sync~q\ : std_logic;
SIGNAL \inst1|process_0~12_combout\ : std_logic;
SIGNAL \inst1|disp_ena~q\ : std_logic;
SIGNAL \inst1|LessThan2~0_combout\ : std_logic;
SIGNAL \inst|LessThan35~3_combout\ : std_logic;
SIGNAL \inst1|column[31]~feeder_combout\ : std_logic;
SIGNAL \inst9|a[0]~feeder_combout\ : std_logic;
SIGNAL \inst|LessThan35~4_combout\ : std_logic;
SIGNAL \inst|LessThan34~1_combout\ : std_logic;
SIGNAL \inst|LessThan34~2_combout\ : std_logic;
SIGNAL \inst|LessThan34~3_combout\ : std_logic;
SIGNAL \inst8|counter[0]~25_combout\ : std_logic;
SIGNAL \inst8|counter[0]~26\ : std_logic;
SIGNAL \inst8|counter[1]~27_combout\ : std_logic;
SIGNAL \inst8|counter[1]~28\ : std_logic;
SIGNAL \inst8|counter[2]~29_combout\ : std_logic;
SIGNAL \inst8|counter[2]~30\ : std_logic;
SIGNAL \inst8|counter[3]~31_combout\ : std_logic;
SIGNAL \inst8|counter[3]~32\ : std_logic;
SIGNAL \inst8|counter[4]~33_combout\ : std_logic;
SIGNAL \inst8|counter[4]~34\ : std_logic;
SIGNAL \inst8|counter[5]~35_combout\ : std_logic;
SIGNAL \inst8|counter[5]~36\ : std_logic;
SIGNAL \inst8|counter[6]~37_combout\ : std_logic;
SIGNAL \inst8|counter[6]~38\ : std_logic;
SIGNAL \inst8|counter[7]~39_combout\ : std_logic;
SIGNAL \inst8|counter[7]~40\ : std_logic;
SIGNAL \inst8|counter[8]~41_combout\ : std_logic;
SIGNAL \inst8|counter[8]~42\ : std_logic;
SIGNAL \inst8|counter[9]~43_combout\ : std_logic;
SIGNAL \inst8|counter[9]~44\ : std_logic;
SIGNAL \inst8|counter[10]~45_combout\ : std_logic;
SIGNAL \inst8|counter[10]~46\ : std_logic;
SIGNAL \inst8|counter[11]~47_combout\ : std_logic;
SIGNAL \inst8|counter[11]~48\ : std_logic;
SIGNAL \inst8|counter[12]~49_combout\ : std_logic;
SIGNAL \inst8|counter[12]~50\ : std_logic;
SIGNAL \inst8|counter[13]~51_combout\ : std_logic;
SIGNAL \inst8|counter[13]~52\ : std_logic;
SIGNAL \inst8|counter[14]~53_combout\ : std_logic;
SIGNAL \inst8|counter[14]~54\ : std_logic;
SIGNAL \inst8|counter[15]~55_combout\ : std_logic;
SIGNAL \inst8|counter[15]~56\ : std_logic;
SIGNAL \inst8|counter[16]~57_combout\ : std_logic;
SIGNAL \inst8|counter[16]~58\ : std_logic;
SIGNAL \inst8|counter[17]~59_combout\ : std_logic;
SIGNAL \inst8|counter[17]~60\ : std_logic;
SIGNAL \inst8|counter[18]~61_combout\ : std_logic;
SIGNAL \inst8|counter[18]~62\ : std_logic;
SIGNAL \inst8|counter[19]~63_combout\ : std_logic;
SIGNAL \inst8|counter[19]~64\ : std_logic;
SIGNAL \inst8|counter[20]~65_combout\ : std_logic;
SIGNAL \inst8|counter[20]~66\ : std_logic;
SIGNAL \inst8|counter[21]~67_combout\ : std_logic;
SIGNAL \inst8|counter[21]~68\ : std_logic;
SIGNAL \inst8|counter[22]~69_combout\ : std_logic;
SIGNAL \inst8|counter[22]~70\ : std_logic;
SIGNAL \inst8|counter[23]~71_combout\ : std_logic;
SIGNAL \inst8|counter[23]~72\ : std_logic;
SIGNAL \inst8|counter[24]~73_combout\ : std_logic;
SIGNAL \inst8|LessThan0~3_combout\ : std_logic;
SIGNAL \inst8|LessThan0~1_combout\ : std_logic;
SIGNAL \inst8|LessThan0~0_combout\ : std_logic;
SIGNAL \inst8|LessThan0~2_combout\ : std_logic;
SIGNAL \inst8|LessThan0~4_combout\ : std_logic;
SIGNAL \inst8|LessThan0~5_combout\ : std_logic;
SIGNAL \inst8|CLK_1HZ~0_combout\ : std_logic;
SIGNAL \inst8|CLK_1HZ~q\ : std_logic;
SIGNAL \inst8|CLK_1HZ~clkctrl_outclk\ : std_logic;
SIGNAL \p1Right~input_o\ : std_logic;
SIGNAL \P1Left~input_o\ : std_logic;
SIGNAL \inst7|Selector5~0_combout\ : std_logic;
SIGNAL \inst7|Selector4~0_combout\ : std_logic;
SIGNAL \inst7|Selector3~0_combout\ : std_logic;
SIGNAL \inst7|Selector0~0_combout\ : std_logic;
SIGNAL \inst7|State.As~q\ : std_logic;
SIGNAL \inst7|Selector1~0_combout\ : std_logic;
SIGNAL \inst7|Selector1~1_combout\ : std_logic;
SIGNAL \inst7|State.Bs~q\ : std_logic;
SIGNAL \inst7|Selector2~0_combout\ : std_logic;
SIGNAL \inst7|Selector2~1_combout\ : std_logic;
SIGNAL \inst7|State.Cs~q\ : std_logic;
SIGNAL \inst7|Selector3~1_combout\ : std_logic;
SIGNAL \inst7|State.Ds~q\ : std_logic;
SIGNAL \inst7|Selector4~1_combout\ : std_logic;
SIGNAL \inst7|State.Es~q\ : std_logic;
SIGNAL \inst7|Selector5~1_combout\ : std_logic;
SIGNAL \inst7|State.Fs~q\ : std_logic;
SIGNAL \inst7|Selector6~0_combout\ : std_logic;
SIGNAL \inst7|Selector6~1_combout\ : std_logic;
SIGNAL \inst7|State.Gs~q\ : std_logic;
SIGNAL \inst7|Selector7~0_combout\ : std_logic;
SIGNAL \inst7|Selector7~1_combout\ : std_logic;
SIGNAL \inst7|State.Hs~q\ : std_logic;
SIGNAL \inst7|Selector8~0_combout\ : std_logic;
SIGNAL \inst7|State.Ist~q\ : std_logic;
SIGNAL \inst7|i~q\ : std_logic;
SIGNAL \inst1|column[0]~0_combout\ : std_logic;
SIGNAL \inst|LessThan34~0_combout\ : std_logic;
SIGNAL \inst|LessThan34~4_combout\ : std_logic;
SIGNAL \inst|LessThan11~0_combout\ : std_logic;
SIGNAL \inst|LessThan34~5_combout\ : std_logic;
SIGNAL \inst|process_0~8_combout\ : std_logic;
SIGNAL \inst|LessThan35~0_combout\ : std_logic;
SIGNAL \inst|LessThan3~0_combout\ : std_logic;
SIGNAL \inst|LessThan35~1_combout\ : std_logic;
SIGNAL \inst|LessThan35~2_combout\ : std_logic;
SIGNAL \inst|LessThan36~0_combout\ : std_logic;
SIGNAL \inst1|row[0]~0_combout\ : std_logic;
SIGNAL \inst1|row[31]~feeder_combout\ : std_logic;
SIGNAL \inst|process_0~24_combout\ : std_logic;
SIGNAL \inst|LessThan1~0_combout\ : std_logic;
SIGNAL \inst|LessThan1~1_combout\ : std_logic;
SIGNAL \inst|LessThan0~0_combout\ : std_logic;
SIGNAL \inst|LessThan0~1_combout\ : std_logic;
SIGNAL \inst|process_0~2_combout\ : std_logic;
SIGNAL \inst|process_0~3_combout\ : std_logic;
SIGNAL \inst|process_0~4_combout\ : std_logic;
SIGNAL \inst|process_0~5_combout\ : std_logic;
SIGNAL \inst|process_0~9_combout\ : std_logic;
SIGNAL \inst|LessThan26~0_combout\ : std_logic;
SIGNAL \inst|LessThan26~2_combout\ : std_logic;
SIGNAL \inst|LessThan26~3_combout\ : std_logic;
SIGNAL \inst|LessThan26~1_combout\ : std_logic;
SIGNAL \inst|LessThan26~4_combout\ : std_logic;
SIGNAL \inst|LessThan26~5_combout\ : std_logic;
SIGNAL \inst|process_0~6_combout\ : std_logic;
SIGNAL \inst7|g~q\ : std_logic;
SIGNAL \inst|LessThan27~0_combout\ : std_logic;
SIGNAL \inst|LessThan30~0_combout\ : std_logic;
SIGNAL \inst|LessThan27~1_combout\ : std_logic;
SIGNAL \inst|process_0~7_combout\ : std_logic;
SIGNAL \inst|LessThan15~0_combout\ : std_logic;
SIGNAL \inst|LessThan19~0_combout\ : std_logic;
SIGNAL \inst|LessThan27~2_combout\ : std_logic;
SIGNAL \inst|blue~0_combout\ : std_logic;
SIGNAL \inst7|f~q\ : std_logic;
SIGNAL \inst|process_0~21_combout\ : std_logic;
SIGNAL \inst|LessThan23~0_combout\ : std_logic;
SIGNAL \inst|LessThan11~5_combout\ : std_logic;
SIGNAL \inst|LessThan23~1_combout\ : std_logic;
SIGNAL \inst|LessThan26~6_combout\ : std_logic;
SIGNAL \inst|LessThan22~2_combout\ : std_logic;
SIGNAL \inst|LessThan22~3_combout\ : std_logic;
SIGNAL \inst|LessThan22~4_combout\ : std_logic;
SIGNAL \inst|LessThan22~5_combout\ : std_logic;
SIGNAL \inst|LessThan14~8_combout\ : std_logic;
SIGNAL \inst|process_0~22_combout\ : std_logic;
SIGNAL \inst|process_0~23_combout\ : std_logic;
SIGNAL \inst|LessThan31~0_combout\ : std_logic;
SIGNAL \inst|process_0~19_combout\ : std_logic;
SIGNAL \inst|LessThan19~2_combout\ : std_logic;
SIGNAL \inst|LessThan19~1_combout\ : std_logic;
SIGNAL \inst|LessThan11~3_combout\ : std_logic;
SIGNAL \inst|LessThan19~3_combout\ : std_logic;
SIGNAL \inst7|e~q\ : std_logic;
SIGNAL \inst|LessThan18~0_combout\ : std_logic;
SIGNAL \inst|LessThan18~1_combout\ : std_logic;
SIGNAL \inst|LessThan18~2_combout\ : std_logic;
SIGNAL \inst|LessThan18~3_combout\ : std_logic;
SIGNAL \inst|LessThan18~4_combout\ : std_logic;
SIGNAL \inst|process_0~20_combout\ : std_logic;
SIGNAL \inst|LessThan30~2_combout\ : std_logic;
SIGNAL \inst|LessThan30~1_combout\ : std_logic;
SIGNAL \inst|LessThan30~3_combout\ : std_logic;
SIGNAL \inst7|h~q\ : std_logic;
SIGNAL \inst|process_0~18_combout\ : std_logic;
SIGNAL \inst|blue~3_combout\ : std_logic;
SIGNAL \inst7|a~0_combout\ : std_logic;
SIGNAL \inst7|a~q\ : std_logic;
SIGNAL \inst|LessThan3~1_combout\ : std_logic;
SIGNAL \inst|LessThan3~2_combout\ : std_logic;
SIGNAL \inst|LessThan3~3_combout\ : std_logic;
SIGNAL \inst|process_0~10_combout\ : std_logic;
SIGNAL \inst|process_0~11_combout\ : std_logic;
SIGNAL \inst|process_0~12_combout\ : std_logic;
SIGNAL \inst|LessThan36~1_combout\ : std_logic;
SIGNAL \inst|LessThan1~2_combout\ : std_logic;
SIGNAL \inst|LessThan1~3_combout\ : std_logic;
SIGNAL \inst|LessThan1~4_combout\ : std_logic;
SIGNAL \inst|process_0~13_combout\ : std_logic;
SIGNAL \inst|process_0~14_combout\ : std_logic;
SIGNAL \inst|LessThan0~2_combout\ : std_logic;
SIGNAL \inst|LessThan6~0_combout\ : std_logic;
SIGNAL \inst|LessThan6~1_combout\ : std_logic;
SIGNAL \inst|LessThan6~2_combout\ : std_logic;
SIGNAL \inst|LessThan6~3_combout\ : std_logic;
SIGNAL \inst|LessThan6~4_combout\ : std_logic;
SIGNAL \inst|LessThan7~0_combout\ : std_logic;
SIGNAL \inst|LessThan7~1_combout\ : std_logic;
SIGNAL \inst|LessThan7~2_combout\ : std_logic;
SIGNAL \inst|LessThan7~3_combout\ : std_logic;
SIGNAL \inst7|b~q\ : std_logic;
SIGNAL \inst|process_0~15_combout\ : std_logic;
SIGNAL \inst|blue~1_combout\ : std_logic;
SIGNAL \inst|LessThan11~4_combout\ : std_logic;
SIGNAL \inst7|c~q\ : std_logic;
SIGNAL \inst|LessThan14~4_combout\ : std_logic;
SIGNAL \inst|LessThan11~1_combout\ : std_logic;
SIGNAL \inst|LessThan11~2_combout\ : std_logic;
SIGNAL \inst|LessThan11~6_combout\ : std_logic;
SIGNAL \inst|LessThan11~7_combout\ : std_logic;
SIGNAL \inst|process_0~16_combout\ : std_logic;
SIGNAL \inst|LessThan10~5_combout\ : std_logic;
SIGNAL \inst|LessThan10~4_combout\ : std_logic;
SIGNAL \inst|LessThan10~6_combout\ : std_logic;
SIGNAL \inst|LessThan10~2_combout\ : std_logic;
SIGNAL \inst|LessThan10~3_combout\ : std_logic;
SIGNAL \inst|LessThan10~7_combout\ : std_logic;
SIGNAL \inst|LessThan15~1_combout\ : std_logic;
SIGNAL \inst|LessThan15~2_combout\ : std_logic;
SIGNAL \inst7|d~q\ : std_logic;
SIGNAL \inst|process_0~17_combout\ : std_logic;
SIGNAL \inst|LessThan14~5_combout\ : std_logic;
SIGNAL \inst|LessThan14~6_combout\ : std_logic;
SIGNAL \inst|LessThan14~7_combout\ : std_logic;
SIGNAL \inst|process_0~25_combout\ : std_logic;
SIGNAL \inst|process_0~26_combout\ : std_logic;
SIGNAL \inst|blue~2_combout\ : std_logic;
SIGNAL \inst|blue~4_combout\ : std_logic;
SIGNAL \inst|blue~5_combout\ : std_logic;
SIGNAL \inst|blue[7]~feeder_combout\ : std_logic;
SIGNAL \inst|blue[6]~feeder_combout\ : std_logic;
SIGNAL \inst|blue[5]~feeder_combout\ : std_logic;
SIGNAL \inst|blue[4]~feeder_combout\ : std_logic;
SIGNAL \inst|blue[3]~feeder_combout\ : std_logic;
SIGNAL \inst|blue[2]~feeder_combout\ : std_logic;
SIGNAL \inst|blue[1]~feeder_combout\ : std_logic;
SIGNAL \inst|red~0_combout\ : std_logic;
SIGNAL \inst|red~1_combout\ : std_logic;
SIGNAL \inst|red~2_combout\ : std_logic;
SIGNAL \inst|red~3_combout\ : std_logic;
SIGNAL \inst|red~4_combout\ : std_logic;
SIGNAL \inst|red~5_combout\ : std_logic;
SIGNAL \inst|red~6_combout\ : std_logic;
SIGNAL \inst|green[7]~feeder_combout\ : std_logic;
SIGNAL \inst|green[6]~feeder_combout\ : std_logic;
SIGNAL \inst|green[5]~feeder_combout\ : std_logic;
SIGNAL \inst|green[4]~feeder_combout\ : std_logic;
SIGNAL \inst|green[3]~feeder_combout\ : std_logic;
SIGNAL \inst|green[2]~feeder_combout\ : std_logic;
SIGNAL \inst|green[1]~feeder_combout\ : std_logic;
SIGNAL \inst|green[0]~feeder_combout\ : std_logic;
SIGNAL \inst|red[7]~feeder_combout\ : std_logic;
SIGNAL \inst|red[6]~feeder_combout\ : std_logic;
SIGNAL \inst|red[5]~feeder_combout\ : std_logic;
SIGNAL \inst|red[4]~feeder_combout\ : std_logic;
SIGNAL \inst|red[3]~feeder_combout\ : std_logic;
SIGNAL \inst|red[2]~feeder_combout\ : std_logic;
SIGNAL \inst|red[1]~feeder_combout\ : std_logic;
SIGNAL \inst|red\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \inst1|h_count\ : std_logic_vector(10 DOWNTO 0);
SIGNAL \inst1|v_count\ : std_logic_vector(10 DOWNTO 0);
SIGNAL \inst1|row\ : std_logic_vector(31 DOWNTO 0);
SIGNAL \inst2|altpll_component|auto_generated|wire_pll1_clk\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \inst1|column\ : std_logic_vector(31 DOWNTO 0);
SIGNAL \inst|blue\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \inst9|a\ : std_logic_vector(31 DOWNTO 0);
SIGNAL \inst|green\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \inst8|counter\ : std_logic_vector(24 DOWNTO 0);
SIGNAL \inst1|ALT_INV_Add1~24_combout\ : std_logic;

BEGIN

pixel_clk <= ww_pixel_clk;
ww_clk <= clk;
h_sync <= ww_h_sync;
v_sync <= ww_v_sync;
n_blank <= ww_n_blank;
n_sync <= ww_n_sync;
blue <= ww_blue;
ww_P1Left <= P1Left;
ww_p1Right <= p1Right;
ww_p1reset <= p1reset;
green <= ww_green;
red <= ww_red;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\inst2|altpll_component|auto_generated|pll1_INCLK_bus\ <= (gnd & \clk~input_o\);

\inst2|altpll_component|auto_generated|wire_pll1_clk\(0) <= \inst2|altpll_component|auto_generated|pll1_CLK_bus\(0);
\inst2|altpll_component|auto_generated|wire_pll1_clk\(1) <= \inst2|altpll_component|auto_generated|pll1_CLK_bus\(1);
\inst2|altpll_component|auto_generated|wire_pll1_clk\(2) <= \inst2|altpll_component|auto_generated|pll1_CLK_bus\(2);
\inst2|altpll_component|auto_generated|wire_pll1_clk\(3) <= \inst2|altpll_component|auto_generated|pll1_CLK_bus\(3);
\inst2|altpll_component|auto_generated|wire_pll1_clk\(4) <= \inst2|altpll_component|auto_generated|pll1_CLK_bus\(4);

\inst8|CLK_1HZ~clkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \inst8|CLK_1HZ~q\);

\inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \inst2|altpll_component|auto_generated|wire_pll1_clk\(0));
\inst1|ALT_INV_Add1~24_combout\ <= NOT \inst1|Add1~24_combout\;

-- Location: IOOBUF_X47_Y73_N2
\pixel_clk~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	devoe => ww_devoe,
	o => ww_pixel_clk);

-- Location: IOOBUF_X38_Y73_N16
\h_sync~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst1|h_sync~q\,
	devoe => ww_devoe,
	o => ww_h_sync);

-- Location: IOOBUF_X54_Y73_N2
\v_sync~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst1|v_sync~q\,
	devoe => ww_devoe,
	o => ww_v_sync);

-- Location: IOOBUF_X31_Y73_N9
\n_blank~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => ww_n_blank);

-- Location: IOOBUF_X35_Y73_N16
\n_sync~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_n_sync);

-- Location: IOOBUF_X52_Y73_N23
\blue[7]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|blue\(7),
	devoe => ww_devoe,
	o => ww_blue(7));

-- Location: IOOBUF_X23_Y73_N9
\blue[6]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|blue\(6),
	devoe => ww_devoe,
	o => ww_blue(6));

-- Location: IOOBUF_X52_Y73_N16
\blue[5]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|blue\(5),
	devoe => ww_devoe,
	o => ww_blue(5));

-- Location: IOOBUF_X42_Y73_N2
\blue[4]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|blue\(4),
	devoe => ww_devoe,
	o => ww_blue(4));

-- Location: IOOBUF_X42_Y73_N9
\blue[3]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|blue\(3),
	devoe => ww_devoe,
	o => ww_blue(3));

-- Location: IOOBUF_X23_Y73_N2
\blue[2]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|blue\(2),
	devoe => ww_devoe,
	o => ww_blue(2));

-- Location: IOOBUF_X38_Y73_N2
\blue[1]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|blue\(1),
	devoe => ww_devoe,
	o => ww_blue(1));

-- Location: IOOBUF_X38_Y73_N9
\blue[0]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|blue\(0),
	devoe => ww_devoe,
	o => ww_blue(0));

-- Location: IOOBUF_X23_Y73_N16
\green[7]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|green\(7),
	devoe => ww_devoe,
	o => ww_green(7));

-- Location: IOOBUF_X20_Y73_N2
\green[6]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|green\(6),
	devoe => ww_devoe,
	o => ww_green(6));

-- Location: IOOBUF_X16_Y73_N2
\green[5]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|green\(5),
	devoe => ww_devoe,
	o => ww_green(5));

-- Location: IOOBUF_X16_Y73_N9
\green[4]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|green\(4),
	devoe => ww_devoe,
	o => ww_green(4));

-- Location: IOOBUF_X25_Y73_N23
\green[3]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|green\(3),
	devoe => ww_devoe,
	o => ww_green(3));

-- Location: IOOBUF_X11_Y73_N9
\green[2]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|green\(2),
	devoe => ww_devoe,
	o => ww_green(2));

-- Location: IOOBUF_X25_Y73_N16
\green[1]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|green\(1),
	devoe => ww_devoe,
	o => ww_green(1));

-- Location: IOOBUF_X11_Y73_N16
\green[0]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|green\(0),
	devoe => ww_devoe,
	o => ww_green(0));

-- Location: IOOBUF_X20_Y73_N16
\red[7]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|red\(7),
	devoe => ww_devoe,
	o => ww_red(7));

-- Location: IOOBUF_X11_Y73_N23
\red[6]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|red\(6),
	devoe => ww_devoe,
	o => ww_red(6));

-- Location: IOOBUF_X40_Y73_N9
\red[5]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|red\(5),
	devoe => ww_devoe,
	o => ww_red(5));

-- Location: IOOBUF_X20_Y73_N9
\red[4]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|red\(4),
	devoe => ww_devoe,
	o => ww_red(4));

-- Location: IOOBUF_X33_Y73_N9
\red[3]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|red\(3),
	devoe => ww_devoe,
	o => ww_red(3));

-- Location: IOOBUF_X35_Y73_N23
\red[2]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|red\(2),
	devoe => ww_devoe,
	o => ww_red(2));

-- Location: IOOBUF_X31_Y73_N2
\red[1]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|red\(1),
	devoe => ww_devoe,
	o => ww_red(1));

-- Location: IOOBUF_X33_Y73_N2
\red[0]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|red\(0),
	devoe => ww_devoe,
	o => ww_red(0));

-- Location: IOIBUF_X0_Y36_N15
\clk~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clk,
	o => \clk~input_o\);

-- Location: PLL_1
\inst2|altpll_component|auto_generated|pll1\ : cycloneive_pll
-- pragma translate_off
GENERIC MAP (
	auto_settings => "false",
	bandwidth_type => "medium",
	c0_high => 3,
	c0_initial => 1,
	c0_low => 2,
	c0_mode => "odd",
	c0_ph => 0,
	c1_high => 0,
	c1_initial => 0,
	c1_low => 0,
	c1_mode => "bypass",
	c1_ph => 0,
	c1_use_casc_in => "off",
	c2_high => 0,
	c2_initial => 0,
	c2_low => 0,
	c2_mode => "bypass",
	c2_ph => 0,
	c2_use_casc_in => "off",
	c3_high => 0,
	c3_initial => 0,
	c3_low => 0,
	c3_mode => "bypass",
	c3_ph => 0,
	c3_use_casc_in => "off",
	c4_high => 0,
	c4_initial => 0,
	c4_low => 0,
	c4_mode => "bypass",
	c4_ph => 0,
	c4_use_casc_in => "off",
	charge_pump_current_bits => 1,
	clk0_counter => "c0",
	clk0_divide_by => 25,
	clk0_duty_cycle => 50,
	clk0_multiply_by => 54,
	clk0_phase_shift => "0",
	clk1_counter => "unused",
	clk1_divide_by => 0,
	clk1_duty_cycle => 50,
	clk1_multiply_by => 0,
	clk1_phase_shift => "0",
	clk2_counter => "unused",
	clk2_divide_by => 0,
	clk2_duty_cycle => 50,
	clk2_multiply_by => 0,
	clk2_phase_shift => "0",
	clk3_counter => "unused",
	clk3_divide_by => 0,
	clk3_duty_cycle => 50,
	clk3_multiply_by => 0,
	clk3_phase_shift => "0",
	clk4_counter => "unused",
	clk4_divide_by => 0,
	clk4_duty_cycle => 50,
	clk4_multiply_by => 0,
	clk4_phase_shift => "0",
	compensate_clock => "clock0",
	inclk0_input_frequency => 20000,
	inclk1_input_frequency => 0,
	loop_filter_c_bits => 0,
	loop_filter_r_bits => 19,
	m => 54,
	m_initial => 1,
	m_ph => 0,
	n => 5,
	operation_mode => "normal",
	pfd_max => 200000,
	pfd_min => 3076,
	pll_compensation_delay => 7173,
	self_reset_on_loss_lock => "off",
	simulation_type => "timing",
	switch_over_type => "auto",
	vco_center => 1538,
	vco_divide_by => 0,
	vco_frequency_control => "auto",
	vco_max => 3333,
	vco_min => 1538,
	vco_multiply_by => 0,
	vco_phase_shift_step => 231,
	vco_post_scale => 2)
-- pragma translate_on
PORT MAP (
	areset => GND,
	fbin => \inst2|altpll_component|auto_generated|wire_pll1_fbout\,
	inclk => \inst2|altpll_component|auto_generated|pll1_INCLK_bus\,
	fbout => \inst2|altpll_component|auto_generated|wire_pll1_fbout\,
	clk => \inst2|altpll_component|auto_generated|pll1_CLK_bus\);

-- Location: CLKCTRL_G3
\inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl\ : cycloneive_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\);

-- Location: LCCOMB_X82_Y36_N4
\inst1|Add0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|Add0~0_combout\ = \inst1|h_count\(0) $ (VCC)
-- \inst1|Add0~1\ = CARRY(\inst1|h_count\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010110101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|h_count\(0),
	datad => VCC,
	combout => \inst1|Add0~0_combout\,
	cout => \inst1|Add0~1\);

-- Location: LCCOMB_X81_Y36_N10
\inst1|h_count~8\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|h_count~8_combout\ = (!\inst1|process_0~5_combout\ & \inst1|Add0~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst1|process_0~5_combout\,
	datad => \inst1|Add0~0_combout\,
	combout => \inst1|h_count~8_combout\);

-- Location: FF_X81_Y36_N11
\inst1|h_count[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst1|h_count~8_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1|h_count\(0));

-- Location: LCCOMB_X82_Y36_N6
\inst1|Add0~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|Add0~2_combout\ = (\inst1|h_count\(1) & (!\inst1|Add0~1\)) # (!\inst1|h_count\(1) & ((\inst1|Add0~1\) # (GND)))
-- \inst1|Add0~3\ = CARRY((!\inst1|Add0~1\) # (!\inst1|h_count\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst1|h_count\(1),
	datad => VCC,
	cin => \inst1|Add0~1\,
	combout => \inst1|Add0~2_combout\,
	cout => \inst1|Add0~3\);

-- Location: LCCOMB_X82_Y36_N8
\inst1|Add0~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|Add0~4_combout\ = (\inst1|h_count\(2) & (\inst1|Add0~3\ $ (GND))) # (!\inst1|h_count\(2) & (!\inst1|Add0~3\ & VCC))
-- \inst1|Add0~5\ = CARRY((\inst1|h_count\(2) & !\inst1|Add0~3\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst1|h_count\(2),
	datad => VCC,
	cin => \inst1|Add0~3\,
	combout => \inst1|Add0~4_combout\,
	cout => \inst1|Add0~5\);

-- Location: LCCOMB_X81_Y36_N16
\inst1|h_count~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|h_count~1_combout\ = (\inst1|Add0~4_combout\ & !\inst1|process_0~5_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst1|Add0~4_combout\,
	datad => \inst1|process_0~5_combout\,
	combout => \inst1|h_count~1_combout\);

-- Location: FF_X82_Y36_N9
\inst1|h_count[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	asdata => \inst1|h_count~1_combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1|h_count\(2));

-- Location: LCCOMB_X82_Y36_N10
\inst1|Add0~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|Add0~6_combout\ = (\inst1|h_count\(3) & (!\inst1|Add0~5\)) # (!\inst1|h_count\(3) & ((\inst1|Add0~5\) # (GND)))
-- \inst1|Add0~7\ = CARRY((!\inst1|Add0~5\) # (!\inst1|h_count\(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|h_count\(3),
	datad => VCC,
	cin => \inst1|Add0~5\,
	combout => \inst1|Add0~6_combout\,
	cout => \inst1|Add0~7\);

-- Location: LCCOMB_X81_Y36_N6
\inst1|h_count~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|h_count~0_combout\ = (\inst1|Add0~6_combout\ & !\inst1|process_0~5_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst1|Add0~6_combout\,
	datad => \inst1|process_0~5_combout\,
	combout => \inst1|h_count~0_combout\);

-- Location: FF_X82_Y36_N11
\inst1|h_count[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	asdata => \inst1|h_count~0_combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1|h_count\(3));

-- Location: LCCOMB_X82_Y36_N12
\inst1|Add0~8\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|Add0~8_combout\ = (\inst1|h_count\(4) & (\inst1|Add0~7\ $ (GND))) # (!\inst1|h_count\(4) & (!\inst1|Add0~7\ & VCC))
-- \inst1|Add0~9\ = CARRY((\inst1|h_count\(4) & !\inst1|Add0~7\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|h_count\(4),
	datad => VCC,
	cin => \inst1|Add0~7\,
	combout => \inst1|Add0~8_combout\,
	cout => \inst1|Add0~9\);

-- Location: LCCOMB_X80_Y36_N24
\inst1|h_count~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|h_count~6_combout\ = (!\inst1|process_0~5_combout\ & \inst1|Add0~8_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst1|process_0~5_combout\,
	datad => \inst1|Add0~8_combout\,
	combout => \inst1|h_count~6_combout\);

-- Location: FF_X82_Y36_N13
\inst1|h_count[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	asdata => \inst1|h_count~6_combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1|h_count\(4));

-- Location: LCCOMB_X82_Y36_N14
\inst1|Add0~10\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|Add0~10_combout\ = (\inst1|h_count\(5) & (!\inst1|Add0~9\)) # (!\inst1|h_count\(5) & ((\inst1|Add0~9\) # (GND)))
-- \inst1|Add0~11\ = CARRY((!\inst1|Add0~9\) # (!\inst1|h_count\(5)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst1|h_count\(5),
	datad => VCC,
	cin => \inst1|Add0~9\,
	combout => \inst1|Add0~10_combout\,
	cout => \inst1|Add0~11\);

-- Location: LCCOMB_X80_Y36_N14
\inst1|h_count~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|h_count~5_combout\ = (!\inst1|process_0~5_combout\ & \inst1|Add0~10_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101000001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|process_0~5_combout\,
	datac => \inst1|Add0~10_combout\,
	combout => \inst1|h_count~5_combout\);

-- Location: FF_X82_Y36_N15
\inst1|h_count[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	asdata => \inst1|h_count~5_combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1|h_count\(5));

-- Location: LCCOMB_X82_Y36_N16
\inst1|Add0~12\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|Add0~12_combout\ = (\inst1|h_count\(6) & (\inst1|Add0~11\ $ (GND))) # (!\inst1|h_count\(6) & (!\inst1|Add0~11\ & VCC))
-- \inst1|Add0~13\ = CARRY((\inst1|h_count\(6) & !\inst1|Add0~11\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|h_count\(6),
	datad => VCC,
	cin => \inst1|Add0~11\,
	combout => \inst1|Add0~12_combout\,
	cout => \inst1|Add0~13\);

-- Location: LCCOMB_X80_Y36_N20
\inst1|h_count~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|h_count~4_combout\ = (!\inst1|process_0~5_combout\ & \inst1|Add0~12_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101000001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|process_0~5_combout\,
	datac => \inst1|Add0~12_combout\,
	combout => \inst1|h_count~4_combout\);

-- Location: FF_X82_Y36_N1
\inst1|h_count[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	asdata => \inst1|h_count~4_combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1|h_count\(6));

-- Location: LCCOMB_X82_Y36_N18
\inst1|Add0~14\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|Add0~14_combout\ = (\inst1|h_count\(7) & (!\inst1|Add0~13\)) # (!\inst1|h_count\(7) & ((\inst1|Add0~13\) # (GND)))
-- \inst1|Add0~15\ = CARRY((!\inst1|Add0~13\) # (!\inst1|h_count\(7)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst1|h_count\(7),
	datad => VCC,
	cin => \inst1|Add0~13\,
	combout => \inst1|Add0~14_combout\,
	cout => \inst1|Add0~15\);

-- Location: LCCOMB_X81_Y36_N20
\inst1|h_count~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|h_count~3_combout\ = (\inst1|Add0~14_combout\ & !\inst1|process_0~5_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst1|Add0~14_combout\,
	datad => \inst1|process_0~5_combout\,
	combout => \inst1|h_count~3_combout\);

-- Location: FF_X82_Y36_N19
\inst1|h_count[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	asdata => \inst1|h_count~3_combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1|h_count\(7));

-- Location: LCCOMB_X82_Y36_N20
\inst1|Add0~16\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|Add0~16_combout\ = (\inst1|h_count\(8) & (\inst1|Add0~15\ $ (GND))) # (!\inst1|h_count\(8) & (!\inst1|Add0~15\ & VCC))
-- \inst1|Add0~17\ = CARRY((\inst1|h_count\(8) & !\inst1|Add0~15\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst1|h_count\(8),
	datad => VCC,
	cin => \inst1|Add0~15\,
	combout => \inst1|Add0~16_combout\,
	cout => \inst1|Add0~17\);

-- Location: LCCOMB_X81_Y36_N18
\inst1|h_count~10\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|h_count~10_combout\ = (\inst1|Add0~16_combout\ & !\inst1|process_0~5_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst1|Add0~16_combout\,
	datad => \inst1|process_0~5_combout\,
	combout => \inst1|h_count~10_combout\);

-- Location: FF_X82_Y36_N3
\inst1|h_count[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	asdata => \inst1|h_count~10_combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1|h_count\(8));

-- Location: LCCOMB_X82_Y36_N22
\inst1|Add0~18\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|Add0~18_combout\ = (\inst1|h_count\(9) & (!\inst1|Add0~17\)) # (!\inst1|h_count\(9) & ((\inst1|Add0~17\) # (GND)))
-- \inst1|Add0~19\ = CARRY((!\inst1|Add0~17\) # (!\inst1|h_count\(9)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|h_count\(9),
	datad => VCC,
	cin => \inst1|Add0~17\,
	combout => \inst1|Add0~18_combout\,
	cout => \inst1|Add0~19\);

-- Location: LCCOMB_X81_Y36_N8
\inst1|h_count~9\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|h_count~9_combout\ = (\inst1|Add0~18_combout\ & !\inst1|process_0~5_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst1|Add0~18_combout\,
	datad => \inst1|process_0~5_combout\,
	combout => \inst1|h_count~9_combout\);

-- Location: FF_X82_Y36_N23
\inst1|h_count[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	asdata => \inst1|h_count~9_combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1|h_count\(9));

-- Location: LCCOMB_X82_Y36_N2
\inst1|process_0~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|process_0~4_combout\ = (\inst1|h_count\(8)) # (\inst1|h_count\(7))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst1|h_count\(8),
	datad => \inst1|h_count\(7),
	combout => \inst1|process_0~4_combout\);

-- Location: LCCOMB_X82_Y36_N24
\inst1|Add0~20\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|Add0~20_combout\ = \inst1|Add0~19\ $ (!\inst1|h_count\(10))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000001111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datad => \inst1|h_count\(10),
	cin => \inst1|Add0~19\,
	combout => \inst1|Add0~20_combout\);

-- Location: LCCOMB_X81_Y36_N4
\inst1|h_count~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|h_count~2_combout\ = (\inst1|Add0~20_combout\ & !\inst1|process_0~5_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst1|Add0~20_combout\,
	datad => \inst1|process_0~5_combout\,
	combout => \inst1|h_count~2_combout\);

-- Location: FF_X82_Y36_N29
\inst1|h_count[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	asdata => \inst1|h_count~2_combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1|h_count\(10));

-- Location: LCCOMB_X82_Y36_N26
\inst1|process_0~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|process_0~2_combout\ = (\inst1|h_count\(0)) # ((\inst1|h_count\(2)) # ((\inst1|h_count\(1)) # (\inst1|h_count\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|h_count\(0),
	datab => \inst1|h_count\(2),
	datac => \inst1|h_count\(1),
	datad => \inst1|h_count\(3),
	combout => \inst1|process_0~2_combout\);

-- Location: LCCOMB_X82_Y36_N0
\inst1|process_0~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|process_0~3_combout\ = (\inst1|process_0~2_combout\ & (\inst1|h_count\(5) & (\inst1|h_count\(6) & \inst1|h_count\(4))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|process_0~2_combout\,
	datab => \inst1|h_count\(5),
	datac => \inst1|h_count\(6),
	datad => \inst1|h_count\(4),
	combout => \inst1|process_0~3_combout\);

-- Location: LCCOMB_X82_Y36_N28
\inst1|process_0~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|process_0~5_combout\ = (\inst1|h_count\(9) & (\inst1|h_count\(10) & ((\inst1|process_0~4_combout\) # (\inst1|process_0~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|h_count\(9),
	datab => \inst1|process_0~4_combout\,
	datac => \inst1|h_count\(10),
	datad => \inst1|process_0~3_combout\,
	combout => \inst1|process_0~5_combout\);

-- Location: LCCOMB_X82_Y36_N30
\inst1|h_count~7\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|h_count~7_combout\ = (\inst1|Add0~2_combout\ & !\inst1|process_0~5_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|Add0~2_combout\,
	datad => \inst1|process_0~5_combout\,
	combout => \inst1|h_count~7_combout\);

-- Location: FF_X82_Y36_N27
\inst1|h_count[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	asdata => \inst1|h_count~7_combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1|h_count\(1));

-- Location: LCCOMB_X81_Y36_N26
\inst1|process_0~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|process_0~6_combout\ = (\inst1|h_count~0_combout\ & ((\inst1|h_count~1_combout\) # ((\inst1|Add0~2_combout\ & \inst1|Add0~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|Add0~2_combout\,
	datab => \inst1|h_count~1_combout\,
	datac => \inst1|h_count~0_combout\,
	datad => \inst1|Add0~0_combout\,
	combout => \inst1|process_0~6_combout\);

-- Location: LCCOMB_X81_Y36_N28
\inst1|process_0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|process_0~0_combout\ = (\inst1|Add0~18_combout\) # ((\inst1|Add0~14_combout\) # (!\inst1|Add0~16_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst1|Add0~18_combout\,
	datac => \inst1|Add0~16_combout\,
	datad => \inst1|Add0~14_combout\,
	combout => \inst1|process_0~0_combout\);

-- Location: LCCOMB_X80_Y36_N0
\inst1|process_0~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|process_0~1_combout\ = (\inst1|Add0~10_combout\ & (\inst1|Add0~12_combout\ & \inst1|Add0~8_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst1|Add0~10_combout\,
	datac => \inst1|Add0~12_combout\,
	datad => \inst1|Add0~8_combout\,
	combout => \inst1|process_0~1_combout\);

-- Location: LCCOMB_X81_Y36_N0
\inst1|process_0~7\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|process_0~7_combout\ = (!\inst1|process_0~0_combout\ & (\inst1|h_count~2_combout\ & ((!\inst1|process_0~1_combout\) # (!\inst1|process_0~6_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001001100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|process_0~6_combout\,
	datab => \inst1|process_0~0_combout\,
	datac => \inst1|process_0~1_combout\,
	datad => \inst1|h_count~2_combout\,
	combout => \inst1|process_0~7_combout\);

-- Location: FF_X81_Y36_N1
\inst1|h_sync\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst1|process_0~7_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1|h_sync~q\);

-- Location: LCCOMB_X82_Y35_N4
\inst1|Add1~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|Add1~1_combout\ = \inst1|v_count\(0) $ (VCC)
-- \inst1|Add1~2\ = CARRY(\inst1|v_count\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010110101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|v_count\(0),
	datad => VCC,
	combout => \inst1|Add1~1_combout\,
	cout => \inst1|Add1~2\);

-- Location: LCCOMB_X81_Y35_N2
\inst1|Add1~30\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|Add1~30_combout\ = (\inst1|Add1~1_combout\ & ((\inst1|Add1~0_combout\) # ((\inst1|v_count\(0) & !\inst1|process_0~5_combout\)))) # (!\inst1|Add1~1_combout\ & (((\inst1|v_count\(0) & !\inst1|process_0~5_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000100011111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|Add1~1_combout\,
	datab => \inst1|Add1~0_combout\,
	datac => \inst1|v_count\(0),
	datad => \inst1|process_0~5_combout\,
	combout => \inst1|Add1~30_combout\);

-- Location: FF_X81_Y35_N3
\inst1|v_count[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst1|Add1~30_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1|v_count\(0));

-- Location: LCCOMB_X82_Y35_N6
\inst1|Add1~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|Add1~3_combout\ = (\inst1|v_count\(1) & (!\inst1|Add1~2\)) # (!\inst1|v_count\(1) & ((\inst1|Add1~2\) # (GND)))
-- \inst1|Add1~4\ = CARRY((!\inst1|Add1~2\) # (!\inst1|v_count\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|v_count\(1),
	datad => VCC,
	cin => \inst1|Add1~2\,
	combout => \inst1|Add1~3_combout\,
	cout => \inst1|Add1~4\);

-- Location: LCCOMB_X81_Y35_N4
\inst1|Add1~31\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|Add1~31_combout\ = (\inst1|v_count\(1) & (((\inst1|Add1~3_combout\ & \inst1|Add1~0_combout\)) # (!\inst1|process_0~5_combout\))) # (!\inst1|v_count\(1) & (\inst1|Add1~3_combout\ & (\inst1|Add1~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|v_count\(1),
	datab => \inst1|Add1~3_combout\,
	datac => \inst1|Add1~0_combout\,
	datad => \inst1|process_0~5_combout\,
	combout => \inst1|Add1~31_combout\);

-- Location: FF_X82_Y35_N7
\inst1|v_count[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	asdata => \inst1|Add1~31_combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1|v_count\(1));

-- Location: LCCOMB_X82_Y35_N8
\inst1|Add1~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|Add1~5_combout\ = (\inst1|v_count\(2) & (\inst1|Add1~4\ $ (GND))) # (!\inst1|v_count\(2) & (!\inst1|Add1~4\ & VCC))
-- \inst1|Add1~6\ = CARRY((\inst1|v_count\(2) & !\inst1|Add1~4\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst1|v_count\(2),
	datad => VCC,
	cin => \inst1|Add1~4\,
	combout => \inst1|Add1~5_combout\,
	cout => \inst1|Add1~6\);

-- Location: LCCOMB_X81_Y35_N10
\inst1|Add1~29\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|Add1~29_combout\ = (\inst1|v_count\(2) & (((\inst1|Add1~0_combout\ & \inst1|Add1~5_combout\)) # (!\inst1|process_0~5_combout\))) # (!\inst1|v_count\(2) & (\inst1|Add1~0_combout\ & (\inst1|Add1~5_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|v_count\(2),
	datab => \inst1|Add1~0_combout\,
	datac => \inst1|Add1~5_combout\,
	datad => \inst1|process_0~5_combout\,
	combout => \inst1|Add1~29_combout\);

-- Location: FF_X81_Y35_N25
\inst1|v_count[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	asdata => \inst1|Add1~29_combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1|v_count\(2));

-- Location: LCCOMB_X82_Y35_N10
\inst1|Add1~7\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|Add1~7_combout\ = (\inst1|v_count\(3) & (!\inst1|Add1~6\)) # (!\inst1|v_count\(3) & ((\inst1|Add1~6\) # (GND)))
-- \inst1|Add1~8\ = CARRY((!\inst1|Add1~6\) # (!\inst1|v_count\(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|v_count\(3),
	datad => VCC,
	cin => \inst1|Add1~6\,
	combout => \inst1|Add1~7_combout\,
	cout => \inst1|Add1~8\);

-- Location: LCCOMB_X81_Y35_N16
\inst1|Add1~28\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|Add1~28_combout\ = (\inst1|v_count\(3) & (((\inst1|Add1~0_combout\ & \inst1|Add1~7_combout\)) # (!\inst1|process_0~5_combout\))) # (!\inst1|v_count\(3) & (\inst1|Add1~0_combout\ & (\inst1|Add1~7_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|v_count\(3),
	datab => \inst1|Add1~0_combout\,
	datac => \inst1|Add1~7_combout\,
	datad => \inst1|process_0~5_combout\,
	combout => \inst1|Add1~28_combout\);

-- Location: FF_X82_Y35_N11
\inst1|v_count[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	asdata => \inst1|Add1~28_combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1|v_count\(3));

-- Location: LCCOMB_X82_Y35_N12
\inst1|Add1~9\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|Add1~9_combout\ = (\inst1|v_count\(4) & (\inst1|Add1~8\ $ (GND))) # (!\inst1|v_count\(4) & (!\inst1|Add1~8\ & VCC))
-- \inst1|Add1~10\ = CARRY((\inst1|v_count\(4) & !\inst1|Add1~8\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|v_count\(4),
	datad => VCC,
	cin => \inst1|Add1~8\,
	combout => \inst1|Add1~9_combout\,
	cout => \inst1|Add1~10\);

-- Location: LCCOMB_X81_Y35_N26
\inst1|Add1~25\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|Add1~25_combout\ = (\inst1|v_count\(4) & (((\inst1|Add1~0_combout\ & \inst1|Add1~9_combout\)) # (!\inst1|process_0~5_combout\))) # (!\inst1|v_count\(4) & (\inst1|Add1~0_combout\ & (\inst1|Add1~9_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|v_count\(4),
	datab => \inst1|Add1~0_combout\,
	datac => \inst1|Add1~9_combout\,
	datad => \inst1|process_0~5_combout\,
	combout => \inst1|Add1~25_combout\);

-- Location: FF_X82_Y35_N13
\inst1|v_count[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	asdata => \inst1|Add1~25_combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1|v_count\(4));

-- Location: LCCOMB_X81_Y35_N24
\inst1|LessThan1~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|LessThan1~0_combout\ = (!\inst1|v_count\(0) & (!\inst1|v_count\(4) & (!\inst1|v_count\(2) & !\inst1|v_count\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|v_count\(0),
	datab => \inst1|v_count\(4),
	datac => \inst1|v_count\(2),
	datad => \inst1|v_count\(1),
	combout => \inst1|LessThan1~0_combout\);

-- Location: LCCOMB_X82_Y35_N14
\inst1|Add1~11\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|Add1~11_combout\ = (\inst1|v_count\(5) & (!\inst1|Add1~10\)) # (!\inst1|v_count\(5) & ((\inst1|Add1~10\) # (GND)))
-- \inst1|Add1~12\ = CARRY((!\inst1|Add1~10\) # (!\inst1|v_count\(5)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|v_count\(5),
	datad => VCC,
	cin => \inst1|Add1~10\,
	combout => \inst1|Add1~11_combout\,
	cout => \inst1|Add1~12\);

-- Location: LCCOMB_X81_Y35_N28
\inst1|Add1~26\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|Add1~26_combout\ = (\inst1|v_count\(5) & (((\inst1|Add1~0_combout\ & \inst1|Add1~11_combout\)) # (!\inst1|process_0~5_combout\))) # (!\inst1|v_count\(5) & (\inst1|Add1~0_combout\ & (\inst1|Add1~11_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|v_count\(5),
	datab => \inst1|Add1~0_combout\,
	datac => \inst1|Add1~11_combout\,
	datad => \inst1|process_0~5_combout\,
	combout => \inst1|Add1~26_combout\);

-- Location: FF_X81_Y35_N13
\inst1|v_count[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	asdata => \inst1|Add1~26_combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1|v_count\(5));

-- Location: LCCOMB_X81_Y35_N12
\inst1|LessThan1~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|LessThan1~1_combout\ = (\inst1|LessThan1~0_combout\) # (((!\inst1|v_count\(3) & !\inst1|v_count\(4))) # (!\inst1|v_count\(5)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111111011111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|v_count\(3),
	datab => \inst1|LessThan1~0_combout\,
	datac => \inst1|v_count\(5),
	datad => \inst1|v_count\(4),
	combout => \inst1|LessThan1~1_combout\);

-- Location: FF_X82_Y35_N1
\inst1|v_count[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	asdata => \inst1|Add1~21_combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1|v_count\(9));

-- Location: LCCOMB_X82_Y35_N16
\inst1|Add1~13\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|Add1~13_combout\ = (\inst1|v_count\(6) & (\inst1|Add1~12\ $ (GND))) # (!\inst1|v_count\(6) & (!\inst1|Add1~12\ & VCC))
-- \inst1|Add1~14\ = CARRY((\inst1|v_count\(6) & !\inst1|Add1~12\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst1|v_count\(6),
	datad => VCC,
	cin => \inst1|Add1~12\,
	combout => \inst1|Add1~13_combout\,
	cout => \inst1|Add1~14\);

-- Location: LCCOMB_X81_Y35_N6
\inst1|Add1~27\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|Add1~27_combout\ = (\inst1|v_count\(6) & (((\inst1|Add1~13_combout\ & \inst1|Add1~0_combout\)) # (!\inst1|process_0~5_combout\))) # (!\inst1|v_count\(6) & (\inst1|Add1~13_combout\ & (\inst1|Add1~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|v_count\(6),
	datab => \inst1|Add1~13_combout\,
	datac => \inst1|Add1~0_combout\,
	datad => \inst1|process_0~5_combout\,
	combout => \inst1|Add1~27_combout\);

-- Location: FF_X82_Y35_N17
\inst1|v_count[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	asdata => \inst1|Add1~27_combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1|v_count\(6));

-- Location: LCCOMB_X82_Y35_N18
\inst1|Add1~15\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|Add1~15_combout\ = (\inst1|v_count\(7) & (!\inst1|Add1~14\)) # (!\inst1|v_count\(7) & ((\inst1|Add1~14\) # (GND)))
-- \inst1|Add1~16\ = CARRY((!\inst1|Add1~14\) # (!\inst1|v_count\(7)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst1|v_count\(7),
	datad => VCC,
	cin => \inst1|Add1~14\,
	combout => \inst1|Add1~15_combout\,
	cout => \inst1|Add1~16\);

-- Location: LCCOMB_X82_Y35_N28
\inst1|Add1~33\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|Add1~33_combout\ = (\inst1|Add1~0_combout\ & ((\inst1|Add1~15_combout\) # ((\inst1|v_count\(7) & !\inst1|process_0~5_combout\)))) # (!\inst1|Add1~0_combout\ & (\inst1|v_count\(7) & ((!\inst1|process_0~5_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000011101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|Add1~0_combout\,
	datab => \inst1|v_count\(7),
	datac => \inst1|Add1~15_combout\,
	datad => \inst1|process_0~5_combout\,
	combout => \inst1|Add1~33_combout\);

-- Location: FF_X82_Y35_N19
\inst1|v_count[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	asdata => \inst1|Add1~33_combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1|v_count\(7));

-- Location: LCCOMB_X82_Y35_N20
\inst1|Add1~17\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|Add1~17_combout\ = (\inst1|v_count\(8) & (\inst1|Add1~16\ $ (GND))) # (!\inst1|v_count\(8) & (!\inst1|Add1~16\ & VCC))
-- \inst1|Add1~18\ = CARRY((\inst1|v_count\(8) & !\inst1|Add1~16\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst1|v_count\(8),
	datad => VCC,
	cin => \inst1|Add1~16\,
	combout => \inst1|Add1~17_combout\,
	cout => \inst1|Add1~18\);

-- Location: LCCOMB_X82_Y35_N2
\inst1|Add1~32\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|Add1~32_combout\ = (\inst1|Add1~0_combout\ & ((\inst1|Add1~17_combout\) # ((\inst1|v_count\(8) & !\inst1|process_0~5_combout\)))) # (!\inst1|Add1~0_combout\ & (\inst1|v_count\(8) & ((!\inst1|process_0~5_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000011101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|Add1~0_combout\,
	datab => \inst1|v_count\(8),
	datac => \inst1|Add1~17_combout\,
	datad => \inst1|process_0~5_combout\,
	combout => \inst1|Add1~32_combout\);

-- Location: FF_X82_Y35_N21
\inst1|v_count[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	asdata => \inst1|Add1~32_combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1|v_count\(8));

-- Location: LCCOMB_X82_Y35_N22
\inst1|Add1~19\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|Add1~19_combout\ = (\inst1|v_count\(9) & (!\inst1|Add1~18\)) # (!\inst1|v_count\(9) & ((\inst1|Add1~18\) # (GND)))
-- \inst1|Add1~20\ = CARRY((!\inst1|Add1~18\) # (!\inst1|v_count\(9)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst1|v_count\(9),
	datad => VCC,
	cin => \inst1|Add1~18\,
	combout => \inst1|Add1~19_combout\,
	cout => \inst1|Add1~20\);

-- Location: LCCOMB_X82_Y35_N24
\inst1|Add1~22\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|Add1~22_combout\ = \inst1|Add1~20\ $ (!\inst1|v_count\(10))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000001111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datad => \inst1|v_count\(10),
	cin => \inst1|Add1~20\,
	combout => \inst1|Add1~22_combout\);

-- Location: LCCOMB_X81_Y35_N14
\inst1|Add1~24\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|Add1~24_combout\ = (\inst1|Add1~0_combout\ & ((\inst1|Add1~22_combout\) # ((\inst1|v_count\(10) & !\inst1|process_0~5_combout\)))) # (!\inst1|Add1~0_combout\ & (((\inst1|v_count\(10) & !\inst1|process_0~5_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000100011111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|Add1~0_combout\,
	datab => \inst1|Add1~22_combout\,
	datac => \inst1|v_count\(10),
	datad => \inst1|process_0~5_combout\,
	combout => \inst1|Add1~24_combout\);

-- Location: FF_X81_Y35_N15
\inst1|v_count[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst1|Add1~24_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1|v_count\(10));

-- Location: LCCOMB_X82_Y35_N0
\inst1|LessThan1~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|LessThan1~2_combout\ = (!\inst1|v_count\(8) & (!\inst1|v_count\(7) & (!\inst1|v_count\(9) & !\inst1|v_count\(6))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|v_count\(8),
	datab => \inst1|v_count\(7),
	datac => \inst1|v_count\(9),
	datad => \inst1|v_count\(6),
	combout => \inst1|LessThan1~2_combout\);

-- Location: LCCOMB_X81_Y35_N8
\inst1|Add1~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|Add1~0_combout\ = (\inst1|process_0~5_combout\ & (((\inst1|LessThan1~1_combout\ & \inst1|LessThan1~2_combout\)) # (!\inst1|v_count\(10))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011001100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|LessThan1~1_combout\,
	datab => \inst1|v_count\(10),
	datac => \inst1|LessThan1~2_combout\,
	datad => \inst1|process_0~5_combout\,
	combout => \inst1|Add1~0_combout\);

-- Location: LCCOMB_X82_Y35_N26
\inst1|Add1~21\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|Add1~21_combout\ = (\inst1|Add1~0_combout\ & ((\inst1|Add1~19_combout\) # ((\inst1|v_count\(9) & !\inst1|process_0~5_combout\)))) # (!\inst1|Add1~0_combout\ & (\inst1|v_count\(9) & ((!\inst1|process_0~5_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000011101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|Add1~0_combout\,
	datab => \inst1|v_count\(9),
	datac => \inst1|Add1~19_combout\,
	datad => \inst1|process_0~5_combout\,
	combout => \inst1|Add1~21_combout\);

-- Location: LCCOMB_X81_Y35_N30
\inst1|process_0~8\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|process_0~8_combout\ = (\inst1|Add1~28_combout\) # (\inst1|Add1~29_combout\ $ (((!\inst1|Add1~30_combout\ & !\inst1|Add1~31_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111011001101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|Add1~30_combout\,
	datab => \inst1|Add1~28_combout\,
	datac => \inst1|Add1~31_combout\,
	datad => \inst1|Add1~29_combout\,
	combout => \inst1|process_0~8_combout\);

-- Location: LCCOMB_X81_Y35_N0
\inst1|process_0~9\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|process_0~9_combout\ = (\inst1|Add1~27_combout\) # ((\inst1|Add1~26_combout\) # ((\inst1|process_0~8_combout\) # (\inst1|Add1~25_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|Add1~27_combout\,
	datab => \inst1|Add1~26_combout\,
	datac => \inst1|process_0~8_combout\,
	datad => \inst1|Add1~25_combout\,
	combout => \inst1|process_0~9_combout\);

-- Location: LCCOMB_X82_Y35_N30
\inst1|process_0~10\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|process_0~10_combout\ = (\inst1|Add1~33_combout\) # (\inst1|Add1~32_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst1|Add1~33_combout\,
	datad => \inst1|Add1~32_combout\,
	combout => \inst1|process_0~10_combout\);

-- Location: LCCOMB_X80_Y35_N0
\inst1|process_0~11\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|process_0~11_combout\ = (!\inst1|Add1~21_combout\ & (!\inst1|process_0~9_combout\ & (\inst1|Add1~24_combout\ & !\inst1|process_0~10_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|Add1~21_combout\,
	datab => \inst1|process_0~9_combout\,
	datac => \inst1|Add1~24_combout\,
	datad => \inst1|process_0~10_combout\,
	combout => \inst1|process_0~11_combout\);

-- Location: FF_X80_Y35_N1
\inst1|v_sync\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst1|process_0~11_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1|v_sync~q\);

-- Location: LCCOMB_X81_Y36_N22
\inst1|process_0~12\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|process_0~12_combout\ = (!\inst1|Add1~24_combout\ & (((!\inst1|Add0~18_combout\ & !\inst1|Add0~16_combout\)) # (!\inst1|h_count~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000101010101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|Add1~24_combout\,
	datab => \inst1|Add0~18_combout\,
	datac => \inst1|Add0~16_combout\,
	datad => \inst1|h_count~2_combout\,
	combout => \inst1|process_0~12_combout\);

-- Location: FF_X81_Y36_N23
\inst1|disp_ena\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst1|process_0~12_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1|disp_ena~q\);

-- Location: LCCOMB_X81_Y36_N2
\inst1|LessThan2~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|LessThan2~0_combout\ = ((\inst1|process_0~5_combout\) # ((!\inst1|Add0~18_combout\ & !\inst1|Add0~16_combout\))) # (!\inst1|Add0~20_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111101010111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|Add0~20_combout\,
	datab => \inst1|Add0~18_combout\,
	datac => \inst1|Add0~16_combout\,
	datad => \inst1|process_0~5_combout\,
	combout => \inst1|LessThan2~0_combout\);

-- Location: FF_X81_Y36_N21
\inst1|column[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst1|h_count~3_combout\,
	ena => \inst1|LessThan2~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1|column\(7));

-- Location: FF_X81_Y36_N9
\inst1|column[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst1|h_count~9_combout\,
	ena => \inst1|LessThan2~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1|column\(9));

-- Location: FF_X81_Y36_N19
\inst1|column[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst1|h_count~10_combout\,
	ena => \inst1|LessThan2~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1|column\(8));

-- Location: LCCOMB_X80_Y33_N10
\inst|LessThan35~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan35~3_combout\ = (\inst1|column\(7) & (\inst1|column\(9) & \inst1|column\(8)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|column\(7),
	datac => \inst1|column\(9),
	datad => \inst1|column\(8),
	combout => \inst|LessThan35~3_combout\);

-- Location: FF_X81_Y36_N5
\inst1|column[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst1|h_count~2_combout\,
	ena => \inst1|LessThan2~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1|column\(10));

-- Location: LCCOMB_X80_Y36_N10
\inst1|column[31]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|column[31]~feeder_combout\ = VCC

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	combout => \inst1|column[31]~feeder_combout\);

-- Location: FF_X80_Y36_N11
\inst1|column[31]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst1|column[31]~feeder_combout\,
	ena => \inst1|LessThan2~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1|column\(31));

-- Location: LCCOMB_X83_Y35_N0
\inst9|a[0]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst9|a[0]~feeder_combout\ = VCC

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	combout => \inst9|a[0]~feeder_combout\);

-- Location: FF_X83_Y35_N1
\inst9|a[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst9|a[0]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst9|a\(0));

-- Location: LCCOMB_X80_Y33_N12
\inst|LessThan35~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan35~4_combout\ = (\inst9|a\(0) & (((!\inst|LessThan35~3_combout\ & !\inst1|column\(10))) # (!\inst1|column\(31))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|LessThan35~3_combout\,
	datab => \inst1|column\(10),
	datac => \inst1|column\(31),
	datad => \inst9|a\(0),
	combout => \inst|LessThan35~4_combout\);

-- Location: LCCOMB_X80_Y33_N20
\inst|LessThan34~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan34~1_combout\ = (!\inst9|a\(0) & (!\inst1|column\(31) & ((\inst1|column\(9)) # (\inst1|column\(8)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010100000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|a\(0),
	datab => \inst1|column\(9),
	datac => \inst1|column\(31),
	datad => \inst1|column\(8),
	combout => \inst|LessThan34~1_combout\);

-- Location: LCCOMB_X80_Y33_N30
\inst|LessThan34~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan34~2_combout\ = (\inst|LessThan34~1_combout\) # ((\inst1|column\(31) & ((\inst1|column\(10)) # (!\inst9|a\(0)))) # (!\inst1|column\(31) & (\inst1|column\(10) & !\inst9|a\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110011111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|column\(31),
	datab => \inst|LessThan34~1_combout\,
	datac => \inst1|column\(10),
	datad => \inst9|a\(0),
	combout => \inst|LessThan34~2_combout\);

-- Location: LCCOMB_X80_Y33_N0
\inst|LessThan34~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan34~3_combout\ = (\inst9|a\(0) & (\inst1|column\(9) & (\inst1|column\(31) & \inst1|column\(8)))) # (!\inst9|a\(0) & (!\inst1|column\(9) & (!\inst1|column\(31) & !\inst1|column\(8))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|a\(0),
	datab => \inst1|column\(9),
	datac => \inst1|column\(31),
	datad => \inst1|column\(8),
	combout => \inst|LessThan34~3_combout\);

-- Location: LCCOMB_X1_Y36_N8
\inst8|counter[0]~25\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst8|counter[0]~25_combout\ = \inst8|counter\(0) $ (VCC)
-- \inst8|counter[0]~26\ = CARRY(\inst8|counter\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst8|counter\(0),
	datad => VCC,
	combout => \inst8|counter[0]~25_combout\,
	cout => \inst8|counter[0]~26\);

-- Location: FF_X1_Y36_N9
\inst8|counter[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst8|counter[0]~25_combout\,
	sclr => \inst8|LessThan0~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst8|counter\(0));

-- Location: LCCOMB_X1_Y36_N10
\inst8|counter[1]~27\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst8|counter[1]~27_combout\ = (\inst8|counter\(1) & (!\inst8|counter[0]~26\)) # (!\inst8|counter\(1) & ((\inst8|counter[0]~26\) # (GND)))
-- \inst8|counter[1]~28\ = CARRY((!\inst8|counter[0]~26\) # (!\inst8|counter\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst8|counter\(1),
	datad => VCC,
	cin => \inst8|counter[0]~26\,
	combout => \inst8|counter[1]~27_combout\,
	cout => \inst8|counter[1]~28\);

-- Location: FF_X1_Y36_N11
\inst8|counter[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst8|counter[1]~27_combout\,
	sclr => \inst8|LessThan0~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst8|counter\(1));

-- Location: LCCOMB_X1_Y36_N12
\inst8|counter[2]~29\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst8|counter[2]~29_combout\ = (\inst8|counter\(2) & (\inst8|counter[1]~28\ $ (GND))) # (!\inst8|counter\(2) & (!\inst8|counter[1]~28\ & VCC))
-- \inst8|counter[2]~30\ = CARRY((\inst8|counter\(2) & !\inst8|counter[1]~28\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst8|counter\(2),
	datad => VCC,
	cin => \inst8|counter[1]~28\,
	combout => \inst8|counter[2]~29_combout\,
	cout => \inst8|counter[2]~30\);

-- Location: FF_X1_Y36_N13
\inst8|counter[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst8|counter[2]~29_combout\,
	sclr => \inst8|LessThan0~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst8|counter\(2));

-- Location: LCCOMB_X1_Y36_N14
\inst8|counter[3]~31\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst8|counter[3]~31_combout\ = (\inst8|counter\(3) & (!\inst8|counter[2]~30\)) # (!\inst8|counter\(3) & ((\inst8|counter[2]~30\) # (GND)))
-- \inst8|counter[3]~32\ = CARRY((!\inst8|counter[2]~30\) # (!\inst8|counter\(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst8|counter\(3),
	datad => VCC,
	cin => \inst8|counter[2]~30\,
	combout => \inst8|counter[3]~31_combout\,
	cout => \inst8|counter[3]~32\);

-- Location: FF_X1_Y36_N15
\inst8|counter[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst8|counter[3]~31_combout\,
	sclr => \inst8|LessThan0~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst8|counter\(3));

-- Location: LCCOMB_X1_Y36_N16
\inst8|counter[4]~33\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst8|counter[4]~33_combout\ = (\inst8|counter\(4) & (\inst8|counter[3]~32\ $ (GND))) # (!\inst8|counter\(4) & (!\inst8|counter[3]~32\ & VCC))
-- \inst8|counter[4]~34\ = CARRY((\inst8|counter\(4) & !\inst8|counter[3]~32\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst8|counter\(4),
	datad => VCC,
	cin => \inst8|counter[3]~32\,
	combout => \inst8|counter[4]~33_combout\,
	cout => \inst8|counter[4]~34\);

-- Location: FF_X1_Y36_N17
\inst8|counter[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst8|counter[4]~33_combout\,
	sclr => \inst8|LessThan0~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst8|counter\(4));

-- Location: LCCOMB_X1_Y36_N18
\inst8|counter[5]~35\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst8|counter[5]~35_combout\ = (\inst8|counter\(5) & (!\inst8|counter[4]~34\)) # (!\inst8|counter\(5) & ((\inst8|counter[4]~34\) # (GND)))
-- \inst8|counter[5]~36\ = CARRY((!\inst8|counter[4]~34\) # (!\inst8|counter\(5)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst8|counter\(5),
	datad => VCC,
	cin => \inst8|counter[4]~34\,
	combout => \inst8|counter[5]~35_combout\,
	cout => \inst8|counter[5]~36\);

-- Location: FF_X1_Y36_N19
\inst8|counter[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst8|counter[5]~35_combout\,
	sclr => \inst8|LessThan0~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst8|counter\(5));

-- Location: LCCOMB_X1_Y36_N20
\inst8|counter[6]~37\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst8|counter[6]~37_combout\ = (\inst8|counter\(6) & (\inst8|counter[5]~36\ $ (GND))) # (!\inst8|counter\(6) & (!\inst8|counter[5]~36\ & VCC))
-- \inst8|counter[6]~38\ = CARRY((\inst8|counter\(6) & !\inst8|counter[5]~36\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst8|counter\(6),
	datad => VCC,
	cin => \inst8|counter[5]~36\,
	combout => \inst8|counter[6]~37_combout\,
	cout => \inst8|counter[6]~38\);

-- Location: FF_X1_Y36_N21
\inst8|counter[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst8|counter[6]~37_combout\,
	sclr => \inst8|LessThan0~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst8|counter\(6));

-- Location: LCCOMB_X1_Y36_N22
\inst8|counter[7]~39\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst8|counter[7]~39_combout\ = (\inst8|counter\(7) & (!\inst8|counter[6]~38\)) # (!\inst8|counter\(7) & ((\inst8|counter[6]~38\) # (GND)))
-- \inst8|counter[7]~40\ = CARRY((!\inst8|counter[6]~38\) # (!\inst8|counter\(7)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst8|counter\(7),
	datad => VCC,
	cin => \inst8|counter[6]~38\,
	combout => \inst8|counter[7]~39_combout\,
	cout => \inst8|counter[7]~40\);

-- Location: FF_X1_Y36_N23
\inst8|counter[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst8|counter[7]~39_combout\,
	sclr => \inst8|LessThan0~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst8|counter\(7));

-- Location: LCCOMB_X1_Y36_N24
\inst8|counter[8]~41\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst8|counter[8]~41_combout\ = (\inst8|counter\(8) & (\inst8|counter[7]~40\ $ (GND))) # (!\inst8|counter\(8) & (!\inst8|counter[7]~40\ & VCC))
-- \inst8|counter[8]~42\ = CARRY((\inst8|counter\(8) & !\inst8|counter[7]~40\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst8|counter\(8),
	datad => VCC,
	cin => \inst8|counter[7]~40\,
	combout => \inst8|counter[8]~41_combout\,
	cout => \inst8|counter[8]~42\);

-- Location: FF_X1_Y36_N25
\inst8|counter[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst8|counter[8]~41_combout\,
	sclr => \inst8|LessThan0~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst8|counter\(8));

-- Location: LCCOMB_X1_Y36_N26
\inst8|counter[9]~43\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst8|counter[9]~43_combout\ = (\inst8|counter\(9) & (!\inst8|counter[8]~42\)) # (!\inst8|counter\(9) & ((\inst8|counter[8]~42\) # (GND)))
-- \inst8|counter[9]~44\ = CARRY((!\inst8|counter[8]~42\) # (!\inst8|counter\(9)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst8|counter\(9),
	datad => VCC,
	cin => \inst8|counter[8]~42\,
	combout => \inst8|counter[9]~43_combout\,
	cout => \inst8|counter[9]~44\);

-- Location: FF_X1_Y36_N27
\inst8|counter[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst8|counter[9]~43_combout\,
	sclr => \inst8|LessThan0~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst8|counter\(9));

-- Location: LCCOMB_X1_Y36_N28
\inst8|counter[10]~45\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst8|counter[10]~45_combout\ = (\inst8|counter\(10) & (\inst8|counter[9]~44\ $ (GND))) # (!\inst8|counter\(10) & (!\inst8|counter[9]~44\ & VCC))
-- \inst8|counter[10]~46\ = CARRY((\inst8|counter\(10) & !\inst8|counter[9]~44\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst8|counter\(10),
	datad => VCC,
	cin => \inst8|counter[9]~44\,
	combout => \inst8|counter[10]~45_combout\,
	cout => \inst8|counter[10]~46\);

-- Location: FF_X1_Y36_N29
\inst8|counter[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst8|counter[10]~45_combout\,
	sclr => \inst8|LessThan0~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst8|counter\(10));

-- Location: LCCOMB_X1_Y36_N30
\inst8|counter[11]~47\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst8|counter[11]~47_combout\ = (\inst8|counter\(11) & (!\inst8|counter[10]~46\)) # (!\inst8|counter\(11) & ((\inst8|counter[10]~46\) # (GND)))
-- \inst8|counter[11]~48\ = CARRY((!\inst8|counter[10]~46\) # (!\inst8|counter\(11)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst8|counter\(11),
	datad => VCC,
	cin => \inst8|counter[10]~46\,
	combout => \inst8|counter[11]~47_combout\,
	cout => \inst8|counter[11]~48\);

-- Location: FF_X1_Y36_N31
\inst8|counter[11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst8|counter[11]~47_combout\,
	sclr => \inst8|LessThan0~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst8|counter\(11));

-- Location: LCCOMB_X1_Y35_N0
\inst8|counter[12]~49\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst8|counter[12]~49_combout\ = (\inst8|counter\(12) & (\inst8|counter[11]~48\ $ (GND))) # (!\inst8|counter\(12) & (!\inst8|counter[11]~48\ & VCC))
-- \inst8|counter[12]~50\ = CARRY((\inst8|counter\(12) & !\inst8|counter[11]~48\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst8|counter\(12),
	datad => VCC,
	cin => \inst8|counter[11]~48\,
	combout => \inst8|counter[12]~49_combout\,
	cout => \inst8|counter[12]~50\);

-- Location: FF_X1_Y35_N1
\inst8|counter[12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst8|counter[12]~49_combout\,
	sclr => \inst8|LessThan0~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst8|counter\(12));

-- Location: LCCOMB_X1_Y35_N2
\inst8|counter[13]~51\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst8|counter[13]~51_combout\ = (\inst8|counter\(13) & (!\inst8|counter[12]~50\)) # (!\inst8|counter\(13) & ((\inst8|counter[12]~50\) # (GND)))
-- \inst8|counter[13]~52\ = CARRY((!\inst8|counter[12]~50\) # (!\inst8|counter\(13)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst8|counter\(13),
	datad => VCC,
	cin => \inst8|counter[12]~50\,
	combout => \inst8|counter[13]~51_combout\,
	cout => \inst8|counter[13]~52\);

-- Location: FF_X1_Y35_N3
\inst8|counter[13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst8|counter[13]~51_combout\,
	sclr => \inst8|LessThan0~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst8|counter\(13));

-- Location: LCCOMB_X1_Y35_N4
\inst8|counter[14]~53\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst8|counter[14]~53_combout\ = (\inst8|counter\(14) & (\inst8|counter[13]~52\ $ (GND))) # (!\inst8|counter\(14) & (!\inst8|counter[13]~52\ & VCC))
-- \inst8|counter[14]~54\ = CARRY((\inst8|counter\(14) & !\inst8|counter[13]~52\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst8|counter\(14),
	datad => VCC,
	cin => \inst8|counter[13]~52\,
	combout => \inst8|counter[14]~53_combout\,
	cout => \inst8|counter[14]~54\);

-- Location: FF_X1_Y35_N5
\inst8|counter[14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst8|counter[14]~53_combout\,
	sclr => \inst8|LessThan0~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst8|counter\(14));

-- Location: LCCOMB_X1_Y35_N6
\inst8|counter[15]~55\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst8|counter[15]~55_combout\ = (\inst8|counter\(15) & (!\inst8|counter[14]~54\)) # (!\inst8|counter\(15) & ((\inst8|counter[14]~54\) # (GND)))
-- \inst8|counter[15]~56\ = CARRY((!\inst8|counter[14]~54\) # (!\inst8|counter\(15)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst8|counter\(15),
	datad => VCC,
	cin => \inst8|counter[14]~54\,
	combout => \inst8|counter[15]~55_combout\,
	cout => \inst8|counter[15]~56\);

-- Location: FF_X1_Y35_N7
\inst8|counter[15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst8|counter[15]~55_combout\,
	sclr => \inst8|LessThan0~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst8|counter\(15));

-- Location: LCCOMB_X1_Y35_N8
\inst8|counter[16]~57\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst8|counter[16]~57_combout\ = (\inst8|counter\(16) & (\inst8|counter[15]~56\ $ (GND))) # (!\inst8|counter\(16) & (!\inst8|counter[15]~56\ & VCC))
-- \inst8|counter[16]~58\ = CARRY((\inst8|counter\(16) & !\inst8|counter[15]~56\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst8|counter\(16),
	datad => VCC,
	cin => \inst8|counter[15]~56\,
	combout => \inst8|counter[16]~57_combout\,
	cout => \inst8|counter[16]~58\);

-- Location: FF_X1_Y35_N9
\inst8|counter[16]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst8|counter[16]~57_combout\,
	sclr => \inst8|LessThan0~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst8|counter\(16));

-- Location: LCCOMB_X1_Y35_N10
\inst8|counter[17]~59\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst8|counter[17]~59_combout\ = (\inst8|counter\(17) & (!\inst8|counter[16]~58\)) # (!\inst8|counter\(17) & ((\inst8|counter[16]~58\) # (GND)))
-- \inst8|counter[17]~60\ = CARRY((!\inst8|counter[16]~58\) # (!\inst8|counter\(17)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst8|counter\(17),
	datad => VCC,
	cin => \inst8|counter[16]~58\,
	combout => \inst8|counter[17]~59_combout\,
	cout => \inst8|counter[17]~60\);

-- Location: FF_X1_Y35_N11
\inst8|counter[17]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst8|counter[17]~59_combout\,
	sclr => \inst8|LessThan0~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst8|counter\(17));

-- Location: LCCOMB_X1_Y35_N12
\inst8|counter[18]~61\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst8|counter[18]~61_combout\ = (\inst8|counter\(18) & (\inst8|counter[17]~60\ $ (GND))) # (!\inst8|counter\(18) & (!\inst8|counter[17]~60\ & VCC))
-- \inst8|counter[18]~62\ = CARRY((\inst8|counter\(18) & !\inst8|counter[17]~60\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst8|counter\(18),
	datad => VCC,
	cin => \inst8|counter[17]~60\,
	combout => \inst8|counter[18]~61_combout\,
	cout => \inst8|counter[18]~62\);

-- Location: FF_X1_Y35_N13
\inst8|counter[18]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst8|counter[18]~61_combout\,
	sclr => \inst8|LessThan0~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst8|counter\(18));

-- Location: LCCOMB_X1_Y35_N14
\inst8|counter[19]~63\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst8|counter[19]~63_combout\ = (\inst8|counter\(19) & (!\inst8|counter[18]~62\)) # (!\inst8|counter\(19) & ((\inst8|counter[18]~62\) # (GND)))
-- \inst8|counter[19]~64\ = CARRY((!\inst8|counter[18]~62\) # (!\inst8|counter\(19)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst8|counter\(19),
	datad => VCC,
	cin => \inst8|counter[18]~62\,
	combout => \inst8|counter[19]~63_combout\,
	cout => \inst8|counter[19]~64\);

-- Location: FF_X1_Y35_N15
\inst8|counter[19]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst8|counter[19]~63_combout\,
	sclr => \inst8|LessThan0~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst8|counter\(19));

-- Location: LCCOMB_X1_Y35_N16
\inst8|counter[20]~65\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst8|counter[20]~65_combout\ = (\inst8|counter\(20) & (\inst8|counter[19]~64\ $ (GND))) # (!\inst8|counter\(20) & (!\inst8|counter[19]~64\ & VCC))
-- \inst8|counter[20]~66\ = CARRY((\inst8|counter\(20) & !\inst8|counter[19]~64\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst8|counter\(20),
	datad => VCC,
	cin => \inst8|counter[19]~64\,
	combout => \inst8|counter[20]~65_combout\,
	cout => \inst8|counter[20]~66\);

-- Location: FF_X1_Y35_N17
\inst8|counter[20]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst8|counter[20]~65_combout\,
	sclr => \inst8|LessThan0~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst8|counter\(20));

-- Location: LCCOMB_X1_Y35_N18
\inst8|counter[21]~67\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst8|counter[21]~67_combout\ = (\inst8|counter\(21) & (!\inst8|counter[20]~66\)) # (!\inst8|counter\(21) & ((\inst8|counter[20]~66\) # (GND)))
-- \inst8|counter[21]~68\ = CARRY((!\inst8|counter[20]~66\) # (!\inst8|counter\(21)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst8|counter\(21),
	datad => VCC,
	cin => \inst8|counter[20]~66\,
	combout => \inst8|counter[21]~67_combout\,
	cout => \inst8|counter[21]~68\);

-- Location: FF_X1_Y35_N19
\inst8|counter[21]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst8|counter[21]~67_combout\,
	sclr => \inst8|LessThan0~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst8|counter\(21));

-- Location: LCCOMB_X1_Y35_N20
\inst8|counter[22]~69\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst8|counter[22]~69_combout\ = (\inst8|counter\(22) & (\inst8|counter[21]~68\ $ (GND))) # (!\inst8|counter\(22) & (!\inst8|counter[21]~68\ & VCC))
-- \inst8|counter[22]~70\ = CARRY((\inst8|counter\(22) & !\inst8|counter[21]~68\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst8|counter\(22),
	datad => VCC,
	cin => \inst8|counter[21]~68\,
	combout => \inst8|counter[22]~69_combout\,
	cout => \inst8|counter[22]~70\);

-- Location: FF_X1_Y35_N21
\inst8|counter[22]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst8|counter[22]~69_combout\,
	sclr => \inst8|LessThan0~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst8|counter\(22));

-- Location: LCCOMB_X1_Y35_N22
\inst8|counter[23]~71\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst8|counter[23]~71_combout\ = (\inst8|counter\(23) & (!\inst8|counter[22]~70\)) # (!\inst8|counter\(23) & ((\inst8|counter[22]~70\) # (GND)))
-- \inst8|counter[23]~72\ = CARRY((!\inst8|counter[22]~70\) # (!\inst8|counter\(23)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst8|counter\(23),
	datad => VCC,
	cin => \inst8|counter[22]~70\,
	combout => \inst8|counter[23]~71_combout\,
	cout => \inst8|counter[23]~72\);

-- Location: FF_X1_Y35_N23
\inst8|counter[23]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst8|counter[23]~71_combout\,
	sclr => \inst8|LessThan0~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst8|counter\(23));

-- Location: LCCOMB_X1_Y35_N24
\inst8|counter[24]~73\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst8|counter[24]~73_combout\ = \inst8|counter[23]~72\ $ (!\inst8|counter\(24))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000001111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datad => \inst8|counter\(24),
	cin => \inst8|counter[23]~72\,
	combout => \inst8|counter[24]~73_combout\);

-- Location: FF_X1_Y35_N25
\inst8|counter[24]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst8|counter[24]~73_combout\,
	sclr => \inst8|LessThan0~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst8|counter\(24));

-- Location: LCCOMB_X1_Y35_N26
\inst8|LessThan0~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst8|LessThan0~3_combout\ = (((!\inst8|counter\(20)) # (!\inst8|counter\(19))) # (!\inst8|counter\(21))) # (!\inst8|counter\(18))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst8|counter\(18),
	datab => \inst8|counter\(21),
	datac => \inst8|counter\(19),
	datad => \inst8|counter\(20),
	combout => \inst8|LessThan0~3_combout\);

-- Location: LCCOMB_X1_Y36_N6
\inst8|LessThan0~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst8|LessThan0~1_combout\ = (!\inst8|counter\(7) & (!\inst8|counter\(8) & (!\inst8|counter\(9) & !\inst8|counter\(6))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst8|counter\(7),
	datab => \inst8|counter\(8),
	datac => \inst8|counter\(9),
	datad => \inst8|counter\(6),
	combout => \inst8|LessThan0~1_combout\);

-- Location: LCCOMB_X1_Y36_N0
\inst8|LessThan0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst8|LessThan0~0_combout\ = (((!\inst8|counter\(14)) # (!\inst8|counter\(11))) # (!\inst8|counter\(12))) # (!\inst8|counter\(13))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst8|counter\(13),
	datab => \inst8|counter\(12),
	datac => \inst8|counter\(11),
	datad => \inst8|counter\(14),
	combout => \inst8|LessThan0~0_combout\);

-- Location: LCCOMB_X1_Y36_N4
\inst8|LessThan0~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst8|LessThan0~2_combout\ = (!\inst8|counter\(15) & ((\inst8|LessThan0~0_combout\) # ((\inst8|LessThan0~1_combout\ & !\inst8|counter\(10)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst8|LessThan0~1_combout\,
	datab => \inst8|counter\(10),
	datac => \inst8|counter\(15),
	datad => \inst8|LessThan0~0_combout\,
	combout => \inst8|LessThan0~2_combout\);

-- Location: LCCOMB_X1_Y35_N28
\inst8|LessThan0~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst8|LessThan0~4_combout\ = (!\inst8|LessThan0~3_combout\ & ((\inst8|counter\(17)) # ((\inst8|counter\(16) & !\inst8|LessThan0~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010100000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst8|LessThan0~3_combout\,
	datab => \inst8|counter\(16),
	datac => \inst8|LessThan0~2_combout\,
	datad => \inst8|counter\(17),
	combout => \inst8|LessThan0~4_combout\);

-- Location: LCCOMB_X1_Y35_N30
\inst8|LessThan0~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst8|LessThan0~5_combout\ = (\inst8|counter\(24)) # ((\inst8|counter\(23)) # ((\inst8|counter\(22) & \inst8|LessThan0~4_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111011111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst8|counter\(22),
	datab => \inst8|counter\(24),
	datac => \inst8|counter\(23),
	datad => \inst8|LessThan0~4_combout\,
	combout => \inst8|LessThan0~5_combout\);

-- Location: LCCOMB_X1_Y36_N2
\inst8|CLK_1HZ~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst8|CLK_1HZ~0_combout\ = \inst8|LessThan0~5_combout\ $ (\inst8|CLK_1HZ~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst8|LessThan0~5_combout\,
	datac => \inst8|CLK_1HZ~q\,
	combout => \inst8|CLK_1HZ~0_combout\);

-- Location: FF_X1_Y36_N3
\inst8|CLK_1HZ\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst8|CLK_1HZ~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst8|CLK_1HZ~q\);

-- Location: CLKCTRL_G1
\inst8|CLK_1HZ~clkctrl\ : cycloneive_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \inst8|CLK_1HZ~clkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \inst8|CLK_1HZ~clkctrl_outclk\);

-- Location: IOIBUF_X115_Y17_N1
\p1Right~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_p1Right,
	o => \p1Right~input_o\);

-- Location: IOIBUF_X115_Y14_N1
\P1Left~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_P1Left,
	o => \P1Left~input_o\);

-- Location: LCCOMB_X82_Y33_N30
\inst7|Selector5~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst7|Selector5~0_combout\ = (!\p1Right~input_o\ & ((\P1Left~input_o\ & ((\inst7|State.Gs~q\))) # (!\P1Left~input_o\ & (\inst7|State.Fs~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010000000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \p1Right~input_o\,
	datab => \inst7|State.Fs~q\,
	datac => \P1Left~input_o\,
	datad => \inst7|State.Gs~q\,
	combout => \inst7|Selector5~0_combout\);

-- Location: LCCOMB_X82_Y33_N28
\inst7|Selector4~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst7|Selector4~0_combout\ = (!\p1Right~input_o\ & ((\P1Left~input_o\ & ((\inst7|State.Fs~q\))) # (!\P1Left~input_o\ & (\inst7|State.Es~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111000000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst7|State.Es~q\,
	datab => \P1Left~input_o\,
	datac => \p1Right~input_o\,
	datad => \inst7|State.Fs~q\,
	combout => \inst7|Selector4~0_combout\);

-- Location: LCCOMB_X82_Y33_N24
\inst7|Selector3~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst7|Selector3~0_combout\ = (!\p1Right~input_o\ & ((\P1Left~input_o\ & (\inst7|State.Es~q\)) # (!\P1Left~input_o\ & ((\inst7|State.Ds~q\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000101100001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst7|State.Es~q\,
	datab => \P1Left~input_o\,
	datac => \p1Right~input_o\,
	datad => \inst7|State.Ds~q\,
	combout => \inst7|Selector3~0_combout\);

-- Location: LCCOMB_X82_Y33_N12
\inst7|Selector0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst7|Selector0~0_combout\ = (\p1Right~input_o\) # ((\inst7|State.As~q\ & ((!\inst7|State.Bs~q\) # (!\P1Left~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101011111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \p1Right~input_o\,
	datab => \P1Left~input_o\,
	datac => \inst7|State.As~q\,
	datad => \inst7|State.Bs~q\,
	combout => \inst7|Selector0~0_combout\);

-- Location: FF_X82_Y33_N13
\inst7|State.As\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst8|CLK_1HZ~clkctrl_outclk\,
	d => \inst7|Selector0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst7|State.As~q\);

-- Location: LCCOMB_X82_Y33_N4
\inst7|Selector1~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst7|Selector1~0_combout\ = (!\p1Right~input_o\ & ((\P1Left~input_o\ & ((\inst7|State.Cs~q\))) # (!\P1Left~input_o\ & (\inst7|State.Bs~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111000000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst7|State.Bs~q\,
	datab => \P1Left~input_o\,
	datac => \p1Right~input_o\,
	datad => \inst7|State.Cs~q\,
	combout => \inst7|Selector1~0_combout\);

-- Location: LCCOMB_X82_Y33_N22
\inst7|Selector1~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst7|Selector1~1_combout\ = (\inst7|Selector1~0_combout\) # ((!\inst7|State.As~q\ & \p1Right~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110011011100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst7|State.As~q\,
	datab => \inst7|Selector1~0_combout\,
	datac => \p1Right~input_o\,
	combout => \inst7|Selector1~1_combout\);

-- Location: FF_X82_Y33_N23
\inst7|State.Bs\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst8|CLK_1HZ~clkctrl_outclk\,
	d => \inst7|Selector1~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst7|State.Bs~q\);

-- Location: LCCOMB_X82_Y33_N14
\inst7|Selector2~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst7|Selector2~0_combout\ = (!\p1Right~input_o\ & ((\P1Left~input_o\ & ((\inst7|State.Ds~q\))) # (!\P1Left~input_o\ & (\inst7|State.Cs~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010000000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \p1Right~input_o\,
	datab => \inst7|State.Cs~q\,
	datac => \P1Left~input_o\,
	datad => \inst7|State.Ds~q\,
	combout => \inst7|Selector2~0_combout\);

-- Location: LCCOMB_X82_Y33_N8
\inst7|Selector2~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst7|Selector2~1_combout\ = (\inst7|Selector2~0_combout\) # ((\inst7|State.Bs~q\ & \p1Right~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110011101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst7|State.Bs~q\,
	datab => \inst7|Selector2~0_combout\,
	datac => \p1Right~input_o\,
	combout => \inst7|Selector2~1_combout\);

-- Location: FF_X82_Y33_N9
\inst7|State.Cs\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst8|CLK_1HZ~clkctrl_outclk\,
	d => \inst7|Selector2~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst7|State.Cs~q\);

-- Location: LCCOMB_X82_Y33_N2
\inst7|Selector3~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst7|Selector3~1_combout\ = (\inst7|Selector3~0_combout\) # ((\p1Right~input_o\ & \inst7|State.Cs~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110011101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \p1Right~input_o\,
	datab => \inst7|Selector3~0_combout\,
	datac => \inst7|State.Cs~q\,
	combout => \inst7|Selector3~1_combout\);

-- Location: FF_X82_Y33_N3
\inst7|State.Ds\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst8|CLK_1HZ~clkctrl_outclk\,
	d => \inst7|Selector3~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst7|State.Ds~q\);

-- Location: LCCOMB_X82_Y33_N6
\inst7|Selector4~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst7|Selector4~1_combout\ = (\inst7|Selector4~0_combout\) # ((\p1Right~input_o\ & \inst7|State.Ds~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110011101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \p1Right~input_o\,
	datab => \inst7|Selector4~0_combout\,
	datac => \inst7|State.Ds~q\,
	combout => \inst7|Selector4~1_combout\);

-- Location: FF_X82_Y33_N7
\inst7|State.Es\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst8|CLK_1HZ~clkctrl_outclk\,
	d => \inst7|Selector4~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst7|State.Es~q\);

-- Location: LCCOMB_X82_Y33_N16
\inst7|Selector5~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst7|Selector5~1_combout\ = (\inst7|Selector5~0_combout\) # ((\p1Right~input_o\ & \inst7|State.Es~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst7|Selector5~0_combout\,
	datac => \p1Right~input_o\,
	datad => \inst7|State.Es~q\,
	combout => \inst7|Selector5~1_combout\);

-- Location: FF_X82_Y33_N17
\inst7|State.Fs\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst8|CLK_1HZ~clkctrl_outclk\,
	d => \inst7|Selector5~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst7|State.Fs~q\);

-- Location: LCCOMB_X82_Y33_N26
\inst7|Selector6~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst7|Selector6~0_combout\ = (!\p1Right~input_o\ & ((\P1Left~input_o\ & (\inst7|State.Hs~q\)) # (!\P1Left~input_o\ & ((\inst7|State.Gs~q\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100010101000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \p1Right~input_o\,
	datab => \inst7|State.Hs~q\,
	datac => \P1Left~input_o\,
	datad => \inst7|State.Gs~q\,
	combout => \inst7|Selector6~0_combout\);

-- Location: LCCOMB_X82_Y33_N0
\inst7|Selector6~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst7|Selector6~1_combout\ = (\inst7|Selector6~0_combout\) # ((\p1Right~input_o\ & \inst7|State.Fs~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100011111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \p1Right~input_o\,
	datab => \inst7|State.Fs~q\,
	datac => \inst7|Selector6~0_combout\,
	combout => \inst7|Selector6~1_combout\);

-- Location: FF_X82_Y33_N1
\inst7|State.Gs\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst8|CLK_1HZ~clkctrl_outclk\,
	d => \inst7|Selector6~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst7|State.Gs~q\);

-- Location: LCCOMB_X82_Y33_N18
\inst7|Selector7~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst7|Selector7~0_combout\ = (\inst7|State.Ist~q\ & ((\P1Left~input_o\) # ((\p1Right~input_o\ & \inst7|State.Gs~q\)))) # (!\inst7|State.Ist~q\ & (((\p1Right~input_o\ & \inst7|State.Gs~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst7|State.Ist~q\,
	datab => \P1Left~input_o\,
	datac => \p1Right~input_o\,
	datad => \inst7|State.Gs~q\,
	combout => \inst7|Selector7~0_combout\);

-- Location: LCCOMB_X82_Y33_N20
\inst7|Selector7~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst7|Selector7~1_combout\ = (\inst7|Selector7~0_combout\) # ((!\p1Right~input_o\ & (!\P1Left~input_o\ & \inst7|State.Hs~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \p1Right~input_o\,
	datab => \P1Left~input_o\,
	datac => \inst7|State.Hs~q\,
	datad => \inst7|Selector7~0_combout\,
	combout => \inst7|Selector7~1_combout\);

-- Location: FF_X82_Y33_N21
\inst7|State.Hs\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst8|CLK_1HZ~clkctrl_outclk\,
	d => \inst7|Selector7~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst7|State.Hs~q\);

-- Location: LCCOMB_X82_Y33_N10
\inst7|Selector8~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst7|Selector8~0_combout\ = (\p1Right~input_o\ & ((\inst7|State.Hs~q\) # ((!\P1Left~input_o\ & \inst7|State.Ist~q\)))) # (!\p1Right~input_o\ & (!\P1Left~input_o\ & (\inst7|State.Ist~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \p1Right~input_o\,
	datab => \P1Left~input_o\,
	datac => \inst7|State.Ist~q\,
	datad => \inst7|State.Hs~q\,
	combout => \inst7|Selector8~0_combout\);

-- Location: FF_X82_Y33_N11
\inst7|State.Ist\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst8|CLK_1HZ~clkctrl_outclk\,
	d => \inst7|Selector8~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst7|State.Ist~q\);

-- Location: FF_X80_Y33_N3
\inst7|i\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst8|CLK_1HZ~clkctrl_outclk\,
	asdata => \inst7|State.Ist~q\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst7|i~q\);

-- Location: FF_X82_Y36_N31
\inst1|column[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst1|h_count~7_combout\,
	ena => \inst1|LessThan2~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1|column\(1));

-- Location: LCCOMB_X81_Y36_N14
\inst1|column[0]~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|column[0]~0_combout\ = !\inst1|h_count~8_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \inst1|h_count~8_combout\,
	combout => \inst1|column[0]~0_combout\);

-- Location: FF_X81_Y36_N15
\inst1|column[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst1|column[0]~0_combout\,
	ena => \inst1|LessThan2~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1|column\(0));

-- Location: LCCOMB_X79_Y34_N28
\inst|LessThan34~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan34~0_combout\ = (!\inst1|column\(1) & ((\inst1|column\(0)) # (!\inst9|a\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101000001010101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|column\(1),
	datac => \inst1|column\(0),
	datad => \inst9|a\(0),
	combout => \inst|LessThan34~0_combout\);

-- Location: FF_X81_Y36_N17
\inst1|column[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst1|h_count~1_combout\,
	ena => \inst1|LessThan2~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1|column\(2));

-- Location: FF_X80_Y36_N25
\inst1|column[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst1|h_count~6_combout\,
	ena => \inst1|LessThan2~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1|column\(4));

-- Location: FF_X81_Y36_N7
\inst1|column[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst1|h_count~0_combout\,
	ena => \inst1|LessThan2~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1|column\(3));

-- Location: LCCOMB_X80_Y36_N12
\inst|LessThan34~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan34~4_combout\ = ((\inst1|column\(2)) # ((\inst1|column\(4)) # (\inst1|column\(3)))) # (!\inst|LessThan34~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|LessThan34~0_combout\,
	datab => \inst1|column\(2),
	datac => \inst1|column\(4),
	datad => \inst1|column\(3),
	combout => \inst|LessThan34~4_combout\);

-- Location: FF_X80_Y36_N21
\inst1|column[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst1|h_count~4_combout\,
	ena => \inst1|LessThan2~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1|column\(6));

-- Location: LCCOMB_X80_Y36_N22
\inst|LessThan11~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan11~0_combout\ = (!\inst1|column\(6) & !\inst1|column\(7))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001100000011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst1|column\(6),
	datac => \inst1|column\(7),
	combout => \inst|LessThan11~0_combout\);

-- Location: FF_X80_Y36_N15
\inst1|column[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst1|h_count~5_combout\,
	ena => \inst1|LessThan2~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1|column\(5));

-- Location: LCCOMB_X80_Y36_N8
\inst|LessThan34~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan34~5_combout\ = ((\inst|LessThan34~4_combout\ & ((\inst1|column\(5)) # (!\inst9|a\(0)))) # (!\inst|LessThan34~4_combout\ & (!\inst9|a\(0) & \inst1|column\(5)))) # (!\inst|LessThan11~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011111100101111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|LessThan34~4_combout\,
	datab => \inst9|a\(0),
	datac => \inst|LessThan11~0_combout\,
	datad => \inst1|column\(5),
	combout => \inst|LessThan34~5_combout\);

-- Location: LCCOMB_X80_Y33_N2
\inst|process_0~8\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|process_0~8_combout\ = (\inst7|i~q\ & ((\inst|LessThan34~2_combout\) # ((\inst|LessThan34~3_combout\ & \inst|LessThan34~5_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|LessThan34~2_combout\,
	datab => \inst|LessThan34~3_combout\,
	datac => \inst7|i~q\,
	datad => \inst|LessThan34~5_combout\,
	combout => \inst|process_0~8_combout\);

-- Location: LCCOMB_X79_Y33_N0
\inst|LessThan35~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan35~0_combout\ = (!\inst1|column\(5) & (!\inst1|column\(4) & (!\inst1|column\(6) & !\inst1|column\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|column\(5),
	datab => \inst1|column\(4),
	datac => \inst1|column\(6),
	datad => \inst1|column\(3),
	combout => \inst|LessThan35~0_combout\);

-- Location: LCCOMB_X80_Y34_N0
\inst|LessThan3~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan3~0_combout\ = (\inst1|column\(0) & !\inst1|column\(1))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst1|column\(0),
	datad => \inst1|column\(1),
	combout => \inst|LessThan3~0_combout\);

-- Location: LCCOMB_X80_Y34_N2
\inst|LessThan35~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan35~1_combout\ = (\inst|LessThan34~3_combout\ & ((\inst9|a\(0)) # ((\inst|LessThan3~0_combout\ & !\inst1|column\(7)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010111000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|a\(0),
	datab => \inst|LessThan3~0_combout\,
	datac => \inst1|column\(7),
	datad => \inst|LessThan34~3_combout\,
	combout => \inst|LessThan35~1_combout\);

-- Location: LCCOMB_X80_Y34_N28
\inst|LessThan35~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan35~2_combout\ = (\inst|LessThan35~0_combout\ & (!\inst1|column\(10) & (!\inst1|column\(2) & \inst|LessThan35~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|LessThan35~0_combout\,
	datab => \inst1|column\(10),
	datac => \inst1|column\(2),
	datad => \inst|LessThan35~1_combout\,
	combout => \inst|LessThan35~2_combout\);

-- Location: FF_X81_Y35_N5
\inst1|row[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst1|Add1~31_combout\,
	ena => \inst1|ALT_INV_Add1~24_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1|row\(1));

-- Location: FF_X82_Y35_N3
\inst1|row[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst1|Add1~32_combout\,
	ena => \inst1|ALT_INV_Add1~24_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1|row\(8));

-- Location: FF_X82_Y35_N29
\inst1|row[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst1|Add1~33_combout\,
	ena => \inst1|ALT_INV_Add1~24_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1|row\(7));

-- Location: FF_X82_Y35_N27
\inst1|row[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst1|Add1~21_combout\,
	ena => \inst1|ALT_INV_Add1~24_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1|row\(9));

-- Location: LCCOMB_X80_Y35_N26
\inst|LessThan36~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan36~0_combout\ = (!\inst1|row\(1) & (!\inst1|row\(8) & (!\inst1|row\(7) & !\inst1|row\(9))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|row\(1),
	datab => \inst1|row\(8),
	datac => \inst1|row\(7),
	datad => \inst1|row\(9),
	combout => \inst|LessThan36~0_combout\);

-- Location: LCCOMB_X81_Y35_N18
\inst1|row[0]~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|row[0]~0_combout\ = !\inst1|Add1~30_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst1|Add1~30_combout\,
	combout => \inst1|row[0]~0_combout\);

-- Location: FF_X81_Y35_N19
\inst1|row[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst1|row[0]~0_combout\,
	ena => \inst1|ALT_INV_Add1~24_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1|row\(0));

-- Location: LCCOMB_X80_Y35_N6
\inst1|row[31]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|row[31]~feeder_combout\ = VCC

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	combout => \inst1|row[31]~feeder_combout\);

-- Location: FF_X80_Y35_N7
\inst1|row[31]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst1|row[31]~feeder_combout\,
	ena => \inst1|ALT_INV_Add1~24_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1|row\(31));

-- Location: LCCOMB_X80_Y35_N22
\inst|process_0~24\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|process_0~24_combout\ = (\inst9|a\(0) & (((\inst1|row\(31))))) # (!\inst9|a\(0) & (\inst|LessThan36~0_combout\ & (\inst1|row\(0) & !\inst1|row\(31))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|LessThan36~0_combout\,
	datab => \inst1|row\(0),
	datac => \inst9|a\(0),
	datad => \inst1|row\(31),
	combout => \inst|process_0~24_combout\);

-- Location: FF_X81_Y35_N27
\inst1|row[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst1|Add1~25_combout\,
	ena => \inst1|ALT_INV_Add1~24_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1|row\(4));

-- Location: FF_X81_Y35_N29
\inst1|row[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst1|Add1~26_combout\,
	ena => \inst1|ALT_INV_Add1~24_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1|row\(5));

-- Location: FF_X81_Y35_N17
\inst1|row[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst1|Add1~28_combout\,
	ena => \inst1|ALT_INV_Add1~24_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1|row\(3));

-- Location: FF_X81_Y35_N7
\inst1|row[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst1|Add1~27_combout\,
	ena => \inst1|ALT_INV_Add1~24_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1|row\(6));

-- Location: LCCOMB_X81_Y35_N20
\inst|LessThan1~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan1~0_combout\ = (!\inst1|row\(4) & (!\inst1|row\(5) & (!\inst1|row\(3) & !\inst1|row\(6))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|row\(4),
	datab => \inst1|row\(5),
	datac => \inst1|row\(3),
	datad => \inst1|row\(6),
	combout => \inst|LessThan1~0_combout\);

-- Location: FF_X81_Y35_N11
\inst1|row[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst1|Add1~29_combout\,
	ena => \inst1|ALT_INV_Add1~24_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1|row\(2));

-- Location: LCCOMB_X80_Y35_N16
\inst|LessThan1~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan1~1_combout\ = (\inst|LessThan1~0_combout\ & !\inst1|row\(2))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000101000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|LessThan1~0_combout\,
	datac => \inst1|row\(2),
	combout => \inst|LessThan1~1_combout\);

-- Location: LCCOMB_X80_Y35_N2
\inst|LessThan0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan0~0_combout\ = ((\inst1|row\(2)) # ((\inst1|row\(7)) # (\inst1|row\(1)))) # (!\inst|LessThan1~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|LessThan1~0_combout\,
	datab => \inst1|row\(2),
	datac => \inst1|row\(7),
	datad => \inst1|row\(1),
	combout => \inst|LessThan0~0_combout\);

-- Location: LCCOMB_X81_Y35_N22
\inst|LessThan0~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan0~1_combout\ = (\inst1|row\(4) & (\inst1|row\(5) & ((\inst1|row\(1)) # (!\inst1|row\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|row\(4),
	datab => \inst1|row\(5),
	datac => \inst1|row\(1),
	datad => \inst1|row\(0),
	combout => \inst|LessThan0~1_combout\);

-- Location: LCCOMB_X80_Y35_N20
\inst|process_0~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|process_0~2_combout\ = (\inst1|row\(6)) # ((\inst1|row\(3) & (\inst1|row\(2) & \inst|LessThan0~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|row\(6),
	datab => \inst1|row\(3),
	datac => \inst1|row\(2),
	datad => \inst|LessThan0~1_combout\,
	combout => \inst|process_0~2_combout\);

-- Location: LCCOMB_X80_Y35_N30
\inst|process_0~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|process_0~3_combout\ = (\inst1|row\(7) & ((\inst1|row\(8) & (\inst|LessThan1~1_combout\)) # (!\inst1|row\(8) & ((\inst|process_0~2_combout\))))) # (!\inst1|row\(7) & (((\inst1|row\(8)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101101011010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|row\(7),
	datab => \inst|LessThan1~1_combout\,
	datac => \inst1|row\(8),
	datad => \inst|process_0~2_combout\,
	combout => \inst|process_0~3_combout\);

-- Location: LCCOMB_X80_Y35_N8
\inst|process_0~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|process_0~4_combout\ = (\inst9|a\(0) & (((\inst|process_0~3_combout\ & \inst1|row\(9))))) # (!\inst9|a\(0) & ((\inst|LessThan0~0_combout\) # ((\inst|process_0~3_combout\) # (\inst1|row\(9)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010101010100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|a\(0),
	datab => \inst|LessThan0~0_combout\,
	datac => \inst|process_0~3_combout\,
	datad => \inst1|row\(9),
	combout => \inst|process_0~4_combout\);

-- Location: LCCOMB_X80_Y35_N18
\inst|process_0~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|process_0~5_combout\ = (\inst|process_0~24_combout\ & (\inst|process_0~4_combout\ & ((\inst|LessThan1~1_combout\) # (\inst9|a\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|process_0~24_combout\,
	datab => \inst|LessThan1~1_combout\,
	datac => \inst9|a\(0),
	datad => \inst|process_0~4_combout\,
	combout => \inst|process_0~5_combout\);

-- Location: LCCOMB_X80_Y33_N14
\inst|process_0~9\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|process_0~9_combout\ = (\inst|process_0~8_combout\ & (\inst|process_0~5_combout\ & ((\inst|LessThan35~4_combout\) # (\inst|LessThan35~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|LessThan35~4_combout\,
	datab => \inst|process_0~8_combout\,
	datac => \inst|LessThan35~2_combout\,
	datad => \inst|process_0~5_combout\,
	combout => \inst|process_0~9_combout\);

-- Location: LCCOMB_X81_Y34_N16
\inst|LessThan26~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan26~0_combout\ = (\inst1|column\(31) & (\inst9|a\(0) & \inst1|column\(9))) # (!\inst1|column\(31) & (!\inst9|a\(0) & !\inst1|column\(9)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000000000011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst1|column\(31),
	datac => \inst9|a\(0),
	datad => \inst1|column\(9),
	combout => \inst|LessThan26~0_combout\);

-- Location: LCCOMB_X79_Y34_N26
\inst|LessThan26~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan26~2_combout\ = ((\inst1|column\(3) & (\inst1|column\(4) & \inst1|column\(6)))) # (!\inst9|a\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|column\(3),
	datab => \inst1|column\(4),
	datac => \inst1|column\(6),
	datad => \inst9|a\(0),
	combout => \inst|LessThan26~2_combout\);

-- Location: LCCOMB_X79_Y34_N30
\inst|LessThan26~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan26~3_combout\ = (\inst|LessThan26~2_combout\ & ((\inst1|column\(2)) # (!\inst|LessThan34~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010001010100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|LessThan26~2_combout\,
	datab => \inst|LessThan34~0_combout\,
	datac => \inst1|column\(2),
	combout => \inst|LessThan26~3_combout\);

-- Location: LCCOMB_X79_Y34_N8
\inst|LessThan26~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan26~1_combout\ = (\inst1|column\(7)) # ((\inst1|column\(8)) # ((\inst1|column\(6) & \inst1|column\(5))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111011111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|column\(6),
	datab => \inst1|column\(7),
	datac => \inst1|column\(8),
	datad => \inst1|column\(5),
	combout => \inst|LessThan26~1_combout\);

-- Location: LCCOMB_X79_Y34_N0
\inst|LessThan26~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan26~4_combout\ = (\inst|LessThan26~3_combout\) # ((\inst|LessThan26~1_combout\) # ((!\inst|LessThan35~0_combout\ & !\inst9|a\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101011111011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|LessThan26~3_combout\,
	datab => \inst|LessThan35~0_combout\,
	datac => \inst|LessThan26~1_combout\,
	datad => \inst9|a\(0),
	combout => \inst|LessThan26~4_combout\);

-- Location: LCCOMB_X81_Y34_N26
\inst|LessThan26~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan26~5_combout\ = (\inst1|column\(10) & (!\inst1|column\(31) & (\inst9|a\(0)))) # (!\inst1|column\(10) & ((\inst9|a\(0)) # ((!\inst1|column\(31) & !\inst1|column\(9)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111000001110001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|column\(10),
	datab => \inst1|column\(31),
	datac => \inst9|a\(0),
	datad => \inst1|column\(9),
	combout => \inst|LessThan26~5_combout\);

-- Location: LCCOMB_X81_Y33_N0
\inst|process_0~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|process_0~6_combout\ = (\inst|process_0~5_combout\ & (((\inst|LessThan26~0_combout\ & \inst|LessThan26~4_combout\)) # (!\inst|LessThan26~5_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|LessThan26~0_combout\,
	datab => \inst|process_0~5_combout\,
	datac => \inst|LessThan26~4_combout\,
	datad => \inst|LessThan26~5_combout\,
	combout => \inst|process_0~6_combout\);

-- Location: FF_X81_Y33_N27
\inst7|g\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst8|CLK_1HZ~clkctrl_outclk\,
	asdata => \inst7|State.Gs~q\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst7|g~q\);

-- Location: LCCOMB_X81_Y36_N24
\inst|LessThan27~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan27~0_combout\ = (\inst1|column\(9) & ((\inst1|column\(7)) # (\inst1|column\(8))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst1|column\(7),
	datac => \inst1|column\(9),
	datad => \inst1|column\(8),
	combout => \inst|LessThan27~0_combout\);

-- Location: LCCOMB_X80_Y36_N18
\inst|LessThan30~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan30~0_combout\ = (\inst1|column\(5) & (\inst1|column\(2) & (\inst1|column\(4) & \inst1|column\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|column\(5),
	datab => \inst1|column\(2),
	datac => \inst1|column\(4),
	datad => \inst1|column\(3),
	combout => \inst|LessThan30~0_combout\);

-- Location: LCCOMB_X81_Y36_N12
\inst|LessThan27~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan27~1_combout\ = ((!\inst1|column\(6) & (!\inst|LessThan30~0_combout\ & !\inst1|column\(8)))) # (!\inst|LessThan27~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001100110111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|column\(6),
	datab => \inst|LessThan27~0_combout\,
	datac => \inst|LessThan30~0_combout\,
	datad => \inst1|column\(8),
	combout => \inst|LessThan27~1_combout\);

-- Location: LCCOMB_X80_Y33_N24
\inst|process_0~7\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|process_0~7_combout\ = (!\inst1|column\(7) & (!\inst1|column\(9) & (!\inst1|column\(10) & !\inst1|column\(8))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|column\(7),
	datab => \inst1|column\(9),
	datac => \inst1|column\(10),
	datad => \inst1|column\(8),
	combout => \inst|process_0~7_combout\);

-- Location: LCCOMB_X79_Y33_N18
\inst|LessThan15~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan15~0_combout\ = (!\inst1|column\(1) & (!\inst1|column\(2) & (\inst1|column\(0) & \inst|LessThan35~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|column\(1),
	datab => \inst1|column\(2),
	datac => \inst1|column\(0),
	datad => \inst|LessThan35~0_combout\,
	combout => \inst|LessThan15~0_combout\);

-- Location: LCCOMB_X81_Y33_N12
\inst|LessThan19~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan19~0_combout\ = (!\inst1|column\(31) & ((\inst9|a\(0)) # ((\inst|process_0~7_combout\ & \inst|LessThan15~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|a\(0),
	datab => \inst|process_0~7_combout\,
	datac => \inst|LessThan15~0_combout\,
	datad => \inst1|column\(31),
	combout => \inst|LessThan19~0_combout\);

-- Location: LCCOMB_X81_Y33_N6
\inst|LessThan27~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan27~2_combout\ = (\inst|LessThan19~0_combout\) # ((!\inst1|column\(10) & (\inst9|a\(0) & \inst|LessThan27~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111101000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|column\(10),
	datab => \inst9|a\(0),
	datac => \inst|LessThan27~1_combout\,
	datad => \inst|LessThan19~0_combout\,
	combout => \inst|LessThan27~2_combout\);

-- Location: LCCOMB_X81_Y33_N26
\inst|blue~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|blue~0_combout\ = (!\inst|process_0~9_combout\ & (((!\inst|LessThan27~2_combout\) # (!\inst7|g~q\)) # (!\inst|process_0~6_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001010101010101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|process_0~9_combout\,
	datab => \inst|process_0~6_combout\,
	datac => \inst7|g~q\,
	datad => \inst|LessThan27~2_combout\,
	combout => \inst|blue~0_combout\);

-- Location: FF_X81_Y33_N11
\inst7|f\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst8|CLK_1HZ~clkctrl_outclk\,
	asdata => \inst7|State.Fs~q\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst7|f~q\);

-- Location: LCCOMB_X81_Y33_N4
\inst|process_0~21\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|process_0~21_combout\ = (!\inst1|column\(7) & !\inst1|column\(8))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst1|column\(7),
	datad => \inst1|column\(8),
	combout => \inst|process_0~21_combout\);

-- Location: LCCOMB_X80_Y36_N4
\inst|LessThan23~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan23~0_combout\ = ((!\inst1|column\(5) & ((!\inst1|column\(3)) # (!\inst1|column\(4))))) # (!\inst1|column\(6))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011011101110111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|column\(5),
	datab => \inst1|column\(6),
	datac => \inst1|column\(4),
	datad => \inst1|column\(3),
	combout => \inst|LessThan23~0_combout\);

-- Location: LCCOMB_X81_Y34_N30
\inst|LessThan11~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan11~5_combout\ = (\inst9|a\(0) & !\inst1|column\(10))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst9|a\(0),
	datad => \inst1|column\(10),
	combout => \inst|LessThan11~5_combout\);

-- Location: LCCOMB_X81_Y33_N22
\inst|LessThan23~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan23~1_combout\ = (\inst|LessThan11~5_combout\ & (((\inst|process_0~21_combout\ & \inst|LessThan23~0_combout\)) # (!\inst1|column\(9))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|process_0~21_combout\,
	datab => \inst|LessThan23~0_combout\,
	datac => \inst|LessThan11~5_combout\,
	datad => \inst1|column\(9),
	combout => \inst|LessThan23~1_combout\);

-- Location: LCCOMB_X80_Y36_N30
\inst|LessThan26~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan26~6_combout\ = (\inst1|column\(6) & \inst1|column\(5))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst1|column\(6),
	datac => \inst1|column\(5),
	combout => \inst|LessThan26~6_combout\);

-- Location: LCCOMB_X80_Y36_N16
\inst|LessThan22~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan22~2_combout\ = (\inst|LessThan26~6_combout\ & (\inst1|column\(4) & (\inst1|column\(7) & \inst1|column\(8))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|LessThan26~6_combout\,
	datab => \inst1|column\(4),
	datac => \inst1|column\(7),
	datad => \inst1|column\(8),
	combout => \inst|LessThan22~2_combout\);

-- Location: LCCOMB_X80_Y36_N2
\inst|LessThan22~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan22~3_combout\ = (\inst|LessThan22~2_combout\ & ((\inst1|column\(3)) # ((!\inst|LessThan34~0_combout\ & \inst1|column\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|LessThan34~0_combout\,
	datab => \inst1|column\(2),
	datac => \inst|LessThan22~2_combout\,
	datad => \inst1|column\(3),
	combout => \inst|LessThan22~3_combout\);

-- Location: LCCOMB_X79_Y33_N16
\inst|LessThan22~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan22~4_combout\ = (\inst1|column\(1)) # ((\inst1|column\(2)) # ((!\inst|LessThan35~0_combout\) # (!\inst|process_0~21_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|column\(1),
	datab => \inst1|column\(2),
	datac => \inst|process_0~21_combout\,
	datad => \inst|LessThan35~0_combout\,
	combout => \inst|LessThan22~4_combout\);

-- Location: LCCOMB_X79_Y33_N26
\inst|LessThan22~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan22~5_combout\ = (\inst|LessThan22~3_combout\ & ((\inst1|column\(31) $ (!\inst9|a\(0))))) # (!\inst|LessThan22~3_combout\ & (\inst|LessThan22~4_combout\ & (!\inst1|column\(31) & !\inst9|a\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000000001110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|LessThan22~3_combout\,
	datab => \inst|LessThan22~4_combout\,
	datac => \inst1|column\(31),
	datad => \inst9|a\(0),
	combout => \inst|LessThan22~5_combout\);

-- Location: LCCOMB_X81_Y33_N30
\inst|LessThan14~8\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan14~8_combout\ = (\inst1|column\(31) & (!\inst1|column\(9) & (\inst9|a\(0) & !\inst1|column\(10)))) # (!\inst1|column\(31) & ((\inst9|a\(0)) # ((!\inst1|column\(9) & !\inst1|column\(10)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000001110001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|column\(9),
	datab => \inst1|column\(31),
	datac => \inst9|a\(0),
	datad => \inst1|column\(10),
	combout => \inst|LessThan14~8_combout\);

-- Location: LCCOMB_X81_Y33_N16
\inst|process_0~22\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|process_0~22_combout\ = (\inst|LessThan23~1_combout\ & ((\inst|LessThan22~5_combout\) # ((!\inst|LessThan14~8_combout\)))) # (!\inst|LessThan23~1_combout\ & (\inst|LessThan19~0_combout\ & ((\inst|LessThan22~5_combout\) # 
-- (!\inst|LessThan14~8_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111110001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|LessThan23~1_combout\,
	datab => \inst|LessThan22~5_combout\,
	datac => \inst|LessThan14~8_combout\,
	datad => \inst|LessThan19~0_combout\,
	combout => \inst|process_0~22_combout\);

-- Location: LCCOMB_X81_Y33_N10
\inst|process_0~23\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|process_0~23_combout\ = (\inst|process_0~5_combout\ & (\inst7|f~q\ & \inst|process_0~22_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|process_0~5_combout\,
	datac => \inst7|f~q\,
	datad => \inst|process_0~22_combout\,
	combout => \inst|process_0~23_combout\);

-- Location: LCCOMB_X81_Y34_N8
\inst|LessThan31~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan31~0_combout\ = (((!\inst1|column\(5) & \inst|LessThan11~0_combout\)) # (!\inst1|column\(9))) # (!\inst1|column\(8))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111010111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|column\(8),
	datab => \inst1|column\(5),
	datac => \inst|LessThan11~0_combout\,
	datad => \inst1|column\(9),
	combout => \inst|LessThan31~0_combout\);

-- Location: LCCOMB_X81_Y33_N18
\inst|process_0~19\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|process_0~19_combout\ = (\inst|process_0~5_combout\ & ((\inst|LessThan19~0_combout\) # ((\inst|LessThan11~5_combout\ & \inst|LessThan31~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|LessThan19~0_combout\,
	datab => \inst|process_0~5_combout\,
	datac => \inst|LessThan11~5_combout\,
	datad => \inst|LessThan31~0_combout\,
	combout => \inst|process_0~19_combout\);

-- Location: LCCOMB_X80_Y34_N10
\inst|LessThan19~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan19~2_combout\ = (\inst1|column\(5) & (\inst1|column\(7) & ((\inst1|column\(2)) # (\inst1|column\(3)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|column\(2),
	datab => \inst1|column\(5),
	datac => \inst1|column\(7),
	datad => \inst1|column\(3),
	combout => \inst|LessThan19~2_combout\);

-- Location: LCCOMB_X80_Y34_N16
\inst|LessThan19~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan19~1_combout\ = (\inst1|column\(6) & (\inst1|column\(4) & \inst1|column\(8)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst1|column\(6),
	datac => \inst1|column\(4),
	datad => \inst1|column\(8),
	combout => \inst|LessThan19~1_combout\);

-- Location: LCCOMB_X81_Y34_N28
\inst|LessThan11~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan11~3_combout\ = (!\inst1|column\(10) & (\inst9|a\(0) & !\inst1|column\(9)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|column\(10),
	datac => \inst9|a\(0),
	datad => \inst1|column\(9),
	combout => \inst|LessThan11~3_combout\);

-- Location: LCCOMB_X81_Y33_N28
\inst|LessThan19~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan19~3_combout\ = (\inst|LessThan19~0_combout\) # ((\inst|LessThan11~3_combout\ & ((!\inst|LessThan19~1_combout\) # (!\inst|LessThan19~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011111110101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|LessThan19~0_combout\,
	datab => \inst|LessThan19~2_combout\,
	datac => \inst|LessThan19~1_combout\,
	datad => \inst|LessThan11~3_combout\,
	combout => \inst|LessThan19~3_combout\);

-- Location: FF_X81_Y33_N15
\inst7|e\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst8|CLK_1HZ~clkctrl_outclk\,
	asdata => \inst7|State.Es~q\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst7|e~q\);

-- Location: LCCOMB_X79_Y34_N4
\inst|LessThan18~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan18~0_combout\ = (!\inst1|column\(3) & (\inst|LessThan34~0_combout\ & !\inst1|column\(2)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010000000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|column\(3),
	datab => \inst|LessThan34~0_combout\,
	datac => \inst1|column\(2),
	combout => \inst|LessThan18~0_combout\);

-- Location: LCCOMB_X79_Y34_N22
\inst|LessThan18~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan18~1_combout\ = (\inst1|column\(4) & (\inst|LessThan18~0_combout\ & \inst9|a\(0))) # (!\inst1|column\(4) & ((\inst|LessThan18~0_combout\) # (\inst9|a\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001100110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst1|column\(4),
	datac => \inst|LessThan18~0_combout\,
	datad => \inst9|a\(0),
	combout => \inst|LessThan18~1_combout\);

-- Location: LCCOMB_X79_Y34_N16
\inst|LessThan18~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan18~2_combout\ = (\inst1|column\(6)) # ((\inst1|column\(5)) # (!\inst|LessThan18~1_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111110101111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|column\(6),
	datac => \inst|LessThan18~1_combout\,
	datad => \inst1|column\(5),
	combout => \inst|LessThan18~2_combout\);

-- Location: LCCOMB_X79_Y34_N2
\inst|LessThan18~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan18~3_combout\ = (\inst|LessThan18~2_combout\ & (((\inst1|column\(7) & \inst1|column\(8))) # (!\inst9|a\(0)))) # (!\inst|LessThan18~2_combout\ & (!\inst9|a\(0) & ((\inst1|column\(7)) # (\inst1|column\(8)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000011111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|LessThan18~2_combout\,
	datab => \inst1|column\(7),
	datac => \inst1|column\(8),
	datad => \inst9|a\(0),
	combout => \inst|LessThan18~3_combout\);

-- Location: LCCOMB_X81_Y33_N24
\inst|LessThan18~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan18~4_combout\ = ((\inst|LessThan18~3_combout\ & (\inst1|column\(31) $ (!\inst9|a\(0))))) # (!\inst|LessThan14~8_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101010101110101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|LessThan14~8_combout\,
	datab => \inst1|column\(31),
	datac => \inst|LessThan18~3_combout\,
	datad => \inst9|a\(0),
	combout => \inst|LessThan18~4_combout\);

-- Location: LCCOMB_X81_Y33_N14
\inst|process_0~20\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|process_0~20_combout\ = (\inst|LessThan19~3_combout\ & (\inst|process_0~5_combout\ & (\inst7|e~q\ & \inst|LessThan18~4_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|LessThan19~3_combout\,
	datab => \inst|process_0~5_combout\,
	datac => \inst7|e~q\,
	datad => \inst|LessThan18~4_combout\,
	combout => \inst|process_0~20_combout\);

-- Location: LCCOMB_X80_Y34_N4
\inst|LessThan30~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan30~2_combout\ = (\inst1|column\(2)) # ((\inst1|column\(7)) # ((\inst1|column\(1)) # (!\inst|LessThan35~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111101111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|column\(2),
	datab => \inst1|column\(7),
	datac => \inst|LessThan35~0_combout\,
	datad => \inst1|column\(1),
	combout => \inst|LessThan30~2_combout\);

-- Location: LCCOMB_X80_Y34_N18
\inst|LessThan30~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan30~1_combout\ = (\inst1|column\(7) & ((\inst1|column\(6)) # ((\inst|LessThan30~0_combout\ & !\inst|LessThan3~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|LessThan30~0_combout\,
	datab => \inst|LessThan3~0_combout\,
	datac => \inst1|column\(7),
	datad => \inst1|column\(6),
	combout => \inst|LessThan30~1_combout\);

-- Location: LCCOMB_X80_Y34_N30
\inst|LessThan30~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan30~3_combout\ = (\inst1|column\(8)) # ((\inst|LessThan30~1_combout\) # ((\inst|LessThan30~2_combout\ & !\inst9|a\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111110101110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|column\(8),
	datab => \inst|LessThan30~2_combout\,
	datac => \inst9|a\(0),
	datad => \inst|LessThan30~1_combout\,
	combout => \inst|LessThan30~3_combout\);

-- Location: FF_X81_Y33_N9
\inst7|h\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst8|CLK_1HZ~clkctrl_outclk\,
	asdata => \inst7|State.Hs~q\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst7|h~q\);

-- Location: LCCOMB_X81_Y33_N8
\inst|process_0~18\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|process_0~18_combout\ = (\inst7|h~q\ & (((\inst|LessThan30~3_combout\ & \inst|LessThan26~0_combout\)) # (!\inst|LessThan26~5_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011000000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|LessThan30~3_combout\,
	datab => \inst|LessThan26~5_combout\,
	datac => \inst7|h~q\,
	datad => \inst|LessThan26~0_combout\,
	combout => \inst|process_0~18_combout\);

-- Location: LCCOMB_X81_Y33_N2
\inst|blue~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|blue~3_combout\ = (!\inst|process_0~23_combout\ & (!\inst|process_0~20_combout\ & ((!\inst|process_0~18_combout\) # (!\inst|process_0~19_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000100000101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|process_0~23_combout\,
	datab => \inst|process_0~19_combout\,
	datac => \inst|process_0~20_combout\,
	datad => \inst|process_0~18_combout\,
	combout => \inst|blue~3_combout\);

-- Location: LCCOMB_X79_Y33_N10
\inst7|a~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst7|a~0_combout\ = !\inst7|State.As~q\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \inst7|State.As~q\,
	combout => \inst7|a~0_combout\);

-- Location: FF_X79_Y33_N11
\inst7|a\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst8|CLK_1HZ~clkctrl_outclk\,
	d => \inst7|a~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst7|a~q\);

-- Location: LCCOMB_X79_Y33_N12
\inst|LessThan3~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan3~1_combout\ = (\inst1|column\(3)) # ((\inst1|column\(4)) # (\inst1|column\(2)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111101110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|column\(3),
	datab => \inst1|column\(4),
	datad => \inst1|column\(2),
	combout => \inst|LessThan3~1_combout\);

-- Location: LCCOMB_X79_Y33_N6
\inst|LessThan3~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan3~2_combout\ = (\inst1|column\(5) & (((\inst1|column\(6)) # (!\inst9|a\(0))))) # (!\inst1|column\(5) & (!\inst9|a\(0) & ((\inst1|column\(1)) # (\inst1|column\(6)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000011111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|column\(5),
	datab => \inst1|column\(1),
	datac => \inst1|column\(6),
	datad => \inst9|a\(0),
	combout => \inst|LessThan3~2_combout\);

-- Location: LCCOMB_X79_Y33_N24
\inst|LessThan3~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan3~3_combout\ = (\inst|LessThan3~1_combout\ & (\inst9|a\(0) & ((!\inst|LessThan3~2_combout\)))) # (!\inst|LessThan3~1_combout\ & ((\inst9|a\(0)) # ((\inst1|column\(0) & !\inst|LessThan3~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100010011011100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|LessThan3~1_combout\,
	datab => \inst9|a\(0),
	datac => \inst1|column\(0),
	datad => \inst|LessThan3~2_combout\,
	combout => \inst|LessThan3~3_combout\);

-- Location: LCCOMB_X79_Y33_N4
\inst|process_0~10\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|process_0~10_combout\ = (!\inst1|column\(2) & (!\inst1|column\(1) & \inst|LessThan35~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst1|column\(2),
	datac => \inst1|column\(1),
	datad => \inst|LessThan35~0_combout\,
	combout => \inst|process_0~10_combout\);

-- Location: LCCOMB_X79_Y33_N30
\inst|process_0~11\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|process_0~11_combout\ = (\inst|process_0~10_combout\ & (((\inst1|column\(0)) # (!\inst9|a\(0))) # (!\inst1|column\(31)))) # (!\inst|process_0~10_combout\ & (\inst1|column\(31) $ (((\inst9|a\(0))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011001111101110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|process_0~10_combout\,
	datab => \inst1|column\(31),
	datac => \inst1|column\(0),
	datad => \inst9|a\(0),
	combout => \inst|process_0~11_combout\);

-- Location: LCCOMB_X79_Y33_N8
\inst|process_0~12\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|process_0~12_combout\ = (\inst7|a~q\ & (\inst|LessThan3~3_combout\ & (!\inst|process_0~11_combout\ & \inst|process_0~7_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst7|a~q\,
	datab => \inst|LessThan3~3_combout\,
	datac => \inst|process_0~11_combout\,
	datad => \inst|process_0~7_combout\,
	combout => \inst|process_0~12_combout\);

-- Location: LCCOMB_X80_Y35_N28
\inst|LessThan36~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan36~1_combout\ = (\inst|LessThan36~0_combout\ & \inst1|row\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|LessThan36~0_combout\,
	datad => \inst1|row\(0),
	combout => \inst|LessThan36~1_combout\);

-- Location: LCCOMB_X80_Y35_N12
\inst|LessThan1~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan1~2_combout\ = (!\inst1|row\(31) & ((\inst9|a\(0)) # ((\inst|LessThan1~1_combout\ & \inst|LessThan36~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|row\(31),
	datab => \inst|LessThan1~1_combout\,
	datac => \inst9|a\(0),
	datad => \inst|LessThan36~1_combout\,
	combout => \inst|LessThan1~2_combout\);

-- Location: LCCOMB_X80_Y35_N14
\inst|LessThan1~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan1~3_combout\ = (\inst1|row\(8) & (\inst1|row\(7) & \inst1|row\(9)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst1|row\(8),
	datac => \inst1|row\(7),
	datad => \inst1|row\(9),
	combout => \inst|LessThan1~3_combout\);

-- Location: LCCOMB_X80_Y33_N8
\inst|LessThan1~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan1~4_combout\ = (\inst|LessThan1~2_combout\) # ((\inst9|a\(0) & ((\inst|LessThan1~1_combout\) # (!\inst|LessThan1~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|LessThan1~1_combout\,
	datab => \inst|LessThan1~2_combout\,
	datac => \inst|LessThan1~3_combout\,
	datad => \inst9|a\(0),
	combout => \inst|LessThan1~4_combout\);

-- Location: LCCOMB_X80_Y35_N24
\inst|process_0~13\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|process_0~13_combout\ = (\inst1|row\(8)) # ((\inst1|row\(7) & \inst|process_0~2_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100011111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|row\(7),
	datab => \inst|process_0~2_combout\,
	datac => \inst1|row\(8),
	combout => \inst|process_0~13_combout\);

-- Location: LCCOMB_X80_Y35_N10
\inst|process_0~14\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|process_0~14_combout\ = (\inst|process_0~13_combout\ & ((\inst9|a\(0) $ (!\inst1|row\(9))))) # (!\inst|process_0~13_combout\ & (\inst|LessThan0~0_combout\ & (!\inst9|a\(0) & !\inst1|row\(9))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000000001110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|LessThan0~0_combout\,
	datab => \inst|process_0~13_combout\,
	datac => \inst9|a\(0),
	datad => \inst1|row\(9),
	combout => \inst|process_0~14_combout\);

-- Location: LCCOMB_X80_Y33_N26
\inst|LessThan0~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan0~2_combout\ = (\inst|process_0~14_combout\ & (((\inst1|row\(31)) # (!\inst9|a\(0))))) # (!\inst|process_0~14_combout\ & (!\inst9|a\(0) & ((\inst1|row\(9)) # (\inst1|row\(31)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|row\(9),
	datab => \inst|process_0~14_combout\,
	datac => \inst1|row\(31),
	datad => \inst9|a\(0),
	combout => \inst|LessThan0~2_combout\);

-- Location: LCCOMB_X80_Y33_N4
\inst|LessThan6~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan6~0_combout\ = (\inst1|column\(7)) # ((\inst1|column\(9)) # ((\inst1|column\(10)) # (\inst1|column\(8))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|column\(7),
	datab => \inst1|column\(9),
	datac => \inst1|column\(10),
	datad => \inst1|column\(8),
	combout => \inst|LessThan6~0_combout\);

-- Location: LCCOMB_X79_Y33_N28
\inst|LessThan6~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan6~1_combout\ = (\inst1|column\(4)) # (\inst1|column\(3))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst1|column\(4),
	datad => \inst1|column\(3),
	combout => \inst|LessThan6~1_combout\);

-- Location: LCCOMB_X79_Y33_N22
\inst|LessThan6~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan6~2_combout\ = (\inst1|column\(5) & ((\inst|LessThan6~1_combout\) # ((!\inst|LessThan34~0_combout\ & \inst1|column\(2))))) # (!\inst1|column\(5) & (!\inst|LessThan6~1_combout\ & (\inst|LessThan34~0_combout\ & !\inst1|column\(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000101010011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|column\(5),
	datab => \inst|LessThan6~1_combout\,
	datac => \inst|LessThan34~0_combout\,
	datad => \inst1|column\(2),
	combout => \inst|LessThan6~2_combout\);

-- Location: LCCOMB_X79_Y33_N20
\inst|LessThan6~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan6~3_combout\ = (\inst1|column\(5) & (((\inst|LessThan6~2_combout\ & \inst1|column\(6))) # (!\inst9|a\(0)))) # (!\inst1|column\(5) & (!\inst9|a\(0) & ((\inst1|column\(6)) # (!\inst|LessThan6~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000011111011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|column\(5),
	datab => \inst|LessThan6~2_combout\,
	datac => \inst1|column\(6),
	datad => \inst9|a\(0),
	combout => \inst|LessThan6~3_combout\);

-- Location: LCCOMB_X79_Y33_N14
\inst|LessThan6~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan6~4_combout\ = (\inst1|column\(31) & ((\inst|LessThan6~0_combout\) # ((\inst|LessThan6~3_combout\) # (!\inst9|a\(0))))) # (!\inst1|column\(31) & (!\inst9|a\(0) & ((\inst|LessThan6~0_combout\) # (\inst|LessThan6~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110000011111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|LessThan6~0_combout\,
	datab => \inst|LessThan6~3_combout\,
	datac => \inst1|column\(31),
	datad => \inst9|a\(0),
	combout => \inst|LessThan6~4_combout\);

-- Location: LCCOMB_X79_Y33_N2
\inst|LessThan7~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan7~0_combout\ = ((!\inst1|column\(5) & (!\inst1|column\(4) & !\inst1|column\(3)))) # (!\inst1|column\(6))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100011111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|column\(5),
	datab => \inst1|column\(4),
	datac => \inst1|column\(6),
	datad => \inst1|column\(3),
	combout => \inst|LessThan7~0_combout\);

-- Location: LCCOMB_X80_Y33_N28
\inst|LessThan7~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan7~1_combout\ = (\inst1|column\(9)) # ((\inst1|column\(10)) # (\inst1|column\(8)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst1|column\(9),
	datac => \inst1|column\(10),
	datad => \inst1|column\(8),
	combout => \inst|LessThan7~1_combout\);

-- Location: LCCOMB_X80_Y33_N22
\inst|LessThan7~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan7~2_combout\ = (\inst1|column\(31) & (((\inst|LessThan7~1_combout\) # (\inst|process_0~7_combout\)) # (!\inst|LessThan7~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|LessThan7~0_combout\,
	datab => \inst|LessThan7~1_combout\,
	datac => \inst1|column\(31),
	datad => \inst|process_0~7_combout\,
	combout => \inst|LessThan7~2_combout\);

-- Location: LCCOMB_X80_Y33_N16
\inst|LessThan7~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan7~3_combout\ = (\inst9|a\(0) & (((\inst|process_0~7_combout\) # (!\inst|LessThan7~2_combout\)))) # (!\inst9|a\(0) & (\inst|LessThan15~0_combout\ & (!\inst|LessThan7~2_combout\ & \inst|process_0~7_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010111000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|a\(0),
	datab => \inst|LessThan15~0_combout\,
	datac => \inst|LessThan7~2_combout\,
	datad => \inst|process_0~7_combout\,
	combout => \inst|LessThan7~3_combout\);

-- Location: FF_X80_Y33_N19
\inst7|b\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst8|CLK_1HZ~clkctrl_outclk\,
	asdata => \inst7|State.Bs~q\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst7|b~q\);

-- Location: LCCOMB_X80_Y33_N18
\inst|process_0~15\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|process_0~15_combout\ = (\inst|LessThan6~4_combout\ & (\inst|LessThan7~3_combout\ & (\inst7|b~q\ & \inst|process_0~5_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|LessThan6~4_combout\,
	datab => \inst|LessThan7~3_combout\,
	datac => \inst7|b~q\,
	datad => \inst|process_0~5_combout\,
	combout => \inst|process_0~15_combout\);

-- Location: LCCOMB_X80_Y33_N6
\inst|blue~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|blue~1_combout\ = (!\inst|process_0~15_combout\ & (((!\inst|LessThan0~2_combout\) # (!\inst|LessThan1~4_combout\)) # (!\inst|process_0~12_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|process_0~12_combout\,
	datab => \inst|LessThan1~4_combout\,
	datac => \inst|LessThan0~2_combout\,
	datad => \inst|process_0~15_combout\,
	combout => \inst|blue~1_combout\);

-- Location: LCCOMB_X81_Y34_N22
\inst|LessThan11~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan11~4_combout\ = (\inst9|a\(0) & (((!\inst1|column\(8) & \inst|LessThan11~3_combout\)) # (!\inst1|column\(31)))) # (!\inst9|a\(0) & (!\inst1|column\(8) & (\inst|LessThan11~3_combout\ & !\inst1|column\(31))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000011110100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|column\(8),
	datab => \inst|LessThan11~3_combout\,
	datac => \inst9|a\(0),
	datad => \inst1|column\(31),
	combout => \inst|LessThan11~4_combout\);

-- Location: FF_X81_Y34_N11
\inst7|c\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst8|CLK_1HZ~clkctrl_outclk\,
	asdata => \inst7|State.Cs~q\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst7|c~q\);

-- Location: LCCOMB_X79_Y34_N6
\inst|LessThan14~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan14~4_combout\ = (!\inst1|column\(3) & (!\inst1|column\(4) & (!\inst1|column\(2) & !\inst1|column\(5))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|column\(3),
	datab => \inst1|column\(4),
	datac => \inst1|column\(2),
	datad => \inst1|column\(5),
	combout => \inst|LessThan14~4_combout\);

-- Location: LCCOMB_X80_Y34_N22
\inst|LessThan11~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan11~1_combout\ = (!\inst1|column\(8) & (\inst|LessThan14~4_combout\ & (!\inst9|a\(0) & \inst|LessThan3~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|column\(8),
	datab => \inst|LessThan14~4_combout\,
	datac => \inst9|a\(0),
	datad => \inst|LessThan3~0_combout\,
	combout => \inst|LessThan11~1_combout\);

-- Location: LCCOMB_X80_Y34_N8
\inst|LessThan11~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan11~2_combout\ = ((!\inst1|column\(4) & ((!\inst1|column\(3)) # (!\inst1|column\(2))))) # (!\inst1|column\(5))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011011100111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|column\(2),
	datab => \inst1|column\(5),
	datac => \inst1|column\(4),
	datad => \inst1|column\(3),
	combout => \inst|LessThan11~2_combout\);

-- Location: LCCOMB_X80_Y34_N14
\inst|LessThan11~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan11~6_combout\ = (\inst|LessThan11~1_combout\ & (\inst1|column\(31) $ ((!\inst9|a\(0))))) # (!\inst|LessThan11~1_combout\ & (\inst1|column\(31) & (\inst9|a\(0) & \inst|LessThan11~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001010000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|LessThan11~1_combout\,
	datab => \inst1|column\(31),
	datac => \inst9|a\(0),
	datad => \inst|LessThan11~2_combout\,
	combout => \inst|LessThan11~6_combout\);

-- Location: LCCOMB_X81_Y34_N6
\inst|LessThan11~7\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan11~7_combout\ = (\inst|LessThan11~0_combout\ & (!\inst1|column\(9) & (\inst|LessThan11~6_combout\ & !\inst1|column\(10))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|LessThan11~0_combout\,
	datab => \inst1|column\(9),
	datac => \inst|LessThan11~6_combout\,
	datad => \inst1|column\(10),
	combout => \inst|LessThan11~7_combout\);

-- Location: LCCOMB_X81_Y34_N10
\inst|process_0~16\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|process_0~16_combout\ = (\inst|process_0~5_combout\ & (\inst7|c~q\ & ((\inst|LessThan11~4_combout\) # (\inst|LessThan11~7_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|LessThan11~4_combout\,
	datab => \inst|process_0~5_combout\,
	datac => \inst7|c~q\,
	datad => \inst|LessThan11~7_combout\,
	combout => \inst|process_0~16_combout\);

-- Location: LCCOMB_X81_Y34_N14
\inst|LessThan10~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan10~5_combout\ = (\inst1|column\(8)) # ((\inst1|column\(9)) # (\inst1|column\(10)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111101110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|column\(8),
	datab => \inst1|column\(9),
	datad => \inst1|column\(10),
	combout => \inst|LessThan10~5_combout\);

-- Location: LCCOMB_X81_Y34_N20
\inst|LessThan10~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan10~4_combout\ = (!\inst9|a\(0) & (!\inst1|column\(31) & ((\inst1|column\(3)) # (!\inst|LessThan11~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|column\(3),
	datab => \inst|LessThan11~0_combout\,
	datac => \inst9|a\(0),
	datad => \inst1|column\(31),
	combout => \inst|LessThan10~4_combout\);

-- Location: LCCOMB_X81_Y34_N24
\inst|LessThan10~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan10~6_combout\ = (\inst|LessThan10~4_combout\) # ((\inst1|column\(31) & ((\inst|LessThan10~5_combout\) # (!\inst9|a\(0)))) # (!\inst1|column\(31) & (\inst|LessThan10~5_combout\ & !\inst9|a\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111110001110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|column\(31),
	datab => \inst|LessThan10~5_combout\,
	datac => \inst9|a\(0),
	datad => \inst|LessThan10~4_combout\,
	combout => \inst|LessThan10~6_combout\);

-- Location: LCCOMB_X79_Y34_N10
\inst|LessThan10~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan10~2_combout\ = (\inst1|column\(31) & (\inst1|column\(7) & (\inst1|column\(6) & \inst9|a\(0)))) # (!\inst1|column\(31) & (((!\inst9|a\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000001010101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|column\(31),
	datab => \inst1|column\(7),
	datac => \inst1|column\(6),
	datad => \inst9|a\(0),
	combout => \inst|LessThan10~2_combout\);

-- Location: LCCOMB_X79_Y34_N12
\inst|LessThan10~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan10~3_combout\ = (\inst|LessThan34~0_combout\ & (\inst1|column\(2) & (\inst1|column\(3) $ (!\inst9|a\(0))))) # (!\inst|LessThan34~0_combout\ & (\inst1|column\(3) $ (((!\inst9|a\(0))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010001001010001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|column\(3),
	datab => \inst|LessThan34~0_combout\,
	datac => \inst1|column\(2),
	datad => \inst9|a\(0),
	combout => \inst|LessThan10~3_combout\);

-- Location: LCCOMB_X79_Y34_N20
\inst|LessThan10~7\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan10~7_combout\ = (\inst|LessThan10~2_combout\ & ((\inst1|column\(4)) # ((\inst|LessThan10~3_combout\) # (\inst1|column\(5)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101010101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|LessThan10~2_combout\,
	datab => \inst1|column\(4),
	datac => \inst|LessThan10~3_combout\,
	datad => \inst1|column\(5),
	combout => \inst|LessThan10~7_combout\);

-- Location: LCCOMB_X80_Y36_N26
\inst|LessThan15~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan15~1_combout\ = (!\inst1|column\(4) & !\inst1|column\(5))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001100000011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst1|column\(4),
	datac => \inst1|column\(5),
	combout => \inst|LessThan15~1_combout\);

-- Location: LCCOMB_X80_Y36_N28
\inst|LessThan15~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan15~2_combout\ = (((!\inst1|column\(6) & \inst|LessThan15~1_combout\)) # (!\inst1|column\(8))) # (!\inst1|column\(7))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111010111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|column\(7),
	datab => \inst1|column\(6),
	datac => \inst|LessThan15~1_combout\,
	datad => \inst1|column\(8),
	combout => \inst|LessThan15~2_combout\);

-- Location: FF_X81_Y34_N1
\inst7|d\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst8|CLK_1HZ~clkctrl_outclk\,
	asdata => \inst7|State.Ds~q\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst7|d~q\);

-- Location: LCCOMB_X81_Y34_N0
\inst|process_0~17\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|process_0~17_combout\ = (\inst7|d~q\ & ((\inst|LessThan19~0_combout\) # ((\inst|LessThan15~2_combout\ & \inst|LessThan11~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|LessThan15~2_combout\,
	datab => \inst|LessThan11~3_combout\,
	datac => \inst7|d~q\,
	datad => \inst|LessThan19~0_combout\,
	combout => \inst|process_0~17_combout\);

-- Location: LCCOMB_X79_Y34_N24
\inst|LessThan14~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan14~5_combout\ = ((\inst1|column\(3) & (\inst1|column\(5) & \inst1|column\(2)))) # (!\inst9|a\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|column\(3),
	datab => \inst1|column\(5),
	datac => \inst1|column\(2),
	datad => \inst9|a\(0),
	combout => \inst|LessThan14~5_combout\);

-- Location: LCCOMB_X79_Y34_N18
\inst|LessThan14~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan14~6_combout\ = (\inst|LessThan14~4_combout\ & (\inst|LessThan14~5_combout\ & (!\inst|LessThan34~0_combout\))) # (!\inst|LessThan14~4_combout\ & (((\inst|LessThan14~5_combout\ & !\inst|LessThan34~0_combout\)) # (!\inst9|a\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000110001011101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|LessThan14~4_combout\,
	datab => \inst|LessThan14~5_combout\,
	datac => \inst|LessThan34~0_combout\,
	datad => \inst9|a\(0),
	combout => \inst|LessThan14~6_combout\);

-- Location: LCCOMB_X81_Y34_N18
\inst|LessThan14~7\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|LessThan14~7_combout\ = ((\inst|LessThan14~6_combout\) # ((\inst1|column\(4) & \inst1|column\(5)))) # (!\inst|LessThan11~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110111110101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|LessThan11~0_combout\,
	datab => \inst1|column\(4),
	datac => \inst|LessThan14~6_combout\,
	datad => \inst1|column\(5),
	combout => \inst|LessThan14~7_combout\);

-- Location: LCCOMB_X81_Y34_N2
\inst|process_0~25\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|process_0~25_combout\ = (\inst1|column\(31) & (\inst1|column\(8) & (\inst9|a\(0) & \inst|LessThan14~7_combout\))) # (!\inst1|column\(31) & (!\inst9|a\(0) & ((\inst1|column\(8)) # (\inst|LessThan14~7_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000001100000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|column\(8),
	datab => \inst1|column\(31),
	datac => \inst9|a\(0),
	datad => \inst|LessThan14~7_combout\,
	combout => \inst|process_0~25_combout\);

-- Location: LCCOMB_X81_Y34_N12
\inst|process_0~26\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|process_0~26_combout\ = (\inst|process_0~17_combout\ & (\inst|process_0~5_combout\ & ((\inst|process_0~25_combout\) # (!\inst|LessThan14~8_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|LessThan14~8_combout\,
	datab => \inst|process_0~17_combout\,
	datac => \inst|process_0~5_combout\,
	datad => \inst|process_0~25_combout\,
	combout => \inst|process_0~26_combout\);

-- Location: LCCOMB_X81_Y34_N4
\inst|blue~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|blue~2_combout\ = (!\inst|process_0~26_combout\ & (((!\inst|LessThan10~6_combout\ & !\inst|LessThan10~7_combout\)) # (!\inst|process_0~16_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001010111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|process_0~16_combout\,
	datab => \inst|LessThan10~6_combout\,
	datac => \inst|LessThan10~7_combout\,
	datad => \inst|process_0~26_combout\,
	combout => \inst|blue~2_combout\);

-- Location: LCCOMB_X81_Y33_N20
\inst|blue~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|blue~4_combout\ = (\inst|blue~0_combout\ & (\inst|blue~3_combout\ & (\inst|blue~1_combout\ & \inst|blue~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|blue~0_combout\,
	datab => \inst|blue~3_combout\,
	datac => \inst|blue~1_combout\,
	datad => \inst|blue~2_combout\,
	combout => \inst|blue~4_combout\);

-- Location: LCCOMB_X43_Y72_N30
\inst|blue~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|blue~5_combout\ = (\inst1|disp_ena~q\ & !\inst|blue~4_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst1|disp_ena~q\,
	datad => \inst|blue~4_combout\,
	combout => \inst|blue~5_combout\);

-- Location: LCCOMB_X43_Y72_N24
\inst|blue[7]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|blue[7]~feeder_combout\ = \inst|blue~5_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|blue~5_combout\,
	combout => \inst|blue[7]~feeder_combout\);

-- Location: FF_X43_Y72_N25
\inst|blue[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst|blue[7]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|blue\(7));

-- Location: LCCOMB_X43_Y72_N26
\inst|blue[6]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|blue[6]~feeder_combout\ = \inst|blue~5_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|blue~5_combout\,
	combout => \inst|blue[6]~feeder_combout\);

-- Location: FF_X43_Y72_N27
\inst|blue[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst|blue[6]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|blue\(6));

-- Location: LCCOMB_X43_Y72_N12
\inst|blue[5]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|blue[5]~feeder_combout\ = \inst|blue~5_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|blue~5_combout\,
	combout => \inst|blue[5]~feeder_combout\);

-- Location: FF_X43_Y72_N13
\inst|blue[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst|blue[5]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|blue\(5));

-- Location: LCCOMB_X43_Y72_N6
\inst|blue[4]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|blue[4]~feeder_combout\ = \inst|blue~5_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|blue~5_combout\,
	combout => \inst|blue[4]~feeder_combout\);

-- Location: FF_X43_Y72_N7
\inst|blue[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst|blue[4]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|blue\(4));

-- Location: LCCOMB_X43_Y72_N0
\inst|blue[3]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|blue[3]~feeder_combout\ = \inst|blue~5_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|blue~5_combout\,
	combout => \inst|blue[3]~feeder_combout\);

-- Location: FF_X43_Y72_N1
\inst|blue[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst|blue[3]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|blue\(3));

-- Location: LCCOMB_X43_Y72_N10
\inst|blue[2]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|blue[2]~feeder_combout\ = \inst|blue~5_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|blue~5_combout\,
	combout => \inst|blue[2]~feeder_combout\);

-- Location: FF_X43_Y72_N11
\inst|blue[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst|blue[2]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|blue\(2));

-- Location: LCCOMB_X43_Y72_N28
\inst|blue[1]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|blue[1]~feeder_combout\ = \inst|blue~5_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|blue~5_combout\,
	combout => \inst|blue[1]~feeder_combout\);

-- Location: FF_X43_Y72_N29
\inst|blue[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst|blue[1]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|blue\(1));

-- Location: FF_X43_Y72_N31
\inst|blue[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst|blue~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|blue\(0));

-- Location: LCCOMB_X80_Y34_N20
\inst|red~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|red~0_combout\ = (\inst1|column\(7) & (\inst1|column\(9) & (!\inst1|column\(10) & \inst1|column\(8))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|column\(7),
	datab => \inst1|column\(9),
	datac => \inst1|column\(10),
	datad => \inst1|column\(8),
	combout => \inst|red~0_combout\);

-- Location: LCCOMB_X80_Y34_N6
\inst|red~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|red~1_combout\ = (\inst|red~0_combout\ & (((\inst1|column\(2) & !\inst|LessThan3~0_combout\)) # (!\inst|LessThan35~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|column\(2),
	datab => \inst|LessThan3~0_combout\,
	datac => \inst|LessThan35~0_combout\,
	datad => \inst|red~0_combout\,
	combout => \inst|red~1_combout\);

-- Location: LCCOMB_X80_Y34_N24
\inst|red~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|red~2_combout\ = (!\inst1|column\(7) & (!\inst1|column\(9) & (\inst1|column\(10) & !\inst1|column\(8))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|column\(7),
	datab => \inst1|column\(9),
	datac => \inst1|column\(10),
	datad => \inst1|column\(8),
	combout => \inst|red~2_combout\);

-- Location: LCCOMB_X80_Y34_N26
\inst|red~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|red~3_combout\ = (!\inst1|column\(5) & (!\inst1|column\(4) & ((!\inst1|column\(3)) # (!\inst1|column\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000100000011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|column\(2),
	datab => \inst1|column\(5),
	datac => \inst1|column\(4),
	datad => \inst1|column\(3),
	combout => \inst|red~3_combout\);

-- Location: LCCOMB_X80_Y34_N12
\inst|red~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|red~4_combout\ = (\inst|red~1_combout\) # ((\inst|red~2_combout\ & ((\inst|red~3_combout\) # (!\inst1|column\(6)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101011101110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|red~1_combout\,
	datab => \inst|red~2_combout\,
	datac => \inst|red~3_combout\,
	datad => \inst1|column\(6),
	combout => \inst|red~4_combout\);

-- Location: LCCOMB_X80_Y35_N4
\inst|red~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|red~5_combout\ = (\inst1|row\(31) & (\inst1|column\(31) & ((!\inst|LessThan36~1_combout\) # (!\inst|LessThan1~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|row\(31),
	datab => \inst|LessThan1~1_combout\,
	datac => \inst1|column\(31),
	datad => \inst|LessThan36~1_combout\,
	combout => \inst|red~5_combout\);

-- Location: LCCOMB_X26_Y72_N22
\inst|red~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|red~6_combout\ = (((\inst|red~4_combout\ & \inst|red~5_combout\)) # (!\inst1|disp_ena~q\)) # (!\inst|blue~4_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101010111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|blue~4_combout\,
	datab => \inst|red~4_combout\,
	datac => \inst|red~5_combout\,
	datad => \inst1|disp_ena~q\,
	combout => \inst|red~6_combout\);

-- Location: LCCOMB_X26_Y72_N24
\inst|green[7]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|green[7]~feeder_combout\ = \inst|red~6_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|red~6_combout\,
	combout => \inst|green[7]~feeder_combout\);

-- Location: FF_X26_Y72_N25
\inst|green[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst|green[7]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|green\(7));

-- Location: LCCOMB_X26_Y72_N26
\inst|green[6]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|green[6]~feeder_combout\ = \inst|red~6_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|red~6_combout\,
	combout => \inst|green[6]~feeder_combout\);

-- Location: FF_X26_Y72_N27
\inst|green[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst|green[6]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|green\(6));

-- Location: LCCOMB_X26_Y72_N20
\inst|green[5]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|green[5]~feeder_combout\ = \inst|red~6_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|red~6_combout\,
	combout => \inst|green[5]~feeder_combout\);

-- Location: FF_X26_Y72_N21
\inst|green[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst|green[5]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|green\(5));

-- Location: LCCOMB_X26_Y72_N30
\inst|green[4]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|green[4]~feeder_combout\ = \inst|red~6_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|red~6_combout\,
	combout => \inst|green[4]~feeder_combout\);

-- Location: FF_X26_Y72_N31
\inst|green[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst|green[4]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|green\(4));

-- Location: LCCOMB_X26_Y72_N0
\inst|green[3]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|green[3]~feeder_combout\ = \inst|red~6_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|red~6_combout\,
	combout => \inst|green[3]~feeder_combout\);

-- Location: FF_X26_Y72_N1
\inst|green[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst|green[3]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|green\(3));

-- Location: LCCOMB_X26_Y72_N18
\inst|green[2]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|green[2]~feeder_combout\ = \inst|red~6_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|red~6_combout\,
	combout => \inst|green[2]~feeder_combout\);

-- Location: FF_X26_Y72_N19
\inst|green[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst|green[2]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|green\(2));

-- Location: LCCOMB_X26_Y72_N4
\inst|green[1]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|green[1]~feeder_combout\ = \inst|red~6_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|red~6_combout\,
	combout => \inst|green[1]~feeder_combout\);

-- Location: FF_X26_Y72_N5
\inst|green[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst|green[1]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|green\(1));

-- Location: LCCOMB_X26_Y72_N14
\inst|green[0]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|green[0]~feeder_combout\ = \inst|red~6_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|red~6_combout\,
	combout => \inst|green[0]~feeder_combout\);

-- Location: FF_X26_Y72_N15
\inst|green[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst|green[0]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|green\(0));

-- Location: LCCOMB_X26_Y72_N8
\inst|red[7]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|red[7]~feeder_combout\ = \inst|red~6_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|red~6_combout\,
	combout => \inst|red[7]~feeder_combout\);

-- Location: FF_X26_Y72_N9
\inst|red[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst|red[7]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|red\(7));

-- Location: LCCOMB_X26_Y72_N2
\inst|red[6]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|red[6]~feeder_combout\ = \inst|red~6_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|red~6_combout\,
	combout => \inst|red[6]~feeder_combout\);

-- Location: FF_X26_Y72_N3
\inst|red[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst|red[6]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|red\(6));

-- Location: LCCOMB_X26_Y72_N12
\inst|red[5]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|red[5]~feeder_combout\ = \inst|red~6_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|red~6_combout\,
	combout => \inst|red[5]~feeder_combout\);

-- Location: FF_X26_Y72_N13
\inst|red[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst|red[5]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|red\(5));

-- Location: LCCOMB_X26_Y72_N6
\inst|red[4]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|red[4]~feeder_combout\ = \inst|red~6_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|red~6_combout\,
	combout => \inst|red[4]~feeder_combout\);

-- Location: FF_X26_Y72_N7
\inst|red[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst|red[4]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|red\(4));

-- Location: LCCOMB_X26_Y72_N16
\inst|red[3]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|red[3]~feeder_combout\ = \inst|red~6_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|red~6_combout\,
	combout => \inst|red[3]~feeder_combout\);

-- Location: FF_X26_Y72_N17
\inst|red[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst|red[3]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|red\(3));

-- Location: LCCOMB_X26_Y72_N10
\inst|red[2]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|red[2]~feeder_combout\ = \inst|red~6_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|red~6_combout\,
	combout => \inst|red[2]~feeder_combout\);

-- Location: FF_X26_Y72_N11
\inst|red[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst|red[2]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|red\(2));

-- Location: LCCOMB_X26_Y72_N28
\inst|red[1]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|red[1]~feeder_combout\ = \inst|red~6_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|red~6_combout\,
	combout => \inst|red[1]~feeder_combout\);

-- Location: FF_X26_Y72_N29
\inst|red[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst|red[1]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|red\(1));

-- Location: FF_X26_Y72_N23
\inst|red[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \inst|red~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|red\(0));

-- Location: IOIBUF_X115_Y14_N8
\p1reset~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_p1reset,
	o => \p1reset~input_o\);
END structure;


