/*

Module: Memory bank 2 controller

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
module gb_mbc2
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

reg [3:0] rom_bank = 4'b0;
reg [23:0] addr_bus_out;
reg [7:0] data_out;
reg ram_enabled;

reg mode = 1'b0;
reg ram_enable = 1'b0;

always 
begin
		ram_enabled <= ram_enable;
		
 		data_out <= data_in;
		
		casex(addr_bus_in[15:12])
			4'b00xx:addr_bus_out = {10'b0, addr_bus_in[13:0]}; //bank 0
			4'b01xx:addr_bus_out = {6'b0, rom_bank, addr_bus_in[13:0]}; //bank 0 -  F
			4'ha: addr_bus_out =   {15'b0, addr_bus_in[8:0]}; //
			default: addr_bus_out = {8'b0,addr_bus_in};
		endcase

end

always @(posedge clock)
begin
	if(rst) begin
		rom_bank = 4'b0;
		ram_enable = 1'b0;
	end else if(we_in) begin
		case(addr_bus_in[15:12])
			4'h0, 4'h1:ram_enable = addr_bus_in[8] ? ram_enable : |data_in[3:0] & |ram_size;
			4'h2, 4'h3:rom_bank = addr_bus_in[8] ? data_in[3:0] : rom_bank;
			
			default: begin end
		endcase
	end
end

endmodule