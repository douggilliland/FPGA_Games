---------------------------------------------------------------------------
--      BouncingBall.vhd                                                 --
--      Viral Mehta                                                      --
--      Spring 2005                                                      --
--                                                                       --
--      Modified by Stephen Kempf 03-01-2006                             --
--                                03-12-2007                             --
--      Fall 2008 Distribution                                         --
--                                                                       --
--      For use with ECE 385 Lab 9                                       --
--      UIUC ECE Department                                              --
---------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity BouncingBall is
    Port ( key: in std_logic_vector (2 downto 0);
           Clk : in std_logic;
           Reset : in std_logic;
           Red   : out std_logic_vector(9 downto 0);
           Green : out std_logic_vector(9 downto 0);
           Blue  : out std_logic_vector(9 downto 0);
           VGA_clk : out std_logic; 
           sync : out std_logic;
           blank : out std_logic;
           vs : out std_logic;
           hs : out std_logic);
end BouncingBall;

architecture Behavioral of BouncingBall is

component ball is
     Port (
       Reset : in std_logic;
       frame_clk : in std_logic;
       CountOver : in std_logic;
       keyin: in std_logic_vector(2 downto 0);
       finished_terminal: out std_logic_vector(3 downto 0);
       BallX: out std_logic_vector(9 downto 0); --ball parameters
       BallS : out std_logic_vector(9 downto 0);
       
       CarROWONEX, CarROWFOURX : out std_logic_vector(29 downto 0); 
	   CarROWTWOX: out std_logic_vector(49 downto 0); 
       CarROWTHREEX: out std_logic_vector (39 downto 0);  
             
       BallY, CarROWONEY, CarROWTWOY, CarROWTHREEY, CarROWFOURY : out std_logic_vector(9 downto 0); --car parameters
       
       
       log1X : out std_logic_vector(29 downto 0); 
       log1Y : out std_logic_vector(9 downto 0); --log1 parameters     
        
       log2X : out std_logic_vector(39 downto 0);
       log2Y : out std_logic_vector(9 downto 0); --log2 parameters    
       
       
       log3X : out std_logic_vector(19 downto 0);
       log3Y : out std_logic_vector(9 downto 0); --log3 parameters  
       
       log4X : out std_logic_vector(19 downto 0);
       log4Y : out std_logic_vector(9 downto 0); --log3 parameters  
       
       Min1,Min0,Sec1,Sec0: out std_logic_vector(3 downto 0);
       levelout: out std_logic_vector(1 downto 0);
       Anouncement: out std_logic;
       lives :	out std_logic_vector(1 downto 0); 
       fail, win : out std_logic);
end component; 


component BCDDownCounter is 
   Port ( 
       
        startMin1,startMin0,startSec1,startSec0: in std_logic_vector(3 downto 0);
        Min1Out,Min0Out,Sec1Out,Sec0Out: out std_logic_vector(3 downto 0);
        frame_clk,Reset: in std_logic;        
        Over: out std_logic);     
end component;

component vga_controller is
    Port ( clk : in std_logic;
           reset : in std_logic;
           hs : out std_logic;
           vs : out std_logic;
           pixel_clk : out std_logic;
           blank : out std_logic;
           sync : out std_logic;
           DrawX : out std_logic_vector(9 downto 0);
           DrawY : out std_logic_vector(9 downto 0));
end component;

component Color_Mapper is
    Port ( BallX : in std_logic_vector(9 downto 0);
           CarX1, CarX4 : in std_logic_vector(29 downto 0);
           BallY, CarY1, CarY2, CarY3, CarY4 : in std_logic_vector(9 downto 0);
           CarX2 : in std_logic_vector(49 downto 0);
           CarX3 : in std_logic_vector(39 downto 0); 
           log1X : in std_logic_vector(29 downto 0);
           log2X : in std_logic_vector(39 downto 0);
           log3X,log4X : in std_logic_vector(19 downto 0);
           log1Y,log2Y,log3Y,log4Y : in std_logic_vector(9 downto 0);
           DrawX : in std_logic_vector(9 downto 0);
           DrawY : in std_logic_vector(9 downto 0);
           Ball_size : in std_logic_vector(9 downto 0);
           keyboard_input: in std_logic_vector(2 downto 0); 
           Red   : out std_logic_vector(9 downto 0);
           Green : out std_logic_vector(9 downto 0);
           Blue  : out std_logic_vector(9 downto 0);
           lives : in std_logic_vector(1 downto 0); 
           Anouncement: in std_logic;
           level: in std_logic_vector(1 downto 0); 
           finished_terminal : in std_logic_vector(3 downto 0);
           Min1,Min0,Sec1,Sec0: in std_logic_vector(3 downto 0);
           fail, win : in std_logic);
end component;

signal Reset_h, vsSig, winSig, failSig,OverSig: std_logic;
signal DrawXSig, DrawYSig, BallXSig, BallYSig, BallSSig, CarYSig1, CarYSig2, CarYSig3, CarYSig4 : std_logic_vector(9 downto 0);
signal CarXSig1, CarXSig4   : std_logic_vector(29 downto 0);
signal CarXSig2  : std_logic_vector(49 downto 0);
signal CarXSig3  : std_logic_vector(39 downto 0);
signal log1XSig  : std_logic_vector(29 downto 0); 
signal log2XSig  : std_logic_vector(39 downto 0);
signal log3XSig,log4XSig  : std_logic_vector(19 downto 0);
signal log1YSig,log2YSig,log3YSig,log4YSig : std_logic_vector(9 downto 0);
signal Min1Sig,Min0Sig,Sec1Sig,Sec0Sig: std_logic_vector (3 downto 0);
signal OutMin1Sig,OutMin0Sig,OutSec1Sig,OutSec0Sig: std_logic_vector (3 downto 0);

signal finishedSig : std_logic_vector(3 downto 0);
signal liveSig,levelSig : std_logic_vector(1 downto 0);
signal AnounceSig: std_logic;


begin

Reset_h <= not Reset; -- The push buttons are active low

vgaSync_instance : vga_controller
   Port map(clk => clk,
            reset => Reset_h,
            hs => hs,
            vs => vsSig,
            pixel_clk => VGA_clk,
            blank => blank,
            sync => sync,
            DrawX => DrawXSig,
            DrawY => DrawYSig);

ball_instance : ball
   Port map(keyin => key,
            Reset => Reset_h,
            frame_clk => vsSig, -- Vertical Sync used as an "ad hoc" 60 Hz clock signal
            BallX => BallXSig,  --   (This is why we registered it in the vga controller!)
            BallY => BallYSig,
            BallS => BallSSig,
            finished_terminal=>finishedSig,
            win=>winSig,
            fail=>failSig,
            lives=>liveSig,
			CarROWONEX   => CarXSig1,
			CarROWONEY   => CarYSig1,
			CarROWTWOX   => CarXSig2,
			CarROWTWOY   => CarYSig2,
			CarROWTHREEX => CarXSig3,
			CarROWTHREEY => CarYSig3, 
			CarROWFOURX  => CarXSig4,
			CarROWFOURY  => CarYSig4,
			Min1=>Min1Sig,
			Min0=>Min0Sig,
			Sec1=>Sec1Sig,
			Sec0=>Sec0Sig, 
			CountOver=>OverSig,
			Anouncement=>AnounceSig,
			levelout=>levelSig,
			log1X=>log1XSig,
			log1Y=>log1YSig,
			log2X=>log2XSig,
			log2Y=>log2YSig,
			log3X=>log3XSig,
			log3Y=>log3YSig,
			log4X=>log4XSig,
			log4Y=>log4YSig
			);
			
BCDcounter: BCDDownCounter 
   Port map ( 
       
        startMin1=>Min1Sig,
        startMin0=>Min0Sig,
        startSec1=>Sec1Sig,
        startSec0=>Sec0Sig, 
        Min1Out=>OutMin1Sig,
        Min0Out=>OutMin0Sig,
        Sec1Out=>OutSec1Sig,
        Sec0Out=>OutSec0Sig,
        frame_clk => vsSig,
        Reset => Reset_h,     
        Over =>OverSig ); 

Color_instance : Color_Mapper
   Port Map(BallX => BallXSig,
            BallY => BallYSig,
            DrawX => DrawXSig,
            DrawY => DrawYSig,
            carX1 => CarXSig1,
            carY1 => CarYSig1,
            CarX2 => CarXSig2,
            CarY2 => CarYSig2,
            CarX3 => CarXSig3, 
            CarY3 => CarYSig3,
            CarX4 => CarXSig4,
            CarY4 => CarYSig4, 
            log1X=>log1XSig,
            log1Y=>log1YSig,
            log2X=>log2XSig,
            log2Y=>log2YSig,
            log3X=>log3XSig,
            log3Y=>log3YSig,  
            log4X=>log4XSig,
			log4Y=>log4YSig,
			Min1=>OutMin1Sig,
			Min0=>OutMin0Sig,
			Sec1=>OutSec1Sig,
			Sec0=>OutSec0Sig,     
            Ball_size => BallSSig,
            keyboard_input=> key,
            Anouncement=>AnounceSig,
            level=>levelSig,
            Red => Red,
            Green => Green,
            Blue => Blue,
            finished_terminal=>finishedSig,
            lives=>liveSig,
            win=>winSig,
            fail=>failSig
            );

vs <= vsSig;

end Behavioral;      
