------------------------------------------------------------------------------------
---- Company: 
---- Engineer: 
---- 
---- Create Date:    15:48:53 12/03/2013 
---- Design Name: 
---- Module Name:    VGAOutput - Behavioral 
---- Project Name: 
---- Target Devices: 
---- Tool versions: 
---- Description: 
----
---- Dependencies: 
----
---- Revision: 
---- Revision 0.01 - File Created
---- Additional Comments: 
----
------------------------------------------------------------------------------------
--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
--
---- Uncomment the following library declaration if using
---- arithmetic functions with Signed or Unsigned values
----use IEEE.NUMERIC_STD.ALL;
--
---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
----library UNISIM;
----use UNISIM.VComponents.all;
--
--entity VGAOutput is
--end VGAOutput;
--
--architecture Behavioral of VGAOutput is
--
--begin
--
--
--end Behavioral;
--

-- 640 x 480

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_textio.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity VGAOutput is
port (
	v_dir : in STD_LOGIC;
	h_dir : in STD_LOGIC;
	sp_v : in STD_LOGIC_VECTOR(1 downto 0);
	sp_h : in STD_LOGIC_VECTOR(1 downto 0);

	clk100_in: in std_logic;
	rst : in std_logic;
	lv	: in STD_LOGIC_VECTOR(1 downto 0);
	
	rgb_out:  out std_logic_vector(7 downto 0);
	hs_out: out std_logic;
	vs_out: out std_logic);
end VGAOutput;


architecture behavioral of VGAoutput is
-- CLOCK VARS
signal counter : std_logic_vector(1 downto 0) := "00";
signal count5000 : std_logic_vector (12 downto 0) := "0000000000000";
signal count1250 : std_logic_vector (11 downto 0) := "000000000000";
signal easy : std_logic_vector (11 downto 0) := 	  "000110010000";
signal medi : std_logic_vector (11 downto 0) := 	  "000011111010";
signal hard : std_logic_vector (11 downto 0) := 	  "000011001000";
signal game_cnt : std_logic_vector (11 downto 0) :=  "000000000000";
signal pastlvl : std_logic_vector(1 downto 0) := "00";


signal clk25: std_logic := '0';
signal clk8 : std_logic := '0';

signal hc : std_logic_vector(9 downto 0) := "0000000000";
signal vc : std_logic_vector(9 downto 0) := "0000000000";

---- VARIABLES ----
-- m means marble
-- hl = horizontal left
-- hr = horizontal right
-- vt = vertical top
-- vb = vertical bottom
-- m_s means marble start
-- m_c means marble collision
-- m_n means marble next

-- current positions for the corners of the marble
signal m_hl : std_logic_vector(9 downto 0) := "0000110101";
signal m_hr : std_logic_vector(9 downto 0) := "0000111100";
signal m_vt : std_logic_vector(9 downto 0) := "0000110101";
signal m_vb : std_logic_vector(9 downto 0) := "0000111100";

-- start positions for the marble
signal m_s_hl : std_logic_vector(9 downto 0) := "0000110101";
signal m_s_hr : std_logic_vector(9 downto 0) := "0000111100";
signal m_s_vt : std_logic_vector(9 downto 0) := "0000110101";
signal m_s_vb : std_logic_vector(9 downto 0) := "0000111100";

-- COLLISION DETECTION - THIS DID NOT WORK
signal m_c_v : std_logic_vector(9 downto 0) := "0000000000";
signal m_c_h : std_logic_vector(9 downto 0) := "0000000000";

-- collision tracking vars
signal fell : std_logic := '0';
signal reset_fell : std_logic := '0';

--Winner Stuff
signal win : std_logic := '0';
signal m_clr : std_logic_vector(7 downto 0) := "00000011";

-- next positions for marble
signal m_n_hl : std_logic_vector(9 downto 0) := "0000110101";
signal m_n_hr : std_logic_vector(9 downto 0) := "0000111100";
signal m_n_vt : std_logic_vector(9 downto 0) := "0000110101";
signal m_n_vb : std_logic_vector(9 downto 0) := "0000111100";
											
begin

	-- This process divides the main clock (100MHz) to (25MHz)
	-- Do not modify this
	process(clk100_in)
	begin
		if clk100_in'event and clk100_in='1' then
			counter <= counter+'1';
			count5000 <= count5000+'1';
			if pastlvl /= lv then 
				count5000 <= "0000000000000";
				count1250 <= "000000000000";
				pastlvl <= lv;
			end if;
			if lv = "10" then
				game_cnt <= hard;
			elsif lv = "01" then
				game_cnt <= medi;
			else
				game_cnt <= easy;
			end if;
			
			if counter = "11" then
				clk25 <= '1';
				counter <= "00";
			else
				clk25 <= '0';
			end if;
			
			if count5000 = "1001110001000" then
				count5000 <= "0000000000000";
				count1250 <= count1250 + '1';
				
				if count1250 = game_cnt then
					count1250 <= "000000000000";
					clk8 <= '1'; 
				else 
					clk8 <= '0';
				end if;				
			end if;
			
		end if;
	end process;

	-- This is the process that you want to modify in order to display
	-- different drawings on the screen. 
	-- The screen size is 640 by 480.
	-- Currently, it is displaying "white color" on the screen (i.e., the pixels
	--  within the screen size) 
	process(clk25)
	begin
		
		--surrounding blackness
		if (((vc < 40 or vc > 440) and hc < 640)) then
			rgb_out <= "00000000";
		elsif((hc < 40 or hc > 600) and vc<480) then
			rgb_out <= "00000000";
		
		--Holes throughout board
		elsif (vc > 80 and vc <110 and ((hc > 250 and hc < 280)or (hc >410 and hc < 440))) then
			rgb_out <= "00000000";
		elsif (vc > 120 and vc < 150 and ((hc > 90 and hc < 120)or (hc >330 and hc < 360) or (hc >570 and hc < 640)))then
			rgb_out <= "00000000";
		elsif (((vc > 200 and vc < 270) or (vc > 320 and vc < 360)) and hc > 170 and hc < 200) then
			rgb_out <= "00000000";
		elsif (vc > 200 and vc < 240 and hc > 450 and hc < 480) then
			rgb_out <= "00000000";
		elsif (vc > 360 and vc < 390 and ((hc > 410 and hc < 440) or (hc > 450 and hc < 480))) then
			rgb_out <= "00000000";
		
		--start point
		elsif (vc >= 51 and vc < 70 and hc >= 51 and hc < 70) then
			rgb_out <= "01110000";
		-- end point
		elsif (vc > 200 and vc < 230 and hc > 360 and hc < 440) then
			rgb_out <= "00010100";
		
		--Horizontal Walls
		elsif(vc>40 and vc<50 and hc>40 and hc<80) then
			rgb_out <= "00110000";
		elsif(vc>70 and vc<80 and hc>40 and hc<560) then
			rgb_out <= "00110000";
		elsif(vc>120 and vc<130 and hc>120 and hc<200) then
			rgb_out <= "00110000";
		elsif(vc>150 and vc<160 and hc>120 and hc<600) then
			rgb_out <= "00110000";
		elsif(vc>190 and vc<200 and ((hc>40 and hc<120)or(hc>160 and hc<560))) then
			rgb_out <= "00110000";
		elsif(vc>230 and vc<240 and ((hc>80 and hc<160)or (hc>240 and hc<440))) then
			rgb_out <= "00110000";
		elsif(vc>270 and vc<280 and hc>160 and hc<520) then
			rgb_out <= "00110000";
		elsif(vc>310 and vc<320 and hc>160 and hc<560) then
			rgb_out <= "00110000";
		elsif(vc>350 and vc<360 and hc>440 and hc<520) then
			rgb_out <= "00110000";
		elsif(vc>390 and vc<400 and ((hc>80 and hc<440)or(hc>520 and hc<560))) then
			rgb_out <= "00110000";

		--Vertical Walls
		elsif(hc>40 and hc<50 and ((vc>40 and vc<80) or (vc>200 and vc<440))) then
			rgb_out <= "00110000";
		elsif(hc>80 and hc<90 and vc>240 and vc<400) then
			rgb_out <= "00110000"; 
		elsif(hc>120 and hc<130 and vc>120 and vc<160) then
			rgb_out <= "00110000";
		elsif(hc>160 and hc<170 and ((vc>200 and vc<280) or (vc>320 and vc<360))) then
			rgb_out <= "00110000";
		elsif(hc>240 and hc<250 and ((vc>80 and vc<120) or (vc>360 and vc<400))) then
			rgb_out <= "00110000";
		elsif(hc>320 and hc<330 and ((vc>120 and vc<160) or (vc>320 and vc<360))) then
			rgb_out <= "00110000";
			
		elsif(hc>400 and hc<410 and vc>80 and vc<120) then
			rgb_out <= "00110000";
		elsif(hc>440 and hc<450 and ((vc>200 and vc<240) or (vc>360 and vc<400))) then
			rgb_out <= "00110000";
		elsif(hc>480 and hc<490 and ((vc>120 and vc<160))) then
			rgb_out <= "00110000";
		elsif(hc>520 and hc<530 and ((vc>80 and vc<120) or (vc>400 and vc<440) or (vc>240 and vc<280))) then
			rgb_out <= "00110000";
		elsif(hc>560 and hc<570 and vc>200 and vc<400) then
			rgb_out <= "00110000";
				
		--All Else
		else
			rgb_out <= "11111111";
		end if;	
		
		-- 1) Check Marble Horizontal top-left
		if(m_n_vt>=40 and m_n_vt<=50 and m_n_hl>=40 and m_n_hl<=80) then
			--do nothing
		elsif(m_n_vt>=70 and m_n_vt<=80 and m_n_hl>=40 and m_n_hl<=560) then
			--do nothing
		elsif(m_n_vt>=120 and m_n_vt<=130 and m_n_hl>=120 and m_n_hl<=200) then
			--do nothing
		elsif(m_n_vt>=150 and m_n_vt<=160 and m_n_hl>=120 and m_n_hl<=600) then
			--do nothing
		elsif(m_n_vt>190 and m_n_vt<=200 and ((m_n_hl>=40 and m_n_hl<=120)or(m_n_hl>=160 and m_n_hl<=560))) then
			--do nothing
		elsif(m_n_vt>=230 and m_n_vt<=240 and ((m_n_hl>=80 and m_n_hl<=160)or (m_n_hl>=240 and m_n_hl<=440))) then
			--do nothing
		elsif(m_n_vt>=270 and m_n_vt<=280 and m_n_hl>=160 and m_n_hl<=520) then
			--do nothing
		elsif(m_n_vt>=310 and m_n_vt<=320 and m_n_hl>=160 and m_n_hl<=560) then
			--do nothing
		elsif(m_n_vt>=350 and m_n_vt<=360 and m_n_hl>=440 and m_n_hl<=520) then
			--do nothing
		elsif(m_n_vt>=390 and m_n_vt<=400 and ((m_n_hl>=80 and m_n_hl<=440)or(m_n_hl>=520 and m_n_hl<=560))) then
			--do nothing
		
		-- 2) Check Marble Horizontal top-right
		elsif(m_n_vt>=40 and m_n_vt<=50 and m_n_hr>=40 and m_n_hr<=80) then
			--do nothing
		elsif(m_n_vt>=70 and m_n_vt<=80 and m_n_hr>=40 and m_n_hr<=560) then
			--do nothing
		elsif(m_n_vt>=120 and m_n_vt<=130 and m_n_hr>=120 and m_n_hr<=200) then
			--do nothing
		elsif(m_n_vt>=150 and m_n_vt<=160 and m_n_hr>=120 and m_n_hr<=600) then
			--do nothing
		elsif(m_n_vt>190 and m_n_vt<=200 and ((m_n_hr>=40 and m_n_hr<=120)or(m_n_hr>=160 and m_n_hr<=560))) then
			--do nothing
		elsif(m_n_vt>=230 and m_n_vt<=240 and ((m_n_hr>=80 and m_n_hl<=160)or (m_n_hr>=240 and m_n_hr<=440))) then
			--do nothing
		elsif(m_n_vt>=270 and m_n_vt<=280 and m_n_hr>=160 and m_n_hr<=520) then
			--do nothing
		elsif(m_n_vt>=310 and m_n_vt<=320 and m_n_hr>=160 and m_n_hr<=560) then
			--do nothing
		elsif(m_n_vt>=350 and m_n_vt<=360 and m_n_hr>=440 and m_n_hr<=520) then
			--do nothing
		elsif(m_n_vt>=390 and m_n_vt<=400 and ((m_n_hr>=80 and m_n_hr<=440)or(m_n_hr>=520 and m_n_hr<=560))) then
			--do nothing
		
		-- 3) Check Marble Horizontal bottom-left
		elsif(m_n_vb>=40 and m_n_vb<=50 and m_n_hl>=40 and m_n_hl<=80) then
			--do nothing
		elsif(m_n_vb>=70 and m_n_vb<=80 and m_n_hl>=40 and m_n_hl<=560) then
			--do nothing
		elsif(m_n_vb>=120 and m_n_vb<=130 and m_n_hl>=120 and m_n_hl<=200) then
			--do nothing
		elsif(m_n_vb>=150 and m_n_vb<=160 and m_n_hl>=120 and m_n_hl<=600) then
			--do nothing
		elsif(m_n_vb>190 and m_n_vb<=200 and ((m_n_hl>=40 and m_n_hl<=120)or(m_n_hl>=160 and m_n_hl<=560))) then
			--do nothing
		elsif(m_n_vb>=230 and m_n_vb<=240 and ((m_n_hl>=80 and m_n_hl<=160)or (m_n_hl>=240 and m_n_hl<=440))) then
			--do nothing
		elsif(m_n_vb>=270 and m_n_vb<=280 and m_n_hl>=160 and m_n_hl<=520) then
			--do nothing
		elsif(m_n_vb>=310 and m_n_vb<=320 and m_n_hl>=160 and m_n_hl<=560) then
			--do nothing
		elsif(m_n_vb>=350 and m_n_vb<=360 and m_n_hl>=440 and m_n_hl<=520) then
			--do nothing
		elsif(m_n_vb>=390 and m_n_vb<=400 and ((m_n_hl>=80 and m_n_hl<=440)or(m_n_hl>=520 and m_n_hl<=560))) then
			--do nothing
		
		-- 4) Check Marble Horizontal bottom-right
		elsif(m_n_vb>=40 and m_n_vb<=50 and m_n_hr>=40 and m_n_hr<=80) then
			--do nothing
		elsif(m_n_vb>=70 and m_n_vb<=80 and m_n_hr>=40 and m_n_hr<=560) then
			--do nothing
		elsif(m_n_vb>=120 and m_n_vb<=130 and m_n_hr>=120 and m_n_hr<=200) then
			--do nothing
		elsif(m_n_vb>=150 and m_n_vb<=160 and m_n_hr>=120 and m_n_hr<=600) then
			--do nothing
		elsif(m_n_vb>190 and m_n_vb<=200 and ((m_n_hr>=40 and m_n_hr<=120)or(m_n_hr>=160 and m_n_hr<=560))) then
			--do nothing
		elsif(m_n_vb>=230 and m_n_vb<=240 and ((m_n_hr>=80 and m_n_hl<=160)or (m_n_hr>=240 and m_n_hr<=440))) then
			--do nothing
		elsif(m_n_vb>=270 and m_n_vb<=280 and m_n_hr>=160 and m_n_hr<=520) then
			--do nothing
		elsif(m_n_vb>=310 and m_n_vb<=320 and m_n_hr>=160 and m_n_hr<=560) then
			--do nothing
		elsif(m_n_vb>=350 and m_n_vb<=360 and m_n_hr>=440 and m_n_hr<=520) then
			--do nothing
		elsif(m_n_vb>=390 and m_n_vb<=400 and ((m_n_hr>=80 and m_n_hr<=440)or(m_n_hr>=520 and m_n_hr<=560))) then
			--do nothing
		
		--5)Check Marble Vertical Top-left
		elsif(m_n_hl>=40 and m_n_hl<=50 and ((m_n_vt>=40 and m_n_vt<=80) or (m_n_vt>=200 and m_n_vt<=440))) then
			--do nothing
		elsif(m_n_hl>=80 and m_n_hl<=90 and m_n_vt>=240 and m_n_vt<=400) then
			--do nothing 
		elsif(m_n_hl>=120 and m_n_hl<=130 and m_n_vt>=120 and m_n_vt<=160) then
			--do nothing
		elsif(m_n_hl>=160 and m_n_hl<=170 and ((m_n_vt>=200 and m_n_vt<=280) or (m_n_vt>=320 and m_n_vt<=360))) then
			--do nothing
		elsif(m_n_hl>=240 and m_n_hl<=250 and ((m_n_vt>=80 and m_n_vt<=120) or (m_n_vt>=360 and m_n_vt<=400))) then
			--do nothing
		elsif(m_n_hl>=320 and m_n_hl<=330 and ((m_n_vt>=120 and m_n_vt<=160) or (m_n_vt>=320 and m_n_vt<=360))) then
			--do nothing
		elsif(m_n_hl>=400 and m_n_hl<=410 and m_n_vt>=80 and m_n_vt<=120) then
			--do nothing
		elsif(m_n_hl>=440 and m_n_hl<=450 and ((m_n_vt>=200 and m_n_vt<=240) or (m_n_vt>=360 and m_n_vt<=400))) then
			--do nothing
		elsif(m_n_hl>=480 and m_n_hl<=490 and ((m_n_vt>=120 and m_n_vt<=160))) then
			--do nothing
		elsif(m_n_hl>=520 and m_n_hl<=530 and ((m_n_vt>=80 and m_n_vt<=120) or (m_n_vt>=400 and m_n_vt<=440) or (m_n_vt>=240 and m_n_vt<=280))) then
			--do nothing
		elsif(m_n_hl>=560 and m_n_hl<=570 and m_n_vt>=200 and m_n_vt<=400) then
			--do nothing
		
		--6)Check Marble Vertical Top-right
		elsif(m_n_hr>=40 and m_n_hr<=50 and ((m_n_vt>=40 and m_n_vt<=80) or (m_n_vt>=200 and m_n_vt<=440))) then
			--do nothing
		elsif(m_n_hr>=80 and m_n_hr<=90 and m_n_vt>=240 and m_n_vt<=400) then
			--do nothing 
		elsif(m_n_hr>=120 and m_n_hr<=130 and m_n_vt>=120 and m_n_vt<=160) then
			--do nothing
		elsif(m_n_hr>=160 and m_n_hr<=170 and ((m_n_vt>=200 and m_n_vt<=280) or (m_n_vt>=320 and m_n_vt<=360))) then
			--do nothing
		elsif(m_n_hr>=240 and m_n_hr<=250 and ((m_n_vt>=80 and m_n_vt<=120) or (m_n_vt>=360 and m_n_vt<=400))) then
			--do nothing
		elsif(m_n_hr>=320 and m_n_hr<=330 and ((m_n_vt>=120 and m_n_vt<=160) or (m_n_vt>=320 and m_n_vt<=360))) then
			--do nothing
		elsif(m_n_hr>=400 and m_n_hr<=410 and m_n_vt>=80 and m_n_vt<=120) then
			--do nothing
		elsif(m_n_hr>=440 and m_n_hr<=450 and ((m_n_vt>=200 and m_n_vt<=240) or (m_n_vt>=360 and m_n_vt<=400))) then
			--do nothing
		elsif(m_n_hr>=480 and m_n_hr<=490 and ((m_n_vt>=120 and m_n_vt<=160))) then
			--do nothing
		elsif(m_n_hr>=520 and m_n_hr<=530 and ((m_n_vt>=80 and m_n_vt<=120) or (m_n_vt>=400 and m_n_vt<=440) or (m_n_vt>=240 and m_n_vt<=280))) then
			--do nothing
		elsif(m_n_hr>=560 and m_n_hr<=570 and m_n_vt>=200 and m_n_vt<=400) then
			--do nothing
		
		--7) Check Marble Vertical bottom-left
		elsif(m_n_hl>=40 and m_n_hl<=50 and ((m_n_vb>=40 and m_n_vb<=80) or (m_n_vb>=200 and m_n_vb<=440))) then
			--do nothing
		elsif(m_n_hl>=80 and m_n_hl<=90 and m_n_vb>=240 and m_n_vb<=400) then
			--do nothing 
		elsif(m_n_hl>=120 and m_n_hl<=130 and m_n_vb>=120 and m_n_vb<=160) then
			--do nothing
		elsif(m_n_hl>=160 and m_n_hl<=170 and ((m_n_vb>=200 and m_n_vb<=280) or (m_n_vb>=320 and m_n_vb<=360))) then
			--do nothing
		elsif(m_n_hl>=240 and m_n_hl<=250 and ((m_n_vb>=80 and m_n_vb<=120) or (m_n_vb>=360 and m_n_vb<=400))) then
			--do nothing
		elsif(m_n_hl>=320 and m_n_hl<=330 and ((m_n_vb>=120 and m_n_vb<=160) or (m_n_vb>=320 and m_n_vb<=360))) then
			--do nothing
		elsif(m_n_hl>=400 and m_n_hl<=410 and m_n_vb>=80 and m_n_vb<=120) then
			--do nothing
		elsif(m_n_hl>=440 and m_n_hl<=450 and ((m_n_vb>=200 and m_n_vb<=240) or (m_n_vb>=360 and m_n_vb<=400))) then
			--do nothing
		elsif(m_n_hl>=480 and m_n_hl<=490 and ((m_n_vb>=120 and m_n_vb<=160))) then
			--do nothing
		elsif(m_n_hl>=520 and m_n_hl<=530 and ((m_n_vb>=80 and m_n_vb<=120) or (m_n_vb>=400 and m_n_vb<=440) or (m_n_vb>=240 and m_n_vb<=280))) then
			--do nothing
		elsif(m_n_hl>=560 and m_n_hl<=570 and m_n_vb>=200 and m_n_vb<=400) then
			--do nothing
		
		--8) Check Marble Vertical bottom-right
		elsif(m_n_hr>=40 and m_n_hr<=50 and ((m_n_vb>=40 and m_n_vb<=80) or (m_n_vb>=200 and m_n_vb<=440))) then
			--do nothing
		elsif(m_n_hr>=80 and m_n_hr<=90 and m_n_vb>=240 and m_n_vb<=400) then
			--do nothing 
		elsif(m_n_hr>=120 and m_n_hr<=130 and m_n_vb>=120 and m_n_vb<=160) then
			--do nothing
		elsif(m_n_hr>=160 and m_n_hr<=170 and ((m_n_vb>=200 and m_n_vb<=280) or (m_n_vb>=320 and m_n_vb<=360))) then
			--do nothing
		elsif(m_n_hr>=240 and m_n_hr<=250 and ((m_n_vb>=80 and m_n_vb<=120) or (m_n_vb>=360 and m_n_vb<=400))) then
			--do nothing
		elsif(m_n_hr>=320 and m_n_hr<=330 and ((m_n_vb>=120 and m_n_vb<=160) or (m_n_vb>=320 and m_n_vb<=360))) then
			--do nothing
		elsif(m_n_hr>=400 and m_n_hr<=410 and m_n_vb>=80 and m_n_vb<=120) then
			--do nothing
		elsif(m_n_hr>=440 and m_n_hr<=450 and ((m_n_vb>=200 and m_n_vb<=240) or (m_n_vb>=360 and m_n_vb<=400))) then
			--do nothing
		elsif(m_n_hr>=480 and m_n_hr<=490 and ((m_n_vb>=120 and m_n_vb<=160))) then
			--do nothing
		elsif(m_n_hr>=520 and m_n_hr<=530 and ((m_n_vb>=80 and m_n_vb<=120) or (m_n_vb>=400 and m_n_vb<=440) or (m_n_vb>=240 and m_n_vb<=280))) then
			--do nothing
		elsif(m_n_hr>=560 and m_n_hr<=570 and m_n_vb>=200 and m_n_vb<=400) then
			--do nothing		
		
		--ELSE Current Marble Position equals next position
		else
			-- current positions for the corners of the marble
			m_hl <= m_n_hl;
			m_hr <= m_n_hr;
			m_vt <= m_n_vt;
			m_vb <= m_n_vb;
		end if;

		--1) Top-Left Falling In Hole
		if (m_n_vt >= 85 and m_n_vt <=105 and ((m_n_hl >= 255 and m_n_hl <= 275)or (m_n_hl >=415 and m_n_hl <= 435))) then
			fell <= '1';
		elsif (m_n_vt >= 125 and m_n_vt <= 145 and ((m_n_hl >= 95 and m_n_hl <= 115)or (m_n_hl >=335 and m_n_hl <= 355) or (m_n_hl >=575 and m_n_hl <= 635)))then
			fell <= '1';
		elsif (((m_n_vt >= 205 and m_n_vt <= 265) or (m_n_vt >= 325 and m_n_vt <= 355)) and m_n_hl >= 175 and m_n_hl <= 195) then
			fell <= '1';
		elsif (m_n_vt >= 205 and m_n_vt <= 235 and m_n_hl >= 455 and m_n_hl <= 475) then
			fell <= '1';
		elsif (m_n_vt >= 365 and m_n_vt <= 385 and ((m_n_hl >= 415 and m_n_hl <= 435) or (m_n_hl >= 455 and m_n_hl <= 475))) then
			fell <= '1';
		--2) Top-Right Falling In Hole
		elsif (m_n_vt >= 85 and m_n_vt <=105 and ((m_n_hr >= 255 and m_n_hr <= 275)or (m_n_hr >=415 and m_n_hr <= 435))) then
			fell <= '1';
		elsif (m_n_vt >= 125 and m_n_vt <= 145 and ((m_n_hr >= 95 and m_n_hr <= 115)or (m_n_hr >=335 and m_n_hr <= 355) or (m_n_hr >=575 and m_n_hr <= 635)))then
			fell <= '1';
		elsif (((m_n_vt >= 205 and m_n_vt <= 265) or (m_n_vt >= 325 and m_n_vt <= 355)) and m_n_hr >= 175 and m_n_hr <= 195) then
			fell <= '1';
		elsif (m_n_vt >= 205 and m_n_vt <= 235 and m_n_hr >= 455 and m_n_hr <= 475) then
			fell <= '1';
		elsif (m_n_vt >= 365 and m_n_vt <= 385 and ((m_n_hr >= 415 and m_n_hr <= 435) or (m_n_hr >= 455 and m_n_hr <= 475))) then
			fell <= '1';
		--3) Bottom-Left Falling In Hole
		elsif (m_n_vb >= 85 and m_n_vb <=105 and ((m_n_hl >= 255 and m_n_hl <= 275)or (m_n_hl >=415 and m_n_hl <= 435))) then
			fell <= '1';
		elsif (m_n_vb >= 125 and m_n_vb <= 145 and ((m_n_hl >= 95 and m_n_hl <= 115)or (m_n_hl >=335 and m_n_hl <= 355) or (m_n_hl >=575 and m_n_hl <= 635)))then
			fell <= '1';
		elsif (((m_n_vb >= 205 and m_n_vb <= 265) or (m_n_vb >= 325 and m_n_vb <= 355)) and m_n_hl >= 175 and m_n_hl <= 195) then
			fell <= '1';
		elsif (m_n_vb >= 205 and m_n_vb <= 235 and m_n_hl >= 455 and m_n_hl <= 475) then
			fell <= '1';
		elsif (m_n_vb >= 365 and m_n_vb <= 385 and ((m_n_hl >= 415 and m_n_hl <= 435) or (m_n_hl >= 455 and m_n_hl <= 475))) then
			fell <= '1';
		--2) Bottom-right Falling In Hole
		elsif (m_n_vb >= 85 and m_n_vb <=105 and ((m_n_hr >= 255 and m_n_hr <= 275)or (m_n_hr >=415 and m_n_hr <= 435))) then
			fell <= '1';
		elsif (m_n_vb >= 125 and m_n_vb <= 145 and ((m_n_hr >= 95 and m_n_hr <= 115)or (m_n_hr >=335 and m_n_hr <= 355) or (m_n_hr >=575 and m_n_hr <= 635)))then
			fell <= '1';
		elsif (((m_n_vb >= 205 and m_n_vb <= 265) or (m_n_vb >= 325 and m_n_vb <= 355)) and m_n_hr >= 175 and m_n_hr <= 195) then
			fell <= '1';
		elsif (m_n_vb >= 205 and m_n_vb <= 235 and m_n_hr >= 455 and m_n_hr <= 475) then
			fell <= '1';
		elsif (m_n_vb >= 365 and m_n_vb <= 385 and ((m_n_hr >= 415 and m_n_hr <= 435) or (m_n_hr >= 455 and m_n_hr <= 475))) then
			fell <= '1';
		else
			fell <= '0';
		end if;

		
		if reset_fell = '0' then
			-- check fell on top or bottom
			if m_vt <= 35 then
				fell <= '1';
			elsif m_vb >= 445 then
				fell <= '1';
			end if;
			-- check fell on left of right
			if m_hl <= 35 then
				fell <= '1';
			elsif m_hr >= 605 then
				fell <= '1';
			end if;
		else
			fell<='0';
			
		end if;
		
		--In Winning Region
		if rst = '1' then
			win <= '0';
		elsif (m_n_vt > 200 and m_n_vt < 230 and m_n_hl > 360 and m_n_hl < 440) then
			win <= '1';
		elsif (m_n_vt > 200 and m_n_vt < 230 and m_n_hr > 360 and m_n_hr < 440) then
			win <= '1';
		elsif (m_n_vb > 200 and m_n_vb < 230 and m_n_hl > 360 and m_n_hl < 440) then
			win <= '1';
		elsif (m_n_vb > 200 and m_n_vb < 230 and m_n_hr > 360 and m_n_hr < 440) then
			win <= '1';
		end if;
		-- draw marble
		if( vc <= m_vb and vc >= m_vt and hc <= m_hr and hc >= m_hl) then
			rgb_out <= m_clr;
		end if;

	end process;
	
	
	process(clk8)
	begin 
		if clk8'event and clk8 = '1' then
			
			if rst = '1' then
				m_clr <= "00000011";
			elsif win = '1' then
				m_clr <= "11110000";
			else
				m_clr <= "00000011";
			end if;
			
			if rst = '1' then
				m_n_vt <= m_s_vt;
				m_n_vb <= m_s_vb;
				m_n_hl <= m_s_hl;
				m_n_hr <= m_s_hr;
				reset_fell <= '1';
			elsif fell = '1' then 
				-- fall animation
				reset_fell <= '0';
				if m_vb > m_vt then
					-- fall animation
						m_n_vt <= m_vt+1;
						m_n_vb <= m_vb-1;
						m_n_hl <= m_hl+1;
						m_n_hr <= m_hr-1;
				else
					-- if we fell reset to start point
					m_n_vt <= m_s_vt;
					m_n_vb <= m_s_vb;
					m_n_hl <= m_s_hl;
					m_n_hr <= m_s_hr;
					reset_fell <= '1';
				end if;
			else
				reset_fell <= '0';
				if v_dir = '0' then
					m_n_vt <= m_vt + sp_v;
					m_n_vb <= m_vb + sp_v;
				elsif v_dir = '1' then
					m_n_vt <= m_vt - sp_v;
					m_n_vb <= m_vb - sp_v;
				end if;
				if h_dir = '0' then
					m_n_hl <= m_hl + sp_h;
					m_n_hr <= m_hr + sp_h;
				elsif h_dir = '1' then
					m_n_hl <= m_hl - sp_h;
					m_n_hr <= m_hr - sp_h;
				end if;
			
			end if;			
		end if;
			
	end process;
	
	-- Do not modify this process
	process(clk25)
	begin
		if clk25'event and clk25 = '1' then
			-- porch			
			if hc >= (639+16) and hc <= (639+16+96) then
				hs_out <= '0';
			else
				hs_out <= '1';
			end if;
			
			if vc >= (479+10) and vc <= (479+10+2) then
				vs_out <= '0';
			else
				vs_out <= '1';
			end if;
			
			-- hc from 0 to 799; the whole frame is 800
			hc <= hc + 1;
			if hc = 799 then
				vc <= vc + 1;
				hc <= "0000000000";
			end if;
			
			-- vc from 0 to 524; the whole frame is 525
			if vc = 524 then
				vc <= "0000000000";
			end if;
		end if;
	end process;
end behavioral;
	
