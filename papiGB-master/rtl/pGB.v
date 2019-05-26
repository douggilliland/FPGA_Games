`timescale 1ns / 1ps
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
module pGB
(

input wire iClock,

`ifdef VGA_ENABLED
output wire [3:0] oVgaRed,
output wire [3:0] oVgaGreen,
output wire [3:0] oVgaBlue,
output wire       oVgaHsync,
output wire       oVgaVsync,
`endif

//IO input ports
//ASCII IMAGE BUTTON MATRIX
input wire [5:0]  iButtonRegister,    //Pressed button


`ifndef XILINX_IP
output wire       oFrameBufferWe,
output wire [15:0] oFrameBufferData,
output wire [15:0] oFrameBufferAddr,

`endif

input wire iReset
);

wire [15:0] wdZCPU_2_MMU_Addr, wGPU_2_MCU_Addr;
wire [7:0]  wdZCPU_2_MMU_WriteData, wMMU_ReadData;
wire        wdZCPU_2_MMU_We, wdZCPU_2_MMU_ReadRequest;

wire[7:0] wGPU_2_MCU_LCDC;
wire[7:0] wGPU_2_MCU_STAT;
wire[7:0] wGPU_2_MCU_SCY;
wire[7:0] wGPU_2_MCU_SCX;
wire[7:0] wGPU_2_MCU_LY;
wire[7:0] wGPU_2_MCU_LYC;
wire[7:0] wGPU_2_MCU_DMA;
wire[7:0] wGPU_2_MCU_BGP;
wire[7:0] wGPU_2_MCU_OBP0;
wire[7:0] wGPU_2_MCU_OBP1;
wire[7:0] wGPU_2_MCU_WY;
wire[7:0] wGPU_2_MCU_WX, wMMU_RegData, wMMU_2_GPU_VmemReadData;
wire[7:0] wButtonRegister;
wire[7:0] wCurrentZ80Insn;
wire[15:0] wGpuAddr;
wire [2:0] wMMU_RegWe;
wire[3:0] wMMU_RegSelect, wMCU_2_TIMER_RegSelect;
wire wGPU_2_MCU_ReadRequest, wMCU_2_TIMER_We;
wire wIOInterruptTrigger, wdZCPU_Eof, wdZCPU_BranchTaken, wDZCPU_2_Timer_IntDetected;
wire [7:0] wInterruptRequest,wInt_2_MMU_InterruptFlag, wInt_2_MMU_IntEnable;
wire wInterrupt0x50;

dzcpu  DZCPU
(
	.iClock( iClock ),
	.iReset( iReset ),
	.iMCUData( wMMU_ReadData ),
	.oMCUAddr( wdZCPU_2_MMU_Addr      ),
	.oMCUwe( wdZCPU_2_MMU_We ),
	.oMCUData( wdZCPU_2_MMU_WriteData ),
	.oMcuReadRequest( wdZCPU_2_MMU_ReadRequest ),
	.oCurrentZ80Insn( wCurrentZ80Insn ),
	.oEof( wdZCPU_Eof ),
	.iInterruptRequests( wInterruptRequest ),
	.oInterruptJump( wDZCPU_2_Timer_IntDetected ),
	.oBranchTaken( wdZCPU_BranchTaken ),
	.iJoypad(wButtonRegister[5:0])
);


interrupt_controller INTERRUPTS
(
	.iClock(iClock ),
	.iReset( iReset ),

	 .iMcuWe( wMMU_RegWe[2] ),
	 .iMcuRegSelect(wMMU_RegSelect ), //control register select comes from cpu
	 .iMcuWriteData( wMMU_RegData  ), //what does the cpu want to write

	 .oInterruptEnableRegister( wInt_2_MMU_IntEnable ),
	 .oInterruptFlag( wInt_2_MMU_InterruptFlag),


	.iInterruptRequest( {5'b0, wInterrupt0x50, 2'b0} ),
	.oInterruptResquestPending( wInterruptRequest )
);

timers TIMERS
(
 .iClock( iClock    ),
 .iReset( iReset    ),
 .iOpcode( wCurrentZ80Insn  ),
 .iBranchTaken( wdZCPU_BranchTaken ),
 .iEof( wdZCPU_Eof  ),
 .iMcuWe( wMMU_RegWe[1] ),
 .iMcuRegSelect( wMMU_RegSelect ),
 .iInterrupt( wDZCPU_2_Timer_IntDetected ),
 .iMcuWriteData( wMMU_RegData ),

 //output wire oInterrupt0x50
 .oInterrupt0x50( wInterrupt0x50 )

);

assign wButtonRegister[7:6] = 2'b0;
//IO unit is in charge of marshalling the GameBoy push butons
io IO
(
	.Clock( iClock ),
	.Reset( iReset ),
	.iP( iButtonRegister ),
	.oP( wButtonRegister[5:0] ),
	.oIE( wIOInterruptTrigger )

);


mmu MMU
(
	.iClock( iClock ),
	.iReset( iReset ),

	//CPU
	.iCpuReadRequest( wdZCPU_2_MMU_ReadRequest ),
	.iGpuReadRequest( wGPU_2_MCU_ReadRequest ),
	.iCpuAddr(  wdZCPU_2_MMU_Addr ),
	.iCpuWe(    wdZCPU_2_MMU_We   ),
	.iCpuData(  wdZCPU_2_MMU_WriteData ),
	.oCpuData(  wMMU_ReadData ),

  //GPU
	.oGpuVmemReadData( wMMU_2_GPU_VmemReadData ),
	.iGpuAddr( wGPU_2_MCU_Addr  ),
	.oRegData( wMMU_RegData     ),
	.oRegSelect( wMMU_RegSelect ),
	.oRegWe( wMMU_RegWe     ),

	.iGPU_LCDC( wGPU_2_MCU_LCDC ),
	.iGPU_STAT( wGPU_2_MCU_STAT ),
	.iGPU_SCY(  wGPU_2_MCU_SCY  ),
	.iGPU_SCX(  wGPU_2_MCU_SCX  ),
	.iGPU_LY(   wGPU_2_MCU_LY   ),
	.iGPU_LYC(  wGPU_2_MCU_LYC  ),
	.iGPU_DMA(  wGPU_2_MCU_DMA  ),
	.iGPU_BGP(  wGPU_2_MCU_BGP  ),
	.iGPU_OBP0( wGPU_2_MCU_OBP0 ),
	.iGPU_OBP1( wGPU_2_MCU_OBP1 ),
	.iGPU_WY(   wGPU_2_MCU_WY   ),
	.iGPU_WX(   wGPU_2_MCU_WX   ),

	.iInterruptEnable( wInt_2_MMU_IntEnable ),
	.iInterruptFlag(   wInt_2_MMU_InterruptFlag ),

	//IO
	.iButtonRegister( wButtonRegister )
);


`ifdef VGA_ENABLED

 wire [15:0] wFramBufferWriteData, wVgaFBReadData, wVgaFBReadData_Pre, wFrameBufferReadAddress, wFramBufferWriteAddress;
 wire [15:0] wVgaRow, wVgaCol;
 wire [3:0] wVgaR, wVgaG, wVgaB;
 wire [9:0] wVgaFBReadAddr;
 wire [1:0] wVgaColor2Bits;
 wire wFramBufferWe;

	RAM_SINGLE_READ_PORT # ( .DATA_WIDTH(16), .ADDR_WIDTH(10), .MEM_SIZE(8192) ) FBUFFER
	(
	 .Clock( iClock ), //TODO: Should we use graphic clock here?
	 .iWriteEnable( wFramBufferWe        ),
	 //.iReadAddress0( {3'b0,wFrameBufferReadAddress[15:3]}      ), //Divide by 8
	 .iReadAddress0( wFrameBufferReadAddress      ), //Divide by 8
	 .iWriteAddress( wFramBufferWriteAddress  ),
	 .iDataIn(       wFramBufferWriteData     ),
	 .oDataOut0(     wVgaFBReadData_Pre  )

	);

 assign wFrameBufferReadAddress = (wVgaRow  << 5) + (wVgaCol >> 3);

	MUXFULLPARALELL_3SEL_GENERIC # (2) MUX_COLOR (
		.Sel( wVgaCol[2:0] ),
	  .I7( wVgaFBReadData_Pre[1:0]),
		.I6( wVgaFBReadData_Pre[3:2]),
		.I5( wVgaFBReadData_Pre[5:4]),
		.I4( wVgaFBReadData_Pre[7:6]) ,
		.I3( wVgaFBReadData_Pre[9:8]),
		.I2( wVgaFBReadData_Pre[11:10]),
		.I1( wVgaFBReadData_Pre[13:12]),
		.I0( wVgaFBReadData_Pre[15:14]) ,
		.O( wVgaColor2Bits  )
		);

   wire [3:0] wRed,wGreen,wBlue;
		MUXFULLPARALELL_2SEL_GENERIC # (12) MUX_COLOR_OUT (
			.Sel( wVgaColor2Bits  ),
			.I0( {4'b0000, 4'b0000, 4'b0000 } ),
			.I1( {4'b1111, 4'b0000, 4'b0000 } ),
			.I2( {4'b0000, 4'b1111, 4'b0000 } ),
			.I3( {4'b0000, 4'b0000, 4'b1111 }) ,
			.O( {wRed,wGreen,wBlue}  )
			);



	assign oVgaRed   = ( wVgaRow >= 16'd255 || wVgaCol >= 255 ) ? 4'b0111 : wRed;
	assign oVgaGreen = ( wVgaRow >= 16'd255 || wVgaCol >= 255 ) ? 4'b0111 : wGreen;
	assign oVgaBlue  = ( wVgaRow >= 16'd255 || wVgaCol >= 255 ) ? 4'b0111 : wBlue;


	VgaController VGA
	(
	.Clock(iClock),
	.Reset(iReset),
	.oVgaVsync( oVgaVsync ),
	.oVgaHsync( oVgaHsync ),
	/*.oVgaRed( oVgaRed ),
	.oVgaGreen( oVgaGreen ),
	.oVgaBlue( oVgaBlue ),*/
	.oRow( wVgaRow ),
	.oCol(  wVgaCol )

	);

	`ifndef XILINX_IP
		assign oFrameBufferAddr = wFramBufferWriteAddress;
		assign oFrameBufferData  = wFramBufferWriteData;
		assign oFrameBufferWe    = wFramBufferWe;
	`endif

`endif

gpu GPU
(
  .iClock( iClock ),
  .iReset( iReset ),
`ifndef VGA_ENABLED
  .oFramBufferWe(   oFrameBufferWe ),
  .oFramBufferData( oFrameBufferData ),
  .oFramBufferAddr( oFrameBufferAddr ),
`else
	.oFramBufferWe(   wFramBufferWe	 ),
	.oFramBufferData( wFramBufferWriteData ),
	.oFramBufferAddr( wFramBufferWriteAddress ),

`endif
  .oMcuAddr( wGPU_2_MCU_Addr ),
	.oMcuReadRequest( wGPU_2_MCU_ReadRequest ),
  .iMcuRegSelect( wMMU_RegSelect),
  .iMcuWriteData( wMMU_RegData ),
	.iMcuReadData(  wMMU_2_GPU_VmemReadData ),
  .iMcuWe( wMMU_RegWe[0] ),
  .oSTAT( wGPU_2_MCU_STAT ),
  .oLCDC( wGPU_2_MCU_LCDC ),
  .oSCY(  wGPU_2_MCU_SCY  ),
  .oSCX(  wGPU_2_MCU_SCX  ),
  .oLY(   wGPU_2_MCU_LY   ),
  .oLYC(  wGPU_2_MCU_LYC  ),
  .oDMA(  wGPU_2_MCU_DMA  ),
  .oBGP(  wGPU_2_MCU_BGP  ),
  .oOBP0( wGPU_2_MCU_OBP0 ),
  .oOBP1( wGPU_2_MCU_OBP1 ),
  .oWY(   wGPU_2_MCU_WY   ),
  .oWX(   wGPU_2_MCU_WX   )
);

endmodule
