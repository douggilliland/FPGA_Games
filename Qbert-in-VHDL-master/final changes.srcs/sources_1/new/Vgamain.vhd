


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.Constants.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Vgamain is
    Port ( topclock : in STD_LOGIC;
           buttons : in STD_LOGIC_VECTOR (4 downto 0);
           HSync : out STD_LOGIC;
           VSync : out STD_LOGIC;
           R,G,B : out STD_LOGIC_VECTOR (3 downto 0));
end Vgamain;

architecture Behavioral of Vgamain is
 component VGAsync is
    Port ( syncclkin : in STD_LOGIC;
           HSync : out STD_LOGIC;
           VSync : out STD_LOGIC;
           Hpos: out INTEGER range 0 to Htot - 1 := 0;
           Vpos : out INTEGER range 0 to Vtot - 1 := 0);
  end component;
  
  component Mechanics is
    Port( 
              clk: in STD_LOGIC;
              Hpos: in INTEGER range 0 to Htot - 1;
              Vpos : in INTEGER range 0 to Vtot - 1;
              buttonUR,buttonUL,buttonDR,buttonDL,buttonEnd: in STD_LOGIC;
              R,G,B: out STD_LOGIC_VECTOR (3 downto 0) );
  end component;
  
  signal newHpos : INTEGER range 0 to Htot - 1;
  signal newVpos : INTEGER range 0 to Vtot - 1 ;
begin
    
    syncronization: VGAsync port map(
        syncclkin => topclock,
        HSync => HSync,
        VSync => VSync,
        Hpos => newHpos,
        Vpos => newVpos );
        
    gameMechanics: Mechanics port map(
        clk => topclock,
        Hpos => newHpos,
        Vpos => newVpos,
        buttonUR => buttons(4),
        buttonUL => buttons(3),
        buttonDR => buttons(2),
        buttonDL => buttons(1),
        buttonEnd => buttons(0),
        R => R,
        G => G,
        B => B );


end Behavioral;
