-- Arkanoid clone
-- arkanoid_common.vhd : common definitions
--
-- Developed & tested on a Xilinx Spartan-3E Starter Kit FPGA Board Rev.D
--
-- Thijs van As, 2007

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

package arkanoid_common is
    -- change these constants to define the number of columns and rows of blocks
    constant BLOCK_COLS : integer := 3;  -- not working for more than 3x3 blocks as of yet... 'infinite' synthesization time
    constant BLOCK_ROWS : integer := 3;

    -- change these constants to define the size of a block (in pixels)
    constant BLOCK_WIDTH  : integer := 20;  -- default: 20
    constant BLOCK_HEIGHT : integer := 10;  -- default: 10

    -- change FIELD_BORDER to define how many pixels from the edge of the screen the playing field starts
    constant FIELD_BORDER : std_logic_vector(4 downto 0) := "11110";  -- default: 30

    -- change PAD_LENGTH to define the length (width) of the pad
    constant PAD_LENGTH : std_logic_vector(5 downto 0) := "111100";  -- default: 60

    -- change BALL_RADIUS to define the radius of the ball
    constant BALL_RADIUS : std_logic_vector(2 downto 0) := "110";  -- default:  6

    -- in principle, these constants should not be changed
    -- they are used to determine the position of the blocks in the field
    constant BLOCKS_Y_START : integer := 100;  -- 100
    constant BLOCKS_Y_STOP  : integer := BLOCKS_Y_START + BLOCK_HEIGHT * BLOCK_ROWS;  -- 130
    constant BLOCKS_X_START : integer := 400 - ((BLOCK_WIDTH / 2) * BLOCK_COLS);  -- 370
    constant BLOCKS_X_STOP  : integer := BLOCKS_X_START + BLOCK_WIDTH * BLOCK_COLS;  -- 430

    -- type definition for block_matrix matrix
    type matrix is array(0 to (BLOCK_COLS - 1), 0 to (BLOCK_ROWS - 1)) of std_logic;
end package arkanoid_common;

package body arkanoid_common is
end package body arkanoid_common;
