

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.Constants.ALL;

entity VGAsync is
    Port ( syncclkin : in STD_LOGIC;
           HSync : out STD_LOGIC;
           VSync : out STD_LOGIC;
           Hpos: out INTEGER range 0 to Htot - 1 := 0;
           Vpos : out INTEGER range 0 to Vtot - 1 := 0);
end VGAsync;

architecture Behavioral of VGAsync is

signal SHpos: INTEGER range 0 to Htot - 1 := 0;
signal SVpos : INTEGER range 0 to Vtot - 1 := 0;

begin
    process(syncclkin)
    begin
    if ( rising_edge(syncclkin) ) then
        --iterating through the pixels
            if ( SHpos < Htot - 1) then
                SHpos <= SHpos + 1;
            else
                SHpos <= 0;
    
                if ( SVpos < Vtot - 1 ) then
                    SVpos <= SVpos + 1;
                else
                    SVpos <= 0;
                end if;
             end if;
             Hpos <= SHpos;
             Vpos <= SVpos;
        end if;
 end process;
 --pixel
--horizontal
Hsync <= '0' when( SHpos > HFP -1 and SHpos < HFP + HSP  ) else '1';
 --vertical
Vsync <= '0' when( SVpos > VFP -1  and SVpos < VFP + VSP  ) else '1';

end Behavioral;