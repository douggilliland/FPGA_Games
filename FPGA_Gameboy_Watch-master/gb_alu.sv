/*

Module: Arithmetic Logic Unit for Gameboy/Gameboycolor CPU

100% complete and debugged




Author: Jason Rogers
Contact: jasonrogers@alumni.stanford.edu


LICENSE

Copyright (c) 2017 Jason Rogers

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

Attribution is given to the author(s) of the software where such attribution is 
convenient.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

*/

`define ALU_ADD 6'd0 
`define ALU_ADC 6'd1
`define ALU_SUB 6'd2
`define ALU_SBC 6'd3
`define ALU_OR 6'd4
`define ALU_XOR 6'd5
`define ALU_AND 6'd6
`define ALU_SET 6'd8
`define ALU_RST 6'd9
`define ALU_BIT 6'd10
`define ALU_SWAP 6'd11
`define ALU_RL 6'd12
`define ALU_RLC 6'd13
`define ALU_RR 6'd14
`define ALU_RRC 6'd15
`define ALU_SLA 6'd16
`define ALU_SRA 6'd17
`define ALU_SRL 6'd18
`define ALU_NOP 6'd19
`define ALU_SCF 6'd20
`define ALU_CCF 6'd21
`define ALU_DAA 6'd22

module gb_alu
//-----------------------------
(clock, a, b, r, c_in, op, znhc);
//-----------------------------


input clock;
input [7:0] a;
input [7:0] b;
output [7:0] r;
input c_in;
input [5:0] op;
output [3:0] znhc;

///temps to make carry easy to calc
reg [8:0] t1;
reg [4:0] t2;

reg [7:0] r;
reg [3:0] znhc;

//signals for DAA
reg [8:0] fixupa;
reg [8:0] daapos;
reg [8:0] fixupb;
reg [8:0] daaneg;
reg [8:0] daares;


always @(posedge clock)
begin

	case(op)
		`ALU_ADD: begin
			t1 = a + b;
			t2 = a[3:0] + b[3:0];
			r = t1[7:0];
			znhc[3:0] = {~|r,1'b0,t2[4],t1[8]};
		end
		`ALU_ADC: begin
			t1 = a + b + c_in;
			t2 = a[3:0] + b[3:0] + c_in;
			r = t1[7:0];
			znhc[3:0] = {~|r,1'b0,t2[4],t1[8]};
		end
		`ALU_SUB: begin
			t1 = a - b ;
			t2 = a[3:0] - b[3:0];
			r = t1[7:0];
			znhc[3:0] = {~|r,1'b1,t2[4],t1[8]};
		end
		`ALU_SBC: begin
		   t1 = a - b - c_in;
			t2 = a[3:0] - b[3:0] - c_in;
			r = t1[7:0];
			znhc[3:0] = {~|r,1'b1,t2[4],t1[8]};
		end
		`ALU_OR: begin
			r = a | b;
			znhc[3:0] = {~|r,1'b0,1'b0,1'b0};
		end
		`ALU_XOR: begin
			r = a ^ b;
			znhc[3:0] = {~|r,1'b0,1'b0,1'b0};
		end
		`ALU_AND: begin
			r = a & b;
			znhc[3:0] = {~|r,1'b0,1'b1,1'b0};
		end
		`ALU_SET: begin
			r = a | (1'b1<<b[2:0]);
			
		end
		`ALU_RST: begin
			r = a & ~(1'b1<<b[2:0]);
			
		end
		`ALU_BIT: begin
			r = a & (1'b1<<b[2:0]);
			znhc[3:1] = {~|r,1'b0,1'b1};
		end
		`ALU_SWAP: begin
			r = {a[3:0],a[7:4]};
			znhc[3:0] = {~|r,1'b0,1'b0,1'b0};
		end
		`ALU_RL: begin
			{znhc[0],r} = {a, c_in};
			znhc[3:1] = {~|r,1'b0,1'b0};
		end
		`ALU_RLC: begin
			{znhc[0],r} = {a, a[7]};
			znhc[3:1] = {~|r,1'b0,1'b0};
		end
		`ALU_RR: begin
		   {znhc[0],r} = {a[0], c_in, a[7:1]};
			znhc[3:1] = {~|r,1'b0,1'b0};
		end
		`ALU_RRC: begin
			{znhc[0],r} = {a[0], a[0], a[7:1]};
			znhc[3:1] = {~|r,1'b0,1'b0};
		end
		`ALU_SLA: begin
			{znhc[0],r} = {a, 1'b0};
			znhc[3:1] = {~|r,1'b0,1'b0};
		end
		`ALU_SRA: begin
			{znhc[0],r} = {a[0], a[7], a[7:1]};
			znhc[3:1] = {~|r,1'b0,1'b0};
		end
		`ALU_SRL: begin
			{znhc[0],r} = {a[0], 1'b0, a[7:1]};
			znhc[3:1] = {~|r,1'b0,1'b0};
		end
		`ALU_SCF: begin
			znhc[3:0] = {~|r,1'b0,1'b0,1'b1};
		end
		`ALU_CCF: begin
			znhc[3:0] = {~|r,1'b0,1'b0,znhc[0] ^ 1'b1};
		end
		`ALU_NOP:begin
		end
		`ALU_DAA:begin //DAA (stolen with permission from kevtris)
				fixupa = (b[5] | (a[3:0] > 4'd9)) ? ({1'b0, a} + 9'h06) : {1'b0, a};        // select acc or acc + 06h
				daapos = (b[4] | (fixupa[8:4] > 5'd09)) ? (fixupa + 9'h60) : fixupa;              // select above or above + 60h
				fixupb = (b[5]) ? {1'b0, (a - 8'h06)} : {1'b0, a};                            // select acc or acc - 06h
				daaneg = (b[4]) ? (fixupb - 9'h60) : fixupb;                                      // select above or above - 60h
				daares = (b[6]) ? daaneg : daapos;                                                 // select add or sub version
				
				r = daares[7:0];
				
				znhc[3:0] = {~|r, 1'b0, 1'b0, daares[8] | c_in};
				
		end
		
		default: begin
			r = 8'hFF;
			znhc[3:0] = {~|r,3'h0};
		end
		endcase
		
end


endmodule