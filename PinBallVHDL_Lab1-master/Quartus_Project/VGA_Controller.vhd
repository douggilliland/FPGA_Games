library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;
use ieee.STD_LOGIC_ARITH.all;

entity	VGA_Controller is 
port 
(	--	Host Side
	iCLK 			   : in std_logic;
	iRST_N 			: in std_logic;
	oCoord_X 		: out integer;
	oCoord_Y 		: out integer;

	iRed 		   	: in std_logic_vector(7 downto 0);
	iGreen 			: in std_logic_vector(7 downto 0);
	iBlue 			: in std_logic_vector(7 downto 0);
	
	oVGA_R 			: out std_logic_vector(7 downto 0);
	oVGA_G 			: out std_logic_vector(7 downto 0);
	oVGA_B 			: out std_logic_vector(7 downto 0);
	oVGA_H_SYNC 	: out std_logic;
	oVGA_V_SYNC 	: out std_logic;
	oVGA_SYNC 		: out std_logic;
	oVGA_BLANK 		: out std_logic;
	oVGA_CLOCK 		: out std_logic; 
	
	endOfFrame	 	: out std_logic --For user's use
	) ;
end entity;
--	Control Signal
architecture behav of VGA_Controller is

-- Parameters defined for a pixel clock of 25 MHz,
-- a refresh rate of 60 Hz & a display size of 640x480

--	Horizontal Parameters	( Pixel )
constant	H_SYNC_CYC	: integer :=	96;
constant	H_SYNC_BACK	: integer :=	46; 
constant	H_SYNC_ACT	: integer :=	640;	--Horizontal size
constant	H_SYNC_FRONT: integer :=	23; 
constant	H_SYNC_TOTAL: integer :=	805;
--	Vertical Parameters		( Line )
constant	V_SYNC_CYC	: integer :=	2;
constant	V_SYNC_BACK	: integer :=	30;  
constant	V_SYNC_ACT	: integer :=	480;	--Vertical size
constant	V_SYNC_FRONT: integer :=	6; 
constant	V_SYNC_TOTAL: integer :=	518;
--	Start Offset
constant	X_START		: integer :=	H_SYNC_CYC+H_SYNC_BACK;
constant	Y_START		: integer :=	V_SYNC_CYC+V_SYNC_BACK;



--	Internal Registers and Wires
signal H_Cont : integer;
signal V_Cont : integer;


signal oVGA_R_t : std_logic_vector ( 7 downto 0);
signal oVGA_G_t : std_logic_vector ( 7 downto 0);
signal oVGA_B_t : std_logic_vector ( 7 downto 0);

signal oVGA_H_SYNC_t : std_logic;
signal oVGA_V_SYNC_t : std_logic;


signal clk_25 : std_logic ; 

begin


oVGA_H_SYNC	<= oVGA_H_SYNC_t;
oVGA_V_SYNC	<= oVGA_V_SYNC_t;

	oVGA_BLANK	<=	oVGA_H_SYNC_t and oVGA_V_SYNC_t;
	oVGA_SYNC	<=	'0';
	oVGA_CLOCK	<=	iCLK;

	-- drive the outputs 

process ( iCLK, iRST_N)
begin
	if ( iRST_N = '0' ) then
		oVGA_R	<=	(OTHERS => '0');
		oVGA_G	<=	(OTHERS => '0');
		oVGA_B	<=	(OTHERS => '0');
		oCoord_X	<=	0;
		oCoord_Y	<=	0;

	elsif rising_edge (iCLK) then
		if(	H_Cont>=X_START and H_Cont<X_START+H_SYNC_ACT and
			   V_Cont >=Y_START  and V_Cont <Y_START+V_SYNC_ACT ) 
		then	
					oVGA_R	<=	 iRed 	 ; 
					oVGA_G	<=	 iGreen	 ;
					oVGA_B	<=	 iBlue	 ;	
					oCoord_X	<=	H_Cont-X_START;
				   oCoord_Y	<=	V_Cont-Y_START;

		else 
					oVGA_R	<=	(OTHERS => '0');
					oVGA_G	<=	(OTHERS => '0');
					oVGA_B	<=	(OTHERS => '0');
					oCoord_X	<=	0;
					oCoord_Y	<=	0;

		end if;  	

	end if ; 
end process;
				

-- Prescaler 25 MHZ generator from 50 MHZ  
process ( iCLK, iRST_N)
begin
	if ( iRST_N = '0' ) then
		clk_25	<=	'0';
	elsif rising_edge (iCLK) then
		clk_25 <=	not (clk_25);
	end if;
end process;

--	H_Sync Generator, Ref. 25.175 MHz Clock
process ( iCLK, iRST_N)
begin
	if ( iRST_N = '0' ) then
		H_Cont		<=	0;
		oVGA_H_SYNC_t	<=	'0';
	elsif rising_edge (iCLK) then
		--	H_Sync Counter
		if( H_Cont < H_SYNC_TOTAL ) then
				if(clk_25= '0') then
					H_Cont	<=	H_Cont+1;
				end if ;  
		else
			H_Cont	<=	0;
		end if;
		--	H_Sync Generator
		if( H_Cont < H_SYNC_CYC ) then
			oVGA_H_SYNC_t	<=	'0';
		else
			oVGA_H_SYNC_t	<=	'1';	
		end if;
	end if;
end process;	


--	V_Sync Generator, Ref. H_Sync
process ( iCLK, iRST_N)
begin
	if ( iRST_N = '0' ) then
		V_Cont		<=	0;	
		endOfFrame	<=	'0';

		oVGA_V_SYNC_t	<=	'0';
	elsif rising_edge (iCLK) then
		endOfFrame	<=	'0'; --default 

		--	When H_Sync Re-start
		if(H_Cont=0) then
			--	V_Sync Counter
			if( V_Cont < V_SYNC_TOTAL ) then 
				V_Cont	<=	V_Cont+1;
			else
				V_Cont	<=	0;
				endOfFrame	<=	'1';  -- single pulse 

			end if;
			--	V_Sync Generator
			if(	V_Cont < V_SYNC_CYC ) then 
				oVGA_V_SYNC_t	<=	'0';
			else
				oVGA_V_SYNC_t	<=	'1';
			end if;
		end if;
	end if;
	
end process;
	
	

	
	
	

end behav;