# GameOfLife_FPGA
An implementation of the Game of Life on an FPGA, using VHDL. This was made on the Digilent Zedboard, using Vivado. 
The const.xdc file is the constraints file, and is specific to the ZedBoard. The rest should be ported to other boards. 

##Authors
Main authors: Frédéric Meinnel (Game of life part) and Apollinaire Lecocq (VGA and Interface part)

Special thanks to Laurent Cabaret

##Project 
This project is a 80*60 [Conway's Game of Life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life) with 5 premade patterns. It displays the game through a standard VGA protocol, in 640x480 pixels at 60 fps. On the ZedBoard, the constraints file is set to use the VGA port included. It has a reset button, that also changes the pattern of the game, and a generation button, that handles the game. 

In theory, the matrix could be way bigger than 80x60, but somehow Vivado's Synthesis failed for bigger matrices, even though the board's limits are not reached. This remains a mystery.

##Architecture of the code

###Interface.vhd

   This is the top file of the project. It calls other components such as CellArray (the game's manager) and BSOD(the VGA driver). It makes them work together by dividing the coordinates of the pixel sent by BSOD to make it fit the matrix of the game, in order to return the value of the pixel (on or off).

###CellArray.vhd

   This file generates the game. It contains all the initial patterns for the game too, including smaller versions and one bigger as well. The component calls the component Cell from Cell.vhd

###Cell.vhd

   This is the component for one cell. At each clk_E it counts its living neighbours and determinates its own state. Note that it uses integers to count the neighbours, and that they are ranged. Initially they were not ranged, thus they each had 32 bits, which was a huge bottleneck on the number of cells.

###ClockManager.vhd

   This component generates the game's clock. Basically, what it does is that when the generation button is pushed, it advances a generation every 10 frames, so 6 per second. Initially we also wanted it to be able to move just by one generation on a push, and to have two clock speeds, but that was not developped. 

###TablePackage.vhd

   This is the declaration of the type Table, and should be included as a library in the Vivado Project. This is basically an array.

###RisingEdgeDetector and Echantilloneur .vhd

   These are a rising edge detector and a sampler, used to sample the button input well.

###BSOD.vhd

   This is the VGA driver for 640\*480 pixels at 60 fps. It requests the value of a pixel by sending its coordinates X and Y, and at the next clock rising edge sends it on the vga port. Note that here, due to the fact that we only need two colors in this project, one for a living cell, one for a dead cell, the value recieved is a simple std_logic. Replacing it by a rgb input makes it a generic vga driver. This component also has a nice and useless feature, which is that you can choose the color of the living cells through the inputs R1,R2..B1,B2, that are connected to the 8 switches of the ZedBoard. The background of the game is always white, and its color can be changed in the code.

   A possible issue with this is that the pixels might have an offset, because the driver requests them at the moment it should display them, and displays them one pixel late.

   Note that this file is a bit dependent to the board, because on the zedboard each rgb pin is sampled on 4 bits, so the output of the BSOD component for rgb is 3 vectors of size 4.

   BSOD stands for blue screen of death.

###const.xdc

   This is the constraints file for the ZedBoard.

##Bistreams

   These bitstreams work in vivado, to be loaded on the ZedBoard. To load them, open Vivado, open the Hardware Manager, plug and power your ZedBoard, then open target on the zedboard, and finally program device, then browse for the bitstream you want to load.

###BSOD.bit

   This is a basic bitstream of a uniform screen. The color can be changed with the 8 switches.

###1DGoL.bit

   This is a 8x1 game of life, on vga. This was the first we coded.

###Inter9x9.bit

   This is a 8x8 matrix. It's the first 2D game of life we made. It has a glider as a pattern.

###Interface32x24.bit

   A 32x24 matrix, with a glider as a pattern. It's code is not space-optimized because every cell has 10 32 bit integers in it

###GliderGun.bit and GliderGunSequel.bit

   Twice the same glider gun pattern, with different implementation of the game.

###Interface80x60.bit

   This is the bitstream corresponding to the source code of this project. It has 4 patterns in it, changed using the reset button at the center of the cross on the zedboard. The patterns are: acorn, glider gun, R pentomino, glider.