`timescale 1ns / 1ps
`include "gpu_definitions.v"
////////////////////////////////////////////////////////////////////////////////////
//
// pGB, yet another FPGA fully functional and super fun GB classic clone!
// Copyright (C) 2015-2016  Diego Valverde (diego.valverde.g@gmail.com)
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
//
////////////////////////////////////////////////////////////////////////////////////


module gpu_ucode_rom
(
  input  wire[7:0]  iAddr,
  output reg [`GPU_UOP_SZ-1:0]  oUop
);



always @ ( iAddr )
begin
  case ( iAddr )

  /*
/////////////PSEUDO CODE FOR BETTER UNDERSTANDING////////////////////

      state = SCANLINE_VRAM_READ
      cur_tile = 0
1:
      tile_row = 0
2:
      r2 = 32
3:

      vmem_addr = bgmoffset + cur_tile
      grvmem
      vmem_addr = bgtoffset + tile_row + vmem_data_shl_4
      grvmem

      bh = vmem_data
      vmem_addr++
      grvmem
      bl = vmem_data
      gwfbuffer

      cur_tile++
      r2--
      if (r2 > 0)
          goto 3


      tile_row += 2;
      ly++
      if (tile_row <= f)
         cur_tile -= 32
         goto 2;
     else
         goto 1


  */
///////////////////////////////////////////////////////////////////////////
//defines code for getting the first tile and applying color pallete to it
  0: oUop = { `gnop,  `gnull, `gnull, `gnull }; //always has to be a nop because of pc definition
  1: oUop = { `gwrl,  `state, `SCANLINE_VRAM_READ };// writes a literal to register state for cpu to know which state the GPU currently is

//Frame buffer render main loop. Ie. current_tile = 0
  2: oUop = { `gwrr, `cur_tile, `scy_shl_5__plus_scx, `gnull };//which tile am I on, (oScy >>3) <<5 + oScx)
  3: oUop = { `gwrr, `WinTile, `Win_index, `gnull };  // set up window tile index
//Next tile row loop
  4: oUop = { `gwrr, `tile_row, `scy_tile_row_offset, `gnull}; // which tile row am I on
//
  5: oUop = { `gwrl,  `r2, 12'd32 };//assign a literal to r2, 32 tiles

//Current tile render loop
  6: oUop = { `gadd,  `vmem_addr, `bgmoffset, `cur_tile };// adds current tile with bg offset to get vmem adress to know where to read
  7: oUop = { `grvmem, `gnull, `gnull, `gnull };//reads vmem and stores in vmem_data
  8: oUop = { `gwrr, `r3, `vmem_addr, `gnull };// store vmem adress in r3
  9: oUop = { `gadd,  `r1,`vmem_data_shl_4, `tile_row };//add tile row with vmem data shifted left by 4
  10: oUop = { `gadd,  `vmem_addr, `r1, `bgtoffset };// get address for tile memory with r1 and BG tile offset
  11: oUop = { `grvmem, `gnull, `gnull, `gnull };//read from tile memory stores in vmem data
  12: oUop = {  `gwrr,   `bh, `vmem_data, `gnull };// save in BH for high byte
  13: oUop = {  `gaddl,  `vmem_addr, 12'd1  };// get adress for BL adding one to current adress, reads next byte
  14: oUop = {  `grvmem, `gnull, `gnull, `gnull }; // save in vmem data
  15: oUop = {  `gwrr,   `bl, `vmem_data, `gnull };//save in BL for low byte
  16: oUop = {  `gwfbuffer,   `gnull,`gnull, `gnull};// BH and BL go through bg pallete and result gets saved in framebuffer

/////////////////////////uCode for sprite loop/////////////////////////////////////

  17: oUop = {`gwrl, `r6, 12'b10};                     // set bit 2 as 1 for next oUopp
  18: oUop = {`gand, `r3, `r6, `lcdc};                  //and bitwise for r6 and lcdc[1] = 1 sprites are on
  19: oUop = {`gjz,`skip_the_sprites};
  20:
  begin
   oUop = {`gwrl, `r6, 12'd0};                       //we have a maximum of 40 sprites x= 39*4 because if 4 byte descriptors

  end

  21: oUop = {`gadd, `vmem_addr, `r6, `oam_offset};     //get address of sprite
  22: oUop = {`grvmem, `gnull, `gnull, `gnull};               //store vmem data loads first byte of sprite  descriptor
  23: oUop = {`gsubl,  `vmem_data, 12'd0};               //Test to see if the sprite_y_coord is zero
  24: oUop = {`gjz, `get_next_sprite};                     //if y coord is zero jump to next sprite
  25: oUop = {`gwrl,`r4 , 12'd16};                            //Since the sprite_y_coord was no zero, we need to substract 16 in order to obtain the real sprite_y_coord
  26: oUop = {`gsub,`sprite_y_coord ,`vmem_data,`r4};         //get y coord of the sprite
  27: oUop = {`gaddl, `vmem_addr, 12'd1};                     //get address for next byte of sprite descriptor
  28: oUop = {`grvmem, `gnull,`gnull,`gnull};
  29: oUop = {`gsubl,  `vmem_data, 12'd0};               //Test to see if the sprite_x_coord is zero
  30: oUop = {`gjz,    `get_next_sprite};                     //if x coord is zero jump to next sprite
  31: oUop = {`gwrl,`r4 , 12'd8};
  32: oUop = {`gsub, `sprite_x_coord ,`vmem_data ,`r4 };    //get x coord
  33: oUop = {`gnop,  `gnull, `gnull, `gnull};  //{`gsub, `r5, `tile_column, `vmem_data};
  34: oUop = {`gsprtt,  `r4, `sprite_x_coord, `sprite_y_coord};     //Test if the sprite is in the current tile
  35: oUop = {`gjz,    `get_next_sprite};
//Fetch sprite tile number
  36: oUop = {`gaddl, `vmem_addr, 12'd1};//get next byte sprite index
  37: oUop = {`grvmem, `gnull,`gnull,`gnull};
  38: oUop = {`gadd, `r4 ,`vmem_data_shl_4, `tile_row };//`sprite_current_row_offset}; //define sprite tile index shifted by 4 to the left would get added with bgomffset for tile memory read
  39: oUop = {`gaddl, `vmem_addr, 12'd1};//get next byte sprite options
  40: oUop = {`grvmem, `gnull,`gnull,`gnull};
  41: oUop = {`gwrr, `sprite_info,`vmem_data}; //define `sprite_info bits are important for effects flips and flashes
//TODO DEFINE LOGIC FOR SpriteOPTIONS (LA FLECHA DE TETRIS NO TIENE OPTIONS ENTONCES QUIERO PROBAR DIBUJARLA SIN HACER LA PARTE
//DE OPTIONS)
//GO read tile memory

  42: oUop = {`gadd, `vmem_addr,`bgtoffset,`r4}; //by adding this two you get the address of the tile memory
  43: oUop = {`grvmem,`gnull,`gnull,`gnull};
  44: oUop = {`gwrr, `sh, `vmem_data, `gnull};                           //first tile high byte for current sprite
  45: oUop = {`gaddl, `vmem_addr, 12'd1};
  46: oUop = {`grvmem, `gnull,`gnull,`gnull};
  47: oUop = {`gwrr, `sl,`vmem_data, `gnull};                            //second tile low byte for current sprite
  48: oUop = {`gnop,  `gnull, `gnull, `gnull};//{`glsprtt, `gnull, `tile_row,`sprite_y_coord}; //test if sprite is in current row
  49: oUop = {`gnop,  `gnull, `gnull, `gnull};//{`gjz,`get_next_sprite};
  //TODO LOGIC FOR BACKGROUND AND FOREGROUND display for sprites
  //sprite palette logic
  50: oUop = {`gwfbuffer, `gnull,`gnull, `gnull};// SH and SL go through sprite palletes and result gets saved in framebuffer
//get_next_sprite
  51: oUop = {`gaddl,`r6, 12'd4};
  52: oUop = {`gsubl,`r6, 12'd156};//39*4 = 156
  53:  begin
  //$display("DRAW THE ARROW PLZ \n");
  //oUop = {`gjnz, 15'd20}; // end of sprites go to next tile
    oUop = {`gwrr,  `sprite_current_row_offset, `tile_row, `gnull};           //Each sprite row is 2Bytes (8 pixles). Increment the sprite row offset by 2 for next iteration
//  $finish();
end
/***************End of ucode for sprite loop********************************/

/************** Start of ucode for window **********************************/
//skip_the_sprites
 54: oUop = {`gwrl, `r6, 12'b00100001}; //set 1 on pos[5] of a temporal register
 55: oUop = {`gand, `r3, `r6, `lcdc}; // and with lcdc and save in r3
 56: oUop = {`gjz,`skip_the_window}; // if lcdc[5] and lcdc[0] not 1 then window display is off
 57: oUop = {`gwx,  `gnull, `gnull, `gnull};
 58: oUop = {`gjz,`skip_the_window};
 59: oUop = {`gwy,  `gnull, `gnull, `gnull}; //check if wx and wy are on screen
 60: //begin
// $display("I would check for a window tile...if i had one !!!");
 oUop = {`gjz,`skip_the_window};
 //end
 ///////at this point ,window is on  and wx and wy are inside screen////////////////
61: oUop = {`gsubl, `IsThisTileWin, 12'b0 }; //first we ask if current tile is a window tile
62: oUop = {`gjnz,`initialize_window}; // if Isthistilewin is 0 background tile isn't inside of window
63: oUop = {`gsubl,`Window_render,12'b0};
64: oUop = {`gjnz,`render_window};
65: oUop = {`ggoto,`skip_the_window};
//initialize_window
66: oUop = {`gwrl,`r5, 12'b0};
67: oUop = {`gwrl,`Window_render, 12'b1};
///render_window
68: oUop = { `gadd,  `vmem_addr, `Winmoffset, `r5 };//r5 is 0 so this would get the mem adress 9C00//{ `gadd,  `vmem_addr, `Winmoffset, `WinTile }//this one is not working
69: oUop = { `grvmem, `gnull, `gnull, `gnull };//reads vmem and stores in vmem_data
70: oUop = { `gwrr, `r3, `vmem_addr, `gnull };// store vmem adress in r3
71: oUop = { `gadd,  `r1,`vmem_data_shl_4, `tile_row };//add tile row with vmem data shifted left by 4
72: oUop = { `gadd,  `vmem_addr, `r1, `bgtoffset };// get address for tile memory with r1 and BG tile offset which is the same for window
73: oUop = { `grvmem, `gnull, `gnull, `gnull };//read from tile memory stores in vmem data
74: oUop = { `gwrr,   `bh, `vmem_data, `gnull };// save in BH for high byte
75: oUop = { `gaddl,  `vmem_addr, 12'd1  };// get adress for BL adding one to current address, reads next byte
76: oUop = { `grvmem, `gnull, `gnull, `gnull }; // save in vmem data
77: oUop = { `gwrr,   `bl, `vmem_data, `gnull };//save in BL for low byte
78: oUop = { `gwfbuffer,   `gnull,`gnull, `gnull};// BH and BL go through bg pallete  which work for window and result gets saved in framebuffer
///Update win tile index
79: oUop = {`gaddl,  `r5, 12'd1};// add 1 to r5, take in account this has to be changed for r5 its actually used in most logic..dedicate a reg
80: oUop = { `gaddl, `WinTile, 12'd1  }; //set up WinTile register for next iteration
81: oUop = { `gsubl, `WinTile, 12'd255  }; // are we going out off screen boundaries
82: oUop = { `gjnz, `skip_the_window };
83: oUop = { `gwrl, `Window_render, 12'd0 };
 //////////////////////////////end of window ucode//////////////////////////////////////////////////
//defines loop for getting the same row for the next tile//
//skip_the_window
  84: oUop = {`ginfbaddr, `gnull, `gnull, `gnull};        //Increment the framebuffer write pointer
  85: oUop = {`gwrl, `sl, 12'd0};
  86: oUop = {`gwrl, `sh, 12'd0};
  87: oUop = { `gsubl, `r1, 12'd8191}; //limit 0x1FFF or d 8191
  88: oUop = { `gsub, `r1, `fbuffer_addr, `r8191};          //Did we painted all of the 32x32 tiles?
  89: oUop = { `gjz, 18'h2};                                //Yes, ok restart the loop for next frame
  90: oUop = {  `gaddl, `r5, 12'd0 };                      //increment window tile
  91: oUop = { `gwrl,`sprite_current_row_offset, 12'd0};    //Reset the sprite roww offset to zero since we will start with a fresh tile now
  92: oUop = {  `gaddl, `cur_tile, 12'd1  };                //Time to take care of the next tile
  93: oUop = {  `gsubl, `r2, 12'd1 };                       //Is this tile the last of the 2 tiles in a tile row?
  94: oUop = {  `gjnz ,  18'd6};                           //No, Keep rendering the  remaining rows of the current tile line
  95: oUop = {  `gaddl,  `tile_row, 12'd2  };
  96: oUop = {  `gaddl , `ly, 12'd1 };
  97: oUop = {  `gwrr,  `r1, `tile_row, `gnull };
  98: oUop = {  `gsubl,  `r1, 12'h10 };
  99: oUop = {  `gjz , 18'd4  };                           //Move to next tile row 0

   //defines jump to next row of pixels
  100: oUop = {  `gsubl, `r5, 12'd32 };
  101: oUop = {  `gsubl, `cur_tile, 12'd32 };  //Reset the tile index to the first tile index in the row of tiles, this is because we always start a a row of tiles from left to right (like a typewritting machine)
  102: oUop = {  `ggoto,  18'd5 };              //Move down one row

  endcase
end

endmodule
