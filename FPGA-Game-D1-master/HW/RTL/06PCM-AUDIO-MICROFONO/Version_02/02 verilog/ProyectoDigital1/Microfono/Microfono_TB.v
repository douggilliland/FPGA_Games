`timescale 10ns / 100ps
module Microfono_TB;
	
	reg clk;
	reg reset;
	reg rec;
	reg play;
	wire bclk;
	wire lrsel;
	reg data_in;
	wire data_out;
	wire ampSD;
	wire rd;
	wire wr;

	Microfono DUT(
		.clk(clk),
		.reset(reset),
		.rec(rec),
		.play(play),
		.bclk(bclk),
		.lrsel(lrsel),
		.data_in(data_in),
		.data_out(data_out),
		.ampSD(ampSD),
		.rd(rd),
		.wr(wr)
	);

	always
		begin
			#0.5 clk = ~clk;
		end	

	always
		begin
			#2021 data_in = ~data_in;
		end	

	initial
		begin: TEST_CASE
   			$dumpfile("Microfono_TB.vcd");
     			$dumpvars(-1, DUT);
			#(100000000) $finish;
		end
	
	initial
		begin
			clk = 1'b0;
			reset = 1'b1;
			data_in = 1'b1;
			rec = 1'b0;
			play = 1'b0;

			#100000 reset = 1'b0;

			#1 rec = 1'b1;
			#1000000 rec = 1'b0;

			#500000 play = 1'b1;
			#100000 play = 1'b0;

		end

endmodule
