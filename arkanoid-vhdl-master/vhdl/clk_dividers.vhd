-- Arkanoid clone
-- clk_dividers.vhd : clock dividers for ball and pad movement
--
-- Developed & tested on a Xilinx Spartan-3E Starter Kit FPGA Board Rev.D
--
-- Thijs van As, 2007

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.arkanoid_common.all;

entity clk_dividers is
    port (clk      : in  std_logic;
          clk_ball : out std_logic;
          clk_pad  : out std_logic);
end entity clk_dividers;

architecture behavioral of clk_dividers is
    signal count_b : std_logic_vector(3 downto 0)  := "0000";
    signal count_p : std_logic_vector(16 downto 0) := "00000000000000000";

begin
    -- clk_divider for ball movement    
    clk_div_ball : process (clk, count_p, count_b)
    begin
        if (clk = '1' and clk'event) then
            if (count_p = "11111111111111000" and count_b = "0100") then
                count_b  <= "0000";
                clk_ball <= '1';

            elsif (count_p = "11111111111111110") then
                count_b  <= count_b + '1';
                clk_ball <= '0';
            else
                clk_ball <= '0';
            end if;
        end if;
    end process clk_div_ball;

    -- clk_divider for pad movement
    clk_div_pad : process (clk, count_p)
    begin
        if (clk = '1' and clk'event) then
            if (count_p = "11111111111111111") then
                clk_pad <= '1';
                count_p <= "00000000000000000";
            else
                clk_pad <= '0';
                count_p <= count_p + '1';
            end if;
        end if;
    end process clk_div_pad;

end architecture behavioral;

