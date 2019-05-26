/*

Module: Memory bank 1 controller

http://gbdev.gg8.se/wiki/articles/Memory_Bank_Controllers


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

module gb_mbc1
//---------------------------------------
(rst, clock, addr_bus_in, addr_bus_out, data_in, data_out, we_in, ram_enabled, rom_size, ram_size, cgb);


input rst;
input clock;
input [15:0] addr_bus_in;
output [23:0] addr_bus_out;
input [7:0] data_in;
output [7:0] data_out;
input we_in;
input [7:0] rom_size;
input [7:0] ram_size;
output ram_enabled;
input cgb;

reg [7:0] rom_bank = 5'b0;
reg [23:0] addr_bus_out;
reg [7:0] data_out;
reg ram_enabled;

reg [1:0] ram_bank = 2'b0;
reg mode = 1'b0;
reg ram_enable = 1'b0;

always 
begin
		ram_enabled <= ram_enable;
		
 		data_out <= data_in;
		
		if(~addr_bus_in[15]) begin //in rom
			addr_bus_out = addr_bus_in[14] ? {mode ? 2'b0 : ram_bank , rom_bank, addr_bus_in[13:0]} : {7'b0, addr_bus_in[13:0]};
		end else if (addr_bus_in[15:13] == 3'b101) begin //in ram
			if(ram_enable) begin				
				case (ram_size)
					8'h1: addr_bus_out = {13'b0,addr_bus_in[10:0]};
					8'h2: addr_bus_out = {11'b0,addr_bus_in[12:0]};
					8'h3: addr_bus_out = {9'b0, mode ? ram_bank : 2'b0, addr_bus_in[12:0]};
					default: begin 
						addr_bus_out = {13'b0,addr_bus_in[10:0]};
					end
				endcase
			end else begin
					addr_bus_out = {13'b0,addr_bus_in[10:0]};
			end
		end else begin
			addr_bus_out = {13'b0,addr_bus_in[10:0]};
		end
end


always @(posedge clock)
begin
	if(rst) begin
		rom_bank = 5'b1;
		ram_enable = 1'b0;
		mode = 1'b0;
	end else if(we_in) begin
		if(~addr_bus_in[15]) begin
			if(addr_bus_in[15:13] == 3'b001) begin
				rom_bank = ~|data_in[4:0] ? 5'b1 : data_in[4:0];
			end else if(addr_bus_in[15:13] == 3'b011) begin
				mode = data_in[0];
			end else if(addr_bus_in[15:13] == 3'b010) begin
				ram_bank = data_in[1:0];
			end else if(addr_bus_in[15:13] == 3'b000) begin
				ram_enable = |data_in[3:0] & |ram_size;
			end				
		end
	end
end

endmodule