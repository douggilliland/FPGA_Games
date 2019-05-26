
/*

Module: SNES Controller 
Author: Jason Rogers
Contact: jasonrogers@alumni.stanford.edu


A snes controller (and NES for which this should also work with a slight modification to make it 8 bit) 
is simply a shift register. To read the buttons you simply latch the data then clock it in.  The below 
is from Mark Knibs' "Using the Super NES controller with a NES" document (c) 1998


NES controller connector pin definitions:
        ___
       |   \
     1 | O  \
       |     \
     2 | O  O | 5
       |      |
     3 | O  O | 6
       |      |
     4 | O  O | 7
       +------+

Super NES controller connector pin definitions:
        ______________________
       |            |         \
       | O  O  O  O | O  O  O  |
       |____________|_________/
         1  2  3  4   5  6  7



Which Pins to Connect with Which
------------------------------
See the note about wire colours below!

     SNES pin  wire colour*        Function         NES pin  wire colour*
     --------  -----------         --------         -------  -----------
        1        white             Vcc (+5V)           5       white
        2        yellow            CLOCK               2       red
        3        orange            LATCH               3       orange
        4        red               DATA                4       yellow
        7        brown             GND (0V)            1       green

		  

For a timing diagram look in:  useful_docs/snes_timing.gif
		  
When clocked in the data will be stored in snes buttons as follows:

0                              ...                11   
B  Y Select Start Up Down Left Right A X L R ? ? ? ?
		  

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


module snes_controller(
   input    clock,              //tested with a 4mhz clock
	input    rst,                 //reset signal 
	output  [15:0] snes_buttons,  //hook up to LED lines 
	input    snes_data,
   output   snes_latch,
	output   snes_clock
	
	);

	

reg [1:0]		snes_state;
reg [4:0] 		snes_ctr;
reg [15:0] 		snes_shift_reg; //temp holder
reg [12:0]     snes_counter;  //frequency divider

always @(posedge clock)
begin
	if(rst) begin
		snes_state = 0;
		snes_latch = 0;
		snes_ctr = 0;
		snes_buttons = 0;
		snes_shift_reg = 0;
	end else begin
		
		snes_clock = ~(~|snes_counter[3:0] & snes_state[1:0]==2);
		
		if(~|snes_counter[3:0]) begin
			case (snes_state)
			
			0: begin
				snes_latch = 0;
				snes_state = ~|snes_counter ? 2'b1 : 2'b0;
				
			end
			1: begin
				snes_latch = 1;
				snes_state = 2;
				snes_shift_reg = 0;
				snes_ctr = 0;
				
			end
			2: begin
				snes_shift_reg = {snes_data, snes_shift_reg[15:1]};
				snes_latch = 0;
				snes_ctr = snes_ctr + 1'b1;
				if(snes_ctr == 16) begin
					snes_buttons = snes_shift_reg;
					snes_state = 0;
				end
			end
			default: snes_state = 0;
			
			endcase
		end
		snes_counter = snes_counter + 1'b1;
		
	
	end
end

endmodule
