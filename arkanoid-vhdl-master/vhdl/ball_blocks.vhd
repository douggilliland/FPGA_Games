-- Arkanoid clone
-- ball_blocks.vhdl : ball and block handling
--
-- Developed & tested on a Xilinx Spartan-3E Starter Kit FPGA Board Rev.D
--
-- Thijs van As, 2007

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.arkanoid_common.all;

entity ball_blocks is
    port (clk          : in    std_logic;
          reset        : in    std_logic;
          clk_ball     : in    std_logic;
          start        : in    std_logic;
          pad_pos      : in    std_logic_vector(9 downto 0);
          end_of_life  : inout std_logic;
          ball_x_pos   : inout std_logic_vector(9 downto 0);
          ball_y_pos   : inout std_logic_vector(9 downto 0);
          block_matrix : inout matrix);
end entity ball_blocks;

architecture behavioral of ball_blocks is
    signal ball_angle_x : integer;
    signal ball_angle_y : integer;
    
begin
    -- calculates consequences of ball moves
    ball_moves : process (clk, reset, end_of_life, clk_ball, start)
    begin
        if (reset = '1' or end_of_life = '1') then
            ball_x_pos   <= "0110010000";  -- 400
            ball_y_pos   <= "0100110010";  -- 300
            ball_angle_x <= 1;
            ball_angle_y <= 1;
            end_of_life  <= '0';

            -- initialize block_matrix
            for i in 0 to (BLOCK_ROWS - 1) loop
                for j in 0 to (BLOCK_COLS - 1) loop
                    block_matrix(i, j) <= '1';
                end loop;
            end loop;
            
        elsif (clk = '1' and clk'event and clk_ball = '1' and start = '1') then
            ball_x_pos <= ball_x_pos + ball_angle_x;
            ball_y_pos <= ball_y_pos + ball_angle_y;

            -- pad bounce
            -- "11001" = 25
            -- "1111" = 15
            -- "11" = 3
            if (((ball_y_pos + BALL_RADIUS) >= 550) and
                ((ball_x_pos >= (pad_pos - (to_stdlogicvector(to_bitvector(PAD_LENGTH) srl 1)))) and
                 (ball_x_pos <= (pad_pos + (to_stdlogicvector(to_bitvector(PAD_LENGTH) srl 1))))) and
                (ball_angle_y > 0)) then

                if (ball_x_pos < (pad_pos - "11001")) then
                    if (ball_angle_x > 0) then
                        ball_angle_y <= -4;
                        ball_angle_x <= 1;
                    else
                        ball_angle_y <= -1;
                        ball_angle_x <= -4;
                    end if;
                elsif (ball_x_pos < (pad_pos - "1111")) then
                    if (ball_angle_x > 0) then
                        ball_angle_y <= -3;
                        ball_angle_x <= 1;
                    else
                        ball_angle_y <= -1;
                        ball_angle_x <= -3;
                    end if;
                elsif (ball_x_pos < (pad_pos - "11")) then
                    if (ball_angle_x > 0) then
                        ball_angle_y <= -2;
                        ball_angle_x <= 1;
                    else
                        ball_angle_y <= -1;
                        ball_angle_x <= -2;
                    end if;
                elsif ((ball_x_pos >= (pad_pos - 3)) and (ball_x_pos <= (pad_pos + "11"))) then
                    ball_angle_y <= -1*ball_angle_y;
                elsif (ball_x_pos > (pad_pos + "11")) then
                    if (ball_angle_x < 0) then
                        ball_angle_y <= -2;
                        ball_angle_x <= -1;
                    else
                        ball_angle_y <= -1;
                        ball_angle_x <= 2;
                    end if;
                elsif (ball_x_pos > (pad_pos + "1111")) then
                    if (ball_angle_x < 0) then
                        ball_angle_y <= -3;
                        ball_angle_x <= -1;
                    else
                        ball_angle_y <= -1;
                        ball_angle_x <= 3;
                    end if;
                elsif (ball_x_pos > (pad_pos + "11001")) then
                    if (ball_angle_x < 0) then
                        ball_angle_y <= -4;
                        ball_angle_x <= -1;
                    else
                        ball_angle_y <= -1;
                        ball_angle_x <= 4;
                    end if;
                end if;
            end if;

            -- ceiling bounce
            if ((ball_y_pos - BALL_RADIUS) <= (FIELD_BORDER + "1") and (ball_angle_y < 0)) then
                ball_angle_y <= -1*ball_angle_y;
            end if;

            -- right wall bounce
            -- "1100011111" = 799
            if ((ball_x_pos + BALL_RADIUS) >= ("1100011111" - FIELD_BORDER) and (ball_angle_x > 0)) then
                ball_angle_x <= -1*ball_angle_x;
            end if;

            -- left wall bounce
            if ((ball_x_pos - BALL_RADIUS) <= (FIELD_BORDER + "1") and (ball_angle_x < 0)) then
                ball_angle_x <= -1*ball_angle_x;
            end if;

            -- block bounce (block_matrix)
            if (((ball_y_pos + BALL_RADIUS) >= BLOCKS_Y_START) and
                ((ball_y_pos - BALL_RADIUS) < BLOCKS_Y_STOP) and
                ((ball_x_pos + BALL_RADIUS) >= BLOCKS_X_START) and
                ((ball_x_pos - BALL_RADIUS) < BLOCKS_X_STOP)) then

                for i in 0 to (BLOCK_ROWS - 1) loop
                    for j in 0 to (BLOCK_COLS - 1) loop
                        if (((ball_x_pos + BALL_RADIUS) >= (BLOCKS_X_START + j*BLOCK_WIDTH)) and
                            ((ball_x_pos - BALL_RADIUS) < (BLOCKS_X_START + BLOCK_WIDTH + j*BLOCK_WIDTH)) and
                            ((ball_y_pos + BALL_RADIUS) >= (BLOCKS_Y_START + i*BLOCK_HEIGHT)) and
                            ((ball_y_pos - BALL_RADIUS) < (BLOCKS_Y_START + BLOCK_HEIGHT + i*BLOCK_HEIGHT)) and
                            (block_matrix(i, j) = '1')) then
                            if ((((ball_x_pos + BALL_RADIUS) >= (BLOCKS_X_START + j*BLOCK_WIDTH)) and
                                 ((ball_x_pos + BALL_RADIUS) < (BLOCKS_X_START + 5 + j*BLOCK_WIDTH))) or 
                                (((ball_x_pos - BALL_RADIUS) <= (BLOCKS_X_START + BLOCK_WIDTH + j*BLOCK_WIDTH)) and
                                 ((ball_x_pos - BALL_RADIUS) > (BLOCKS_X_START + BLOCK_WIDTH - 5 + j*BLOCK_WIDTH)))) then
                                ball_angle_x <= -1*ball_angle_x;
                            else
                                ball_angle_y <= -1*ball_angle_y;
                            end if;
                            block_matrix(i, j) <= '0';
                        end if;
                    end loop;
                end loop;
            end if;

            -- miss!
            if ((ball_y_pos + BALL_RADIUS) > 555) then
                end_of_life <= '1';
            end if;
        end if;
    end process ball_moves;

end architecture behavioral;
