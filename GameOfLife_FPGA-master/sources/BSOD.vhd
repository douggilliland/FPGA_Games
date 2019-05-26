 ----------------------------------------------------------------------------------
-- Module Name:    vga1440x900 - Behavioral 
-- Version:        1.0
-- Author:         Mike Field (hamster@snap.net.nz)
-- 
-- Generate 1440 x 900 x 256 colour VGA signals.
--
-- Horizontal timing (frame)
-- Scanline part    Pixels    Time [µs]
-- Visible area    1440    13.52493660186
-- Front porch        80        0.75138536676998
-- Sync pulse        152    1.427632196863
-- Back porch        232    2.1790175636329
-- Whole line        1904    17.882971729126
--
-- Vertical timing (frame)
-- Polarity of vertical sync pulse is positive.
-- Frame part        Lines    Time [ms]
-- Visible area    900    16.094674556213
-- Front porch        1        0.017882971729126
-- Sync pulse        3        0.053648915187377
-- Back porch        28        0.50072320841552
-- Whole frame        932    16.666929651545
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity BSOD is
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
end BSOD;

architecture Behavioral of BSOD is


  signal hcounter : integer range 0 to 800 :=0;
  signal vcounter : integer range 0 to 525 :=0;
  signal slowClk : STD_LOGIC;
  signal cpt : integer range 0 to 3 :=0 ;
  signal red, blue, green : STD_LOGIC_VECTOR (3 downto 0) :="0000";
  signal h, v : STD_LOGIC;
  signal xInt,yInt: integer range 0 to 800;

begin
vgaBlue <= blue;
vgaRed <= red;
vgaGreen <= green;
Hsync <= h;
Vsync<=v;
X<=xInt;
Y<=yInt;

xInt<= hcounter-47 when hcounter >=47 else 800;
yInt<= vcounter-32 when vcounter >=32 else 800;


  process(hcounter, vcounter, slowClk, CLK) --, R1, R2, R3, G1, G2, G3, B1, B2) --Display
  begin
  if CLK'EVENT and CLK='1' and slowClk='1' then
    if (hcounter>47 and hcounter<47+640 and vcounter>32 and vcounter<32+480) then
    -- display instructions
      if px = '1' then
        red <= '0'&R1&R2&R3;
        green<='0'&G1&G2&G3;
        blue<='0'&B1&B2&'1';
      else
        red<="0111";
        green<="0111";
        blue<="0011";
      end if;
    else 
      red<="0000";
      green<="0000";
      blue<="0000";
    end if;
  end if;
  end process;
  
  process (hcounter,CLK,slowClk) --hsync management
  begin
  if CLK'EVENT and CLK='1' and slowClk='1' then
    if hcounter>=(48+640+16-1) then
      h<='0';
    else
      h<='1';
    end if;
  end if;
  end process;
  
  process (vcounter,CLK,slowClk) --vsync management
  begin
    if CLK'EVENT and CLK = '1' and slowClk='1' then
      if vcounter>=(33+480+10-1) then
        v<='0';
      else
        v<='1';
      end if;
    end if;
  end process;
  
  
  process(slowClk,hcounter,vcounter,clk) --counters Management
  begin
    if CLK'EVENT and CLK = '1' then
      if slowClk = '1' then
        if hcounter=799 then
          hcounter<=0;
          if vcounter = 524 then
            vcounter<=0;
          else
            vcounter<=vcounter+1;
          end if;
        else
          hcounter<=hcounter+1;
        end if;
      end if;
    end if;
  end process;
  
  process (CLK) --slowClk at 25MHz is the standard VGA rate for 640x480 at 60fps
  begin
  if CLK'EVENT and CLK = '1' then
      cpt<=cpt+1;
      if cpt >= 3 then
          slowClk <= '1';
          cpt<=0;
      else
          slowClk <= '0';
      end if;
  end if;
  end process;

end behavioral;