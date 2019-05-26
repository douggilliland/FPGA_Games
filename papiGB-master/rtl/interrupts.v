module interrupt_controller
(
  input wire iClock,
  input wire iReset,

   input wire        iMcuWe,
   input wire [3:0]  iMcuRegSelect, //control register select comes from cpu
   input wire [7:0]  iMcuWriteData, //what does the cpu want to write

   output wire[7:0]  oInterruptEnableRegister,
   output wire[7:0]  oInterruptFlag,


  input wire [7:0] iInterruptRequest,
  output reg [7:0] oInterruptResquestPending
);




////////////////////////////////////////////////
//
// Register 0xFFFF:  IE. Interrupt Enable register
// reset to 0 whenever written to
//
//  Bit 0: V-Blank  Interrupt Enable  (INT 40h)  (1=Enable)
//  Bit 1: LCD STAT Interrupt Enable  (INT 48h)  (1=Enable)
//  Bit 2: Timer    Interrupt Enable  (INT 50h)  (1=Enable)
//  Bit 3: Serial   Interrupt Enable  (INT 58h)  (1=Enable)
//  Bit 4: Joypad   Interrupt Enable  (INT 60h)  (1=Enable)
////////////////////////////////////////////////

wire wWeInterrutpRegister;
assign wWeInterrutpRegister = (iMcuWe & iMcuRegSelect == 4'h0) ? 1'b1 : 1'b0;
FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 )FF_IE(
	iClock, iReset ,  wWeInterrutpRegister , iMcuWriteData, oInterruptEnableRegister );

////////////////////////////////////////////////
//
// Register 0xFF0F: IF. Interrupt Flag
//	Bit 0: V-Blank  Interrupt Request (INT 40h)  (1=Request)
//  Bit 1: LCD STAT Interrupt Request (INT 48h)  (1=Request)
//  Bit 2: Timer    Interrupt Request (INT 50h)  (1=Request)
//  Bit 3: Serial   Interrupt Request (INT 58h)  (1=Request)
//  Bit 4: Joypad   Interrupt Request (INT 60h)  (1=Request)
////////////////////////////////////////////////

wire wWeInterruptFlag;
assign wWeInterruptFlag = (iMcuWe & iMcuRegSelect == 4'hf) ? 1'b1: 1'b0;
FFD_POSEDGE_SYNCRONOUS_RESET_INIT # ( 8 )FF_IF(
	iClock, iReset | wWeInterruptFlag ,  |iInterruptRequest , iMcuWriteData, iInterruptRequest, oInterruptFlag );


wire [7:0] wPendingInterrupts;
assign wPendingInterrupts = oInterruptFlag & oInterruptEnableRegister;


  always @ (*)
  begin
      case (wPendingInterrupts)
       8'h1: oInterruptResquestPending  = 8'b00000001; //VBLANK
       8'h2: oInterruptResquestPending  = 8'b00000010; //LCDSTAT
       8'h4: oInterruptResquestPending  = 8'b00000100; //TIMER
       8'h8: oInterruptResquestPending  = 8'b00001000; //SERIAL
       8'h10: oInterruptResquestPending = 8'b00010000; //JOYPAD
      default: oInterruptResquestPending = 8'b0;
      endcase
  end

endmodule
