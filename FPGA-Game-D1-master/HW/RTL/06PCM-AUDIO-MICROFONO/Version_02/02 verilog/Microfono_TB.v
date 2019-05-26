`timescale 10ns / 100ps
module Microfono_TB;

	reg reset;
	reg clk;
	reg enable;
	reg d_in;
	wire bclk;
	wire ws;
	wire [17:0] d_out;
	wire done;

	Microfono DUT(
		.reset(reset),
		.clk(clk),
		.enable(enable),
		.d_in(d_in),
		.bclk(bclk),
		.ws(ws),
		.d_out(d_out),
		.done(done)
	);

	always
		begin
			#0.5 clk = ~clk;
		end	

	always
		begin
			#2021 d_in = ~d_in;
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
			enable = 1'b0;
			d_in = 1'b1;

			#1 reset = 1'b0;

			#1 enable = 1'b1;
			#1 enable = 1'b0;

		end

endmodule
