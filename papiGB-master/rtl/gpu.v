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
module gpu
(
  input wire iClock,
  input wire iReset,

  output wire         oFramBufferWe, //ask for write
  output wire [15:0]  oFramBufferData, //data for writing on buffer
  output wire [15:0]  oFramBufferAddr, //address to which one wants to write on buffer

  output wire [15:0] oMcuAddr,  //adress that wants to be read
  output reg        oMcuReadRequest,  //ask for read, gain control over databus(depends of timing)
  input wire [3:0]  iMcuRegSelect, //control register select comes from cpu
  input wire [7:0]  iMcuWriteData, //what does the cpu want to write
  input wire [7:0]  iMcuReadData, //data the cpu wants to be written
  input wire        iMcuWe, //write enable for vmem

 //registros de gameboy
  output wire [7:0]  oSTAT, //status reg
  output wire [7:0]  oLCDC, //lcd control
  output wire [7:0]  oSCY, //scroll y position
  output wire [7:0]  oSCX, // scroll x position
  output wire [7:0]  oLY, //which column im on
  output wire [7:0]  oLYC, // compares actual column
  output wire [7:0]  oDMA, //sprites
  output wire [7:0]  oBGP, // bg pallette
  output wire [7:0]  oOBP0, // pallette 1 for sprites
  output wire [7:0]  oOBP1, // pallette 2 for sprites
  output wire [7:0]  oWY,//coords for window, vertical
  output wire [7:0]  oWX // coords for window, horizontal

);


wire [20:0] wMcuRegWriteSelect;
wire [31:0] wGpuRegWriteSelect;
wire [15:0] wOp0, wOp1, wR0, wR1, wR3,wR4, wR5, wR6,  wSpriteCoordX,wSpriteCoordY, wOp0_Pre_B, wOp0_Pre_A, wOp1_Pre_B, wOp1_Pre_A;
wire [7:0] wR2;
wire [15:0]  wCurrentTile,wWinTile;  //Only support up to 32*32 = 1024 tiles
wire [7:0] wBh, wBl, wState, wIp, wInitialPc, wSC_Tile_Row;
wire [15:0] wBGTileOffset, wBGTileMapOffset, wBGRowOffset, wFrameBufferAddress, wCurrentTileRow,wOAMOffset;
wire [15:0] wTile1_Bg_Offset, wTile0_Bg_Offset,wWinTileMapOffset;
wire [15:0] wSC_Tile,wWinTileindex;
wire [7:0] wRegSelect, wSh, wSl;
wire [1:0] wPixel0,wPixel1,wPixel2,wPixel3,wPixel4,wPixel5,wPixel6,wPixel7;
wire [1:0] wBgPixel0,wBgPixel1,wBgPixel2,wBgPixel3,wBgPixel4,wBgPixel5,wBgPixel6,wBgPixel7;
wire [1:0] wSprtPixel0,wSprtPixel1,wSprtPixel2,wSprtPixel3,wSprtPixel4,wSprtPixel5,wSprtPixel6,wSprtPixel7;
wire [`GPU_UOP_SZ-1:0] wUop;
wire [5:0] wOp1Sel;
wire wZ, wRegWe, wGpuActive, wIsSpriteInCurrentTile,wIsSpriteInCurrentRow,wIsWyOnScreen,wIsWxOnScreen,wWinEnabled, wIsWininBG;
wire [15:0] wSpriteWidth, wSpriteHeight, wTileCoordX, wTileCoordY,wSprite_tile_offset,wSprite_info;
reg [15:0] rResult;
reg rRegWe, rBgBufferWe, rJump, rIncFBufferAddr;

wire[15:0] wSpriteTopLeftX     ;
wire[15:0] wSpriteTopLeftY     ;
wire[15:0] wSpriteTopRightX    ;
wire[15:0] wSpriteTopRightY    ;
wire[15:0] wSpriteBottomLeftX  ;
wire[15:0] wSpriteBottomLeftY  ;
wire[15:0] wSpriteBottomRightX ;
wire[15:0] wSpriteBottomRightY ;
wire[15:0] wTileLeft   ;
wire[15:0] wTileRight  ;
wire[15:0] wTileTop    ;
wire[15:0] wTileBottom ;




assign oFramBufferData = {wPixel7,wPixel6,wPixel5,wPixel4,wPixel3,wPixel2,wPixel1,wPixel0};
assign wPixel0 = ({wSh[0],wSl[0]} == `SPRITE_COLOR_TRANSPARENT)? wBgPixel0 : wSprtPixel0;
assign wPixel1 = ({wSh[1],wSl[1]} == `SPRITE_COLOR_TRANSPARENT)? wBgPixel1 : wSprtPixel1;
assign wPixel2 = ({wSh[2],wSl[2]} == `SPRITE_COLOR_TRANSPARENT)? wBgPixel2 : wSprtPixel2;
assign wPixel3 = ({wSh[3],wSl[3]} == `SPRITE_COLOR_TRANSPARENT)? wBgPixel3 : wSprtPixel3;
assign wPixel4 = ({wSh[4],wSl[4]} == `SPRITE_COLOR_TRANSPARENT)? wBgPixel4 : wSprtPixel4;
assign wPixel5 = ({wSh[5],wSl[5]} == `SPRITE_COLOR_TRANSPARENT)? wBgPixel5 : wSprtPixel5;
assign wPixel6 = ({wSh[6],wSl[6]} == `SPRITE_COLOR_TRANSPARENT)? wBgPixel6 : wSprtPixel6;
assign wPixel7 = ({wSh[7],wSl[7]} == `SPRITE_COLOR_TRANSPARENT)? wBgPixel7 : wSprtPixel7;





assign oFramBufferAddr = {2'b0,wFrameBufferAddress};  // address to be written on buffer
assign oFramBufferWe   = rBgBufferWe; // write enable

//LCCD Bit 2 - OBJ (Sprite) Size              (0=8x8, 1=8x16)
assign wSpriteWidth  = 16'h8;
assign wSpriteHeight = ( oLCDC[2] == 1'b1) ? 16'd16 : 16'd8;

//wTileCoordX =  8*(wCurrentTile % 32)
assign wTileCoordX =  wCurrentTile[4:0] << 3;

//wTileCoordY = (wCurrentTile / 32)*8
assign wTileCoordY = (wCurrentTile >>5) << 3;

//Check if the sprite intersects the current tile

assign wSpriteTopLeftX     = wSpriteCoordX;
assign wSpriteTopLeftY     = wSpriteCoordY;

assign wSpriteTopRightX    = wSpriteCoordX + wSpriteWidth;
assign wSpriteTopRightY    = wSpriteCoordY;

assign wSpriteBottomLeftX  = wSpriteCoordX;
assign wSpriteBottomLeftY  = wSpriteCoordY + wSpriteHeight;

assign wSpriteBottomRightX = wSpriteTopRightX;
assign wSpriteBottomRightY = wSpriteBottomLeftY;

assign wTileLeft   = wTileCoordX;
assign wTileRight  = wTileCoordX + 8'd8;
assign wTileTop    = wTileCoordY;
assign wTileBottom = wTileCoordY + 16'd8;


assign wIsSpriteInCurrentTile =
   (

     //Test top left sprite corner
    ((wSpriteTopLeftX >= wTileLeft && wSpriteTopLeftX < wTileRight ) &&
    (wSpriteTopLeftY  >= wTileTop  && wSpriteTopLeftY < wTileBottom))
    ||
     //Test top right sprite corner
     ((wSpriteTopRightX >  wTileLeft && wSpriteTopRightX < wTileRight ) &&
     (wSpriteTopRightY  >  wTileTop  && wSpriteTopRightY < wTileBottom))
    ||
    ((wSpriteBottomRightX > wTileLeft && wSpriteBottomRightX < wTileRight ) &&
    (wSpriteBottomRightY  > wTileTop  && wSpriteBottomRightY < wTileBottom))
    ||
    ((wSpriteBottomLeftX > wTileLeft && wSpriteBottomLeftX < wTileRight ) &&
    (wSpriteBottomLeftY  > wTileTop  && wSpriteBottomLeftY < wTileBottom))
   ) ? 1'b1 : 1'b0;

assign wIsSpriteInCurrentRow = (wCurrentTileRow + wTileCoordY >= wSpriteCoordY &&
wCurrentTileRow + wTileCoordY <= wSpriteCoordY + wSpriteHeight) ? 1'b1 : 1'b0;

assign wIsWyOnScreen = (0 <= oWY <= 8'd143) ? 1'b1:1'b0;

assign wIsWxOnScreen = (0 <= oWX <= 8'd166) ? 1'b1:1'b0;

assign oSTAT = { 6'b0, wState };


// nintendo defined control registers made with flips flops so one can access them all at the same time
FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 ) FF_LCDC( iClock, iReset, iMcuWe  & wMcuRegWriteSelect[0], iMcuWriteData, oLCDC ); //lcd control
FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 ) FFX_STAT(   iClock, iReset, wRegWe  & wGpuRegWriteSelect[1], rResult[7:0], wState );//state register
FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 ) FF_SCY(  iClock, iReset, iMcuWe  & wMcuRegWriteSelect[2], iMcuWriteData, oSCY );// scroll y
FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 ) FF_SCX(  iClock, iReset, iMcuWe  & wMcuRegWriteSelect[3], iMcuWriteData, oSCX );// scroll x
FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 ) FF_LY(   iClock, iReset, wRegWe  & wGpuRegWriteSelect[4], rResult[7:0], oLY );// defines current tile
FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 ) FF_LYC(  iClock, iReset, iMcuWe  & wMcuRegWriteSelect[5], iMcuWriteData, oLYC );//compares to get column
FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 ) FF_DMA(  iClock, iReset, iMcuWe  & wMcuRegWriteSelect[6], iMcuWriteData, oDMA );// writes data in sprite memory $FE00-FE9F.
FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 )FFS_BGP(  iClock, iReset, iMcuWe  & wMcuRegWriteSelect[7], iMcuWriteData, oBGP );// bg pallete
FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 )FFS_OBP0( iClock, iReset, iMcuWe  & wMcuRegWriteSelect[8], iMcuWriteData, oOBP0 );// sprite pallet 1
FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 )FFS_OBP1( iClock, iReset, iMcuWe  & wMcuRegWriteSelect[9], iMcuWriteData, oOBP1 );// sprite pallet 2
FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 )FFS_WY(   iClock, iReset, iMcuWe  & wMcuRegWriteSelect[10],iMcuWriteData, oWY );
FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 )FFX_WX(   iClock, iReset, iMcuWe  & wMcuRegWriteSelect[11],iMcuWriteData, oWX );



//User defined control registers
FFD_POSEDGE_SYNCRONOUS_RESET # ( 16 )FFX_12(   iClock, iReset, wRegWe  & wGpuRegWriteSelect[12], rResult,      oMcuAddr ); //address one wants to read from VMEM
FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 )FFX_13(    iClock, iReset, wRegWe  & wGpuRegWriteSelect[13], rResult[7:0], wBh );//tile high byte
FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 )FFX_14(    iClock, iReset, wRegWe  & wGpuRegWriteSelect[14], rResult[7:0], wBl );//tile low byte
UPCOUNTER_POSEDGE            # ( 16 )UP_15(    iClock, iReset,  13'b0, wGpuActive  & rIncFBufferAddr,          wFrameBufferAddress );// where to write on framebuffer
FFD_POSEDGE_SYNCRONOUS_RESET # ( 16 )FFX_16(   iClock, iReset, wRegWe  & wGpuRegWriteSelect[16], rResult,      wCurrentTile );// gp registers
FFD_POSEDGE_SYNCRONOUS_RESET # ( 16 )FFX_17(   iClock, iReset, wRegWe  & wGpuRegWriteSelect[17], rResult,      wSprite_tile_offset );// tile indx for sprite
FFD_POSEDGE_SYNCRONOUS_RESET # ( 16 )FFX_18(   iClock, iReset, wRegWe  & wGpuRegWriteSelect[18], rResult,      wSpriteCoordX );// gp reg
FFD_POSEDGE_SYNCRONOUS_RESET # ( 16 )FFX_19(   iClock, iReset, wRegWe  & wGpuRegWriteSelect[19], rResult,      wSpriteCoordY );// gp reg
FFD_POSEDGE_SYNCRONOUS_RESET # ( 16 )FFX_20(   iClock, iReset, wRegWe  & wGpuRegWriteSelect[20], rResult,      wCurrentTileRow );//which tile row am I on
FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 )FFX_21(   iClock, iReset, wRegWe  & wGpuRegWriteSelect[21], rResult[7:0],  wSh );
FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 )FFX_22(   iClock, iReset, wRegWe  & wGpuRegWriteSelect[22], rResult[7:0],  wSl );
FFD_POSEDGE_SYNCRONOUS_RESET # ( 16 )FFX_23(   iClock, iReset, wRegWe  & wGpuRegWriteSelect[23], rResult,      wR0 );// gp reg
FFD_POSEDGE_SYNCRONOUS_RESET # ( 16 )FFX_24(   iClock, iReset, wRegWe  & wGpuRegWriteSelect[24], rResult,      wR1 );// gp reg
FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 )FFX_25(   iClock, iReset,  wRegWe  & wGpuRegWriteSelect[25], rResult[7:0], wR2 );// gp reg
FFD_POSEDGE_SYNCRONOUS_RESET # ( 16 )FFX_26(   iClock, iReset, wRegWe  & wGpuRegWriteSelect[26], rResult,      wR3 );// gp reg
FFD_POSEDGE_SYNCRONOUS_RESET # ( 16 )FFX_27(   iClock, iReset, wRegWe  & wGpuRegWriteSelect[27], rResult,      wR4 );// gp reg
FFD_POSEDGE_SYNCRONOUS_RESET # ( 16 )FFX_28(   iClock, iReset, wRegWe  & wGpuRegWriteSelect[28], rResult,      wR5 );// gp reg
FFD_POSEDGE_SYNCRONOUS_RESET # ( 16 )FFX_29(   iClock, iReset, wRegWe  & wGpuRegWriteSelect[29], rResult,      wR6 );// gp reg
FFD_POSEDGE_SYNCRONOUS_RESET # ( 16 )FFX_30(   iClock, iReset, wRegWe  & wGpuRegWriteSelect[30], rResult,      wWinTile );// gp reg
FFD_POSEDGE_SYNCRONOUS_RESET # ( 16  )FFX_31(   iClock, iReset, wRegWe  & wGpuRegWriteSelect[31], rResult,      wSprite_info );



//                                                                                          32 is wBGTileMapOffset
//                                                                                          33 is wBGTileOffset
//                                                                                          34 is {8'h0,iMcuReadData}         vmem_data
//                                                                                          35 is wBGRowOffset
//                                                                                          36 ly_mod_8 = {8'h0,6'h0,oLY[1:0]}
//                                                                                          37 16'd8191
//                                                                                          38 wOAMOffset
//                                                                                          39 vmem_data_shl_4 = {4'b0,iMcuReadData,4'b0}
//                                                                                          40 wSC_Tile = scy_shl_5__plus_scx
//                                                                                          41  {8'b0,wSC_Tile_Row} ),      //scy_tile_row_offset

FFD_POSEDGE_SYNCRONOUS_RESET # ( 1 )FFX_Z(   iClock, iReset, wRegWe, (rResult == 8'b0) ? 1'b1 : 1'b0, wZ );// flag zero



assign wInitialPc = ( rJump ) ? wUop[7:0]: 8'b0;

UPCOUNTER_POSEDGE # (8) PC
(
  .Clock(   iClock                ),
  .Reset(   iReset | rJump        ),
  .Initial( wInitialPc            ),
  .Enable(  ~iReset & wGpuActive  ),//bit 7 LCDC  defines wGPUActive
  .Q(       wIp                   )
);


assign wGpuActive = (oLCDC[7]) ? 1'b1 : 1'b0;
assign wRegSelect = ( wGpuActive ) ? wUop[14:10] : iMcuRegSelect ;
assign wRegWe     = ( wGpuActive ) ? rRegWe : iMcuWe ;

//Generally speaking the tiles are addressed like this:
//             0                  1
//LCDC[6]  9800-9BFF        9C00-9FFF       Window tile map display
//LCDC[4]  8800-97FF        8000-8FFF       Background and window tile data
//LCDC[3]  9800-9BFF        9C00-9FFF       Background tile map display
//However, there is an additional detail, tile1 index can be greater than 127,
//while tile0 index can be negative
//This is done to share some tiles across the two otherwise separate regions
//Let's assume that the tile number is held in iMcuReadData
//if the tile number is greater than 128 (if the bit 7 is set)
//the use 8800-8FFF
//Like this:

//+-----------+------------------------------+
//| Region    |	Usage                        |
//+-----------+------------------------------+
//| 8000-87FF	| Tile set #1: tiles 0-127     |
//+-----------+------------------------------+
//| 8800-8FFF	| Tile set #1: tiles 128-255   |
//|           | Tile set #0: tiles -1 to -128|
//+-----------+------------------------------+
//| 9000-97FF	| Tile set #0: tiles 0-127     |
//+-----------+------------------------------+
//| 9800-9BFF	| Tile map #0                  |
//+-----------+------------------------------+
//| 9C00-9FFF	| Tile map #1                  |
//+-----------+------------------------------+


//Check if tile1 is greater than 127
assign wTile1_Bg_Offset = (iMcuReadData[7] == 1'b1) ? 16'h8000 : 16'h8000;
//Check if tile0 is negative. In case it is negative (ie. 0x80 or greater)
//the add 0x8000 such that 0x8000 + (0x80 << 8) = 0x8000 + 0x0800 = 0x8800
assign wTile0_Bg_Offset = (iMcuReadData[7] == 1'b1) ? 16'h8000 : 16'h9000;

assign wBGTileOffset    = ( oLCDC[4] ) ? wTile1_Bg_Offset : wTile0_Bg_Offset;
assign wBGTileMapOffset = ( oLCDC[3] ) ? 16'h9c00 : 16'h9800;
assign wWinTileMapOffset = ( oLCDC[5] ) ? 16'h9c00 : 16'h9800;
assign wBGRowOffset     = wCurrentTileRow;

assign wOAMOffset = 16'hFE00; //Sprite Attribute Table (OAM - Object Attribute Memory) at $FE00-FE9F.

assign wWinTileindex = ((oWY >> 3) << 5) + (oWX -3'd6) ;
assign wWinEnabled = (oLCDC[0]  &  oLCDC[5]);
assign wIsWininBG = ((wWinTile == wCurrentTile) && wWinEnabled == 1)? 1'b1: 1'b0;




`ifdef LCD_SCXY_DISABLED
  assign wSC_Tile = 16'b0;
`else
  //To know the current tile we divide by 8 (since each tile is 8x8 pixels)
  //then we multiply by 32, since each row has 32 tiles

//TODO cocatenate two zeros to right and discard to zeros to the left instead of shifting 2 to the left
  assign wSC_Tile = ((oSCY >> 3) << 5) + oSCX;
`endif
//defines initial current row
assign wSC_Tile_Row = 8'b0;//{4'b0,oSCY[2:0],1'b0};  //(SCY % 8) * 2


assign wMcuRegWriteSelect = (1 << iMcuRegSelect);
assign wGpuRegWriteSelect = (1 << wUop[`GPU_DST_RNG]);



assign wOp0 = (wUop[`GPU_S0_RNG_SEL_BIT] == 1'b1) ? wOp0_Pre_A : wOp0_Pre_B;

MUXFULLPARALELL_4SEL_GENERIC # (16) MUX_REG0_A
(
  .Sel( wUop[ `GPU_S0_RNG_L]     ),
  .I0( wBGTileMapOffset          ),
  .I1( wBGTileOffset             ),
  .I2( {8'h0,iMcuReadData}       ),
  .I3( wBGRowOffset              ),
  .I4( {8'h0,6'h0,oLY[1:0]}      ), //ly_mod_8
  .I5( 16'd8191                  ),
  .I6( wOAMOffset                ),
  .I7( {4'b0,iMcuReadData,4'b0}  ), //vmem_data_shl_4
  .I8( wSC_Tile                  ), //scy_shl_5__plus_scx
  .I9( {8'b0,wSC_Tile_Row}       ), //scy_tile_row_offset
  .I10( {15'b0,wIsWininBG}       ),
  .I11( wWinTileindex            ),
  .I12(wWinTileMapOffset         ),
  .I13( 16'b0    ),
  .I14( 16'h0                    ),
  .I15( 16'h0                    ),

  .O( wOp0_Pre_A )
);


MUXFULLPARALELL_5SEL_GENERIC # (16) MUX_REG0_B
(
  .Sel( wUop[ `GPU_S0_RNG_H ] ),

  .I0( {8'h0,oLCDC} ),
  .I1( {8'h0,oSTAT} ),
  .I2( {8'h0,oSCY}  ),
  .I3( {8'h0,oSCX}  ),
  .I4( {8'h0,oLY}   ),
  .I5( {8'h0,oLYC}  ),
  .I6( {8'h0,oDMA}  ),
  .I7( {8'h0,oBGP}  ),
  .I8( {8'h0,oOBP0} ),
  .I9( {8'h0,oOBP1} ),
  .I10({8'h0,oWY}   ),
  .I11({8'h0,oWX}   ),
  .I12( oMcuAddr            ),
  .I13( {8'b0,wBh}          ),
  .I14( {8'b0,wBl}          ),
  .I15( wFrameBufferAddress ),
  .I16( wCurrentTile        ),
  .I17( wSprite_tile_offset ),
  .I18( wSpriteCoordX       ),
  .I19( wSpriteCoordY       ),
  .I20( wCurrentTileRow     ),
  .I21( {8'b0,wSh}          ),
  .I22( {8'b0,wSl}          ),
  .I23( wR0 ),
  .I24( wR1 ),
  .I25( {8'b0,wR2} ),
  .I26( wR3 ),
  .I27( wR4 ),
  .I28( wR5 ),
  .I29( wR6 ),
  .I30( wWinTile ),
  .I31( wSprite_info  ),

  .O( wOp0_Pre_B )
);



//defines operator 1


assign wOp1 = (wOp1Sel[5] == 1'b1) ? wOp1_Pre_A : wOp1_Pre_B;

assign wOp1Sel = (wUop[`GPU_OP_RNG] == `gaddl || wUop[`GPU_OP_RNG] == `gsubl ) ? wUop[`GPU_DST_RNG] : wUop[`GPU_S1_RNG];

MUXFULLPARALELL_4SEL_GENERIC # (16) MUX_REG1_A
(
  .Sel( wOp1Sel[3:0]     ),
  .I0( wBGTileMapOffset          ),
  .I1( wBGTileOffset             ),
  .I2( {8'h0,iMcuReadData}       ),
  .I3( wBGRowOffset              ),
  .I4( {8'h0,6'h0,oLY[1:0]}      ), //ly_mod_8
  .I5( 16'd8191                  ),
  .I6( wOAMOffset                ),
  .I7( {4'b0,iMcuReadData,4'b0}  ), //vmem_data_shl_4
  .I8( wSC_Tile                  ), //scy_shl_5__plus_scx
  .I9( {8'b0,wSC_Tile_Row}       ), //scy_tile_row_offset
  .I10( {14'b0,wIsWininBG}       ),
  .I11( wWinTileindex            ),
  .I12( wWinTileMapOffset        ),
  .I13( 16'b0      ),
  .I14( 16'h0                    ),
  .I15( 16'h0                    ),

  .O( wOp1_Pre_A )
);


MUXFULLPARALELL_5SEL_GENERIC # (16) MUX_REG1_B
(
  .Sel( wOp1Sel[4:0] ),

  .I0( {8'h0,oLCDC} ),
  .I1( {8'h0,oSTAT} ),
  .I2( {8'h0,oSCY}  ),
  .I3( {8'h0,oSCX}  ),
  .I4( {8'h0,oLY}   ),
  .I5( {8'h0,oLYC}  ),
  .I6( {8'h0,oDMA}  ),
  .I7( {8'h0,oBGP}  ),
  .I8( {8'h0,oOBP0} ),
  .I9( {8'h0,oOBP1} ),
  .I10({8'h0,oWY}   ),
  .I11({8'h0,oWX}   ),
  .I12( oMcuAddr            ),
  .I13( {8'b0,wBh}          ),
  .I14( {8'b0,wBl}          ),
  .I15( wFrameBufferAddress ),
  .I16( wCurrentTile        ),
  .I17( wSprite_tile_offset ),
  .I18( wSpriteCoordX       ),
  .I19( wSpriteCoordY       ),
  .I20( wCurrentTileRow     ),
  .I21( {8'b0,wSh}          ),
  .I22( {8'b0,wSl}          ),
  .I23( wR0 ),
  .I24( wR1 ),
  .I25( {8'b0,wR2} ),
  .I26( wR3 ),
  .I27( wR4 ),
  .I28( wR5 ),
  .I29( wR6 ),
  .I30( wWinTile ),
  .I31( wSprite_info  ),

  .O( wOp1_Pre_B )
);



//Do palette background color conversion for 8 pixels in parallel
MUXFULLPARALELL_2SEL_GENERIC # (2) MUX_BGP0 (   .Sel( {wBh[0], wBl[0]} ),
  .I0( oBGP[1:0]), .I1( oBGP[3:2]), .I2( oBGP[5:4]), .I3( oBGP[7:6]) , .O( wBgPixel0)  );

MUXFULLPARALELL_2SEL_GENERIC # (2) MUX_BGP1 (   .Sel( {wBh[1], wBl[1]} ),
  .I0( oBGP[1:0]), .I1( oBGP[3:2]), .I2( oBGP[5:4]), .I3( oBGP[7:6]) , .O( wBgPixel1)  );

MUXFULLPARALELL_2SEL_GENERIC # (2) MUX_BGP2 (   .Sel( {wBh[2], wBl[2]} ),
  .I0( oBGP[1:0]), .I1( oBGP[3:2]), .I2( oBGP[5:4]), .I3( oBGP[7:6]) , .O( wBgPixel2)  );

MUXFULLPARALELL_2SEL_GENERIC # (2) MUX_BGP3 (   .Sel( {wBh[3], wBl[3]} ),
  .I0( oBGP[1:0]), .I1( oBGP[3:2]), .I2( oBGP[5:4]), .I3( oBGP[7:6]) , .O( wBgPixel3)  );

MUXFULLPARALELL_2SEL_GENERIC # (2) MUX_BGP4 (   .Sel( {wBh[4], wBl[4]} ),
  .I0( oBGP[1:0]), .I1( oBGP[3:2]), .I2( oBGP[5:4]), .I3( oBGP[7:6]) , .O( wBgPixel4)  );

MUXFULLPARALELL_2SEL_GENERIC # (2) MUX_BGP5 (   .Sel( {wBh[5], wBl[5]} ),
  .I0( oBGP[1:0]), .I1( oBGP[3:2]), .I2( oBGP[5:4]), .I3( oBGP[7:6]) , .O( wBgPixel5)  );

MUXFULLPARALELL_2SEL_GENERIC # (2) MUX_BGP6 (   .Sel( {wBh[6], wBl[6]} ),
  .I0( oBGP[1:0]), .I1( oBGP[3:2]), .I2( oBGP[5:4]), .I3( oBGP[7:6]) , .O( wBgPixel6)  );

MUXFULLPARALELL_2SEL_GENERIC # (2) MUX_BGP7 (   .Sel( {wBh[7], wBl[7]} ),
  .I0( oBGP[1:0]), .I1( oBGP[3:2]), .I2( oBGP[5:4]), .I3( oBGP[7:6]) , .O( wBgPixel7)  );

//PALLETTE 1, 2 for SPRITES

MUXFULLPARALELL_3SEL_GENERIC # (2) MUX_SprtP0 ( .Sel( {wSprite_info[4],wSh[0], wSl[0]} ),
  .I3( oOBP0[1:0]), .I2( oOBP0[3:2]), .I1( oOBP0[5:4]), .I0( oOBP0[7:6]) ,
  .I4( oOBP1[1:0]), .I5( oOBP1[3:2]), .I6( oOBP1[5:4]), .I7( oOBP1[7:6]),
  .O( wSprtPixel0));

MUXFULLPARALELL_3SEL_GENERIC # (2) MUX_SprtP1 (.Sel( {wSprite_info[4],wSh[1], wSl[1]} ),
  .I3( oOBP0[1:0]), .I2( oOBP0[3:2]), .I1( oOBP0[5:4]), .I0( oOBP0[7:6]) ,
  .I4( oOBP1[1:0]), .I5( oOBP1[3:2]), .I6( oOBP1[5:4]), .I7( oOBP1[7:6]),
  .O( wSprtPixel1));

MUXFULLPARALELL_3SEL_GENERIC # (2) MUX_SprtP2 (.Sel( {wSprite_info[4],wSh[2], wSl[2]} ),
  .I3( oOBP0[1:0]), .I2( oOBP0[3:2]), .I1( oOBP0[5:4]), .I0( oOBP0[7:6]) ,
  .I4( oOBP1[1:0]), .I5( oOBP1[3:2]), .I6( oOBP1[5:4]), .I7( oOBP1[7:6]),
  .O( wSprtPixel2));

MUXFULLPARALELL_3SEL_GENERIC # (2) MUX_SprtP3 (.Sel( {wSprite_info[4],wSh[3], wSl[3]} ),

  .I3( oOBP0[1:0]), .I2( oOBP0[3:2]), .I1( oOBP0[5:4]),.I0( oOBP0[7:6]) ,
  .I4( oOBP1[1:0]), .I5( oOBP1[3:2]), .I6( oOBP1[5:4]), .I7( oOBP1[7:6]),

  .O( wSprtPixel3));

MUXFULLPARALELL_3SEL_GENERIC # (2) MUX_SprtP4 ( .Sel( {wSprite_info[4],wSh[4], wSl[4]} ),

  .I3( oOBP0[1:0]), .I2( oOBP0[3:2]), .I1( oOBP0[5:4]), .I0( oOBP0[7:6]) ,
  .I4( oOBP1[1:0]), .I5( oOBP1[3:2]), .I6( oOBP1[5:4]), .I7( oOBP1[7:6]),
  .O( wSprtPixel4));

MUXFULLPARALELL_3SEL_GENERIC # (2) MUX_SprtP5 (.Sel( {wSprite_info[4],wSh[5], wSl[5]} ),
  .I3( oOBP0[1:0]), .I2( oOBP0[3:2]), .I1( oOBP0[5:4]), .I0( oOBP0[7:6]) ,
  .I4( oOBP1[1:0]), .I5( oOBP1[3:2]), .I6( oOBP1[5:4]), .I7( oOBP1[7:6]),
  .O( wSprtPixel5));

MUXFULLPARALELL_3SEL_GENERIC # (2) MUX_SprtP6 (.Sel( {wSprite_info[4],wSh[6], wSl[6]} ),
  .I3( oOBP0[1:0]), .I2( oOBP0[3:2]), .I1( oOBP0[5:4]), .I0( oOBP0[7:6]) ,
  .I4( oOBP1[1:0]), .I5( oOBP1[3:2]), .I6( oOBP1[5:4]), .I7( oOBP1[7:6]),
  .O( wSprtPixel6));

MUXFULLPARALELL_3SEL_GENERIC # (2) MUX_SprtP7 (.Sel( {wSprite_info[4],wSh[7], wSl[7]} ),
  .I3( oOBP0[1:0]), .I2( oOBP0[3:2]), .I1( oOBP0[5:4]), .I0( oOBP0[7:6]) ,
  .I4( oOBP1[1:0]), .I5( oOBP1[3:2]), .I6( oOBP1[5:4]), .I7( oOBP1[7:6]),
  .O( wSprtPixel7));


always @ ( * )
begin
  case (wUop[`GPU_OP_RNG])
   `gnop:
    begin
      rResult     = wUop[7:0];
      rRegWe      = 1'b0;
      rBgBufferWe = 1'b0;
      rJump       = 1'b0;
      oMcuReadRequest = 1'b0;
      rIncFBufferAddr = 1'b0;
    end

    `gwfbuffer: //Writes color of current pixels to a 8pixel row buffer
    begin
      rResult     = wUop[7:0];
      rRegWe      = 1'b0;
      rBgBufferWe = 1'b1;
      rJump       = 1'b0;
      oMcuReadRequest = 1'b0;
      rIncFBufferAddr = 1'b0;
    end

    `ginfbaddr:
    begin
      rResult     = wUop[7:0];
      rRegWe      = 1'b0;
      rBgBufferWe = 1'b0;
      rJump       = 1'b0;
      oMcuReadRequest = 1'b0;
      rIncFBufferAddr = 1'b1;
    end

    `gwrr:// moves one value to another GPU register
    begin
      rResult     = wOp1;
      rRegWe      = 1'b1;
      rBgBufferWe = 1'b0;
      rJump       = 1'b0;
      oMcuReadRequest = 1'b0;
      rIncFBufferAddr = 1'b0;
    end

    `gwrl:// writes a literal to a GPU register
    begin
      rResult     = wUop[`GPU_LIT_RNG];
      rRegWe      = 1'b1;
      rBgBufferWe = 1'b0;
      rJump       = 1'b0;
      oMcuReadRequest = 1'b0;
      rIncFBufferAddr = 1'b0;
    end

    `grvmem://reads from VMEM data gets stored in a register by default
    begin
      rResult     = wUop[7:0];
      rRegWe      = 1'b0;
      rBgBufferWe = 1'b0;
      rJump       = 1'b0;
      oMcuReadRequest = 1'b1;
      rIncFBufferAddr = 1'b0;
    end

    `gadd:// adds two registers
    begin
      rResult     = wOp1 + wOp0 ;
      rRegWe      = 1'b1;
      rBgBufferWe = 1'b0;
      rJump       = 1'b0;
      oMcuReadRequest = 1'b0;
      rIncFBufferAddr = 1'b0;
    end


    `gshl://shift left
    begin
      rResult     = wOp1 << wUop[5:0]  ;
      rRegWe      = 1'b1;
      rBgBufferWe = 1'b0;
      rJump       = 1'b0;
      oMcuReadRequest = 1'b0;
      rIncFBufferAddr = 1'b0;
    end

    `gaddl://adds a literal to a register
    begin
      rResult     = wOp1 + {6'b0,wUop[`GPU_LIT_RNG]} ;
      rRegWe      = 1'b1;
      rBgBufferWe = 1'b0;
      rJump       = 1'b0;
      oMcuReadRequest = 1'b0;
      rIncFBufferAddr = 1'b0;
    end

    `gsubl://subs a literal to a register
    begin
      rResult     = wOp1 - {6'b0,wUop[`GPU_LIT_RNG]} ;
      rRegWe      = 1'b1;
      rBgBufferWe = 1'b0;
      rJump       = 1'b0;
      oMcuReadRequest = 1'b0;
      rIncFBufferAddr = 1'b0;
    end


    `gsub://subs two registers
    begin
      rResult     = wOp1 - wOp0;
      rRegWe      = 1'b1;
      rBgBufferWe = 1'b0;
      rJump       = 1'b0;
      oMcuReadRequest = 1'b0;
      rIncFBufferAddr = 1'b0;
    end

    `gjnz://jump if not zero
    begin
      rResult     = wOp1 ;
      rRegWe      = 1'b0;
      rBgBufferWe = 1'b0;
      rJump       = ~wZ;
      oMcuReadRequest = 1'b0;
      rIncFBufferAddr = 1'b0;
    end

    `gjz://jump if zero
    begin
      rResult     = wOp1 ;
      rRegWe      = 1'b0;
      rBgBufferWe = 1'b0;
      rJump       = wZ;
      oMcuReadRequest = 1'b0;
      rIncFBufferAddr = 1'b0;
    end

    `ggoto://jump to address
    begin
      rResult     = wOp1 ;
      rRegWe      = 1'b0;
      rBgBufferWe = 1'b0;
      rJump       = 1'b1;
      oMcuReadRequest = 1'b0;
      rIncFBufferAddr = 1'b0;
    end

  `gand://bitwise and for two registers
    begin
      rResult     = wOp1 & wOp0 ;
      rRegWe      = 1'b1;
      rBgBufferWe = 1'b0;
      rJump       = 1'b0;
      oMcuReadRequest = 1'b0;
      rIncFBufferAddr = 1'b0;
    end

    `gsprtt:
    begin
      rResult     = {15'b0,wIsSpriteInCurrentTile};
      rRegWe      = 1'b1;
      rBgBufferWe = 1'b0;
      rJump       = 1'b0;
      oMcuReadRequest = 1'b0;
      rIncFBufferAddr = 1'b0;
    end

   `gwx:
    begin
      rResult     = {15'b0,wIsWyOnScreen};
      rRegWe      = 1'b1;
      rBgBufferWe = 1'b0;
      rJump       = 1'b0;
      oMcuReadRequest = 1'b0;
      rIncFBufferAddr = 1'b0;
    end

    `gwy:
     begin
       rResult     = {15'b0,wIsWyOnScreen};
       rRegWe      = 1'b1;
       rBgBufferWe = 1'b0;
       rJump       = 1'b0;
       oMcuReadRequest = 1'b0;
       rIncFBufferAddr = 1'b0;
     end

    default://default case for error
    begin
      rResult     = 16'hdead ;
      rRegWe      = 1'b0;
      rBgBufferWe = 1'b0;
      rJump       = 1'b0;
      oMcuReadRequest = 1'b0;
      rIncFBufferAddr = 1'b0;
    end

  endcase
end

gpu_ucode_rom UCODE_ROM
(
  .iAddr( wIp ),
  .oUop(  wUop)
);

endmodule
