----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.02.2017 16:58:57
-- Design Name: 
-- Module Name: Interface - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work; 
use work.TableType.ALL;

entity Interface is  
port (  
        CLK      : in    std_logic;
-- data vga
        R1       : in    std_logic;
        R2       : in    std_logic;
        R3       : in    std_logic;
        G1       : in    std_logic;
        G2       : in    std_logic;
        G3       : in    std_logic;
        B1       : in    std_logic;
        B2       : in    std_logic;
        Hsync    : out   std_logic; 
        Vsync    : out   std_logic;
        vgaBlue  : out   std_logic_vector (3 downto 0); 
        vgaGreen : out   std_logic_vector (3 downto 0); 
        vgaRed   : out   std_logic_vector (3 downto 0);
-- data GoL
        H_btn    : in    std_logic;
        H_once_btn: in   std_logic;
        RST_btn  : in    std_logic
   );
end Interface;

architecture Behavioral of Interface is

component CellArray is
    port(
        CLK         : in std_logic;
        CLK_SLOW    : in std_logic;
        RST         : in std_logic;
        STATE       : out TABLE(80 downto 1, 60 downto 1));
end component;

component BSOD is
 port ( CLK      : in    std_logic; 
-- data vga
       R1       : in    std_logic;
       R2       : in    std_logic;
       R3       : in    std_logic;
       G1       : in    std_logic;
       G2       : in    std_logic;
       G3       : in    std_logic;
       B1       : in    std_logic;
       B2       : in    std_logic;
       Hsync    : out   std_logic; 
       Vsync    : out   std_logic;
       vgaBlue  : out   std_logic_vector (3 downto 0); 
       vgaGreen : out   std_logic_vector (3 downto 0); 
       vgaRed   : out   std_logic_vector (3 downto 0);
-- data image
       px       : in    std_logic;
       X,Y      : out   integer range 0 to 800
       );
end component;

component Echantilloneur is  --sampler for buttons
  port (
         S_E : in STD_LOGIC;
         CLK : in STD_LOGIC;
         Q_E : out STD_LOGIC :='0');
end component;

component RisingEdgeDetector is  
    port (
         i_clk     : in  std_logic;
         i_input   : in  std_logic;
         o_pulse   : out std_logic);
end component;

component ClockManager is  --generation of the game clock - only btn_fast works
Port ( CLK : in STD_LOGIC;
       CLK_btn_fast : in STD_LOGIC;
       CLK_btn_once : in STD_LOGIC;
       V_sync : in STD_LOGIC;
       CLK_gol : out STD_LOGIC);
end component;

signal internalPx           : std_logic;
signal internalX,internalY  : integer range 0 to 800;
signal internalState        : TABLE(80 downto 1, 60 downto 1); 
signal CLK_btn              : std_logic;
signal CLK_once_btn         : std_logic;
signal RST_signal           : std_logic;
signal CLK_Vsync            : std_logic;
signal internalVSync        : std_logic;
signal internalOnce_btn     : std_logic;

begin
VSync<=internalVSync;
BSOD1  : BSOD port map       (CLK,R1,R2,R3,G1,G2,G3,B1,B2,Hsync,internalVSync,vgaBlue,vgaGreen,vgaRed,internalPx,internalX,internalY);
Echan  : Echantilloneur port map (H_once_btn, CLK, CLK_once_btn);
Echan2 : Echantilloneur port map (RST_btn, CLK, RST_signal);
RED : RisingEdgeDetector port map (CLK, internalVSync, CLK_Vsync);
RED_once : RisingEdgeDetector port map (CLK, CLK_once_btn, internalOnce_btn);
CM : ClockManager port map (CLK, H_btn, internalOnce_btn, CLK_Vsync, CLK_btn);
CellMatrix : CellArray port map (CLK,CLK_btn,RST_signal,internalState);

transform : process (internalPx,internalX,internalY,CLK,internalState) --This Matrix transforms the Pixel Matrix into the GoL Matrix
begin
     if CLK'EVENT and CLK='1' then
     if(internalX<640 and internalY<480) then
       internalPx<=internalState(1+internalX/8,1+internalY/8);
     end if;
     end if;
end process;

end Behavioral;
