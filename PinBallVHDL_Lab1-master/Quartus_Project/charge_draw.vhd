library IEEE;
use IEEE.STD_LOGIC_1164.all;



entity charge_draw is
port 	(
		--////////////////////	Clock Input	 	////////////////////	
	   CLK  					: in std_logic;
		RESETn				: in std_logic;
		oCoord_X				: in integer;
		oCoord_Y : in integer;
		game_started 		: in std_logic ;
		charge_level : in std_logic_vector (1 downto 0);
		max_charge : in std_logic;
		drawing_request	: out std_logic ;
		mVGA_RGB 			: out std_logic_vector(7 downto 0)
	);
end entity;

architecture behav of charge_draw is 

	
	--All Purpose :
	signal sig_draw_req : std_logic := '0';
	signal sig_draw_data: std_logic_vector (7 downto 0);
	
	--signal game_started : std_logic := '0';
	constant charge_X_size : integer := 40;
	constant charge_Y_size : integer := 20;
	
	constant charge_X_start : integer := 570;
	constant charge_X_end : integer := 610;
	constant charge_start_Y_red : integer := 290;
	constant charge_end_Y_red : integer := 310;
	constant charge_start_Y_yellow_2 : integer := 310;
	constant charge_end_Y_yellow_2 : integer := 330;
	constant charge_start_Y_yellow_1 : integer := 330;
	constant charge_end_Y_yellow_1 : integer := 350;
	constant charge_start_Y_green : integer := 350;
	constant charge_end_Y_green : integer := 370;
	
	signal charge_drawing_X : std_logic := '0';
	signal charge_drawing_Y_red : std_logic := '0';
	signal charge_drawing_Y_yellow_2 : std_logic := '0';
	signal charge_drawing_Y_yellow_1 : std_logic := '0';
	signal charge_drawing_Y_green : std_logic := '0';
	
	signal red_color : std_logic_vector (7 downto 0) := x"e1";
	signal yellow_color_2 : std_logic_vector (7 downto 0) := x"f0";
	signal yellow_color_1 : std_logic_vector (7 downto 0) := x"fc";
	signal green_color : std_logic_vector (7 downto 0) := x"7c";


begin

	-- Calculate objects end boundaries
	
	-- test if ooCoord is in the rectangle defined by Start and End 
   charge_drawing_X	<= '1' when  (oCoord_X  >= charge_X_start) and  (oCoord_X < charge_X_end) else '0';
	
   charge_drawing_Y_red	<= '1' when  (oCoord_Y  >= charge_start_Y_red) and  (oCoord_Y < charge_end_Y_red) else '0';
	charge_drawing_Y_yellow_2	<= '1' when  (oCoord_Y  >= charge_start_Y_yellow_2) and  (oCoord_Y < charge_end_Y_yellow_2) else '0';
   charge_drawing_Y_yellow_1	<= '1' when  (oCoord_Y  >= charge_start_Y_yellow_1) and  (oCoord_Y < charge_end_Y_yellow_1) else '0';
   charge_drawing_Y_green	<= '1' when  (oCoord_Y  >= charge_start_Y_green) and  (oCoord_Y < charge_end_Y_green) else '0';	
	
	-- calculate offset from start corner 
	
process ( RESETn, CLK)

  		
   begin
		
	if RESETn = '0' then
	    mVGA_RGB	<=  (others => '0') ; 	
		 drawing_request	<=  '0' ;

	elsif rising_edge(CLK) then
	
		sig_draw_req <= '0';
		
		if ( charge_drawing_X = '1') then
			if (charge_drawing_Y_red = '1' and max_charge = '1') then
				sig_draw_req <= '1';
				sig_draw_data <= red_color;
			end if;
			if (charge_drawing_Y_yellow_2 = '1' and charge_level >= "11") then
				sig_draw_req <= '1';
				sig_draw_data <= yellow_color_2;
			end if;
			if (charge_drawing_Y_yellow_1 = '1' and charge_level >= "10") then
				sig_draw_req <= '1';
				sig_draw_data <= yellow_color_1;
			end if;
			if (charge_drawing_Y_green = '1' and charge_level >= "01") then
				sig_draw_req <= '1';
				sig_draw_data <= green_color;
			end if;
		end if;
	
		mVGA_RGB	<=  sig_draw_data;	--get from colors table 
		drawing_request	<=  sig_draw_req ; -- get from mask table if inside rectangle
	end if;

  end process;

		
end architecture; 