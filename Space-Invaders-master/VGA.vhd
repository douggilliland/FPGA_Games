library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
entity VGA is
	port( 
		clk, reset : in std_logic;	
	        color: in std_logic_vector(2 downto 0);
		hsync : out std_logic;
		vsync : out std_logic;
		R, G, B: out std_logic_vector(3 downto 0);
		X : out std_logic_vector(9 downto 0);
		Y : out std_logic_vector(9 downto 0)
	);
end VGA;


architecture VGA of VGA is
	constant hpixels: integer := 800;
		--Value of pixels in a horizontal line = 800
	constant vlines: integer := 521;
		--Number of horizontal lines in the display = 521
	constant bh: integer := 654;
		--Length till the hor. signal goes from 1 to 0
	constant ch: integer := 752;
		--Length till the hor. signal goes from 0 to 1
	constant bv: integer := 490;
		--Length till the vertical signal goes from 1 to 0
	constant cv: integer := 492;
		--Length till the vertical signal goes from 0 to 1
	signal hcs, vcs : integer;
		--These are the Horizontal and Vertical counters
	signal vsenable: std_logic;
		--Enable for the Vertical counter
	signal count4 : integer;
	signal cout : integer;


begin
	process (clk, reset)
	begin
		if reset = '1' then 
			count4 <= 0;
		elsif (clk'event and clk = '1') then
			if count4 = 3 then
				count4 <= 0;
			else
				count4 <= count4 + 1;
			end if;
		end if;
	end process;
	cout <= 1 when count4 = 3 else 0;

	--Counter for the horizontal sync signal
	process (clk, reset)
	begin
		if reset = '1' then 
			hcs <= 0;
		elsif (clk'event and clk = '1') then
			if cout = 1 then
		
			if (hcs = hpixels - 1) then
				hcs <= 0;
			else
				hcs <= hcs + 1;
			end if;

			end if;
		end if;
	end process;
	vsenable <= '1' when hcs = hpixels - 1 and cout = 1 else '0';

	--Counter for the vertical sync signal
	process (clk, reset)
	begin
		if reset = '1' then 
			vcs <= 0;
		elsif(clk'event and clk = '1' ) then
			--Increment when enabled
			if vsenable = '1' then
				if vcs = vlines - 1 then 
				--Reset when the number of lines is reached
					vcs <= 0;
				else
					vcs <= vcs + 1; --Increment vertical counter
				end if;
			end if;
		end if;
	end process;
	hsync <= '0' when hcs >= bh and hcs < ch else '1' ;
	vsync <= '0' when vcs >= bv and vcs < cv else '1';

	process(hcs, vcs, color)
    	begin
        	if hcs < 640 and vcs < 480 then
                	R <= (3 downto 0 => color(2));
                	G <= (3 downto 0 => color(1));
                	B <= (3 downto 0 => color(0));
            	else
                	R <= "0000";
                	G <= "0000";
                	B <= "0000";
            	end if;
        end process;
	x <= std_logic_vector(to_unsigned(hcs, x'length));
	y <= std_logic_vector(to_unsigned(vcs, y'length));
end  VGA;