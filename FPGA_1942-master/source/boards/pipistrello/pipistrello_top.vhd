--	(c) 2018 d18c7db(a)hotmail
--
--	This program is free software; you can redistribute it and/or modify it under
--	the terms of the GNU General Public License version 3 or, at your option,
--	any later version as published by the Free Software Foundation.
--
--	This program is distributed in the hope that it will be useful,
--	but WITHOUT ANY WARRANTY; without even the implied warranty of
--	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
--
-- For full details, see the GNU General Public License at www.gnu.org/licenses

--------------------------------------------------------------------------------
--	Top level for 1942 game targeted for Pipistrello board, basic h/w specs:
--		Spartan 6 LX45
--		50Mhz xtal oscillator
--		32Mx16 LPDDR DRAM (not used)
--		128Mbit serial Flash
--

library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_arith.all;
	use ieee.std_logic_unsigned.all;
	use ieee.numeric_std.all;

library unisim;
	use unisim.vcomponents.all;

entity PIPISTRELLO_TOP is
	port(
		I_RESET				: in		std_logic;								-- active high reset

		-- VGA monitor output
		O_VIDEO_R			: out   std_logic_vector(3 downto 0);
		O_VIDEO_G			: out   std_logic_vector(3 downto 0);
		O_VIDEO_B			: out   std_logic_vector(3 downto 0);
		O_HSYNC				: out   std_logic;
		O_VSYNC				: out   std_logic;

		-- HDMI monitor output
		TMDS_P,
		TMDS_N				: out   std_logic_vector(3 downto 0);

		-- Sound out
		O_AUDIO_L,
		O_AUDIO_R			: out   std_logic;

		-- PS2 keyboard
--		PS2CLK1,
--		PS2DAT1				: inout std_logic;

		-- gamecube controller I/O line
		PMOD1_IO4			: inout std_logic;

		-- 50MHz clock
		CLK_IN				: in    std_logic := '0'						-- System clock 50Mhz

	);
end PIPISTRELLO_TOP;

architecture RTL of PIPISTRELLO_TOP is
	signal
		ext_reset,
		clk_4M_en,
		clk_6M_en,
		clk_12M,
		clk_24M,
		clk_48M,

		red_s,
		grn_s,
		blu_s,
	
		clk_dvi_p,
		clk_dvi_n,
		clk_s,
		s_blank,

	-- player buttons
		p_coin, p1_start, p1_loop, p1_fire, p1_down, p1_up, p1_left, p1_right,
		p_srvc, p2_start, p2_loop, p2_fire, p2_down, p2_up, p2_left, p2_right,

		ready,

		but_S,
		but_X,
		but_Y,
		but_Z,

		but_A,
		but_B,
		but_L,
		but_R,

		s_cmpblk_n,
		s_cmpblk_n_out,
		s_dac_out_l,
		s_dac_out_r,
		s_hsync_n,
		s_vsync_n,
		ps2_codeready,

		HSync,
		VSync
								: std_logic := '1';
	-- video
	signal
		s_red,
		s_grn,
		s_blu,
		dummy,

		VideoR,
		VideoG,
		VideoB					
								: std_logic_vector(3 downto 0);

	signal
		joy_X,
		joy_Y,

		s_audio_l,
		s_audio_r
								: std_logic_vector( 7 downto 0) := (others => '0');
	signal
		ps2_scancode
								: std_logic_vector( 9 downto 0) := (others => '0');
begin
	-----------------------------------------------
	-- DCM generates all the system clocks required
	-----------------------------------------------
	ClockGen : entity work.CLOCKGEN
	generic map (
		C_CLKFX_DIVIDE   => 25,
		C_CLKFX_MULTIPLY => 24,
		C_CLKIN_PERIOD   => 20.0
	)
	port map(
		I_CLK			=> CLK_IN,		-- external board clock (50MHz)
		I_RST			=> I_RESET,		-- active high reset
		O_RST			=> ext_reset,
		O_CLK_4M		=> clk_4M_en,
		O_CLK_6M		=> clk_6M_en,
		O_CLK_12M	=> clk_12M,
		O_CLK_24M	=> clk_24M,
		O_CLK_48M	=> clk_48M
	);

------------------------------------------------------------------------------
------------------------------------------------------------------------------
-- USER portion begins here
------------------------------------------------------------------------------
----------------------------------------------------------------------------
	O_AUDIO_L	<= s_dac_out_l;
	O_AUDIO_R	<= s_dac_out_r;

	-- uncomment for VGA output
	O_VIDEO_R	<= VideoR;
	O_VIDEO_G	<= VideoG;
	O_VIDEO_B	<= VideoB;
	O_HSYNC		<= HSync;
	O_VSYNC		<= VSync;

--	nunchack: entity work.nunchack
--	port map(
--	sys_clk		=> clk_4M_en,
--		i2c_reset	=> ext_reset,
--		i2c_sck		=> PS2CLK1,
--		i2c_sda		=> PS2DAT1,
--		but_c			=> but_c,
--		but_z			=> but_z,
--		joy_x			=> joy_x,
--		joy_y			=> joy_y
--		acc_x			=> open,
--		acc_y			=> open,
--		acc_z			=> open
--	);

	-----------------------------------------------------------------------------
	-- Keyboard - active low buttons
	-----------------------------------------------------------------------------
--	Keyboard : entity work.Keyboard
--	port map (
--		Reset     => ext_reset,
--		Clock     => clk_12M,
--		PS2Clock  => PS2CLK1,
--		PS2Data   => PS2DAT1,
--		CodeReady => ps2_codeready,  --: out STD_LOGIC;
--		ScanCode  => ps2_scancode    --: out STD_LOGIC_VECTOR(9 downto 0)
--	);

-- ScanCode(9)          : 1 = Extended  0 = Regular
-- ScanCode(8)          : 1 = Break     0 = Make
-- ScanCode(7 downto 0) : Key Code
--	process(clk_12M)
--	begin
--		if rising_edge(clk_12M) then
--			if ext_reset = '1' then
--				p1_start <= '0';
--				p1_coin  <= '0';
--				p1_loop  <= '0';
--				p1_fire  <= '0';
--				p1_down  <= '0';
--				p1_up    <= '0';
--				p1_left  <= '0';
--				p1_right <= '0';
--
--				p2_start <= '0';
--				p2_coin  <= '0';
--				p2_loop  <= '0';
--				p2_fire  <= '0';
--				p2_down  <= '0';
--				p2_up    <= '0';
--				p2_left  <= '0';
--				p2_right <= '0';
-- keyboard input section
--			elsif (ps2_codeready = '1') then
--				case (ps2_scancode(7 downto 0)) is
--					when x"05" =>	p_coin   <= not ps2_scancode(8);     -- coin    "F1"
--					when x"04" =>	p_srvc   <= not ps2_scancode(8);     -- service "F3"
--
--					when x"06" =>	p1_start <= not ps2_scancode(8);     -- 1P start "F2"
--					when x"0c" =>	p2_start <= not ps2_scancode(8);     -- 2P start "F4"
--
--					when x"43" =>	p1_loop  <= not ps2_scancode(8);     -- P1 jump "I"
--										p2_loop  <= not ps2_scancode(8);     -- P2 jump "I"
--
--					when x"44" =>	p1_fire  <= not ps2_scancode(8);     -- P1 jump "O"
--										p2_fire  <= not ps2_scancode(8);     -- P2 jump "O"
--
--					when x"75" =>	p1_up    <= not ps2_scancode(8);     -- P1 up arrow
--										p2_up  	<= not ps2_scancode(8);     -- P2 up arrow
--
--					when x"72" =>	p1_down  <= not ps2_scancode(8);     -- P1 down arrow
--										p2_down  <= not ps2_scancode(8);     -- P2 down arrow
--
--					when x"6b" =>	p1_left  <= not ps2_scancode(8);     -- P1 left arrow
--										p2_left  <= not ps2_scancode(8);     -- P2 left arrow
--
--					when x"74" =>	p1_right <= not ps2_scancode(8);     -- P1 right arrow
--										p2_right <= not ps2_scancode(8);     -- P2 right arrow
--
--					when others => null;
--				end case;
--			end if;
--		end if;
--	end process;

	-- Generic GameCube controller
	p_gc: entity work.gamecube
	port map(
		clk			=> clk_4M_en,	-- 4MHz clock
		reset			=> ext_reset,
		ready			=> ready,		-- buttons are stable when set
		serio			=> PMOD1_IO4,

		but_S			=> but_S,	-- button Start
		but_X			=> but_X,	-- button X
		but_Y			=> but_Y,	-- button Y
		but_Z			=> but_Z,	-- button Z
                     
		but_A			=> but_A,	-- button A
		but_B			=> but_B,	-- button B
		but_L			=> but_L,	-- button Left
		but_R			=> but_R,	-- button Right
                     
		but_DU		=> open,		-- button Dpad up
		but_DD		=> open,		-- button Dpad down
		but_DL		=> open,		-- button Dpad left
		but_DR		=> open,		-- button Dpad right

		joy_X			=> joy_X,	-- Joy X analog
		joy_Y			=> joy_Y,	-- Joy Y analog
		cst_X			=> open,		-- C-Stick X analog
		cst_Y			=> open,		-- C-Stick Y analog
		ana_L			=> open,		-- Left Button analog
		ana_R			=> open		-- Right Button analog
	);

	process
	begin
		wait until rising_edge(clk_12M);
		if ready = '1' then
			p_coin	<= not but_Z;
			p1_start	<= not but_S;
			p1_loop	<= not but_B;
			p1_fire	<= not but_A;

			if joy_Y > x"A0" then
				p1_up		<= '0';
			else
				p1_up		<= '1';
			end if;

			if joy_Y < x"60" then
				p1_down	<= '0';
			else
				p1_down	<= '1';
			end if;

			if joy_X > x"A0" then
				p1_right	<= '0';
			else
				p1_right	<= '1';
			end if;

			if joy_X < x"60" then
				p1_left	<= '0';
			else
				p1_left	<= '1';
			end if;

--			p_srvc	<= not;
--			p2_start	<= not;
--			p2_loop	<= not;
--			p2_fire	<= not;
--			p2_up		<= not;
--			p2_down	<= not;
--			p2_left	<= not;
--			p2_right	<= not;
		end if;
	end process;

	inst_1942 : entity work.FPGA_1942
	port map(
		-- System Clock
		I_CLK_12M	=> clk_12M,

		-- Active high reset
		I_RESET		=> ext_reset,

		-- player 1 controls, active low
		I_P1(7)		=> p_coin,					-- coin
		I_P1(6)		=> p1_start, 				-- P1 start
		I_P1(5)		=> p1_loop, 				-- P1 loop
		I_P1(4)		=> p1_fire, 				-- P1 fire
		I_P1(3)		=> p1_up,					-- P1 up
		I_P1(2)		=> p1_down, 				-- P1 down
		I_P1(1)		=> p1_left, 				-- P1 left
		I_P1(0)		=> p1_right, 				-- P1 right

		-- player 2 controls, active low
		I_P2(7)		=> p_srvc,					-- service
		I_P2(6)		=> p2_start,				-- P2 start
		I_P2(5)		=> p2_loop,					-- P2 loop
		I_P2(4)		=> p2_fire, 				-- P1 fire
		I_P2(3)		=> p2_up,					-- P2 up
		I_P2(2)		=> p2_down,					-- P2 down
		I_P2(1)		=> p2_left,					-- P2 left
		I_P2(0)		=> p2_right,				-- P2 right


		-- DIP SW A
--		I_DIP_A					=> x"77",		-- Default Settings
		I_DIP_A(7 downto 6)	=> "01",			-- Planes: 00=5, 01=2, 10=1, 11=3
		I_DIP_A(5 downto 4)	=> "11",			-- Bonus: 00=30K/100K, 01=30K/80K, 10=20K/100K, 11=20K/80K
		I_DIP_A(3)				=> '0',			-- Type: 0=Upright, 1=Table
		I_DIP_A(2 downto 0)	=> "111",		-- Play/Coins: 000=FreePlay, 001=1P/4C, 010=1P/3C, 011=3P/2C, 100=1P/2C, 101=4P/1C, 110=2P/1C, 111=1P/1C

		-- DIP SW B
--		I_DIP_B					=> x"FF",		-- Default Settings
		I_DIP_B(7)				=> '1',			-- Stop: 0=Stop, 1=Run
		I_DIP_B(6 downto 5)	=> "11",			-- Difficulty: 00=Very Hard, 01=Difficult, 10=Easy, 11=Normal
		I_DIP_B(4)				=> '1',			-- Picture: 0=Reverse, 1=Normal
		I_DIP_B(3)				=> '1',			-- Mode: 0=Test, 1=Normal
		I_DIP_B(2 downto 0)	=> "111",		-- Reserved set to 111

		-- Audio out
		O_AUDIO_L	=> s_audio_l,
		O_AUDIO_R	=> s_audio_r,

		-- VGA monitor output
		O_VIDEO_R	=> s_red,
		O_VIDEO_G	=> s_grn,
		O_VIDEO_B	=> s_blu,
		O_HSYNC		=> s_hsync_n,
		O_VSYNC		=> s_vsync_n,
		O_CSYNC		=> s_cmpblk_n

	);

	-----------------------------------------------------------------
	-- video scan converter required to display video on VGA hardware
	-----------------------------------------------------------------
	-- game native resolution 256x224 visible area or 384x262 total pixel area
	-- take note: the values below are relative to the CLK period not standard VGA clock period
	ScanConv : entity work.VGA_SCANCONV
	generic map (
		-- mark start of active area of input video
		vstart      =>  127,  -- start  of active video
		vlength     =>  256,  -- length of active video

		-- parameters below affect output video timing
		-- these must add up to 384 (including hpad*2)
		hF				=>   8,	-- h front porch
		hS				=>  46,	-- h sync
		hB				=>  22,	-- h back porch
		hV				=> 288,	-- active video
		hpad			=>  10,	-- create H black border

		-- these should add up to 262 (including vpad*2)
		vF				=>   1,	-- v front porch
		vS				=>   1,	-- v sync
		vB				=>  36,	-- v back porch
		vV				=> 224,	-- active video
		vpad			=>   0	-- create V black border
	)
	port map (
		I_VIDEO(15 downto 12)=> "0000",
		I_VIDEO(11 downto 8) => s_red,
		I_VIDEO( 7 downto 4) => s_grn,
		I_VIDEO( 3 downto 0) => s_blu,
		I_HSYNC					=> s_hsync_n,
		I_VSYNC					=> s_vsync_n,
		--
		O_VIDEO(15 downto 12)=> dummy,
		O_VIDEO(11 downto 8) => VideoR,
		O_VIDEO( 7 downto 4) => VideoG,
		O_VIDEO( 3 downto 0) => VideoB,
		O_HSYNC					=> HSync,
		O_VSYNC					=> VSync,
		O_CMPBLK_N				=> s_cmpblk_n_out,
		--
		CLK						=> clk_6M_en,
		CLK_x2					=> clk_12M
	);

	s_blank <= not s_cmpblk_n_out;

	DVID: entity work.dvid
	port map(
		clk						=> CLK_IN,
		clk_pixel				=> clk_24M,
		red_p(  7 downto 4)	=> VideoR,
		red_p(  3 downto 0)	=> x"0",
		green_p(7 downto 4)	=> VideoG,
		green_p(3 downto 0)	=> x"0",
		blue_p( 7 downto 4)	=> VideoB,
		blue_p( 3 downto 0)	=> x"0",
		blank						=> s_blank,
		hsync						=> HSync,
		vsync						=> VSync,
		-- outputs to TMDS drivers
		tmds_p					=> TMDS_P,
		tmds_n					=> TMDS_N
	);

	----------------------
	-- 1 bit D/A converter
	----------------------
	DACL : entity work.DAC
	port map (
		clk_i		=> clk_48M, -- the higher the clock the better
		res_i		=> ext_reset,
		dac_i		=> s_audio_l,
		dac_o		=> s_dac_out_l
	);

	DACR : entity work.DAC
	port map (
		clk_i		=> clk_48M, -- the higher the clock the better
		res_i		=> ext_reset,
		dac_i		=> s_audio_r,
		dac_o		=> s_dac_out_r
	);

end RTL;
