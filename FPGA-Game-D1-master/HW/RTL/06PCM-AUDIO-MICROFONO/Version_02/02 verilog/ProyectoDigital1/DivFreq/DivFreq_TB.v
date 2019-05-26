`timescale 1ns / 1ns
module DivFreq_TB;

	reg reset;
	reg clk;
	reg en_clk;
	wire bclk;

	DivFreq DUT(
		.reset(reset),
		.clk(clk),
		.en_clk(en_clk),
		.bclk(bclk)
	);

	always
		begin
			#1 clk = ~clk;
		end	

	initial
		begin: TEST_CASE
   			$dumpfile("DivFreq_TB.vcd");
     		$dumpvars(-1, DUT);
			#(500) $finish;
		end
	
	initial
		begin
			clk = 1'b0;
			reset = 1'b1;
			en_clk = 1'b0;

			#5 reset = 1'b0;

			#5 en_clk = 1'b1;
			#10 en_clk = 1'b0;
			#10 en_clk = 1'b1;
			#500 reset = 1'b1;

		end

endmodule
