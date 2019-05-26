`timescale 10ns / 100ps
module Microfono_TB;

	reg RESET;
	reg CLK;
	reg ENABLE;
	reg D_IN;
	wire BCLK;
	wire WS;
	wire [17:0] D_OUT;
	wire DONE;
	wire D_AMP;

	Microfono DUT(
		.RESET(RESET),
		.CLK(CLK),
		.ENABLE(ENABLE),
		.D_IN(D_IN),
		.BCLK(BCLK),
		.WS(WS),
		.D_OUT(D_OUT),
		.DONE(DONE),
		.D_AMP(D_AMP)
	);

	always
		begin
			#0.5 CLK = ~CLK;
		end	

	always
		begin
			#2021 D_IN = ~D_IN;
		end	

	initial
		begin: TEST_CASE
   			$dumpfile("Microfono_TB.vcd");
     			$dumpvars(-1, DUT);
			#(100000) $finish;
		end
	
	initial
		begin
			CLK = 1'b0;
			RESET = 1'b1;
			ENABLE = 1'b0;
			D_IN = 1'b1;

			#1 RESET = 1'b0;

			#1 ENABLE = 1'b1;
			#1 ENABLE = 1'b0;

		end

endmodule
