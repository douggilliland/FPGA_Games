library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity spaceinv is 
	port(   clk    : in STD_LOGIC;
		reset  : in STD_LOGIC;
		Fire   : in STD_LOGIC;
		hsync  : out STD_LOGIC;
		vsync  : out STD_LOGIC;
		R,G,B  : out std_logic_vector(3 downto 0);
		test_op: in std_logic;
		start  : in  std_logic;
		rightbutton : in std_logic;
		leftbutton : in std_logic     
	);
end spaceinv;

architecture a of spaceinv is
	
	--position and color
	signal color: std_logic_vector(2 downto 0);
	signal x, y: std_logic_vector(9 downto 0);

	--spaceship left/right buttons and column
	signal leftdir : std_logic;
	signal rightdir : std_logic;
	signal colss: integer range 0 to 19;

	--bullet on/off and row/col
	signal bullet_row : integer range 0 to 14;
	signal bullet_col : integer range 0 to 19;
	signal end_bullet : std_logic;
	signal bullet_on  : std_logic;
	
	--enable signals from timers for invaders and bullet
	signal enable_t1: std_logic;
	signal enable_t2: std_logic;

	--invaders row and column vector
	signal row_invaders: integer range 0 to 14;
	signal invaderspos:  STD_LOGIC_vector(19 downto 0);

	component VGA is
	port(   clk, reset: in std_logic;
	   	color: in std_logic_vector(2 downto 0);
		hsync : out std_logic;
		vsync : out std_logic;
		R, G, B: out std_logic_vector(3 downto 0);
		X : out std_logic_vector(9 downto 0);
		Y : out std_logic_vector(9 downto 0)
	);
	end component;
	
	component ScreenFormat is
	port (	x :   in std_logic_vector(9 downto 0);
		y :   in std_logic_vector(9 downto 0); 
		test_op: in std_logic;
		colss : in integer range 0 to 19;
		rowinv : in integer range 0 to 14;
		colinv : in  std_logic_vector(19 downto 0);
		bullet_row : in integer range 0 to 14;
		bullet_col : in  integer range 0 to 19;
		color: out std_logic_vector(2 downto 0)
	);
	end component;

	component timer is
	generic (maxval : integer);
	port (  clk    : in std_logic;
		reset  : in std_logic;
       		enable : out std_logic
     	);
	end component;

	component invaders is
	port (  clk	: in  STD_LOGIC;
		reset		: in  STD_LOGIC;
		start		: in  STD_LOGIC;
		bullet_row	: in integer range 0 to 14;
		bullet_col	: in integer range 0 to 19;
		bullet_on	: in std_logic;
		end_bullet	: out std_logic;
		row_invaders    : out  integer range 0 to 14;
		invaders	: out  STD_LOGIC_vector(19 downto 0);
		enable		: in std_logic
		);
	end component;

	component Starship is
	port (  clk, reset: in std_logic;
		rightdir: in std_logic;
		leftdir: in std_logic;
		colss: out  integer range 0 to 19
	);
	end component;

	component edgedetectorleft is
        port ( clk, reset: in  STD_LOGIC;
               signal_inleft: in  STD_LOGIC;
               outputleft: out  STD_LOGIC);
	end component;

	component edgedetectorright is
        port ( clk, reset: in  STD_LOGIC;
               signal_inright: in  STD_LOGIC;
               outputright: out  STD_LOGIC);
	end component;

	component shot is
	port( enable, clk, reset  : in  std_logic;
	      Fire		  : in  std_logic; 
	      bullet_row	  : out integer range 0 to 14;
	      bullet_col	  : out integer range 0 to 19;
	      end_bullet	  : in  std_logic;
	      bullet_on		  : out std_logic;
	      colss		  : in integer range 0 to 19
	);
	end component;

begin
	U1 : VGA port map(
		clk => clk,
		reset => reset,
		hsync => hsync,
		vsync => vsync,
		x => x,
		y => y,
		R => R,
		G => G,
		B => B,
		color => color
	);

	U2 : ScreenFormat port map(
		x => x,
		y => y, 
		test_op => test_op, 
		colss => colss,
		rowinv => row_invaders,
		colinv => invaderspos,
		bullet_row => bullet_row,
		bullet_col => bullet_col,
		color => color
	);

	T1: timer generic map(maxval => 50000000) port map(
		clk => clk,
		reset => reset,
       		enable => enable_t1
        );
	
	T2: timer generic map(maxval => 30000000) port map(
		clk => clk,
		reset => reset,
		enable => enable_t2
	);
		
	U4 : invaders port map(
		clk => clk,
		reset => reset,
		start => start,
		bullet_row => bullet_row,
		bullet_col => bullet_col,
		bullet_on => bullet_on,
		end_bullet => end_bullet,
		row_invaders => row_invaders, 
		invaders => invaderspos,
		enable => enable_t1	
	);

	EDR: edgedetectorright port map(
		clk => clk,
		reset => reset,
		signal_inright => rightbutton,
		outputright => rightdir
	);

	EDL: edgedetectorleft port map(
		clk => clk,
		reset => reset,
		signal_inleft => leftbutton,
		outputleft => leftdir
	);

	S1: Starship port map(
	        clk => clk,
		reset => reset,
		rightdir => rightdir,
		leftdir => leftdir,
		colss => colss
	);

	SH: shot port map(
		enable => enable_t2, 
		clk => clk, 
		reset => reset,	  
	 	Fire => Fire,		 
	 	bullet_row => bullet_row, 	
	 	bullet_col => bullet_col,	
	 	end_bullet => end_bullet,	
	 	bullet_on => bullet_on,	
	 	colss => colss			
	);
end a;