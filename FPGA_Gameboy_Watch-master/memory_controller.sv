/*

Module: Memory controller

Handles bus translation for the mappers.  80% complete (supports most roms)  


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


module gb_memory_controller
//---------------------------------------
(
input rst,
input clock,
input [15:0] addr_bus,
input [7:0] data_in,
output reg [7:0] data_out,
input we,
input rd,
input cgb,
input initialized,

output reg unloaded,
output reg gb_rom,
input [27:0] uart_addr,
input [7:0] uart_data_in,
input uart_we,
input uart_load
);




//---------------------------------------
//
//   Registers
//
//---------------------------------------
reg [7:0] rom_size;
reg [7:0] ram_size;
reg [7:0] mbc_type;

reg done_load;

reg ram_enabled;
reg [23:0] decoded_addr_bus;


//---------------------------------------
//
//   Memory 
//
//---------------------------------------
reg [23:0] rom_addr_bus;
wire [7:0] rom_data_out;
reg rom_we;

wire [7:0] bios_data_out;
wire [7:0] jbios_data_out;

reg [12:0] wram_addr_bus;
reg [7:0] wram_data_in;
wire [7:0] wram_data_out;
reg [2:0] wram_bank_sel;
reg wram_we;

reg [15:0] cart_ram_addr_bus;
reg [7:0] cart_ram_data_in;
wire [7:0] cart_ram_data_out;
reg cart_ram_we;


//=======================================================
//  Rams...lots of rams
//=======================================================
	
gb_work_ram wram({2'b0,wram_addr_bus} | {wram_bank_sel & {wram_addr_bus[12],wram_addr_bus[12],wram_addr_bus[12]}, 11'b0},
	clock,
	wram_data_in,
	wram_we,
	wram_data_out);
	
gb_rom rom((uart_load && (uart_addr[27:24] == 4'h0)) ? uart_addr[23:0] : rom_addr_bus,
	clock,
	(uart_load && (uart_addr[27:24] == 4'h0))  ? uart_data_in : data_in,
	(uart_load && (uart_addr[27:24] == 4'h0))  ? uart_we : rom_we,
	rom_data_out);
	
gb_bios bios((uart_load && uart_addr[27:24] == 4'h1) ? uart_addr[23:0] : rom_addr_bus[12:0],
	clock,
	(uart_load && (uart_addr[27:24] == 4'h1)) ? uart_data_in : 8'h00,
	(uart_load && (uart_addr[27:24] == 4'h1)) ? uart_we : 1'b0,
	bios_data_out);
	
jbios jbios((uart_load && (uart_addr[27:24] == 4'h2)) ? uart_addr[23:0] : rom_addr_bus[12:0],
	clock,
	(uart_load && (uart_addr[27:24] == 4'h2)) ? uart_data_in : 8'h00,
	(uart_load && (uart_addr[27:24] == 4'h2)) ? uart_we : 1'b0,
	jbios_data_out);

gb_cart_ram cart(cart_ram_addr_bus,
	clock,
	cart_ram_data_in,
	cart_ram_we,
	cart_ram_data_out);	



//---------------------------------------
//
//   MBCs
//
//---------------------------------------	
reg [15:0] mbc_addr_bus_in;

//---------------------------------------
//
//   MBC5
//
//---------------------------------------

wire [7:0] mbc5_data_out;
wire mbc5_ram_enabled;
wire [23:0] mbc5_decoded_addr;
reg mbc5_we;


gb_mbc5 mbc5(.rst(rst), 
.clock(clock), 
.addr_bus_in(mbc_addr_bus_in), 
.addr_bus_out(mbc5_decoded_addr), 
.data_in(data_in), 
.data_out(mbc5_data_out), 
.we_in(mbc5_we), 
.ram_enabled(mbc5_ram_enabled), 
.rom_size(rom_size), 
.ram_size(ram_size), 
.cgb(cgb));

//---------------------------------------
//
//   MBC2
//
//---------------------------------------

wire [7:0] mbc2_data_out;
wire mbc2_ram_enabled;
wire [23:0] mbc2_decoded_addr;
reg mbc2_we;

reg [15:0] mbc2_addr_bus_in;

gb_mbc2 mbc2(.rst(rst), 
.clock(clock), 
.addr_bus_in(mbc_addr_bus_in), 
.addr_bus_out(mbc2_decoded_addr), 
.data_in(data_in), 
.data_out(mbc2_data_out), 
.we_in(mbc2_we), 
.ram_enabled(mbc2_ram_enabled), 
.rom_size(rom_size), 
.ram_size(ram_size), 
.cgb(cgb));
	
//---------------------------------------
//
//   MBC1
//
//---------------------------------------

wire [7:0] mbc1_data_out;
wire mbc1_ram_enabled;
wire [23:0] mbc1_decoded_addr;
reg mbc1_we;

reg [15:0] mbc1_addr_bus_in;

gb_mbc1 mbc1(.rst(rst), 
.clock(clock), 
.addr_bus_in(mbc_addr_bus_in), 
.addr_bus_out(mbc1_decoded_addr), 
.data_in(data_in), 
.data_out(mbc1_data_out), 
.we_in(mbc1_we), 
.ram_enabled(mbc1_ram_enabled), 
.rom_size(rom_size), 
.ram_size(ram_size), 
.cgb(cgb));


//---------------------------------------
//
//   MBC0
//
//---------------------------------------

wire [7:0] mbc0_data_out;
wire mbc0_ram_enabled;
wire [23:0] mbc0_decoded_addr;
reg mbc0_we;



gb_mbc0 mbc0(.rst(rst), 
.clock(clock), 
.addr_bus_in(mbc_addr_bus_in), 
.addr_bus_out(mbc0_decoded_addr), 
.data_in(data_in), 
.data_out(mbc0_data_out), 
.we_in(mbc0_we), 
.ram_enabled(mbc0_ram_enabled), 
.rom_size(rom_size), 
.ram_size(ram_size), 
.cgb(cgb),
.unloaded(~done_load));

always
begin

	cart_ram_addr_bus <= decoded_addr_bus[14:0];
	rom_addr_bus <= decoded_addr_bus;
	
	wram_addr_bus <= addr_bus[12:0];
	mbc_addr_bus_in = addr_bus;
	
	wram_data_in <= data_in;
	cart_ram_data_in <= data_in;
	
	
//---------------------------------------
//
//   MBC mux
//
//---------------------------------------
	case (mbc_type)
		8'h00:  begin //MBC0
			decoded_addr_bus <= mbc0_decoded_addr;
			ram_enabled <= mbc0_ram_enabled; 
			mbc0_we = we;
			mbc1_we = 1'b0;
			mbc2_we = 1'b0;
			mbc5_we = 1'b0;
		end
		8'h01,8'h02,8'h03:  begin //MBC1
			decoded_addr_bus <= mbc1_decoded_addr;
			ram_enabled <= mbc1_ram_enabled; 
			mbc0_we = 1'b0;
			mbc1_we = we;
			mbc2_we = 1'b0;
			mbc5_we = 1'b0;
		end
		8'h5,8'h6:  begin //MBC2
			decoded_addr_bus <= mbc2_decoded_addr;
			ram_enabled <= mbc2_ram_enabled; 
			mbc0_we = 1'b0;
			mbc1_we = 1'b0;
			mbc2_we = we;
			mbc5_we = 1'b0;
		end
		8'h19,8'h1a,8'h1b,8'h1c,8'h1d,8'h1e:  begin //MBC5
			decoded_addr_bus <= mbc5_decoded_addr;
			ram_enabled <= mbc5_ram_enabled; 
			mbc0_we = 1'b0;
			mbc1_we = 1'b0;
			mbc2_we = 1'b0;
			mbc5_we = we;
		end
		default: begin
			decoded_addr_bus <= mbc1_decoded_addr;
			ram_enabled <= mbc1_ram_enabled; 
			mbc0_we = 1'b0;
			mbc1_we = we;
			mbc2_we = 1'b0;
			mbc5_we = 1'b0;
		end	
	endcase

//---------------------------------------
//
//   Memory area decoding
//
//---------------------------------------
		casex (addr_bus)

		16'b0xxxxxxxxxxxxxxx: begin //rom / bios
			if(unloaded) begin
				data_out = (done_load && addr_bus[15:8] == 8'h01) ? (rom_data_out) : jbios_data_out;
			end else begin
				data_out = (~initialized && addr_bus[15:8] != 8'h01) ? (bios_data_out) : rom_data_out;
			end
			wram_we = 1'b0;
			cart_ram_we = 1'b0;
			rom_we = 1'b0;
		end
		16'b101xxxxxxxxxxxxx: begin //cart ram
			data_out = ram_enabled ? cart_ram_data_out : 8'hff;
			wram_we = 1'b0;
			rom_we = 1'b0;
			cart_ram_we = ram_enabled & we;
		end
		16'b110xxxxxxxxxxxxx,
		16'b1110xxxxxxxxxxxx,
		16'b11110xxxxxxxxxxx,
		16'b1111x0xxxxxxxxxx,
		16'b1111xx0xxxxxxxxx,
		16'b1111xxx0xxxxxxxx: begin //wram
			data_out = wram_data_out;//sdram_data_in;//
			wram_we = we;
			rom_we = 1'b0;
			cart_ram_we = 1'b0;

		end

		16'b111111110xxxxxxx: begin
			case (addr_bus[6:0])

				7'h70: data_out = 8'hf8 | wram_bank_sel;
				default: begin
					 data_out = 8'hff; 
				end
			endcase
			wram_we = 1'b0;
			rom_we = 1'b0;
			cart_ram_we = 1'b0;
		end
		default:	begin 
	      data_out = 8'hFF;
			wram_we = 1'b0;
			rom_we = 1'b0;
			cart_ram_we = 1'b0;	

		end
	endcase
	
end


always @(posedge clock)
	begin
		if(rst) begin  
			unloaded = 1;
			done_load = 0;
			mbc_type = 0;
			rom_size = 0;
			ram_size = 0;
			gb_rom = 0;
			wram_bank_sel = 0;
		end else if(we & unloaded & addr_bus[15:8] == 8'hFF) begin
			casex (addr_bus[7:0])
				8'h80: mbc_type = data_in;
				8'h81: rom_size = data_in;
				8'h82: ram_size = data_in;
				8'h83: done_load = 1;
				8'h86: gb_rom = ~data_in[7];
				8'h70: wram_bank_sel = data_in[2:0];
			endcase
		end else begin
			unloaded = ~(addr_bus == 0 & done_load) & unloaded;
		end
	end
endmodule


