-- Arkanoid clone
-- output.vhd : output handlers
--
-- Developed & tested on a Xilinx Spartan-3E Starter Kit FPGA Board Rev.D
--
-- Thijs van As, 2007

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.arkanoid_common.all;

entity output is
    port (clk           : in  std_logic;
          ball_x_pos    : in  std_logic_vector(9 downto 0);
          ball_y_pos    : in  std_logic_vector(9 downto 0);
          block_matrix  : in  matrix;
          pad_pos       : in  std_logic_vector(9 downto 0);
          vga_vsynch    : out std_logic;
          vga_hsynch    : out std_logic;
          vga_out_blue  : out std_logic;
          vga_out_red   : out std_logic;
          vga_out_green : out std_logic;
          led           : out std_logic_vector(7 downto 0));
end entity output;

architecture behavioral of output is
    signal rowcount    : std_logic_vector(11 downto 0);
    signal columncount : std_logic_vector(11 downto 0);

begin
    -- generates h-sync and v-sync VGA signals
    video_synch : process (clk)
    begin
        if(clk'event and clk = '1') then
            if(rowcount >= 637 and rowcount < 643) then
                vga_vsynch <= '0';
            else
                vga_vsynch <= '1';
            end if;
            if(columncount >= 856 and columncount < 976) then
                vga_hsynch <= '0';
            else
                vga_hsynch <= '1';
            end if;
        end if;
    end process video_synch;

    -- keeps track of VGA rows and columns
    video_rows_cols : process (clk)
    begin
        if(clk'event and clk = '1') then
            columncount <= columncount + 1;
            if(columncount = 1040) then
                columncount <= "000000000000";
                rowcount    <= rowcount + 1;
            end if;

            if(rowcount = 666) then
                rowcount <= "000000000000";
            end if;
        end if;
    end process video_rows_cols;

    -- draw the screen
    draw : process (clk)
    begin
        if (clk = '1' and clk'event) then

            -- draw the field  
            -- "1001011000" = 600 
            -- "1100100000" = 800
            if (((rowcount = FIELD_BORDER or rowcount = ("1001011000"-FIELD_BORDER)) and columncount >= FIELD_BORDER and columncount <= ("1100100000"-FIELD_BORDER)) or
                (rowcount > FIELD_BORDER and rowcount < ("1001011000"-FIELD_BORDER) and (columncount = FIELD_BORDER or columncount = ("1100100000"-FIELD_BORDER)))) then
                vga_out_red   <= '1';
                vga_out_green <= '0';
                vga_out_blue  <= '0';
            else
                vga_out_red   <= '0';
                vga_out_green <= '0';
                vga_out_blue  <= '0';
            end if;

            -- draw the blocks (block_matrix)
            if ((rowcount >= BLOCKS_Y_START) and (rowcount < BLOCKS_Y_STOP) and
                (columncount >= BLOCKS_X_START) and (columncount < BLOCKS_X_STOP)) then

                for i in 0 to (BLOCK_ROWS - 1) loop
                    for j in 0 to (BLOCK_COLS - 1) loop
                        if (((((rowcount = (BLOCKS_Y_START + i*BLOCK_HEIGHT)) or
                               (rowcount = (BLOCKS_Y_START + BLOCK_HEIGHT - 1 + i*BLOCK_HEIGHT))) and 
                              (columncount >= (BLOCKS_X_START + j*BLOCK_WIDTH)) and
                              (columncount < (BLOCKS_X_START + BLOCK_WIDTH + j*BLOCK_WIDTH))) or
                             ((rowcount >= (BLOCKS_Y_START + i*BLOCK_HEIGHT)) and
                              (rowcount < (BLOCKS_Y_START + BLOCK_HEIGHT + i*BLOCK_HEIGHT)) and
                              ((columncount = (BLOCKS_X_START + j*BLOCK_WIDTH)) or
                               (columncount = (BLOCKS_X_START + BLOCK_WIDTH - 1 + j*BLOCK_WIDTH))))) and 
                            (block_matrix(i, j) = '1')) then

                            vga_out_red   <= '1';
                            vga_out_green <= '1';
                            vga_out_blue  <= '0';
                        elsif ((rowcount > (BLOCKS_Y_START + i*BLOCK_HEIGHT)) and
                               (rowcount < (BLOCKS_Y_START + BLOCK_HEIGHT - 1 + i*BLOCK_HEIGHT)) and
                               (columncount > (BLOCKS_X_START + j*BLOCK_WIDTH)) and
                               (columncount < (BLOCKS_X_START + BLOCK_WIDTH - 1 + j*BLOCK_WIDTH)) and
                               (block_matrix(i, j) = '1')) then

                            vga_out_red   <= '0';
                            vga_out_green <= '0';
                            vga_out_blue  <= '1';
                        end if;
                    end loop;
                end loop;
            end if;

            -- draw the pad
            if (rowcount >= 550 and rowcount < 560) then
                if ((rowcount = 550) and ((columncount >= (pad_pos - 3)) and (columncount <= (pad_pos + 3)))) then
                    vga_out_red   <= '1';
                    vga_out_green <= '1';
                    vga_out_blue  <= '1';
                elsif ((rowcount = 551) and ((columncount >= pad_pos - 8) and (columncount <= pad_pos + 8))) then
                    vga_out_red   <= '1';
                    vga_out_green <= '1';
                    vga_out_blue  <= '1';
                elsif ((rowcount = 552) and ((columncount >= pad_pos - 15) and (columncount <= pad_pos + 15))) then
                    vga_out_red   <= '1';
                    vga_out_green <= '1';
                    vga_out_blue  <= '1';
                elsif ((rowcount = 553) and ((columncount >= pad_pos - 19) and (columncount <= pad_pos + 19))) then
                    vga_out_red   <= '1';
                    vga_out_green <= '1';
                    vga_out_blue  <= '1';
                elsif ((rowcount = 554) and ((columncount >= pad_pos - 23) and (columncount <= pad_pos + 23))) then
                    vga_out_red   <= '1';
                    vga_out_green <= '1';
                    vga_out_blue  <= '1';
                elsif ((rowcount = 555) and ((columncount >= pad_pos - 27) and (columncount <= pad_pos + 27))) then
                    vga_out_red   <= '1';
                    vga_out_green <= '1';
                    vga_out_blue  <= '1';
                elsif ((rowcount = 556) and ((columncount >= pad_pos - 29) and (columncount <= pad_pos + 29))) then
                    vga_out_red   <= '1';
                    vga_out_green <= '1';
                    vga_out_blue  <= '1';
                elsif ((rowcount >= 557) and
                       (columncount >= (pad_pos - (to_stdlogicvector(to_bitvector(PAD_LENGTH) srl 1))) and
                        columncount <= (pad_pos + (to_stdlogicvector(to_bitvector(PAD_LENGTH) srl 1))))) then
                    vga_out_red   <= '1';
                    vga_out_green <= '1';
                    vga_out_blue  <= '1';
                elsif (columncount = FIELD_BORDER or columncount = ("1100100000" - FIELD_BORDER)) then
                    vga_out_red   <= '1';
                    vga_out_green <= '0';
                    vga_out_blue  <= '0';
                else
                    vga_out_red   <= '0';
                    vga_out_green <= '0';
                    vga_out_blue  <= '0';
                end if;
            end if;

            -- draw the ball
            if (rowcount > (ball_y_pos - BALL_RADIUS) and rowcount < (ball_y_pos + BALL_RADIUS)) then
                if ((rowcount = (ball_y_pos - BALL_RADIUS + 1) or rowcount = (ball_y_pos + BALL_RADIUS - 1)) and
                    (columncount >= (ball_x_pos - 1) and columncount <= (ball_x_pos +1))) then
                    vga_out_red   <= '0';
                    vga_out_green <= '1';
                    vga_out_blue  <= '1';
                elsif ((rowcount = (ball_y_pos - BALL_RADIUS + 2) or rowcount = (ball_y_pos + BALL_RADIUS - 2)) and
                       (columncount >= (ball_x_pos - 3) and columncount <= (ball_x_pos +3))) then
                    vga_out_red   <= '0';
                    vga_out_green <= '1';
                    vga_out_blue  <= '1';
                elsif ((rowcount = (ball_y_pos - BALL_RADIUS + 3) or rowcount = (ball_y_pos + BALL_RADIUS - 3)) and
                       (columncount >= (ball_x_pos - 4) and columncount <= (ball_x_pos +4))) then
                    vga_out_red   <= '0';
                    vga_out_green <= '1';
                    vga_out_blue  <= '1';
                elsif ((rowcount = (ball_y_pos - BALL_RADIUS + 4) or rowcount = (ball_y_pos + BALL_RADIUS - 4)) and
                       (columncount >= (ball_x_pos - 4) and columncount <= (ball_x_pos +4))) then
                    vga_out_red   <= '0';
                    vga_out_green <= '1';
                    vga_out_blue  <= '1';
                elsif ((rowcount >= (ball_y_pos - BALL_RADIUS + 5) and rowcount <= (ball_y_pos + BALL_RADIUS - 5)) and
                       (columncount >= (ball_x_pos - 5) and columncount         <= (ball_x_pos +5))) then
                    vga_out_red   <= '0';
                    vga_out_green <= '1';
                    vga_out_blue  <= '1';
                end if;
            end if;
        end if;
    end process draw;

    -- lights up led according to position of ball
    walking_leds : process (clk, ball_x_pos)
    begin
        if (clk = '1' and clk'event) then
            if (ball_x_pos >= 700) then
                led <= "00000001";
            elsif (ball_x_pos >= 600) then
                led <= "00000010";
            elsif (ball_x_pos >= 500) then
                led <= "00000100";
            elsif (ball_x_pos >= 400) then
                led <= "00001000";
            elsif (ball_x_pos >= 300) then
                led <= "00010000";
            elsif (ball_x_pos >= 200) then
                led <= "00100000";
            elsif (ball_x_pos >= 100) then
                led <= "01000000";
            elsif (ball_x_pos >= 0) then
                led <= "10000000";
            end if;
        end if;
    end process walking_leds;

end architecture behavioral;

