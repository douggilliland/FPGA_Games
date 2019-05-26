library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;

entity VGAPixelDriver is 
    Port(  clk : in STD_LOGIC;
           red_in, blue_in, green_in : in STD_LOGIC_VECTOR( 3 downto 0);
           Hsync, Vsync, display_o : out STD_LOGIC;
           pixel_x, pixel_y : out integer;
           refresh : out std_logic;
           red, blue, green : out STD_LOGIC_VECTOR( 3 downto 0) := "0000");
end VGAPixelDriver;
architecture behavioral of VGAPixelDriver is
signal pixel_clk : STD_LOGIC := '0';
signal line_clk : STD_LOGIC := '0';
signal vert_ok : STD_LOGIC := '0';
signal display :STD_LOGIC := '0';
signal all_ok : STD_LOGIC := '0';
begin
    pixel_clk_divider : process (clk)
    variable even : std_logic := '0';
    begin
       if ( rising_edge(clk) ) then 
        even := not even;
        if ( even = '0') then 
            pixel_clk <= not pixel_clk;
        end if;
       end if;
    end process pixel_clk_divider;
    
    refresh <= vert_ok;
    all_ok <= display and vert_ok;
    display_o <= all_ok;
    red <= red_in when all_ok = '1' else "0000";
    blue <= blue_in when all_ok = '1' else "0000";
    green <= green_in when all_ok = '1' else "0000";
   
    horizontal: process (pixel_clk)
    variable count800 : integer := 0;
    begin
        if ( rising_edge(pixel_clk ) ) then 
            if ( count800 = 0 ) then --start
                Hsync <= '1';
            elsif ( count800 = 96) then --pulse width
                Hsync <= '0';
            elsif ( count800 = 144 ) then --back porch
                display <= '1';
            elsif ( count800 = 400 ) then 
                line_clk <= '0';
            elsif ( count800 = 783 ) then 
                display <= '0';
            end if;
            count800 := count800 + 1;
            if ( count800 = 800 ) then
                count800 := 0;
                line_clk <= '1';
            end if;
            pixel_x <= count800 - 144;
            end if;
    end process horizontal;
   
    vertical : process( line_clk )
    variable count521 : integer := 0;
    begin
       if ( rising_edge(line_clk) ) then 
        if ( count521 = 0) then
            Vsync <= '1';
        elsif (count521 = 2) then
            Vsync <= '0';
        elsif ( count521 = 31 ) then
            vert_ok <= '1';
        elsif ( count521 = 511 ) then
            vert_ok <= '0';
        end if;
        count521 := count521 + 1;
        if ( count521 = 521 ) then
            count521 := 0;
        end if;
        pixel_y <= count521 - 31;
       end if; 
            
    end process vertical;
end behavioral;