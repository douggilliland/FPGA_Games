`timescale 1ns / 1ns
module DivFreq_TB;

	reg RESET;
	reg CLK;
	reg EN_CLK;
	wire BCLK;

	DivFreq DUT(
		.RESET(RESET),
		.CLK(CLK),
		.EN_CLK(EN_CLK),
		.BCLK(BCLK)
	);

	always
		begin
			#1 CLK = ~CLK;
		end	

	initial
		begin: TEST_CASE
   			$dumpfile("DivFreq_TB.vcd");
     		$dumpvars(-1, DUT);
			#(500) $finish;
		end
	
	initial
		begin
			CLK = 1'b0;
			RESET = 1'b1;
			EN_CLK = 1'b0;

			#5 RESET = 1'b0;

			#5 EN_CLK = 1'b1;
			#10 EN_CLK = 1'b0;
			#10 EN_CLK = 1'b1;
			#500 RESET = 1'b1;

		end

endmodule
