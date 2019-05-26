/*

Module: Gameboy and Gameboy color CPU

100% complete and debugged.  Cycle accurate.  Sub cycle timing not verified (read/write signal generation)
however, it passes all of blarggs cpu timing tests.

Not as refactored or well formatted as it could be.


This CPU is similar to a Z80 but has many differences.




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

module gb_cpu 
//---------------------------------------
(rst, clock, addr_bus_out, data_bus_in, data_bus_out, we, re, PC, irq, cgb, initialized, gdma_happening, speed_double);

input rst;
input clock;
output [15:0] addr_bus_out;
input [7:0] data_bus_in;
output [7:0] data_bus_out;
output we;
output re;
output [15:0] PC;
input [7:0] irq;
input cgb;
output initialized;
input gdma_happening;
output speed_double;
	

reg [15:0] addr_bus_out;
reg [7:0] data_bus_out;

reg speed_double;
wire [7:0] irq;

wire cgb;

reg we;
reg re;

reg [15:0] addr_bus ;
reg [7:0] cpu_data_out ;
reg [7:0] cpu_data_in ;
reg cpu_we;


reg [7:0] A = 8'h11;
reg [7:0] B = 8'h00;
reg [7:0] D = 8'hFF;
reg [7:0] H = 8'h00;
reg [7:0] F = 8'h80;
reg [7:0] C = 8'h00;
reg [7:0] E = 8'h56;
reg [7:0] L = 8'h0D;
reg [15:0] SP = 16'hFFFE;
reg [15:0] PC = 16'h0100;

reg [7:0] temp_F;

reg [15:0] PC_minusone;
reg [15:0] PC_plusone;
reg [15:0] PC_jump;
reg [15:0] addr_latch;
reg jump;
reg extended_hl;

reg [15:0] HL_plusone;
reg [15:0] HL_minusone;
reg [15:0] SP_plusone;
reg [15:0] SP_minusone;

reg [7:0] opcode;
reg [7:0] opcode_ex;
reg [7:0] cycles;
reg [9:0] instr_count;

reg [7:0] alu_a;
reg [7:0] alu_b;
wire [7:0] alu_r;
reg [5:0] alu_op;
wire [3:0] alu_znhc;
reg alu_c_in;
reg [5:0] alu_op_dec;

reg IME;
reg IME_next;

reg halt;
reg stop;

	
//temp registers for computing carry
reg [15:0] add_16;
reg [16:0] add_17;
reg [12:0] add_13;

reg call;

gb_alu alu (clock, alu_a, alu_b, alu_r, F[4], alu_op, alu_znhc);


wire [7:0] zpage_data_out;



gb_zpage zpage(addr_bus[6:0],
	clock,
	data_bus_out,
	addr_bus[15:7] == 9'b111111111 ? cpu_we : 0,
	zpage_data_out);

//control wires to select registers for reading and writing
`define REG_SEL_B 4'd0
`define REG_SEL_C 4'd1
`define REG_SEL_D 4'd2
`define REG_SEL_E 4'd3
`define REG_SEL_H 4'd4
`define REG_SEL_L 4'd5
`define REG_SEL_NOP 4'd6
`define REG_SEL_A 4'd7

`define REG_SEL_BC 4'd0
`define REG_SEL_DE 4'd1
`define REG_SEL_HL 4'd2

reg [7:0] data_reg_out;

//registers
reg [7:0] Reg_init_ff50;
reg [7:0] Reg_IF_ff0f;
reg [7:0] Reg_IE_ffff;
//reg [7:0] Reg_DMA_ff46;
reg [7:0] Reg_speed_switch_ff4d;

reg [7:0] irq_old;
reg [7:0] pendingIRQ;
reg [7:0] processedIRQ;
reg [7:0] valid_irqs;
reg irq_begin;

reg [7:0] regIn;
reg [7:0] regOut;
reg [3:0] regInSel;
reg [3:0] regOutSel;
reg regWrite;

reg [15:0] regIn16;
reg [3:0] regInSel16;
reg regWrite16;

reg halt_bug;

reg initialized;

always @(posedge clock)
begin 

	if(rst) begin	
		A = 8'h11;
		B = 8'h00;
		D = 8'hFF;
		H = 8'h00;
		C = 8'h00;
		E = 8'h56;
		L = 8'h0D;
	end else begin
		
		initialized = |Reg_init_ff50;
		
		if(regWrite == 1)begin
			case (regInSel)
			`REG_SEL_A: A = regIn;
			`REG_SEL_B: B = regIn;
			`REG_SEL_D: D = regIn;
			`REG_SEL_H: H = regIn;
			`REG_SEL_C: C = regIn;
			`REG_SEL_E: E = regIn;
			`REG_SEL_L: L = regIn;
			default: begin end
			endcase
		end 
		if (regWrite16 == 1) begin  //todo: delete this 
			case (regInSel16)
			
			`REG_SEL_BC: {B,C} = regIn16;
			`REG_SEL_DE: {D,E} = regIn16;
			`REG_SEL_HL: {H,L} = regIn16;
			default: begin end
			endcase
		end
	end
end

always 
begin
	
	
	
	case (regOutSel)
	`REG_SEL_A: regOut = A;
	`REG_SEL_B: regOut = B;
	`REG_SEL_D: regOut = D;
	`REG_SEL_H: regOut = H;	
	`REG_SEL_C: regOut = C;
	`REG_SEL_E: regOut = E;
	`REG_SEL_L: regOut = L;
	default: regOut = 8'hFF;
	endcase
	
	

	casex (addr_bus)

		16'b111111111xxxxxxx: begin //zero page
			
			cpu_data_in = addr_bus[7:0] == 8'hFF ? Reg_IE_ffff : zpage_data_out;
		end
		
		16'b111111110xxxxxxx: begin //registers
			case (addr_bus[7:0])
				8'h50: cpu_data_in = Reg_init_ff50;
				8'h0F: cpu_data_in = Reg_IF_ff0f;
				8'h4d: cpu_data_in = {speed_double, 6'b0, Reg_speed_switch_ff4d[0]};
				default: cpu_data_in = data_bus_in;			
			endcase	
			
		end
		default:	begin 
	      cpu_data_in = data_bus_in;
		end
	endcase
	


	data_bus_out = cpu_data_out ;
	addr_bus_out = addr_bus;
	we =  cpu_we;

end


always @(posedge clock)
begin
	if(rst) begin
		Reg_init_ff50 = 0;
		Reg_IE_ffff = 0;
		Reg_IF_ff0f = 8'hE0;
		Reg_speed_switch_ff4d[0] = 0;
		irq_old = 0;
	end else begin
	
		if(cpu_we) begin
	
			casex (addr_bus)
				16'b11111111xxxxxxxx: begin
						case (addr_bus[7:0])
							8'h50: Reg_init_ff50 = cpu_data_out;
							8'h0F: Reg_IF_ff0f[4:0] = cpu_data_out[4:0] ;
							8'h4d: Reg_speed_switch_ff4d[0] = cpu_data_out[0];
							8'hFF: Reg_IE_ffff[4:0] = cpu_data_out[4:0];
							default: begin end
						endcase
					end 
			endcase
		end
	end

	PC_plusone = PC + 1'b1;
	PC_minusone = PC - 1'b1;
	HL_plusone = {H,L} + 1'b1;
	HL_minusone = {H,L} - 1'b1;
	SP_plusone = SP + 1'b1;
	SP_minusone = SP - 1'b1;
	
	Reg_IF_ff0f = (Reg_IF_ff0f & ~processedIRQ) | (irq & ~irq_old) ;
	valid_irqs = Reg_IF_ff0f & Reg_IE_ffff;
	
	irq_old = irq;
	
	
	if(rst == 1) begin
		opcode = 0;
		F = 8'h80;
		SP = 16'hFFFE;
		PC = 16'h0000;
		PC_plusone = 16'h0001;
		cycles = 2'h3;
		IME = 0;
		IME_next = 0;
		jump = 0;
		PC_jump = 0;
		halt = 0;
		stop = 0;
		extended_hl = 1'b0;
		irq_begin = 0;
		instr_count = 0;
		halt_bug = 0;
		cpu_we = 0;
		addr_bus = 0;
		
		speed_double = 0;
	end else if (gdma_happening && cycles == 3) begin
		//dont think I need to do anything here...stop on the third cycle
	end else if (stop | halt) begin
		stop = ~|Reg_IF_ff0f[4:0] ;
		halt = ~|valid_irqs;//~|Reg_IF_ff0f[4:0];
		
	end else	if(((|valid_irqs  & IME & (cycles == 0)) | irq_begin)) begin
		
		cycles = cycles == 8'd0 ? 8'd20: cycles;
		
		
		if (cycles == 20) begin
			SP = SP_minusone;
			addr_bus = SP;
			cpu_data_out = PC_minusone[15:8];
			cpu_we = 1;
			re = 0;
			irq_begin = 1;
		end else if (cycles == 19) begin
			cpu_we = 0;
		end else if (cycles == 18) begin
			SP = SP_minusone;
			addr_bus = SP;
			cpu_data_out = PC_minusone[7:0];
			cpu_we = 1;
		end else if (cycles == 17) begin
			cpu_we = 0;
		end else if (cycles == 8) begin
			cpu_we = 0;
			if(valid_irqs & 5'b00001) begin processedIRQ = 5'b00001; PC = 16'h0040; end
			else if(valid_irqs & 5'b00010) begin processedIRQ = 5'b00010; PC = 16'h0048; end
			else if(valid_irqs & 5'b00100) begin processedIRQ = 5'b00100; PC = 16'h0050; end
			else if(valid_irqs & 5'b01000) begin processedIRQ = 5'b01000; PC = 16'h0058; end
			else if(valid_irqs & 5'b10000) begin processedIRQ = 5'b10000; PC = 16'h0060; end
		end else if (cycles == 6) begin
			addr_bus = 16'hff0f;
			cpu_data_out = Reg_IF_ff0f & ~processedIRQ;
			cpu_we = 1;
		end else if (cycles == 5) begin
			processedIRQ = 0;
			cpu_we = 0;
		end else if (cycles == 3) begin
			IME = 0;
			IME_next = 0;
			addr_bus = PC;
			re = 1;
			PC = PC_plusone;
		end else if (cycles == 1) begin
			irq_begin = 0;
			re = 0;
			opcode  = cpu_data_in;
			regWrite = 0;
			regWrite16 = 0;
			jump = 0;
		end
		
		cycles = cycles - 8'd1;
	end else begin

		
		casex (cycles)
	
			2:	begin
				addr_bus = jump ? PC_jump : PC;
				re = 1;
				if(~halt_bug) begin
					PC = jump ? PC_jump + 1'b1: PC_plusone;
				end else begin
					halt_bug = 0;
				end
			end 
			1:	begin
				re = 0;
				IME = IME_next;
			end 
			0: begin
				re = 0;
				cpu_we = 1'b0;
				opcode  = cpu_data_in;
				regWrite = 0;
				regWrite16 = 0;
				jump = 0;
							
			end
		endcase	

		case (opcode)
			8'h00: begin  //nop
				cycles = cycles == 8'd0 ? 8'd4 : cycles;
			end
			8'h01, //ld bc, d16
			8'h11, //ld de, d16
			8'h21: //ld hl, d16
			begin 
				cycles = cycles == 8'd0 ? 8'd12 : cycles;
	
				if(cycles == 12)begin
					addr_bus = PC;
					PC = PC_plusone;
					re = 1;
				end else if (cycles == 11) begin
					re = 0;
				end else if (cycles == 10) begin
					regInSel = {opcode[5:4], 1'b1};
					regIn  = cpu_data_in;
					regWrite = 1;
					addr_bus = PC;
					PC = PC_plusone;
					re = 1;
				end else if (cycles == 8) begin
					regInSel = {opcode[5:4],1'b0};
					regIn  = cpu_data_in;
					regWrite = 1;
					re = 0;
				end 					
			end
			8'h31: //ld sp, d16
			begin 
				cycles = cycles == 8'd0 ? 8'd12 : cycles;
	
				if(cycles == 12)begin
					addr_bus = PC;
					PC = PC_plusone;
					re = 1;
				end else if (cycles == 11) begin
					re = 0;
				end else if (cycles == 10) begin
					SP[7:0]  = cpu_data_in;
					regWrite = 1;
					addr_bus = PC;
					PC = PC_plusone;
					re = 1;
				end else if (cycles == 8) begin
					SP[15:8]  = cpu_data_in;
					regWrite = 1;
					re = 0;
				end 						
			end
			8'h02: begin //ld (bc), a
				cycles = cycles == 8'd0 ? 8'd8 : cycles;
				
				if(cycles == 8) begin
					cpu_data_out = A;
					addr_bus = {B,C};
					cpu_we = 1;
				end else if (cycles == 6) begin
					cpu_we = 0;
				end
			end
			8'h12: begin //ld (de), a
				cycles = cycles == 8'd0 ? 8'd8 : cycles;
				
				if(cycles == 8) begin
					cpu_data_out = A;
					addr_bus = {D,E};
					cpu_we = 1;
				end else if (cycles == 6) begin
					cpu_we = 0;
				end
			end
			8'h22: begin //ld (hl+), a
				cycles = cycles == 8'd0 ? 8'd8 : cycles;
				
				if(cycles == 8'd8) begin
					cpu_data_out = A;
					addr_bus = {H,L};
					cpu_we = 1'b1;
				end else if (cycles == 8'd6) begin
					cpu_we = 0;
					regIn16 = HL_plusone;
					regInSel16 = `REG_SEL_HL;
					regWrite16 = 1'b1;
				end
			end
			8'h32: begin //ld (hl-), a
				cycles = cycles == 8'd0 ? 8'd8 : cycles;
				
				if(cycles == 8) begin
					cpu_data_out = A;
					addr_bus = {H,L};
					cpu_we = 1;
				end else if (cycles == 6) begin
					cpu_we = 0;
					regIn16 = HL_minusone;
					regInSel16 = `REG_SEL_HL;
					regWrite16 = 1;
				end
			end
			
			8'h0B,//dec BC
			8'h1B,//dec DE
			8'h2B,//dec HL
			8'h3B,//dec SP
			8'h03,//inc BC
			8'h13,//inc DE
			8'h23,//inc HL
			8'h33: begin //inc SP
				cycles = cycles == 8'd0 ? 8'd8 : cycles;
				
				if(cycles == 8) begin
					case(opcode[5:4])
						0: alu_a = C;
						1: alu_a = E;
						2: alu_a = L;
						3: alu_a = SP[7:0];
					endcase
					
					alu_b = 1'b1;
					alu_op = opcode[3] ? `ALU_SUB : `ALU_ADD;
					temp_F = F;
				end else if(cycles == 6) begin
					if(opcode[5:4] == 3) begin
						SP[7:0] = alu_r;
					end else begin
						regInSel = {opcode[5:4], 1'b1};
						regIn = alu_r;
						regWrite = 1;
					end 
					F[4] = alu_znhc[0];
					
					case(opcode[5:4])
						0: alu_a = B;
						1: alu_a = D;
						2: alu_a = H;
						3: alu_a = SP[15:8];
					endcase
					
					alu_b = 1'b0;
					alu_op =  opcode[3] ? `ALU_SBC :`ALU_ADC;

				 end else if(cycles == 4) begin
					if(opcode[5:4] == 3) begin
						SP[15:8] = alu_r;
					end else begin
						regInSel = {opcode[5:4], 1'b0};
						regIn = alu_r;
						regWrite = 1;
					end 
					F = temp_F;
				end
			end


			8'h04, //inc B
			8'h14, //inc D
			8'h24, //inc H
			8'h0C, //inc C
			8'h1C, //inc E
			8'h2C, //inc L
			8'h3C,  //inc A
			8'h05, //dec B
			8'h15, //dec D
			8'h25, //dec H 
			8'h0D, //dec C
			8'h1D, //dec E 
			8'h2D, //dec L 
			8'h3D: begin //dec A
		
				cycles = cycles == 8'd0 ? 8'd4 : cycles;
				
				if(cycles == 8'd4) begin
					case(opcode[5:3])
						0: alu_a = B;
						1: alu_a = C;
						2: alu_a = D;
						3: alu_a = E;
						4: alu_a = H;
						5: alu_a = L;
						6: alu_a = 8'h0;
						7: alu_a = A;
					endcase
					alu_b = 1;
					alu_op = opcode[0] ? `ALU_SUB : `ALU_ADD;
				end else if (cycles == 8'd2) begin
					regIn = alu_r;
					regInSel = opcode[5:3];
					regWrite = 1;
					F[7:5] = {alu_znhc[3],opcode[0],alu_znhc[1]};
				end
			end
			
			8'h06, //ld B, d8
			8'h16, //ld D, d8					
			8'h26, //ld H, d8					
			8'h0E, //ld C, d8
			8'h1E, //ld E, d8					
			8'h2E, //ld L, d8		
			8'h3E: begin //ld A, d8
				cycles = cycles == 8'd0 ? 8'd8 : cycles;
				
				if(cycles == 8) begin
					addr_bus = PC;
					PC = PC_plusone;
					re = 1;
				end else if (cycles == 6) begin
					regIn = cpu_data_in;
					regInSel = opcode[5:3];
					regWrite = 1;
					re = 0;
				end else if (cycles == 4) begin
					regWrite = 0;
				end
			end

			8'h0F, //RRCA
			8'h1F, //RRA
			8'h17, //RLA
			8'h07: begin //RLCA
				cycles = cycles == 8'd0 ? 8'd4 : cycles;
				
				if(cycles == 4) begin
					alu_a = A;
					case(opcode)
						8'h0F: alu_op = `ALU_RRC;//RRCA
						8'h1F: alu_op = `ALU_RR;//RRA
						8'h17: alu_op = `ALU_RL;//RLA
						8'h07: alu_op = `ALU_RLC;//RLCA
					endcase					
				end else if (cycles == 2) begin
					regInSel = `REG_SEL_A;	
					regIn = alu_r;
					regWrite = 1;
					F[7:4] = {3'b0,alu_znhc[0]};
				end
				
			end
				
			
			8'h0A,//ld A, (BC)
			8'h1A,//ld A, (DE)
			8'h2A,//ld A, (HL+)
			8'h3A: begin //ld A, (HL-)
				cycles = cycles == 8'd0 ? 8'd8 : cycles;
				
				if(cycles == 8) begin
					case (opcode[5:4])
						0: addr_bus = {B,C};
						1: addr_bus = {D,E};
						2,3: addr_bus = {H,L};
					endcase
					
					re = 1;
				end else if (cycles == 6) begin
					re = 0;
					regIn = cpu_data_in;
					regInSel = `REG_SEL_A;
					regWrite = 1'b1;
				end else if (cycles == 4) begin
					if(opcode[5]) begin
						regIn16 = opcode[4] ?  HL_minusone : HL_plusone;
						regInSel16 = `REG_SEL_HL;
						regWrite16 = 1'b1;
					end
				end 
			end
			
			//ld r1, r2 
			8'h40,8'h41,8'h42,8'h43,8'h44,8'h45,   8'h47,8'h48,8'h49,8'h4A,8'h4B,8'h4C,8'h4D,  8'h4F,
			8'h50,8'h51,8'h52,8'h53,8'h54,8'h55,   8'h57,8'h58,8'h59,8'h5A,8'h5B,8'h5C,8'h5D,  8'h5F,
			8'h60,8'h61,8'h62,8'h63,8'h64,8'h65,   8'h67,8'h68,8'h69,8'h6A,8'h6B,8'h6C,8'h6D,  8'h6F,
																		8'h78,8'h79,8'h7A,8'h7B,8'h7C,8'h7D,  8'h7F:
			begin
				cycles = cycles == 8'd0 ? 8'd4 : cycles;
				
				if(cycles == 4) begin
					regInSel = opcode[5:3];
					regOutSel = opcode[2:0];
					regWrite = 0;
				end else if (cycles == 3) begin
					regIn = regOut;
					regWrite = 1;
				end
			end
			
			//ld r1, (hl)
			8'h46, 8'h4E,
			8'h56, 8'h5E,
			8'h66, 8'h6E,
					 8'h7E: 
					 
			begin
				cycles = cycles == 8'd0 ? 8'd8 : cycles;
				
				if(cycles == 8) begin
					addr_bus = {H,L};
					re = 1;
				end else if (cycles == 6) begin
					regIn  = cpu_data_in;
					regInSel = opcode[5:3];
					regWrite = 1;
					re = 0;
				end
			end
			
			//ld (hl), r1
			8'h70, 8'h71, 8'h72,8'h73,8'h74,8'h75,   8'h77:
			begin
				cycles = cycles == 8'd0 ? 8'd8 : cycles;
				
				if(cycles == 8) begin
					addr_bus = {H,L};
					regOutSel = opcode[2:0];
				end else if (cycles == 6) begin
					cpu_data_out = regOut;
					cpu_we = 1;
				end else if (cycles == 4) begin
					cpu_we = 0;
				end
			end
			
			8'h80, 8'h81, 8'h82,8'h83,8'h84,8'h85,   8'h87, //add a,r1
			8'h88, 8'h89, 8'h8A,8'h8B,8'h8C,8'h8D,   8'h8F, //adc a, r1 
			8'h90, 8'h91, 8'h92,8'h93,8'h94,8'h95,   8'h97, //sub a,r1
			8'h98, 8'h99, 8'h9A,8'h9B,8'h9C,8'h9D,   8'h9F, //sbc a, r1 
			8'hA0, 8'hA1, 8'hA2,8'hA3,8'hA4,8'hA5,   8'hA7, //and a,r1
			8'hA8, 8'hA9, 8'hAA,8'hAB,8'hAC,8'hAD,   8'hAF, //xor a, r1 
			8'hB0, 8'hB1, 8'hB2,8'hB3,8'hB4,8'hB5,   8'hB7, //or a,r1
			8'hB8, 8'hB9, 8'hBA,8'hBB,8'hBC,8'hBD,   8'hBF: //cp a, r1 
			begin
				cycles = cycles == 8'd0 ? 8'd4 : cycles;
				
				if(cycles == 4) begin
					alu_a = A;
					case(opcode[2:0])
						0: alu_b = B;
						1: alu_b = C;
						2: alu_b = D;
						3: alu_b = E;
						4: alu_b = H;
						5: alu_b = L;
						6: alu_b = 8'h0;
						7: alu_b = A;
					endcase
					case (opcode[5:3])
						0: alu_op = `ALU_ADD;
						1: alu_op = `ALU_ADC;
						2: alu_op = `ALU_SUB;
						3: alu_op = `ALU_SBC;
						4: alu_op = `ALU_AND;
						5: alu_op = `ALU_XOR;
						6: alu_op = `ALU_OR;
						7: alu_op = `ALU_SUB;
					endcase	
					
				end else if (cycles == 2) begin
					regInSel = `REG_SEL_A;
					regIn = alu_r;
					regWrite = opcode[5:3] != 7;
					F[7:4] = alu_znhc;
				end
			end
			
			8'h86, //add a,(HL)
			8'h8E, //adc a, (HL) 
			8'h96, //sub a,(HL)
			8'h9E, //sbc a, (HL) 
			8'hA6, //and a,(HL)
			8'hAE, //xor a, (HL) 
			8'hB6, //or a,(HL)
			8'hBE: //cp a, (HL) 
			begin
				cycles = cycles == 8'd0 ? 8'd8 : cycles;
				
				if(cycles == 8) begin
					addr_bus = {H,L};
					re = 1;
				end else if(cycles == 6) begin
					re = 0;
					alu_a = A;
					alu_b  = cpu_data_in;
					//todo makes these line up so the demux isnt necessary
					case (opcode[5:3])
						0: alu_op = `ALU_ADD;
						1: alu_op = `ALU_ADC;
						2: alu_op = `ALU_SUB;
						3: alu_op = `ALU_SBC;
						4: alu_op = `ALU_AND;
						5: alu_op = `ALU_XOR;
						6: alu_op = `ALU_OR;
						7: alu_op = `ALU_SUB;
					endcase
					
				end else if (cycles == 4) begin
					regInSel = `REG_SEL_A;
					regIn = alu_r;
					regWrite = opcode[5:3] != 7;
					F[7:4] = alu_znhc ;
				end
			end	
			
			8'hC6, //add a,d8
			8'hCE, //adc a, d8 
			8'hD6, //sub a,d8
			8'hDE, //sbc a, d8 
			8'hE6, //and a,d8
			8'hEE, //xor a, d8 
			8'hF6, //or a,d8
			8'hFE: //cp a, d8 
			begin
				cycles = cycles == 8'd0 ? 8'd8 : cycles;
				
				if(cycles == 8) begin
					addr_bus = PC;
					PC = PC_plusone;
					re = 1;
				end else if(cycles == 6) begin
					re = 0;
					alu_a = A;
					alu_b  = cpu_data_in;
					case (opcode[5:3])
						0: alu_op = `ALU_ADD;
						1: alu_op = `ALU_ADC;
						2: alu_op = `ALU_SUB;
						3: alu_op = `ALU_SBC;
						4: alu_op = `ALU_AND;
						5: alu_op = `ALU_XOR;
						6: alu_op = `ALU_OR;
						7: alu_op = `ALU_SUB;
					endcase					
				end else if (cycles == 4) begin
					regInSel = `REG_SEL_A;
					regIn = alu_r;
					regWrite = opcode[5:3] != 7;
					F[7:4] = alu_znhc ;
					
				end
			end	
			
			8'h18, //jr r8
			8'h20, //jr nz r8
			8'h28, //jr z r8			
			8'h30, //jr nc r8
			8'h38: //jr c r8
			begin
				jump = (opcode[7:4] == 4'h1) | 
						((opcode[7:4] == 4'h2) & (F[7] == opcode[3])) | 
						((opcode[7:4] == 4'h3) & (F[4] == opcode[3]));
				
				cycles = cycles == 8'd0 ? (jump ? 8'd12 : 8'd8) : cycles;
				
				if(cycles == 8) begin
					addr_bus = PC;
					PC = PC_plusone;
					re = 1;
				end else if (cycles == 6) begin
					re = 0;
					if(jump) begin
						PC_jump = PC  + {{8{cpu_data_in[7]}}, cpu_data_in};
					end
				end
				
			end
			
			8'hC7,8'hD7,8'hE7,8'hF7,8'hCF,8'hDF,8'hEF,8'hFF: //RST
			begin
				cycles = cycles == 8'd0 ? 8'd16 : cycles;
				
				if(cycles == 16) begin
					SP = SP_minusone;
					addr_bus = SP;
					cpu_data_out = PC[15:8];
					cpu_we = 1;
				end else if (cycles == 15) begin
					cpu_we = 0;
				end else if (cycles == 14) begin
					SP = SP_minusone;
					addr_bus = SP;
					cpu_data_out = PC[7:0];
					cpu_we = 1;
				end else if (cycles == 12) begin
					PC_jump = {8'b0, opcode[5:3], 3'b0};
					jump = 1;
					re = 0;
					cpu_we = 0;
				end
			end
			
			8'hC5, 8'hD5, 8'hE5, 8'hF5: //push
			begin
				cycles = cycles == 8'd0 ? 8'd16 : cycles;
				
				if(cycles == 16) begin
					SP = SP_minusone;
					addr_bus = SP;
					case(opcode[5:4])
						0: cpu_data_out = B;
						1: cpu_data_out = D;
						2: cpu_data_out = H;
						3: cpu_data_out = A;
					endcase
					cpu_we = 1;
				end else if(cycles == 15) begin	
				   cpu_we = 0;
				end else if(cycles == 8) begin
					SP = SP_minusone;
					addr_bus = SP;
					case(opcode[5:4])
						0: cpu_data_out = C;
						1: cpu_data_out = E;
						2: cpu_data_out = L;
						3: cpu_data_out = F;
					endcase
					cpu_we = 1;
					
				end else if (cycles == 6) begin
					cpu_we = 0;
				end
			end
			
			
			8'hC1, 8'hD1, 8'hE1, 8'hF1: //pop
			begin
				cycles = cycles == 8'd0 ? 8'd12 : cycles;
				
				if(cycles == 12) begin
					addr_bus = SP;
					SP = SP_plusone;
					re = 1;
				end else if (cycles == 11) begin
					re = 0;	
				end else if(cycles == 10) begin
					addr_bus = SP;
					SP = SP_plusone;
					re = 1;
					
					case(opcode[5:4])
						0: regInSel = `REG_SEL_C;
						1: regInSel = `REG_SEL_E;
						2: regInSel = `REG_SEL_L;
						3: begin
							regInSel = `REG_SEL_NOP;
							F[7:4]  = cpu_data_in[7:4];
						end
					endcase
					regIn  = cpu_data_in;
					regWrite = 1;	
					
				end else if (cycles == 8) begin
					case(opcode[5:4])
						0: regInSel = `REG_SEL_B;
						1: regInSel = `REG_SEL_D;
						2: regInSel = `REG_SEL_H;
						3: regInSel = `REG_SEL_A;
					endcase
					regIn  = cpu_data_in;
					regWrite = 1;	
					re = 0;
				end
			end
			
			8'hC4, 8'hD4, 8'hCC, 8'hDC, 8'hCD: //call
			begin
			
				case (opcode)
					8'hC4, 8'HCC: call = F[7] == opcode[3];
					8'hD4, 8'hDC: call = F[4] == opcode[3];
					8'hCD: call = 1;
				endcase
		
				cycles = cycles == 8'd0 ? 8'd24 : cycles;
				
				if (cycles == 24) begin
					addr_bus = PC;
					PC = PC_plusone;
					re = 1;	
				end else if (cycles == 23) begin
					re = 0;
				end else if (cycles == 22) begin
					addr_latch[7:0]  = cpu_data_in;
					addr_bus = PC;
					PC = PC_plusone;
					re = 1;
				end else if (cycles == 20) begin
					addr_latch[15:8]  = cpu_data_in;
					re = 0;
				end else if (cycles == 15) begin
					cycles = call ? cycles : 8'd3;
				end else if (cycles == 10) begin
					SP = SP_minusone;
					addr_bus = SP;
					cpu_data_out = PC[15:8];
					cpu_we = 1;
				end else if (cycles == 9) begin
					
					cpu_we = 0;
					
				end else if (cycles == 8) begin
					SP = SP_minusone;
					addr_bus = SP;
					cpu_data_out = PC[7:0];
					cpu_we = 1;
					
				end else if (cycles == 7) begin
					cpu_we = 0;
			
				end else if (cycles == 4) begin
					PC_jump = call ? addr_latch : PC;
					jump = call;
				end
			end
			
			8'hC0, 8'hD0, 8'hC8, 8'hD8, 8'hC9: //RET
			begin
				
				case (opcode)
					8'hC0, 8'hC8: call = F[7] == opcode[3];
					8'hD0, 8'hD8: call = F[4] == opcode[3];
					8'hC9: call = 1;
				endcase
			
				
				cycles = cycles == 8'd0 ? (opcode == 8'hC9 ? 8'd16 : (call ? 8'd20 : 8'd8)) : cycles;
				
				if (cycles == 16) begin
					addr_bus = SP;
					SP = SP_plusone;
					re = 1;
				end else if (cycles == 15) begin
					re = 0;
				end else if (cycles == 14) begin
					addr_latch[7:0]  = cpu_data_in;
					addr_bus = SP;
					SP = SP_plusone;
					re = 1;
				end else if (cycles == 10) begin
					addr_latch[15:8]  = cpu_data_in;
					re = 0;
					cycles = call ? cycles : 8'd4;
				end else if (cycles == 8) begin
					PC_jump = call ? addr_latch : PC;
					jump = call;
				end
			end
			
			8'hC2, 8'hD2, 8'hC3, 8'hCA, 8'hDA: //jp flag, a16
			begin
	
				case (opcode)
					8'hC2, 8'hCA: call = F[7] == opcode[3];
					8'hD2, 8'hDA: call = F[4] == opcode[3];
					8'hC3: call = 1;
				endcase
				
				cycles = cycles == 8'd0 ? (call ? 8'd16 : 8'd12) : cycles;
				
				if (cycles == 12) begin
					addr_bus = PC;
					PC=PC_plusone;
					re = 1;
				end else if (cycles == 11) begin
					re = 0;
				end else if (cycles == 10) begin
					addr_latch[7:0]  = cpu_data_in;
					addr_bus = PC;
					PC=PC_plusone;
					re = 1;
				end else if (cycles == 8) begin
					addr_latch[15:8]  = cpu_data_in;
					re = 0;
				end else if (cycles == 6) begin
					PC_jump = call ? addr_latch : PC;
					jump = call;
				end
				
			end
			
			8'hF0: //ldh  A, (a8)
			begin
				cycles = cycles == 8'd0 ? 8'd12 : cycles;
				
				if(cycles == 12) begin
					addr_bus = PC;
					PC = PC_plusone;
					re = 1;
				end else if (cycles == 11) begin
					re = 0;
				end else if (cycles == 8) begin
					addr_bus = {8'hFF, cpu_data_in};
					re = 1;
				end else if (cycles == 6) begin
					re = 0;
					regIn  = cpu_data_in;
					regInSel = `REG_SEL_A;
					regWrite = 1;
				end
			
			end
			
			8'hE0: //ldh (a8), A 
			begin
				cycles = cycles == 8'd0 ? 8'd12 : cycles;
				
				if(cycles == 12) begin
					addr_bus = PC;
					PC = PC_plusone;
					re = 1;
				end else if (cycles == 8) begin
					
					addr_bus = {8'hFF, cpu_data_in};
					cpu_data_out = A;
					cpu_we = 1;
					re = 0;
				end else if (cycles == 7) begin
					cpu_we = 0;
				end				
			end
		8'hF2: //ldh A, (c)
			begin
				cycles = cycles == 8'd0 ? 8'd8 : cycles;
				
				if (cycles == 6) begin
					addr_bus = {8'hFF, C};
					re = 1;
				end else if (cycles == 4) begin
					re = 0;
					regIn  = cpu_data_in;
					regInSel = `REG_SEL_A;
					regWrite = 1;
				end
			
			end	
		8'hE2: //ldh (c), A
			begin
				cycles = cycles == 8'd0 ? 8'd8 : cycles;
				
				if (cycles == 8) begin
					addr_bus = {8'hFF, C};
					cpu_data_out = A;
					cpu_we = 1;
				end else if (cycles == 7) begin
					cpu_we = 0;
				end 				
			end	
			
		8'hEA: //ldh (a16), A
			begin
				cycles = cycles == 8'd0 ? 8'd16 : cycles;
				
				if(cycles == 16) begin
					addr_bus = PC;
					PC = PC_plusone;
					re = 1;
				end else if (cycles == 15) begin
					re = 0;
				end else if (cycles == 12) begin
					addr_latch[7:0] = {cpu_data_in};
					addr_bus = PC;
					PC = PC_plusone;
					re = 1;
				end else if (cycles == 10) begin
					re = 0;
					addr_latch[15:8]  = cpu_data_in;
				end else if (cycles == 8) begin
					cpu_data_out = A;
					addr_bus = addr_latch;
					cpu_we = 1;
				end else if (cycles == 7) begin
					cpu_we = 0;
				end
			
			end
			
		8'hFA: //ldh A, (a16)
			begin
				cycles = cycles == 8'd0 ? 8'd16 : cycles;
				
				if(cycles == 16) begin
					addr_bus = PC;
					PC = PC_plusone;
					re = 1;
				end else if (cycles == 15) begin
					re = 0;
				end else if (cycles == 12) begin
					addr_latch[7:0] = {cpu_data_in};
					addr_bus = PC;
					PC = PC_plusone;
					re = 1;
				end else if (cycles == 10) begin
					re = 0;
					addr_latch[15:8]  = cpu_data_in;
				end else if (cycles == 6) begin
					cpu_data_out = A;
					addr_bus = addr_latch;
					re = 1;
				end else if (cycles == 4) begin
					re = 0;
					regIn  = cpu_data_in;
					regInSel = `REG_SEL_A;
					regWrite = 1;
				end
			end	
			
		8'h08: //ldh (a16), SP
			begin
				cycles = cycles == 8'd0 ? 8'd20 : cycles;
				
				if(cycles == 20) begin
					addr_bus = PC;
					PC = PC_plusone;
					re = 1;
				end else if (cycles == 19) begin
					re = 0;
				end else if (cycles == 18) begin
					addr_latch[7:0] = {cpu_data_in};
					addr_bus = PC;
					PC = PC_plusone;
					re = 1;
				end else if (cycles == 16) begin
					re = 0;
					addr_latch[15:8]  = cpu_data_in;
				end else if (cycles == 14) begin
					cpu_data_out = SP[7:0];
					addr_bus = addr_latch;
					addr_latch = addr_latch + 1'b1;
				end else if (cycles == 13) begin
					cpu_we = 1;
				end else if (cycles == 12) begin	
				   cpu_we = 0;
				end else if (cycles == 11) begin
					cpu_data_out = SP[15:8];
					addr_bus = addr_latch;
				end else if (cycles == 10) begin
					cpu_we = 1;
				end else if (cycles == 9) begin
					cpu_we = 0;
				end
			
			end
			
		8'h09,8'h19,8'h29,8'h39: //add HL, nn
		begin
			cycles = cycles == 8'd0 ? 8'd8 : cycles;
			
					if(cycles == 8) begin
					case(opcode[5:4])
						0: alu_a = C;
						1: alu_a = E;
						2: alu_a = L;
						3: alu_a = SP[7:0];
					endcase
					
					alu_b = L;
					alu_op = `ALU_ADD;
		
				end else if(cycles == 6) begin
					regInSel = `REG_SEL_L;
					regIn = alu_r;
					regWrite = 1;
					 
					F[4] = alu_znhc[0];
					
					case(opcode[5:4])
						0: alu_a = B;
						1: alu_a = D;
						2: alu_a = H;
						3: alu_a = SP[15:8];
					endcase
					
					alu_b = H;
					alu_op = `ALU_ADC;

				 end else if(cycles == 4) begin
					
					regInSel = `REG_SEL_H;;
					regIn = alu_r;
					regWrite = 1;
					
					F[6:4] = {1'b0,alu_znhc[1:0]};
				end
			end
			

	
	
		8'hFB, 8'hF3: //di
		begin
			cycles = cycles == 8'd0 ? 8'd4 : cycles;
			
			if(cycles == 4) begin
				IME_next = opcode[3];
			end
		end
		
		8'h34, 8'h35: //inc (HL), dec (HL)
		begin
			cycles = cycles == 8'd0 ? 8'd12 : cycles;
			
			if(cycles == 12) begin
				addr_bus = {H,L};
				re = 1;
			end else if (cycles == 10) begin
				alu_a  = cpu_data_in;
				alu_b = 1'b1;
				alu_op = opcode[0] ? `ALU_SUB : `ALU_ADD;
				re = 0;
			end else if (cycles == 8) begin
				cpu_data_out = alu_r;
				F[7:5] = alu_znhc[3:1];
				addr_bus = {H,L};
				cpu_we = 1;
			end else if (cycles == 7) begin
				cpu_we = 0;
			end
		end
		
		8'h36: //ld (HL), d8
		begin
			cycles = cycles == 8'd0 ? 8'd12 : cycles;
			
			if(cycles == 12) begin
				addr_bus = PC;
				PC = PC_plusone;
				re = 1;	
			end else if (cycles == 8) begin
				re = 0;
				cpu_data_out  = cpu_data_in;
				addr_bus = {H,L};
				cpu_we = 1;
			end else if (cycles == 7) begin
				cpu_we = 0;
			end 
		end
		
		8'h37:// scf
		begin
			cycles = cycles == 8'd0 ? 8'd4 : cycles;
			
			if(cycles == 4) begin
				F[6:4] = {1'b0,1'b0, 1'b1};	
				alu_op = `ALU_SCF;
			end
		end
		
		8'h3F:// ccf
		begin
			cycles = cycles == 8'd0 ? 8'd4 : cycles;
			
			if(cycles == 4) begin
				F[6:4] = {1'b0,1'b0, F[4] ^ 1'b1};	
				alu_op = `ALU_CCF;
			end else if(cycles == 3) begin
				alu_op = `ALU_NOP;
			end
		end
		8'h2F:// cpl
		begin
			cycles = cycles == 8'd0 ? 8'd4 : cycles;
			
			if(cycles == 4) begin
				regIn = A ^ 8'hFF;
				regInSel = `REG_SEL_A;
				regWrite = 1;
				F[6:5] = 2'b11;
			end
		end
		
		8'hE9: //jp (HL)
		begin
			cycles = cycles == 8'd0 ? 8'd4 : cycles;
			
			if(cycles == 4) begin
				PC_jump = {H,L};
				jump = 1;
			end
		end
		
		8'hF9: //ld SP,HL
		begin
			cycles = cycles == 8'd0 ? 8'd8 : cycles;
			
			if(cycles == 8) begin
				SP = {H,L};	
			end
		end
		
		8'hF8: //ld HL, SP + r8   
		begin
			cycles = cycles == 8'd0 ? 8'd12 : cycles;
			
			if(cycles == 12) begin
				addr_bus = PC;
				PC = PC_plusone;
				re = 1;
			end else if (cycles == 10) begin
				alu_a = SP[7:0];
				alu_b  = cpu_data_in;
				alu_op = `ALU_ADD;
				re = 0;
			end else if (cycles == 8) begin
				alu_a = SP[15:8];
				alu_b = {8{cpu_data_in[7]}};
				regInSel = `REG_SEL_L;
				regIn = alu_r;
				regWrite = 1'b1;
				F[7:4] = {1'b0, 1'b0, alu_znhc[1], alu_znhc[0]};
				alu_op = `ALU_ADC;
			end else if (cycles == 7) begin
				regWrite = 1'b0;
			end else if (cycles == 6) begin
				regInSel = `REG_SEL_H;
				regIn = alu_r;
				regWrite = 1'b1;
			//	F[7:4] = {1'b0, 1'b0, alu_znhc[1], alu_znhc[0]};
			end
		end
		
		8'hE8: //ADD SP, r8  
		begin
			cycles = cycles == 8'd0 ? 8'd16 : cycles;
			
			if(cycles == 12) begin
				addr_bus = PC;
				PC = PC_plusone;
				re = 1;
			end else if (cycles == 10) begin
				alu_a = SP[7:0];
				alu_b  = cpu_data_in;
				alu_op = `ALU_ADD;
				re = 0;
			end else if (cycles == 8) begin
				SP[7:0] = alu_r;
				alu_a = SP[15:8];
				alu_b = {8{cpu_data_in[7]}};
				F[7:4] = {1'b0, 1'b0, alu_znhc[1], alu_znhc[0]};
				alu_op = `ALU_ADC;
			end else if (cycles == 6) begin
				SP[15:8] = alu_r;
			//	F[7:4] = {1'b0, 1'b0, alu_znhc[1], alu_znhc[0]};
			end
		end
		
		8'hD9: //reti
		begin
			cycles = cycles == 8'd0 ? 8'd16 : cycles;
			
			if(cycles == 16) begin
				addr_bus = SP;
				SP = SP_plusone;
				re = 1;
			end else if (cycles == 15) begin
					re = 0;
			end else if(cycles == 14) begin
				addr_latch[7:0]  = cpu_data_in;
				addr_bus = SP;
				SP = SP_plusone;
				re = 1;
			end else if (cycles == 8) begin
				addr_latch[15:8]  = cpu_data_in;
				re = 0;
			end else if (cycles == 4) begin
				IME_next = 1;
				PC_jump = addr_latch;
				jump = 1;
			end
		end
		
		8'h27: //daa
		begin
			cycles = cycles == 8'd0 ? 8'd4 : cycles;
			
			if(cycles == 4) begin
				alu_a = A;
				alu_b = F;
				alu_op = `ALU_DAA;
			end else if(cycles == 2) begin
				regIn = alu_r;
				regInSel = `REG_SEL_A;
				regWrite = 1;
				
				F[7:4] = {alu_znhc[3], F[6], alu_znhc[1:0]};
			end
		end
		
		8'h76: //halt
		begin
			cycles = cycles == 8'd0 ? (IME ? 8'd8: 8'd4) : cycles;
			
			if(cycles == (IME ? 8'd8: 8'd4)) begin
				halt = IME | ~|valid_irqs;
				halt_bug = |valid_irqs & ~IME;
		
   		end
			
			
		end
		
		8'h10: //stop
		begin
			cycles = cycles == 8'd0 ? 8'd4 : cycles;
			
			if(cycles == 4) begin
				if(Reg_speed_switch_ff4d[0]) begin
					speed_double = speed_double ^ 1'b1;
					Reg_speed_switch_ff4d[0] = 1'b0;
				end else begin				
					stop = 1;
				end
			end
		end
		
		8'hCB: //prefex opcodes
		begin
			cycles = cycles == 8'd0 ? 8'd16 : cycles;
			
			if(cycles == 16) begin
				addr_bus = PC;
				PC = PC_plusone;
				re = 1;	
			end else if (cycles == 15) begin
					re = 0;				
			end else if(cycles == 14) begin
				opcode_ex  = cpu_data_in;
				
				casex (opcode_ex)
					8'b00000xxx: alu_op = `ALU_RLC;
					8'b00001xxx: alu_op = `ALU_RRC;
					8'b00010xxx: alu_op = `ALU_RL;
					8'b00011xxx: alu_op = `ALU_RR;
					8'b00100xxx: alu_op = `ALU_SLA;
					8'b00101xxx: alu_op = `ALU_SRA;
					8'b00110xxx: alu_op = `ALU_SWAP;
					8'b00111xxx: alu_op = `ALU_SRL;
					8'b01xxxxxx: alu_op = `ALU_BIT;
					8'b10xxxxxx: alu_op = `ALU_RST;
					8'b11xxxxxx: alu_op = `ALU_SET;
				endcase

				case(opcode_ex[2:0])
					0: alu_a = B;
					1: alu_a = C;
					2: alu_a = D;
					3: alu_a = E;
					4: alu_a = H;
					5: alu_a = L;
					6: extended_hl = 1'b1;
					7: alu_a = A;
				endcase
				
				alu_b = opcode_ex[5:3];
				
			end else if (cycles == 12) begin
				
				if (extended_hl == 0) begin
					regInSel = opcode_ex[2:0];
					regIn = alu_r;
					regWrite = alu_op == `ALU_BIT ? 1'b0 : 1'b1;
					if(alu_op != `ALU_RST && alu_op != `ALU_SET) begin
						F[7:4] = {alu_znhc[3:1], alu_op == `ALU_BIT ? F[4] : alu_znhc[0]};
					end
					cycles = 4'd4;
				end else begin
					addr_bus = {H,L};
					re = 1;
					
				end
			
			end else if (cycles == 10) begin
				alu_a = cpu_data_in;
				re = 0;
			end else if (cycles == 8) begin
				if(alu_op != `ALU_RST && alu_op != `ALU_SET) begin
					F[7:4] = {alu_znhc[3:1], alu_op == `ALU_BIT ? F[4] : alu_znhc[0]};
				end
				if (alu_op != `ALU_BIT ) begin
					addr_bus = {H,L};
					cpu_data_out = alu_r;
					cpu_we = 1;
				end else begin
					cycles = 4'd4;
				end
			end else if (cycles == 7) begin
				cpu_we = 0;
			end else if (cycles == 2) begin
				extended_hl = 1'b0;
			end
		end
		
		8'hf4: begin //custom instruction to dump to signal tap
			cycles = cycles == 0 ? 8'd8 : cycles;
			
			if(cycles == 8) begin
				addr_bus = PC;
				PC = PC_plusone;
				re = 1;	
			end if (cycles == 6) begin
				re = 0;
				instr_count = cpu_data_in;
			end
		end
		default: begin
			cycles = cycles == 0 ? 4'd4 : cycles;
		end
		endcase
		
		cycles = cycles - 1'b1;
		
				
		instr_count = cycles == 0 && instr_count != 0 ? instr_count - 1'b1 : instr_count;
	end
	
end

endmodule