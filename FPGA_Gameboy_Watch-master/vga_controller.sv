/*

Module: 640x480 and 1280x1024 VGA signal generators


---------------------------------------
two very simple single mode vga generators
generator 

 inputs:
		clock_25_125mhz - 25.125mhz 50% duty cycle pixel clock (108Mhz for 1280x1024)

 outputs
		hs - horizontal sync pulse (negative)
		vs - vertical sync pulse (negative)
		hblank - 0 when in hblank 1 otherwise (continues during vblank)
		vblank - 0 when in vblank 1 otherwise 
		x - horizontal pixel counter (0 is left edge, continues to count during blanking periods)
		y - vertical pixel counter (0 is top edge, continues to count during blanking periods)

		
See useful documents for further info on VGA timing for creating other modes.  



Extending this to be generic would 
be rather trivial.		

![Vga timing]http://tinyvga.com/vga-timing		

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



module vga_controller_640x480 
//---------------------------------------
(clock_25_125mhz, vs, hs, vblank, hblank, x, y);

output [12:0]	x;
output [12:0]	y;
output 			hs;
output 			vs;
output 			hblank;
output 			vblank;

input 			clock_25_125mhz;
//----------------------------------------
//
wire 				hs;
wire				vs;
wire 				hblank;
wire				vblank;
wire				clock_25_125mhz;


reg [12:0]		x;
reg [12:0]		y;

//640x480 mode
parameter WIDTH = 640;
parameter HEIGHT = 480;

parameter HBLANK_CYCLES = 95;
parameter HBLANK_FRONTPORCH_CYCLES = 18;
parameter HBLANK_BACKPORCH_CYCLES = 46;

parameter VBLANK_LINES = 2;
parameter VBLANK_FRONTPORCH_LINES = 12;
parameter VBLANK_BACKPORCH_LINES = 31;

always_comb
begin
	
	if(x >= WIDTH + HBLANK_FRONTPORCH_CYCLES + HBLANK_CYCLES - 1) begin
		hs = 1; //back porch
		hblank = 0;
	end else if(x >= WIDTH + HBLANK_FRONTPORCH_CYCLES - 1) begin
		hs = 0;//hblank
		hblank = 0;
	end else if(x >= WIDTH ) begin
		hs = 1; //front porch
		hblank = 0;
	end else begin
		hs = 1;//display
		hblank = 1;
	end
	
	if(y >= HEIGHT + VBLANK_FRONTPORCH_LINES + VBLANK_LINES - 1) begin
		vs = 1;  //back porch
		vblank = 0;
	end else if(y >= HEIGHT + VBLANK_FRONTPORCH_LINES - 1) begin
		vs = 0;   //vblank
		vblank = 0;
	end else if(y >= HEIGHT - 1) begin
		vs = 1;  //front porch
		vblank = 0;
	end else begin
		vs = 1;  //display
		vblank = 1;
	end
end


always @ (posedge clock_25_125mhz)
begin:counters
	
	if(x == WIDTH + HBLANK_FRONTPORCH_CYCLES + HBLANK_BACKPORCH_CYCLES + HBLANK_CYCLES -1) begin
		x <= 0;
		
		if(y == HEIGHT + VBLANK_FRONTPORCH_LINES + VBLANK_BACKPORCH_LINES + VBLANK_LINES -1) begin
			y <= 0;
		end else  begin
		   y <= y + 1'b1;
		end
		
	end else begin
		x <= x + 1'b1;
	end	
end

endmodule 

module vga_controller_1280x1024 
//---------------------------------------
(clock_108mhz, vs, hs, vblank, hblank, x, y);

output [12:0]	x;
output [12:0]	y;
output 			hs;
output 			vs;
output 			hblank;
output 			vblank;

input 			clock_108mhz;
//----------------------------------------
//
wire 				hs;
wire				vs;
wire 				hblank;
wire				vblank;
wire				clock_108mhz;


reg [12:0]		x;
reg [12:0]		y;

//640x480 mode
parameter WIDTH = 1280;
parameter HEIGHT = 1024;

parameter HBLANK_CYCLES = 112;
parameter HBLANK_FRONTPORCH_CYCLES = 48;
parameter HBLANK_BACKPORCH_CYCLES = 248;

parameter VBLANK_LINES = 3;
parameter VBLANK_FRONTPORCH_LINES = 1;
parameter VBLANK_BACKPORCH_LINES = 38;

always_comb
begin
	
	if(x >= WIDTH + HBLANK_FRONTPORCH_CYCLES + HBLANK_CYCLES - 1) begin
		hs = 1; //back porch
		hblank = 0;
	end else if(x >= WIDTH + HBLANK_FRONTPORCH_CYCLES - 1) begin
		hs = 0;//hblank
		hblank = 0;
	end else if(x >= WIDTH ) begin
		hs = 1; //front porch
		hblank = 0;
	end else begin
		hs = 1;//display
		hblank = 1;
	end
	
	if(y >= HEIGHT + VBLANK_FRONTPORCH_LINES + VBLANK_LINES - 1) begin
		vs = 1;  //back porch
		vblank = 0;
	end else if(y >= HEIGHT + VBLANK_FRONTPORCH_LINES - 1) begin
		vs = 0;   //vblank
		vblank = 0;
	end else if(y >= HEIGHT - 1) begin
		vs = 1;  //front porch
		vblank = 0;
	end else begin
		vs = 1;  //display
		vblank = 1;
	end
end


always @ (posedge clock_108mhz)
begin:counters
	
	if(x == WIDTH + HBLANK_FRONTPORCH_CYCLES + HBLANK_BACKPORCH_CYCLES + HBLANK_CYCLES -1) begin
		x <= 0;
		
		if(y == HEIGHT + VBLANK_FRONTPORCH_LINES + VBLANK_BACKPORCH_LINES + VBLANK_LINES -1) begin
			y <= 0;
		end else  begin
		   y <= y + 1'b1;
		end
		
	end else begin
		x <= x + 1'b1;
	end	
end





endmodule 


