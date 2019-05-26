
`timescale 1ns / 1ps
`include "collaterals.v"
`include "z80_opcode_definitions.v"
`include "aDefinitions.v"
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

module dzcpu
(
  input wire         iClock,
  input wire         iReset,
  input wire [7:0]   iMCUData,
  output wire [7:0]  oMCUData,
  output wire [15:0] oMCUAddr,
  output wire         oMcuReadRequest,
  input wire  [3:0]  iInterruptRequests,
  output reg         oMCUwe,
  output wire [7:0]  oCurrentZ80Insn,
  output wire        oEof,
  output wire        oInterruptJump,
  output wire        oBranchTaken,
  input wire [5:0]   iJoypad

);
wire[15:0]  wPc, wRegData, wUopSrc, wX16, wY16, wZ16, wInitialPc, wInterruptVectorAddress, wXY16 ;
wire [7:0]  wBitMask, wX8, wY8;
wire [9:0]  wuOpBasicFlowIdx,wuOpExtendedFlowIdx, wuOpFlowIdx, wuPc, wNextFlow;
wire        wIPC,wEof, wZ, wN;
wire [14:0] wUop;
wire [4:0 ] wuCmd;
wire [4:0]  wMcuAdrrSel;
wire [2:0]  wUopRegReadAddr0, wUopRegReadAddr1, rUopRegWriteAddr;
wire [7:0]  wB,wC,wD, wE, wH,wL,wA, wSpL, wSpH, wFlags, wUopSrcRegData0;
wire [7:0]  wSHR_RegData, wUopSrcRegData1, wNextUopFlowIdx;
wire [3:0]  wInterruptRequestBitMap, wInterruptRequestBitMaps_pre;
wire        wInterruptsEnabled, wTimerTick;
reg         rSetiWe,rSetiVal; // set FF_INTENABLE
reg         rClearIntLatch; // clean FF_INTSIGNAL
reg         rLatchInsn;
reg         rResetFlow,rFlowEnable, rRegWe, rSetMCOAddr, rOverWritePc, rCarry, rMcuReadRequest;
reg [4:0]   rRegSelect;
reg [7:0]   rZ80Result, rWriteSelect;
reg [15:0]  rUopDstRegData;
reg         rHalt;  //Flag to stop microflow
wire        wStopCondition;
//wire        wContFlow; //Flag to continue microflow //remplaced this line because halt = stop

assign oInterruptJump = wInterruptRoutineJumpDetected;
assign oBranchTaken = rOverWritePc | wInterruptRoutineJumpDetected;
assign wUopSrc = wUop[4:0];
assign wIPC    = wUop[13];    //Increment Macro Insn program counter
assign wuCmd   = wUop[9:5];
assign oEof    = wEof & rFlowEnable & ~wInterruptRoutineJumpDetected;
assign wStopCondition = (rHalt == 1'b0 && iJoypad == 6'b111111 && |iInterruptRequests == 1'b0)? 1'b0 : 1'b1;
//assign wContFlow = rHalt | |iInterruptRequests;  //remplaced this line because halt = stop

MUXFULLPARALELL_3SEL_GENERIC # ( 1'b1 ) MUX_EOF
 (
 .Sel( wUop[12:10] ),
 .I0( 1'b0 ),             //op
 .I1( 1'b1 ),             //eof
 .I2( wFlags[`flag_c] ),  //eof_c
 .I3( ~wFlags[`flag_c] ), //eof_nc
 .I4( wFlags[`flag_z] ),  //eof_z
 .I5( ~wFlags[`flag_z] ), //eof_nz
 .I6( 1'b0 ),             //Reserved
 .I7( 1'b0 ),             //Reserved
 .O( wEof )
 );

dzcpu_ucode_rom urom
(
  .iAddr( wuPc ),
  .oUop( wUop  )
);

dzcpu_ucode_lut ulut
(
  .iMop( iMCUData ),
  .oUopFlowIdx( wuOpBasicFlowIdx )
);

dzcpu_ucode_cblut ucblut
(
  .iMop( iMCUData ),
  .oUopFlowIdx( wuOpExtendedFlowIdx )
);

wire wJcbDetected, wInterruptRoutineJumpDetected;

//If at leaast 1 bit from iInterruptRequests is set and interrupts are enable,
//then we have an interrupt
assign wInterruptRoutineJumpDetected = |iInterruptRequests & wInterruptsEnabled;
assign wJcbDetected    = ( rFlowEnable & wuCmd == `jcb ) ? 1'b1 : 1'b0;


//Hold the int signal while we wait for current flow to finish
FFD_POSEDGE_SYNCRONOUS_RESET # ( 4 )FF_INTSIGNAL( iClock, iReset | rClearIntLatch, 1'b1 , iInterruptRequests, wInterruptRequestBitMaps_pre );

FFD_POSEDGE_SYNCRONOUS_RESET # ( 1 )FF_INTENABLE( iClock, iReset, rFlowEnable & rSetiWe, rSetiVal, wInterruptsEnabled );

FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 )FF_Z80_INSN( iClock, iReset, rLatchInsn, iMCUData, oCurrentZ80Insn );

FFD_POSEDGE_SYNCRONOUS_RESET # ( 1 )FF_TIMER_TICK( iClock, iReset, 1'b1, rLatchInsn, wTimerTick );

//Disregard interrupts if interrupts are disabled
assign wInterruptRequestBitMap = ( wInterruptsEnabled  == 1'b1) ? wInterruptRequestBitMaps_pre : 4'b0;




UPCOUNTER_POSEDGE # (10) UPC
(
  .Clock(   iClock                             ),
  .Reset(   iReset | rResetFlow | wJcbDetected ),
  .Initial( wNextFlow                          ),
  .Enable(  rFlowEnable /*& wContFlow */& wStopCondition ),
  .Q(       wuPc                               )
);


assign wNextFlow = (iReset) ? 10'b0 : wuOpFlowIdx;

MUXFULLPARALELL_2SEL_GENERIC # (10) MUX_NEXT_FLOW
(
  .Sel({wInterruptRoutineJumpDetected,wJcbDetected}),
  .I0( wuOpBasicFlowIdx     ),
  .I1( wuOpExtendedFlowIdx  ),
  .I2( `FLOW_ID_INTERRUPT   ),
  .I3( `FLOW_ID_INTERRUPT   ),
  .O( wuOpFlowIdx )
);


MUXFULLPARALELL_4SEL_GENERIC # (16) MUX_INTERRUPT
(
       .Sel( wInterruptRequestBitMap ),
       .I0(  wPc             ),                //0000 No interrupts, use the normal flow
       .I1(  `INT_ADDR_VBLANK ),               //0001 -- Interrupt routine 0x40
       .I2(  `INT_ADDR_LCD_STATUS_TRIGGER),    //0010
       .I3(  `INT_ADDR_VBLANK ),               //0011 -- Interrupt routine 0x40
       .I4(  `INT_ADDR_TIMER_OVERFLOW),        //0100
       .I5(  `INT_ADDR_VBLANK),                //0101
       .I6(  `INT_ADDR_TIMER_OVERFLOW),        //0110
       .I7(  `INT_ADDR_VBLANK        ),        //0111
       .I8( `INT_ADDR_VBLANK_JOYPAD_PRESS),    //1000
       .I9( `INT_ADDR_VBLANK_JOYPAD_PRESS),    //1001
       .I10( `INT_ADDR_VBLANK_JOYPAD_PRESS),   //1010
       .I11( `INT_ADDR_VBLANK_JOYPAD_PRESS),   //1011
       .I12( `INT_ADDR_VBLANK_JOYPAD_PRESS),   //1100
       .I13( `INT_ADDR_VBLANK_JOYPAD_PRESS),   //1101
       .I14( `INT_ADDR_VBLANK_JOYPAD_PRESS),   //1110
       .I15( `INT_ADDR_VBLANK_JOYPAD_PRESS),   //1111

       .O( wInterruptVectorAddress )
);



`ifdef SKIP_BIOS
  assign wInitialPc = ( rOverWritePc ) ? rUopDstRegData : 16'h100;
`else
  assign wInitialPc = ( rOverWritePc ) ? rUopDstRegData : 16'b0;
`endif


UPCOUNTER_POSEDGE # (16) PC
(
  .Clock(   iClock                ),
  .Reset(   iReset | (rOverWritePc & rFlowEnable)),
  .Initial( wInitialPc            ),
  `ifdef DISABLE_CPU
          .Enable(  1'b0    ),
    `else
        .Enable(  wIPC & rFlowEnable    ),
  `endif
  .Q(       wPc                   )
);

//--------------------------------------------------------
// Current State Logic //
reg [7:0]    rCurrentState,rNextState;

always @(posedge iClock )
begin
     if( iReset!=1 )
        rCurrentState <= rNextState;
   else
    rCurrentState <= `DZCPU_AFTER_RESET;
end
//--------------------------------------------------------

always @( * )
 begin
  case (rCurrentState)
  //----------------------------------------
  `DZCPU_AFTER_RESET:
  begin
    rResetFlow = 1'b0;
    rFlowEnable = 1'b0;
    rLatchInsn  = 1'b0;

    rNextState = `DZCPU_START_FLOW;
  end
  //----------------------------------------
  `DZCPU_START_FLOW:
  begin
     rResetFlow  = 1'b1;
     rFlowEnable = 1'b0;
     rLatchInsn  = 1'b1;

     if (iReset)
       rNextState = `DZCPU_AFTER_RESET;
     else
       rNextState = `DZCPU_RUN_FLOW;
  end
  //----------------------------------------
  `DZCPU_RUN_FLOW:
  begin
    rResetFlow = 1'b0;
    rFlowEnable = 1'b1;
    rLatchInsn  = 1'b0;

    if (wEof)
      rNextState = `DZCPU_END_FLOW;
    else
      rNextState = `DZCPU_RUN_FLOW;
  end
  //----------------------------------------
  `DZCPU_END_FLOW:
  begin
    rResetFlow = 1'b0;
    rFlowEnable = 1'b0;
    rLatchInsn  = 1'b0;

    rNextState = `DZCPU_START_FLOW;
  end
  //----------------------------------------
  default:
  begin
    rResetFlow = 1'b0;
    rFlowEnable = 1'b0;
    rLatchInsn  = 1'b0;

    rNextState = `DZCPU_AFTER_RESET;
  end
endcase
end

reg [13:0] rRegWriteSelect;


FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 ) FFB (   iClock, iReset, rFlowEnable & rRegWe & rRegWriteSelect[0],  (( rRegWriteSelect[1] &  rRegWriteSelect[0])? rUopDstRegData[15:8] : rUopDstRegData[7:0]), wB );
FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 ) FFC (   iClock, iReset, rFlowEnable & rRegWe & rRegWriteSelect[1],  rUopDstRegData[7:0], wC );
FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 ) FFD (   iClock, iReset, rFlowEnable & rRegWe & rRegWriteSelect[2],  (( rRegWriteSelect[2] &  rRegWriteSelect[3])? rUopDstRegData[15:8] : rUopDstRegData[7:0]), wD );
FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 ) FFE (   iClock, iReset, rFlowEnable & rRegWe & rRegWriteSelect[3],  rUopDstRegData[7:0], wE );
FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 ) FFH (   iClock, iReset, rFlowEnable & rRegWe & rRegWriteSelect[4],  (( rRegWriteSelect[4] &  rRegWriteSelect[5])? rUopDstRegData[15:8] : rUopDstRegData[7:0]), wH );
FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 ) FFL (   iClock, iReset, rFlowEnable & rRegWe & rRegWriteSelect[5],  rUopDstRegData[7:0], wL );
FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 ) FFA (   iClock, iReset, rFlowEnable & rRegWe & rRegWriteSelect[6],  rUopDstRegData[7:0], wA );
FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 )FFSPL(   iClock, iReset, rFlowEnable & rRegWe & rRegWriteSelect[7],  rUopDstRegData[7:0], wSpL );
FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 )FFSPH(   iClock, iReset, rFlowEnable & rRegWe & rRegWriteSelect[8],  (( rRegWriteSelect[7] &  rRegWriteSelect[8])? rUopDstRegData[15:8] : rUopDstRegData[7:0]), wSpH );
FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 )FFX8 (   iClock, iReset, rFlowEnable & rRegWe & rRegWriteSelect[9],  rUopDstRegData[7:0], wX8 );
FFD_POSEDGE_SYNCRONOUS_RESET # ( 16)FFX16 (  iClock, iReset, rFlowEnable & rRegWe & rRegWriteSelect[10], rUopDstRegData[15:0], wX16 );
FFD_POSEDGE_SYNCRONOUS_RESET # ( 16)FFY16 (  iClock, iReset, rFlowEnable & rRegWe & rRegWriteSelect[11], rUopDstRegData[15:0], wY8 );
FFD_POSEDGE_SYNCRONOUS_RESET # ( 16)FFZ16 (  iClock, iReset, rFlowEnable & rRegWe & rRegWriteSelect[12], rUopDstRegData[15:0], wZ16 );

//wire[15:0] wUopDstRegData_Prev;
//FFD_POSEDGE_SYNCRONOUS_RESET # ( 16)FF_RESULT_PREV (  iClock, iReset, 1'b1, rUopDstRegData, wUopDstRegData_Prev);

reg [1:0] rFlagsZ, rFlagsN, rFlagsH, rFlagsC;
wire wFlagsWe;
wire wCarry, wCarry12, wHalfCarry_Inc, wHalfCarry_Add, wHalfCarry_Sub, wHalfCarry_Dec, wCpnHalf, wHalfCarry_AddC;
wire [7:0] wFlagsUpdate;
reg rCarry16, rCarry8;

wire [3:0] wNibble_Add, wNibble_Sub;

assign wHalfCarry_Inc = ((rUopDstRegData[3:0] ) == 4'h0) ? 1'b1 : 1'b0;
assign wHalfCarry_Dec = ((rUopDstRegData[3:0] ) == 4'hf) ? 1'b1 : 1'b0;

assign {wHalfCarry_AddC, wNibble_Add} = wRegData[3:0] + wX16[3:0] + wFlags[`flag_c];
assign {wHalfCarry_Add, wNibble_Add} = wRegData[3:0] + wX16[3:0];
assign {wHalfCarry_Sub, wNibble_Sub} = wX16[3:0] - wRegData[3:0];

assign wCpnHalf = (rUopDstRegData[3:0] > wA[3:0]) ? 1'b1 : 1'b0;

//assign wHalfCarry = wUopDstRegData_Prev[4];  //Need value from prev CC
assign wCarry     = rUopDstRegData[8];
//assign wCarry16   = rUopDstRegData[15];
assign wCarry12   = rUopDstRegData[12];


assign wFlagsWe = rFlowEnable & (wUop[ `uop_flags_update_enable ] == 1'b1 || wuCmd == `z801bop )
  & ( rFlagsZ[1]  | rFlagsN[1] | rFlagsH[1] | rFlagsC[1] );

assign wFlagsUpdate[`flag_z ] = ( rFlagsZ[1] == 1'b1 ) ? rFlagsZ[0] : wFlags[`flag_z ] ;
assign wFlagsUpdate[`flag_h ] = ( rFlagsH[1] == 1'b1 ) ? rFlagsH[0] : wFlags[`flag_h ] ;
assign wFlagsUpdate[`flag_n ] = ( rFlagsN[1] == 1'b1 ) ? rFlagsN[0] : wFlags[`flag_n ] ;
assign wFlagsUpdate[`flag_c ] = ( rFlagsC[1] == 1'b1 ) ? rFlagsC[0] : wFlags[`flag_c ] ;
assign wFlagsUpdate[3:0] = 4'b0;

wire [7:0] wNewFlags;
wire       wOverWriteFlagswithRegister;
assign wOverWriteFlagswithRegister = (rFlowEnable & rRegWe & rRegWriteSelect[13]) ? 1'b1 : 1'b0;
assign wNewFlags = ( wOverWriteFlagswithRegister ) ? rUopDstRegData : wFlagsUpdate;

FFD_POSEDGE_SYNCRONOUS_RESET_INIT # ( 8 )FFFLAGS( iClock, iReset, wFlagsWe | wOverWriteFlagswithRegister , 8'hb0,wNewFlags, wFlags );
FFD_POSEDGE_SYNCRONOUS_RESET_INIT # ( 5 )FFMCUADR( iClock, iReset, rFlowEnable & rSetMCOAddr, `pc , wUop[4:0], wMcuAdrrSel );
FFD_POSEDGE_SYNCRONOUS_RESET # ( 1 )FF_RREQ( iClock, iReset, rFlowEnable & ~oMCUwe, rMcuReadRequest, oMcuReadRequest );



MUXFULLPARALELL_5SEL_GENERIC # (16) MUX_MCUADR
(
  .Sel( wMcuAdrrSel),
  .I0({8'b0,wB}),           .I1({8'b0,wC}),           .I2({8'b0,wD}),    .I3({8'b0,wE}),
  .I4({8'b0,wH}),           .I5({8'b0,wL}),           .I6({wH,wL}),      .I7({8'b0,wA}),
  .I8(wPc),                 .I9({8'b0,wPc[15:8]}),    .I10({wSpH,wSpL}), .I11({8'b0,wFlags})  ,
  .I12({8'b0,wSpL}),        .I13( {8'b0,wSpH} ),      .I14( wY16 ),      .I15( wZ16 ),
  .I16({8'b0,wX8 }),        .I17( wX16),              .I18({8'hff,wC}),  .I19({wD,wE}),
  .I20({8'b0,wFlags }),         .I21({wB,wC}),            .I22({wA,wFlags}),     .I23(16'b0),
  .I24(16'b0), .I25({8'b0,wY8} ), .I26({wX8,wY8 }), .I27(16'hff0f),
  .I28(16'b0), .I29(16'b0), .I30(16'b0), .I31(16'b0),
  .O( oMCUAddr )
);

MUXFULLPARALELL_5SEL_GENERIC # (16) MUX_REGDATA
(
  .Sel( rRegSelect),
  .I0({8'b0,wB}),           .I1({8'b0,wC}),           .I2({8'b0,wD}),    .I3({8'b0,wE}),
  .I4({8'b0,wH}),           .I5({8'b0,wL}),           .I6({wH,wL}),      .I7({8'b0,wA}),
  .I8(wPc),                 .I9({8'b0,wPc[15:8]}),    .I10({wSpH,wSpL}), .I11({8'b0,wFlags})  ,
  .I12({8'b0,wSpL}),        .I13( {8'b0,wSpH} ),      .I14( wY16 ),      .I15( wZ16 ),
  .I16({8'b0,wX8 }),        .I17( wX16),              .I18({8'hff,wC}),  .I19({wD,wE}),
  .I20({8'b0,wFlags }),         .I21({wB,wC}),            .I22({wA,wFlags}),     .I23({8'b0,iMCUData}),
  .I24({15'b0,wFlags[`flag_c]}), .I25( {8'b0,wY8 } ), .I26( {wX8,wY8 }), .I27(16'b0),
  .I28(16'b0), .I29(16'b0), .I30(16'b0), .I31(16'b0),
  .O( wRegData )
);

MUXFULLPARALELL_5SEL_GENERIC # (8) MUX_MCUDATA_OUT
(
  .Sel( rRegSelect),
  .I0(wB),           .I1(wC),           .I2(wD),                .I3(wE),
  .I4(wH),           .I5(wL),           .I6(wL),                .I7(wA),
  .I8(wPc[7:0]),     .I9(wPc[15:8]),    .I10(wSpL),             .I11(wFlags)  ,
  .I12(wSpL),        .I13( wSpH ),      .I14( wY16[7:0] ),      .I15( wZ16[7:0] ),
  .I16(wX8 ),        .I17( wX16[7:0]),  .I18(wC),               .I19(wE),
  .I20(wFlags ),         .I21(wC),          .I22(wFlags),     .I23(8'b0),
  .I24({7'b0,wFlags[`flag_c]}), .I25( wY8  ), .I26( wX8 ), .I27(8'b0),
  .I28(8'b0), .I29(8'b0), .I30(8'b0), .I31(8'b0),
  .O( oMCUData )
);


always @ ( * )
begin
  case (rWriteSelect)
    `b:    rRegWriteSelect = 14'b00000000000001;
    `c:    rRegWriteSelect = 14'b00000000000010;
    `bc:   rRegWriteSelect = 14'b00000000000011;
    `d:    rRegWriteSelect = 14'b00000000000100;
    `e:    rRegWriteSelect = 14'b00000000001000;
    `de:   rRegWriteSelect = 14'b00000000001100;
    `h:    rRegWriteSelect = 14'b00000000010000;
    `l:    rRegWriteSelect = 14'b00000000100000;
    `hl:   rRegWriteSelect = 14'b00000000110000;
    `a:    rRegWriteSelect = 14'b00000001000000;
    `spl:  rRegWriteSelect = 14'b00000010000000;
    `sph:  rRegWriteSelect = 14'b00000100000000;
    `sp:   rRegWriteSelect = 14'b00000110000000;
    `x8:   rRegWriteSelect = 14'b00001000000000;
    `x16:  rRegWriteSelect = 14'b00010000000000;
    `y8:   rRegWriteSelect = 14'b00100000000000;
    `xy16: rRegWriteSelect = 14'b01000000000000;
    `f:    rRegWriteSelect = 14'b10000000000000;

    default: rRegWriteSelect = 13'b0;
  endcase
end

assign wZ = (rUopDstRegData[7:0] ==8'b0) ? 1'b1 : 1'b0;
assign wN = (rUopDstRegData[15] == 1'b1) ? 1'b1 : 1'b0;
assign wSHR_RegData = wRegData >> 1;

always @ ( * )
begin
  case (wuCmd)
    `nop:
    begin
      oMCUwe              = 1'b0;
      rRegSelect          = `null;
      rSetMCOAddr         = 1'b0;
      rRegWe              = 1'b0;
      rWriteSelect        = wUopSrc[7:0];
      {rCarry16,rUopDstRegData}      = 16'b0;
      rOverWritePc        = 1'b0;
      rMcuReadRequest     = 1'b0;
      rSetiWe             = 1'b0;
      rSetiVal            = 1'b0;
      rClearIntLatch      = 1'b0;
      rHalt               = 1'b1;
    end

    `sma:
    begin
      oMCUwe              = 1'b0;
      rRegSelect          = wUop[4:0];
      rSetMCOAddr         = 1'b1;
      rRegWe              = 1'b0;
      rWriteSelect        = wUopSrc[7:0];
      {rCarry16,rUopDstRegData}      = 16'b0;
      rOverWritePc        = 1'b0;
      rMcuReadRequest     = 1'b1;
      rSetiWe             = 1'b0;
      rSetiVal            = 1'b0;
      rClearIntLatch      = 1'b0;
      rHalt               = 1'b1;
    end

    `srm:
    begin
      oMCUwe              = 1'b0;
      rRegSelect          = `null;
      rSetMCOAddr         = 1'b0;
      rRegWe              = 1'b1;
      rWriteSelect        = wUopSrc[7:0];
      {rCarry16,rUopDstRegData}      = iMCUData;
      rOverWritePc        = 1'b0;
      rMcuReadRequest     = 1'b0;
      rSetiWe             = 1'b0;
      rSetiVal            = 1'b0;
      rClearIntLatch      = 1'b0;
      rHalt               = 1'b1;
    end

    `smw:
    begin
      oMCUwe              = 1'b1;
      rRegSelect          = wUop[4:0];
      rSetMCOAddr         = 1'b0;
      rRegWe              = 1'b0;
      rWriteSelect        = wUopSrc[7:0];
      {rCarry16,rUopDstRegData}      = 16'b0;
      rOverWritePc        = 1'b0;
      rMcuReadRequest     = 1'b0;
      rSetiWe             = 1'b0;
      rSetiVal            = 1'b0;
      rClearIntLatch      = 1'b0;
      rHalt               = 1'b1;
    end

    `dec16:
    begin
      oMCUwe              = 1'b0;
      rRegSelect          = wUop[4:0];
      rSetMCOAddr         = 1'b0;
      rRegWe              = 1'b1;
      rWriteSelect        = wUopSrc[7:0];
      {rCarry16,rUopDstRegData}      = wRegData - 16'd1;
      rOverWritePc        = 1'b0;
      rMcuReadRequest     = 1'b0;
      rSetiWe             = 1'b0;
      rSetiVal            = 1'b0;
      rClearIntLatch      = 1'b0;
      rHalt               = 1'b1;
    end

    `inc16:
    begin
      oMCUwe              = 1'b0;
      rRegSelect          = wUop[4:0];
      rSetMCOAddr         = 1'b0;
      rRegWe              = 1'b1;
      rWriteSelect        = wUopSrc[7:0];
      {rCarry16,rUopDstRegData}      = wRegData  + 1'b1;
      rOverWritePc        = 1'b0;
      rMcuReadRequest     = 1'b0;
      rSetiWe             = 1'b0;
      rSetiVal            = 1'b0;
      rClearIntLatch      = 1'b0;
      rHalt               = 1'b1;
    end

    `xorx16:
    begin
      oMCUwe              = 1'b0;
      rRegSelect          = wUop[4:0];
      rSetMCOAddr         = 1'b0;
      rRegWe              = 1'b1;
      rWriteSelect        = `x16;
      {rCarry16,rUopDstRegData}      = wX16 ^ {8'b0,wRegData[7:0]};
      rOverWritePc        = 1'b0;
      rMcuReadRequest     = 1'b0;
      rSetiWe             = 1'b0;
      rSetiVal            = 1'b0;
      rClearIntLatch      = 1'b0;
      rHalt               = 1'b1;
    end

    `subx16:
    begin
      oMCUwe              = 1'b0;
      rRegSelect          = wUop[4:0];
      rSetMCOAddr         = 1'b0;
      rRegWe              = 1'b1;
      rWriteSelect        = `x16;
      {rCarry16,rUopDstRegData}      = wX16 - {8'b0,wRegData[7:0]};
      rOverWritePc        = 1'b0;
      rMcuReadRequest     = 1'b0;
      rSetiWe             = 1'b0;
      rSetiVal            = 1'b0;
      rClearIntLatch      = 1'b0;
      rHalt               = 1'b1;
    end

    `xora:
    begin
      oMCUwe              = 1'b0;
      rRegSelect          = wUop[4:0];
      rSetMCOAddr         = 1'b0;
      rRegWe              = 1'b1;
      rWriteSelect        = `a;
      {rCarry16,rUopDstRegData}      = {8'b0,wA} ^ {8'b0,wRegData[7:0]};
      rOverWritePc        = 1'b0;
      rMcuReadRequest     = 1'b0;
      rSetiWe             = 1'b0;
      rSetiVal            = 1'b0;
      rClearIntLatch      = 1'b0;
      rHalt               = 1'b1;
    end

    `ora:
    begin
      oMCUwe              = 1'b0;
      rRegSelect          = wUop[4:0];
      rSetMCOAddr         = 1'b0;
      rRegWe              = 1'b1;
      rWriteSelect        = `a;
      {rCarry16,rUopDstRegData}      = {8'b0,wA} | {8'b0,wRegData[7:0]};
      rOverWritePc        = 1'b0;
      rMcuReadRequest     = 1'b0;
      rSetiWe             = 1'b0;
      rSetiVal            = 1'b0;
      rClearIntLatch      = 1'b0;
      rHalt               = 1'b1;
    end

    `anda:
    begin
      oMCUwe              = 1'b0;
      rRegSelect          = wUop[4:0];
      rSetMCOAddr         = 1'b0;
      rRegWe              = 1'b1;
      rWriteSelect        = `a;
      {rCarry16,rUopDstRegData}      = {8'b0,wA} & {8'b0,wRegData[7:0]};
      rOverWritePc        = 1'b0;
      rMcuReadRequest     = 1'b0;
      rSetiWe             = 1'b0;
      rSetiVal            = 1'b0;
      rClearIntLatch      = 1'b0;
      rHalt               = 1'b1;
    end

    `addx16:
    begin
      oMCUwe              = 1'b0;
      rRegSelect          = wUop[4:0];
      rSetMCOAddr         = 1'b0;
      rRegWe              = 1'b1;
      rWriteSelect        = `x16;
      {rCarry16,rUopDstRegData}      = wX16 + {{8{wRegData[7]}},wRegData[7:0]};  //sign extended 2'complement
      rOverWritePc        = 1'b0;
      rMcuReadRequest     = 1'b0;
      rSetiWe             = 1'b0;
      rSetiVal            = 1'b0;
      rClearIntLatch      = 1'b0;
      rHalt               = 1'b1;
    end

    `addx16u:
    begin
      oMCUwe              = 1'b0;
      rRegSelect          = wUop[4:0];
      rSetMCOAddr         = 1'b0;
      rRegWe              = 1'b1;
      rWriteSelect        = `x16;
      {rCarry16,rUopDstRegData}      = wX16 + wRegData;
      rOverWritePc        = 1'b0;
      rMcuReadRequest     = 1'b0;
      rSetiWe             = 1'b0;
      rSetiVal            = 1'b0;
      rClearIntLatch      = 1'b0;
      rHalt               = 1'b1;
    end

    `addx16c:
    begin
      oMCUwe              = 1'b0;
      rRegSelect          = wUop[4:0];
      rSetMCOAddr         = 1'b0;
      rRegWe              = 1'b1;
      rWriteSelect        = `x16;
      {rCarry16,rUopDstRegData}      = wX16 + wRegData + wFlags[`flag_c];
      rOverWritePc        = 1'b0;
      rMcuReadRequest     = 1'b0;
      rSetiWe             = 1'b0;
      rSetiVal            = 1'b0;
      rClearIntLatch      = 1'b0;
      rHalt               = 1'b1;
    end

    `spc:
    begin
      oMCUwe              = 1'b0;
      rRegSelect          = wUop[4:0];
      rSetMCOAddr         = 1'b0;
      rRegWe              = 1'b0;
      rWriteSelect        = wUopSrc[7:0];
      {rCarry16,rUopDstRegData}      = wRegData;
      rOverWritePc        = 1'b1;
      rMcuReadRequest     = 1'b0;
      rSetiWe             = 1'b0;
      rSetiVal            = 1'b0;
      rClearIntLatch      = 1'b0;
      rHalt               = 1'b1;
    end

    `jint:    //Jump to interrupt routine
    begin
      oMCUwe              = 1'b0;
      rRegSelect          = wUop[4:0];
      rSetMCOAddr         = 1'b0;
      rRegWe              = 1'b0;
      rWriteSelect        = `pc;
      {rCarry16,rUopDstRegData}      = wInterruptVectorAddress;
      rOverWritePc        = 1'b1;
      rMcuReadRequest     = 1'b0;
      rSetiWe             = 1'b0;
      rSetiVal            = 1'b0;
      rClearIntLatch      = 1'b1;
      rHalt               = 1'b1;
    end

    `jcb:  //Jump to extended Z80 flow (0xCB command)
    begin
      oMCUwe              = 1'b0;
      rRegSelect          = wUop[4:0];
      rSetMCOAddr         = 1'b0;
      rRegWe              = 1'b0;
      {rCarry16,rWriteSelect}        = wUopSrc[7:0];
      rUopDstRegData      = 16'b0;
      rOverWritePc        = 1'b0;
      rMcuReadRequest     = 1'b0;
      rSetiWe             = 1'b0;
      rSetiVal            = 1'b0;
      rClearIntLatch      = 1'b0;
      rHalt               = 1'b1;
    end

    `srx8:
    begin
      oMCUwe              = 1'b0;
      rRegSelect          = wUop[4:0];
      rSetMCOAddr         = 1'b0;
      rRegWe              = 1'b1;
      {rCarry16,rWriteSelect}        = wUopSrc[7:0];
      rUopDstRegData      = wX8;
      rOverWritePc        = 1'b0;
      rMcuReadRequest     = 1'b0;
      rSetiWe             = 1'b0;
      rSetiVal            = 1'b0;
      rClearIntLatch      = 1'b0;
      rHalt               = 1'b1;
    end

    `srx16:
    begin
      oMCUwe              = 1'b0;
      rRegSelect          = wUop[4:0];
      rSetMCOAddr         = 1'b0;
      rRegWe              = 1'b1;
      rWriteSelect        = wUopSrc[7:0];
      {rCarry16,rUopDstRegData}      = wX16;
      rOverWritePc        = 1'b0;
      rMcuReadRequest     = 1'b0;
      rSetiWe             = 1'b0;
      rSetiVal            = 1'b0;
      rClearIntLatch      = 1'b0;
      rHalt               = 1'b1;
    end

    `z801bop:
    begin
      oMCUwe              = 1'b0;
      rRegSelect          = {1'b0,iMCUData[2:0]};
      rSetMCOAddr         = 1'b0;
      rRegWe              = 1'b1;
      rWriteSelect        = ( iMCUData[7:6] == 2'b01  ) ? iMCUData[5:3] : wUopSrc[7:0];
      {rCarry16,rUopDstRegData}      = rZ80Result;
      rOverWritePc        = 1'b0;
      rMcuReadRequest     = 1'b0;
      rSetiWe             = 1'b0;
      rSetiVal            = 1'b0;
      rClearIntLatch      = 1'b0;
      rHalt               = 1'b1;
    end

    `shl:
    begin
      oMCUwe              = 1'b0;
      rRegSelect          = {1'b0,iMCUData[2:0]};
      rSetMCOAddr         = 1'b0;
      rRegWe              = 1'b1;
      rWriteSelect        = {5'b0,iMCUData[2:0]};
      {rCarry16,rUopDstRegData}      = (wRegData << 1) + wFlags[`flag_c];
      rOverWritePc        = 1'b0;
      rMcuReadRequest     = 1'b0;
      rSetiWe             = 1'b0;
      rSetiVal            = 1'b0;
      rClearIntLatch      = 1'b0;
      rHalt               = 1'b1;
    end

    `shl8:
    begin
      oMCUwe              = 1'b0;
      rRegSelect          = {1'b0,iMCUData[2:0]};
      rSetMCOAddr         = 1'b0;
      rRegWe              = 1'b1;
      rWriteSelect        = {5'b0,iMCUData[2:0]};
      {rCarry8,rUopDstRegData[7:0]}      = (wRegData << 1);
      rOverWritePc        = 1'b0;
      rMcuReadRequest     = 1'b0;
      rSetiWe             = 1'b0;
      rSetiVal            = 1'b0;
      rClearIntLatch      = 1'b0;
      rHalt               = 1'b1;
    end

    `addx16c_ext:
    begin
      oMCUwe              = 1'b0;
      rRegSelect          = {1'b0,iMCUData[2:0]};
      rSetMCOAddr         = 1'b0;
      rRegWe              = 1'b1;
      rWriteSelect        = {5'b0,iMCUData[2:0]};
      {rCarry16,rUopDstRegData}      = {rCarry8, wX16 + wRegData + rCarry8};
      rOverWritePc        = 1'b0;
      rMcuReadRequest     = 1'b0;
      rSetiWe             = 1'b0;
      rSetiVal            = 1'b0;
      rClearIntLatch      = 1'b0;
      rHalt               = 1'b1;
    end

    `rrot:
    begin
      oMCUwe              = 1'b0;
      rRegSelect          = {1'b0,iMCUData[2:0]};
      rSetMCOAddr         = 1'b0;
      rRegWe              = 1'b1;
      rWriteSelect        = {5'b0,iMCUData[2:0]};
      {rCarry16,rUopDstRegData}      = {wFlags[`flag_c], wSHR_RegData[6:0] };
      rOverWritePc        = 1'b0;
      rMcuReadRequest     = 1'b0;
      rSetiWe             = 1'b0;
      rSetiVal            = 1'b0;
      rClearIntLatch      = 1'b0;
      rHalt               = 1'b1;
    end

    `shr:
    begin
      oMCUwe              = 1'b0;
      rRegSelect          = {1'b0,iMCUData[2:0]};
      rSetMCOAddr         = 1'b0;
      rRegWe              = 1'b1;
      rWriteSelect        = {5'b0,iMCUData[2:0]};
      {rCarry16,rUopDstRegData}      = wSHR_RegData[7:0];
      rOverWritePc        = 1'b0;
      rMcuReadRequest     = 1'b0;
      rSetiWe             = 1'b0;
      rSetiVal            = 1'b0;
      rClearIntLatch      = 1'b0;
      rHalt               = 1'b1;
    end

    `bit:
    begin
      oMCUwe              = 1'b0;
      rRegSelect          = {1'b0,iMCUData[2:0]};
      rSetMCOAddr         = 1'b0;
      rRegWe              = 1'b0;
      rWriteSelect        = wUopSrc[7:0];
      {rCarry16,rUopDstRegData}      = wRegData & wBitMask;
      rOverWritePc        = 1'b0;
      rMcuReadRequest     = 1'b0;
      rSetiWe             = 1'b0;
      rSetiVal            = 1'b0;
      rClearIntLatch      = 1'b0;
      rHalt               = 1'b1;
    end

    `sx8r:
    begin
      oMCUwe              = 1'b0;
      rRegSelect          = wUop[4:0];
      rSetMCOAddr         = 1'b0;
      rRegWe              = 1'b1;
      rWriteSelect        = `x8;
      {rCarry16,rUopDstRegData}      = wRegData;
      rOverWritePc        = 1'b0;
      rMcuReadRequest     = 1'b0;
      rSetiWe             = 1'b0;
      rSetiVal            = 1'b0;
      rClearIntLatch      = 1'b0;
      rHalt               = 1'b1;
    end

    `sx16r:
    begin
      oMCUwe              = 1'b0;
      rRegSelect          = wUop[4:0];
      rSetMCOAddr         = 1'b0;
      rRegWe              = 1'b1;
      rWriteSelect        = `x16;
      {rCarry16,rUopDstRegData}      = wRegData;
      rOverWritePc        = 1'b0;
      rMcuReadRequest     = 1'b0;
      rSetiWe             = 1'b0;
      rSetiVal            = 1'b0;
      rClearIntLatch      = 1'b0;
      rHalt               = 1'b1;
    end

    `seti:
     begin
        oMCUwe              = 1'b0;
        rRegSelect          = `null;
        rSetMCOAddr         = 1'b0;
        rRegWe              = 1'b0;
        rWriteSelect        = 8'b0;
        {rCarry16,rUopDstRegData}      = 16'b0;
        rOverWritePc        = 1'b0;
        rMcuReadRequest     = 1'b0;
        rSetiWe             = 1'b1;
        rSetiVal            = 1'b1;
        rClearIntLatch      = 1'b0;
        rHalt               = 1'b1;
     end

    `ceti:  //Disable interruption
     begin
        oMCUwe              = 1'b0;
        rRegSelect          = `null;
        rSetMCOAddr         = 1'b0;
        rRegWe              = 1'b0;
        rWriteSelect        = 8'b0;
        {rCarry16,rUopDstRegData}      = 16'b0;
        rOverWritePc        = 1'b0;
        rMcuReadRequest     = 1'b0;
        rSetiWe             = 1'b1;
        rSetiVal            = 1'b0;
        rClearIntLatch      = 1'b0;
        rHalt               = 1'b1;
     end

     `cibit:
     begin
        oMCUwe              = 1'b0;
        rRegSelect          = `null;
        rSetMCOAddr         = 1'b0;
        rRegWe              = 1'b0;
        rWriteSelect        = 8'b0;
        {rCarry16,rUopDstRegData}      = 16'b0;
        rOverWritePc        = 1'b0;
        rMcuReadRequest     = 1'b0;
        rSetiWe             = 1'b0;
        rSetiVal            = 1'b0;
        rClearIntLatch      = 1'b1;
        rHalt               = 1'b1;
     end

     `hlt:
     begin
       oMCUwe              = 1'b0;
       rRegSelect          = `null;
       rSetMCOAddr         = 1'b0;
       rRegWe              = 1'b0;
       rWriteSelect        = wUopSrc[7:0];
       {rCarry16,rUopDstRegData}      = 16'b0;
       rOverWritePc        = 1'b0;
       rMcuReadRequest     = 1'b0;
       rSetiWe             = 1'b0;
       rSetiVal            = 1'b0;
       rClearIntLatch      = 1'b0;
       rHalt               = 1'b0;
     end

    default:
    begin
      oMCUwe              = 1'b0;
      rRegSelect          = `pc;
      rSetMCOAddr         = 1'b0;
      rRegWe              = 1'b0;
      rWriteSelect        = wUopSrc[7:0];
      {rCarry16,rUopDstRegData}      = 16'b0;
      rOverWritePc        = 1'b0;
      rMcuReadRequest     = 1'b0;
      rSetiWe             = 1'b0;
      rSetiVal            = 1'b0;
      rClearIntLatch      = 1'b0;
      rHalt               = 1'b1;
    end
  endcase
end

//Flags
// +----+-----+----+----+---------+
// | Z  |  N  | H  |  C | 4'b0    |
// +----+-----+----+----+---------+

wire [7:0] wCurrentFlow;
wire       wCBFlow, wIsCBFlow;
assign wIsCBFlow = (wuCmd == `jcb) ? 1'b1 : 1'b0;


FFD_POSEDGE_SYNCRONOUS_RESET # (8) FFD_CURFLOW (
  iClock, iReset, (rResetFlow | wIsCBFlow),iMCUData, wCurrentFlow);

FFD_POSEDGE_SYNCRONOUS_RESET # (1) FFD_CBFLOW (
  iClock, iReset, 1'b1 ,wIsCBFlow, wCBFlow);

always @ ( * )
begin
  case ({wCBFlow,wCurrentFlow})

    {1'b0,`INCr_a},{1'b0,`INCr_b},{1'b0,`INCr_c},{1'b0,`INCr_d},
    {1'b0,`INCr_e},{1'b0,`INCr_h},{1'b0,`INCr_l}:
    begin
       rFlagsZ              = {1'b1,wZ};
       rFlagsN              = {1'b1,1'b0};  //Can never be neg
       rFlagsH              = {1'b1,wHalfCarry_Inc};
       rFlagsC              = {1'b0,1'b0};
    end

    {1'b0,`DECr_b},{1'b0,`DECr_c},{1'b0,`DECr_d},{1'b0,`DECr_e},
    {1'b0,`DECr_h},{1'b0,`DECr_l},{1'b0,`DECr_a}, {1'b0,`DECHL},{1'b0,`DECHLm}:
     begin
        rFlagsZ              = {1'b1,wZ};
        rFlagsN              = {1'b1,1'b1};   //Gearboy behaves like this
        rFlagsH              = {1'b1,wHalfCarry_Dec};
        rFlagsC              = {1'b0,1'b0};   //This is needed to make BIOS work...
     end

    {1'b0,`ADDHLHL}, {1'b0,`ADDHLDE}:
    begin
       rFlagsZ              = {1'b0,1'b0};
       rFlagsN              = {1'b1,1'b0};
       rFlagsH              = {1'b1,wCarry12};
       rFlagsC              = {1'b1,rCarry16};
    end



    {1'b0,`ADDr_a}, {1'b0,`ADDr_b}, {1'b0,`ADDr_c},{1'b0, `ADDr_d},
    {1'b0,`ADDr_h}, {1'b0,`ADDr_l}, {1'b0,`ADDr_e},{1'b0, `ADDn}:
    begin
       rFlagsZ              = {1'b1,wZ};
       rFlagsN              = {1'b1,1'b0};
       rFlagsH              = {1'b1,wHalfCarry_Add};
       rFlagsC              = {1'b1,wCarry};
    end

    {1'b0,`ADCn}:
    begin
        rFlagsZ              = {1'b1,wZ};
        rFlagsN              = {1'b1,1'b0};
        rFlagsH              = {1'b1,wHalfCarry_AddC};
        rFlagsC              = {1'b1,wCarry};
    end

    {1'b0,`SUBr_a}, {1'b0,`SUBr_b}, {1'b0,`SUBr_e},{1'b0, `SUBr_d},
    {1'b0,`SUBr_h}, {1'b0,`SUBr_l},{1'b0,`SUBn}:
    begin
       rFlagsZ              = {1'b1,wZ};
       rFlagsN              = {1'b1,1'b1};
       rFlagsH              = {1'b1,wHalfCarry_Sub};
       rFlagsC              = {1'b1,wCarry};
    end

    {1'b0,`CPn}:
    begin
       rFlagsZ              = {1'b1,wZ};   // A == n
       rFlagsN              = {1'b1,1'b1};
       rFlagsH              = {1'b1,wCpnHalf};   //A > n
       rFlagsC              = {1'b1,wN};   //A < n
    end

    {1'b0,`ANDr_a},{1'b0,`ANDr_b},
    {1'b0,`ANDr_c},{1'b0,`ANDn},
    {1'b0,`ANDr_d},{1'b0,`ANDr_e},
    {1'b0,`ANDr_h},{1'b0,`ANDr_l}:
    begin
       rFlagsZ              = {1'b1,wZ};
       rFlagsN              = {1'b1,1'b0};
       rFlagsH              = {1'b1,1'b1};  //H is set
       rFlagsC              = {1'b1,1'b0};
    end

    {1'b0, `LDHLSPn}:
    begin
       rFlagsZ              = {1'b1,1'b0}; //Clear this flag
       rFlagsN              = {1'b1,1'b0}; //Clear this flag
       rFlagsH              = {1'b1,rUopDstRegData[3]};
       rFlagsC              = {1'b1,wCarry};
    end



    {1'b0,`RLA}:
    begin
       rFlagsZ              = {1'b0,1'b0};
       rFlagsN              = {1'b0,1'b0};
       rFlagsH              = {1'b1,1'b0};  //H is reset
       rFlagsC              = {1'b1,wA[7]};
    end

    {1'b0,`RLCA}:
      begin
         rFlagsZ              = {1'b0,1'b0};
         rFlagsN              = {1'b0,1'b0};
         rFlagsH              = {1'b1,1'b0};  //H is reset
         rFlagsC              = {1'b1,rCarry16};
      end

    {1'b0,`RRA}:
    begin
       rFlagsZ              = {1'b1,wZ};
       rFlagsN              = {1'b1,1'b0};
       rFlagsH              = {1'b1,1'b0};  //H is reset
       rFlagsC              = {1'b1,wA[0]};
    end

    {1'b1,`RLr_a},{1'b1,`RLr_b},{1'b1,`RLr_d},{1'b1,`RLr_e},
    {1'b1,`RLr_h},{1'b1,`RLr_l},{1'b1,`RLr_c}:
    begin
       rFlagsZ              = {1'b1,wZ};
       rFlagsN              = {1'b1,wN};
       rFlagsH              = {1'b1,1'b0};  //H is reset
       rFlagsC              = {1'b1,wRegData[7]};
    end


    {1'b1,`SRLr_a},{1'b1,`SRLr_b},{1'b1,`SRLr_d},{1'b1,`SRLr_e},
    {1'b1,`SRLr_h},{1'b1,`SRLr_l},{1'b1,`SRLr_c}:
    begin
       rFlagsZ              = {1'b1,wZ};
       rFlagsN              = {1'b1,wN};
       rFlagsH              = {1'b1,1'b0};  //H is reset
       rFlagsC              = {1'b1,wRegData[0]};
    end


    {1'b0,`ORr_a}, {1'b0,`ORr_b}, {1'b0,`ORr_d},{1'b0,`ORr_c},
    {1'b0,`ORr_e}, {1'b0,`ORr_h}, {1'b0,`ORr_l},{1'b0,`ORn},{1'b0,`XORn},{1'b0,`ORHL},
    {1'b0,`XORr_a},{1'b0,`XORr_b},{1'b0,`XORr_d},{1'b0,`XORr_c},
    {1'b0,`XORr_e},{1'b0,`XORr_h},{1'b0,`XORr_l},{1'b0,`XORHL}:
    begin
       rFlagsZ              = {1'b1,wZ};
       rFlagsN              = {1'b1,1'b0};
       rFlagsH              = {1'b1,1'b0};  //H is reset
       rFlagsC              = {1'b1,1'b0};  //C is reset
    end


    {1'b1,  `RLCr_b}, {1'b1, `RLCr_c}, {1'b1,`RLCr_d}, {1'b1,`RLCr_e},
    {1'b1,  `RLCr_h}, {1'b1, `RLCr_l}, {1'b1,`RLCr_a}:
    begin
       rFlagsZ              = {1'b1,wZ};
       rFlagsN              = {1'b1,1'b0};
       rFlagsH              = {1'b1,1'b0};
       rFlagsC              = {1'b1,wRegData[7]};
    end

    {1'b1,  `RRCr_b}, {1'b1,  `RRCr_c}, {1'b1, `RRCr_d}, {1'b1,  `RRCr_e},
    {1'b1,  `RRCr_h}, {1'b1,  `RRCr_l},
    {1'b1,  `RRr_b}, {1'b1,  `RRr_c}, {1'b1, `RRr_d}, {1'b1,  `RRr_e},
    {1'b1,  `RRr_h}, {1'b1,  `RRr_l},{1'b1,  `RRr_a}:
    begin
       rFlagsZ              = {1'b1,wZ};
       rFlagsN              = {1'b1,1'b0};
       rFlagsH              = {1'b1,1'b0};
       rFlagsC              = {1'b1,wRegData[0]};
    end

    {1'b1, `BIT7h },  {1'b1, `BIT7l },  {1'b1, `BIT7m }, {1'b1, `BIT7a }:
    begin
       rFlagsZ              = {1'b1,wZ};
       rFlagsN              = {1'b0,1'b0};
       rFlagsH              = {1'b0,1'b0};
       rFlagsC              = {1'b0,1'b0};
    end

    default:
    begin
        rFlagsZ              = {1'b0,1'b0};
        rFlagsN              = {1'b0,1'b0};
        rFlagsH              = {1'b0,1'b0};
        rFlagsC              = {1'b0,1'b0};
    end
  endcase
end

DECODER_MASK_3_BITS BIT_MASK( iMCUData[5:3], wBitMask );

always @ ( * )
begin
  case (iMCUData[7:3])
    5'b10100:  rZ80Result = wA & wRegData; //AND
    5'b10101:  rZ80Result = wA ^ wRegData; //XOR
    5'b10110:  rZ80Result = wA | wRegData; //OR
    5'b01000, 5'b01001, 5'b01010, 5'b01011, 5'b01100, 5'b01101, 5'b01110, 5'b01111:   rZ80Result = wRegData;      //ldrr
    default:  rZ80Result = 8'hcc;
  endcase
end

endmodule
