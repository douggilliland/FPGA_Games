`timescale 1ns / 1ns
module audio_TB;

		reg clk;
		reg [15:0]d_in;
		reg enable=0;
		reg bclk;
		reg lrclk;
		reg done;
		reg reset;
		wire [15:0]d_out;

audio a1(.enable(enable),.d_in(d_in),.reset(reset),.clk(clk));//;.LRCLK(LRCLK),,.DONE(DONE),.LRCLK(LRCLK),.DONE(DONE)

		always
		begin

		clk =1'b1;
		#2;
		clk=1'b0;
		#2;
		end

		initial
		begin
		reset =1'b1;
		#5;
		reset =1'b0;

		d_in=16'b11110000111;
		#100; enable=1;
		end 

	
initial begin: TEST_CASE
     $dumpfile("audio_TB.vcd");
     $dumpvars(-1, a1);
     #(1000) $finish;
   end

endmodule


