-- Arkanoid clone
-- arkanoid.vhd : top level entity
--
-- Developed & tested on a Xilinx Spartan-3E Starter Kit FPGA Board Rev.D
--
-- Thijs van As, 2007

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.arkanoid_common.all;

entity arkanoid is
    port(clk_50mhz     : in  std_logic;
         reset         : in  std_logic;
         push_left     : in  std_logic;
         push_right    : in  std_logic;
         vga_vsynch    : out std_logic;
         vga_hsynch    : out std_logic;
         vga_out_blue  : out std_logic;
         vga_out_red   : out std_logic;
         vga_out_green : out std_logic;
         led           : out std_logic_vector(7 downto 0));
end entity arkanoid;

architecture behavioral of arkanoid is
    signal pad_pos : std_logic_vector(9 downto 0);

    signal ball_x_pos : std_logic_vector(9 downto 0);
    signal ball_y_pos : std_logic_vector(9 downto 0);

    signal clk_pad  : std_logic;
    signal clk_ball : std_logic;

    signal start       : std_logic := '0';
    signal end_of_life : std_logic := '0';

    signal block_matrix : matrix;

    component clk_dividers is
        port (clk      : in  std_logic;
              clk_ball : out std_logic;
              clk_pad  : out std_logic);
    end component clk_dividers;

    component output is
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
    end component output;

    component input is
        port (clk         : in    std_logic;
              reset       : in    std_logic;
              clk_pad     : in    std_logic;
              end_of_life : in    std_logic;
              push_left   : in    std_logic;
              push_right  : in    std_logic;
              pad_pos     : inout std_logic_vector(9 downto 0);
              start       : out   std_logic);
    end component input;

    component ball_blocks is
        port (clk          : in    std_logic;
              reset        : in    std_logic;
              clk_ball     : in    std_logic;
              start        : in    std_logic;
              pad_pos      : in    std_logic_vector(9 downto 0);
              end_of_life  : inout std_logic;
              ball_x_pos   : inout std_logic_vector(9 downto 0);
              ball_y_pos   : inout std_logic_vector(9 downto 0);
              block_matrix : inout matrix);
    end component ball_blocks;
    
begin
    -- clock dividers for the ball and pad movement
    proc_clk_dividers : clk_dividers port map (clk      => clk_50mhz,
                                               clk_ball => clk_ball,
                                               clk_pad  => clk_pad);

    -- output handlers
    proc_output : output port map (clk           => clk_50mhz,
                                   ball_x_pos    => ball_x_pos,
                                   ball_y_pos    => ball_y_pos,
                                   block_matrix  => block_matrix,
                                   pad_pos       => pad_pos,
                                   vga_vsynch    => vga_vsynch,
                                   vga_hsynch    => vga_hsynch,
                                   vga_out_blue  => vga_out_blue,
                                   vga_out_red   => vga_out_red,
                                   vga_out_green => vga_out_green,
                                   led           => led);

    -- input handler
    proc_input : input port map (clk         => clk_50mhz,
                                 reset       => reset,
                                 clk_pad     => clk_pad,
                                 end_of_life => end_of_life,
                                 push_left   => push_left,
                                 push_right  => push_right,
                                 pad_pos     => pad_pos,
                                 start       => start);

    -- calculates consequences of ball position
    proc_ball_blocks : ball_blocks port map (clk          => clk_50mhz,
                                             reset        => reset,
                                             clk_ball     => clk_ball,
                                             start        => start,
                                             pad_pos      => pad_pos,
                                             end_of_life  => end_of_life,
                                             ball_x_pos   => ball_x_pos,
                                             ball_y_pos   => ball_y_pos,
                                             block_matrix => block_matrix);

end architecture behavioral;

