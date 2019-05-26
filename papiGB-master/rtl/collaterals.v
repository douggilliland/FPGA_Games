`ifndef COLLATERALS_V
`define COLLATERALS_V

`timescale 1ns / 1ps
`include "aDefinitions.v"
/**********************************************************************************
Theia, Ray Cast Programable graphic Processing Unit.
Copyright (C) 2010  Diego Valverde (diego.valverde.g@gmail.com)

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

***********************************************************************************/

//----------------------------------------------------
module FFD_POSEDGE_SYNCRONOUS_RESET # ( parameter SIZE=`WIDTH )
(
	input wire				Clock,
	input wire				Reset,
	input wire				Enable,
	input wire [SIZE-1:0]	D,
	output reg [SIZE-1:0]	Q
);


always @ (posedge Clock)
begin
	if ( Reset )
		Q <= {SIZE{1'b0}};
	else
	begin
		if (Enable)
			Q <= D;
	end

end//always

endmodule
//----------------------------------------------------
module XNOR # (parameter SIZE=8)
(
	input wire [SIZE-1:0]	inA,
	input wire [SIZE-1:0]	inB,
	output reg [SIZE-1:0]	out
);

always @ (*)
begin
  out <= ~(inA ^ inB);
end//always

endmodule


//----------------------------------------------------
module FFD_POSEDGE_SYNCRONOUS_RESET_INIT # ( parameter SIZE=`WIDTH )
(
	input wire				Clock,
	input wire				Reset,
	input wire				Enable,
	input wire [SIZE-1:0]   iInitial,
	input wire [SIZE-1:0]	D,
	output reg [SIZE-1:0]	Q
);


always @ (posedge Clock)
begin
	if ( Reset )
		Q <= iInitial;
	else
	begin
		if (Enable)
			Q <= D;
	end

end//always

endmodule
//------------------------------------------------
module UPCOUNTER_POSEDGE # (parameter SIZE=`WIDTH)
(
input wire Clock, Reset,
input wire [SIZE-1:0] Initial,
input wire Enable,
output reg [SIZE-1:0] Q
);


  always @(posedge Clock )
  begin
      if (Reset)
        Q <= Initial;
      else
		begin
		if (Enable)
			Q <= Q + 1;

		end
  end

endmodule

//----------------------------------------------------------------------

module SELECT_1_TO_N # ( parameter SEL_WIDTH=4, parameter OUTPUT_WIDTH=16 )
 (
 input wire [SEL_WIDTH-1:0] Sel,
 input wire  En,
 output wire [OUTPUT_WIDTH-1:0] O
 );

reg[OUTPUT_WIDTH-1:0] shift;

always @ ( * )
begin
	if (~En)
		shift = 1;
	else
		shift = (1 << 	Sel);


end

assign O = ( ~En ) ? 0 : shift ;

//assign O = En & (1 << Sel);

endmodule


//----------------------------------------------------------------------
module DECODER_MASK_3_BITS
(
input wire[2:0] iIn,
output reg [7:0] oOut
);

always @ ( * )
begin
	case (iIn)
		3'b000: oOut = 8'b00000001;
		3'b001: oOut = 8'b00000010;
		3'b010: oOut = 8'b00000100;
		3'b011: oOut = 8'b00001000;
		3'b100: oOut = 8'b00010000;
		3'b101: oOut = 8'b00100000;
		3'b110: oOut = 8'b01000000;
		3'b111: oOut = 8'b10000000;
	default: oOut = 8'b0;
	endcase

end
endmodule
//---------------------------------------------------------------------------
module MUX2 # (parameter SIZE=8)
(
	input wire select,
	input wire [SIZE-1:0] inA,
	input wire [SIZE-1:0] inB,
	output reg [SIZE-1:0] out
);

always @ (*)
begin
  out <= (select == 0)? inA : inB;
end

endmodule

//----------------------------------------------------------------------
module MUXFULLPARALELL_3SEL_GENERIC # ( parameter SIZE=`WIDTH )
 (
 input wire [2:0] Sel,
 input wire [SIZE-1:0] I0, I1, I2, I3,I4, I5, I6, I7,
 output reg [SIZE-1:0] O
 );

always @( * )

  begin

    case (Sel)
      3'd0: O = I0;
      3'd1: O = I1;
	  3'd2: O = I2;
	  3'd3: O = I3;
	  3'd4: O = I4;
	  3'd5: O = I5;
	  3'd6: O = I6;
	  3'd7: O = I7;
	  default: O = SIZE;

    endcase

  end

endmodule
//----------------------------------------------------------------------
module MUXFULLPARALELL_4SEL_GENERIC # ( parameter SIZE=`WIDTH )
 (
 input wire [3:0] Sel,
 input wire [SIZE-1:0] I0, I1, I2, I3,I4, I5, I6, I7, I8, I9, I10, I11, I12, I13, I14, I15,
 output reg [SIZE-1:0] O
 );

always @( * )

  begin

    case (Sel)
      4'd0: O = I0;
      4'd1: O = I1;
	  4'd2: O = I2;
	  4'd3: O = I3;
	  4'd4: O = I4;
	  4'd5: O = I5;
	  4'd6: O = I6;
	  4'd7: O = I7;
	  4'd8: O = I8;
	  4'd9: O = I9;
	  4'd10: O = I10;
	  4'd11: O = I11;
	  4'd12: O = I12;
	  4'd13: O = I13;
	  4'd14: O = I14;
	  4'd15: O = I15;
	  default: O = SIZE;

    endcase

  end

endmodule

//----------------------------------------------------------------------
module MUXFULLPARALELL_5SEL_GENERIC # ( parameter SIZE=`WIDTH )
 (
 input wire [4:0] Sel,
 input wire [SIZE-1:0] I0, I1, I2, I3,I4, I5, I6, I7, I8, I9, I10, I11, I12, I13, I14, I15,
 input wire [SIZE-1:0] I16, I17, I18, I19,I20, I21, I22, I23, I24, I25, I26, I27, I28, I29, I30, I31,
 output reg [SIZE-1:0] O
 );

always @( * )

  begin

    case (Sel)
	  5'd0: O = I0;
	  5'd1: O = I1;
	  5'd2: O = I2;
	  5'd3: O = I3;
	  5'd4: O = I4;
	  5'd5: O = I5;
	  5'd6: O = I6;
	  5'd7: O = I7;
	  5'd8: O = I8;
	  5'd9: O = I9;
	  5'd10: O = I10;
	  5'd11: O = I11;
	  5'd12: O = I12;
	  5'd13: O = I13;
	  5'd14: O = I14;
	  5'd15: O = I15;
	  5'd16: O = I16;
	  5'd17: O = I17;
	  5'd18: O = I18;
	  5'd19: O = I19;
	  5'd20: O = I20;
	  5'd21: O = I21;
	  5'd22: O = I22;
	  5'd23: O = I23;
	  5'd24: O = I24;
	  5'd25: O = I25;
	  5'd26: O = I26;
	  5'd27: O = I27;
	  5'd28: O = I28;
	  5'd29: O = I29;
	  5'd30: O = I30;
	  5'd31: O = I31;
	  default: O = SIZE;

    endcase

  end

endmodule

//----------------------------------------------------------------------
module MUXFULLPARALELL_2SEL_GENERIC # ( parameter SIZE=`WIDTH )
 (
 input wire [1:0] Sel,
 input wire [SIZE-1:0]I0, I1, I2,I3,
 output reg [SIZE-1:0] O
 );

always @( * )

  begin

    case (Sel)

      2'b00: O = I0;
      2'b01: O = I1;
      2'b10: O = I2;
      2'b11: O = I3;
      default: O = SIZE;

    endcase

  end

endmodule

//--------
module CIRCULAR_SHIFTLEFT_POSEDGE_EX # ( parameter SIZE=`WIDTH )
( input wire Clock,
  input wire Reset,
  input wire[SIZE-1:0] Initial,
  input wire      Enable,
  output wire[SIZE-1:0] O
);

reg [SIZE-1:0] tmp;


  always @(posedge Clock)
  begin
  if (Reset)
		tmp <= Initial;
	else
	begin
		if (Enable)
		begin
			if (tmp[SIZE-1])
			begin
				tmp <= Initial;
			end
			else
			begin
				tmp <= tmp << 1;
			end
		end
	end
  end


    assign O  = tmp;
endmodule
//------------------------------------------------
module MUXFULLPARALELL_3SEL_WALKINGONE # ( parameter SIZE=`WIDTH )
 (
 input wire [2:0] Sel,
 input wire [SIZE-1:0]I1, I2, I3,
 output reg [SIZE-1:0] O1
 );

always @( * )

  begin

    case (Sel)

      3'b001: O1 = I1;
      3'b010: O1 = I2;
      3'b100: O1 = I3;
      default: O1 = SIZE;

    endcase

  end

endmodule
//------------------------------------------------
module SHIFTLEFT_POSEDGE # ( parameter SIZE=`WIDTH )
( input wire Clock,
  input wire Reset,
  input wire[SIZE-1:0] Initial,
  input wire      Enable,
  output wire[SIZE-1:0] O
);

reg [SIZE-1:0] tmp;


  always @(posedge Clock)
  begin
  if (Reset)
		tmp <= Initial;
	else
	begin
		if (Enable)
			tmp <= tmp << 1;
	end
  end


    assign O  = tmp;
endmodule
//------------------------------------------------
//------------------------------------------------
module CIRCULAR_SHIFTLEFT_POSEDGE # ( parameter SIZE=`WIDTH )
( input wire Clock,
  input wire Reset,
  input wire[SIZE-1:0] Initial,
  input wire      Enable,
  output wire[SIZE-1:0] O
);

reg [SIZE-1:0] tmp;


  always @(posedge Clock)
  begin
  if (Reset || tmp[SIZE-1])
		tmp <= Initial;
	else
	begin
		if (Enable)
			tmp <= tmp << 1;
	end
  end


    assign O  = tmp;
endmodule
//-----------------------------------------------------------
/*
	Sorry forgot how this flop is called.
	Any way Truth table is this

	Q	S	Q_next R
	0	0	0		 0
	0	1	1		 0
	1	0	1		 0
	1	1	1		 0
	X	X	0		 1

	The idea is that it toggles from 0 to 1 when S = 1, but if it
	gets another S = 1, it keeps the output to 1.
*/
module FFToggleOnce_1Bit
(
	input wire Clock,
	input wire Reset,
	input wire Enable,
	input wire S,
	output reg Q

);


reg Q_next;

always @ (negedge Clock)
begin
	Q <= Q_next;
end

always @ ( posedge Clock )
begin
	if (Reset)
		Q_next <= 0;
	else if (Enable)
		Q_next <= (S && !Q) || Q;
	else
		Q_next <= Q;
end
endmodule

//-----------------------------------------------------------


module FFD32_POSEDGE
(
	input wire Clock,
	input wire[31:0] D,
	output reg[31:0] Q
);

	always @ (posedge Clock)
		Q <= D;

endmodule

//------------------------------------------------
module MUXFULLPARALELL_96bits_2SEL
 (
 input wire Sel,
 input wire [95:0]I1, I2,
 output reg [95:0] O1
 );



always @( * )

  begin

    case (Sel)

      1'b0: O1 = I1;
      1'b1: O1 = I2;

    endcase

  end

endmodule

//------------------------------------------------
module MUXFULLPARALELL_16bits_2SEL
 (
 input wire Sel,
 input wire [15:0]I1, I2,
 output reg [15:0] O1
 );



always @( * )

  begin

    case (Sel)

      1'b0: O1 = I1;
      1'b1: O1 = I2;

    endcase

  end

endmodule

//--------------------------------------------------------------

  module FFT1
  (
   input wire D,
   input wire Clock,
   input wire Reset ,
   output reg Q
 );

  always @ ( posedge Clock or posedge Reset )
  begin

	if (Reset)
	begin
    Q <= 1'b0;
   end
	else
	begin
		if (D)
			Q <=  ! Q;
	end

  end//always

 endmodule
//--------------------------------------------------------------

module RAM_DUAL_READ_PORT # ( parameter DATA_WIDTH=`WIDTH, parameter ADDR_WIDTH=`WIDTH, parameter MEM_SIZE=128 )
(
 input wire                    Clock,
 input wire                    iWriteEnable,
 input wire[ADDR_WIDTH-1:0]    iReadAddress0,
 input wire[ADDR_WIDTH-1:0]    iReadAddress1,
 input wire[ADDR_WIDTH-1:0]    iWriteAddress,
 input wire[DATA_WIDTH-1:0]    iDataIn,
 output reg [DATA_WIDTH-1:0]   oDataOut0,
 output reg [DATA_WIDTH-1:0]   oDataOut1
);

reg [DATA_WIDTH-1:0] Ram [MEM_SIZE-1:0];

always @(posedge Clock)
begin

  /* verilator lint_off WIDTH */
  if (iWriteEnable)
   Ram[iWriteAddress] <= iDataIn;


   oDataOut0 <= Ram[iReadAddress0];
   oDataOut1 <= Ram[iReadAddress1];
    /* verilator lint_on WIDTH */

end
endmodule
//--------------------------------------------------------

module RAM_SINGLE_READ_PORT # ( parameter DATA_WIDTH=`WIDTH, parameter ADDR_WIDTH=`WIDTH, parameter MEM_SIZE=128 )
(
 input wire      Clock,
 input wire      iWriteEnable,
 input wire[ADDR_WIDTH-1:0] iReadAddress0,
 input wire[ADDR_WIDTH-1:0] iWriteAddress,
 input wire[DATA_WIDTH-1:0]    iDataIn,
 output reg [DATA_WIDTH-1:0]   oDataOut0

);

reg [DATA_WIDTH-1:0] Ram [MEM_SIZE-1:0];

always @(posedge Clock)
begin

  if (iWriteEnable)
   Ram[iWriteAddress] <= iDataIn;


   oDataOut0 <= Ram[iReadAddress0];


end
endmodule

`endif
