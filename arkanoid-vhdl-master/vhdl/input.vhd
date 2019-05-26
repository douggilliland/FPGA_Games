-- Arkanoid clone
-- input.vhd : user input handlers
--
-- Developed & tested on a Xilinx Spartan-3E Starter Kit FPGA Board Rev.D
--
-- Thijs van As, 2007

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.arkanoid_common.all;

entity input is
    port (clk         : in    std_logic;
          reset       : in    std_logic;
          clk_pad     : in    std_logic;
          end_of_life : in    std_logic;
          push_left   : in    std_logic;
          push_right  : in    std_logic;
          pad_pos     : inout std_logic_vector(9 downto 0);
          start       : out   std_logic);
end entity input;

architecture behavioral of input is

begin
    -- handles user input
    -- "1100011111" = 799
    user_input : process (clk, reset, end_of_life, clk_pad)
    begin
        if (reset = '1' or end_of_life = '1') then
            pad_pos <= "0110010000";    -- 400
            start   <= '0';
        elsif (clk = '1' and clk'event) then
            if (push_left = '1' and clk_pad = '1' and ((pad_pos - to_stdlogicvector(to_bitvector(PAD_LENGTH) srl 1)) > (FIELD_BORDER + "1"))) then
                pad_pos <= pad_pos - 1;
                pad_pos <= pad_pos - 1;
                start   <= '1';
            elsif (push_right = '1' and clk_pad = '1' and ((pad_pos + to_stdlogicvector(to_bitvector(PAD_LENGTH) srl 1)) < ("1100011111" - FIELD_BORDER))) then
                pad_pos <= pad_pos + 1;
                pad_pos <= pad_pos + 1;
                start   <= '1';
            end if;
        end if;
    end process user_input;
    
end architecture behavioral;
