`timescale 1ns / 1ns
module FSM_TB;

	reg RESET;
	reg CLK;
	reg ENABLE;
	reg COUNT18;
	reg COUNT32;
	wire RESET_INT;
	wire DONE;
	wire EN_BCLK;

	FSM DUT(
		.RESET(RESET),
		.CLK(CLK),
		.ENABLE(ENABLE),
		.COUNT18(COUNT18),
		.COUNT32(COUNT32),
		.RESET_INT(RESET_INT),
		.DONE(DONE),
		.EN_BCLK(EN_BCLK)
	);

	always
		begin
			#1 CLK = ~CLK;
		end	

	initial
		begin: TEST_CASE
   			$dumpfile("FSM_TB.vcd");
     			$dumpvars(-1, DUT);
			#(500) $finish;
		end
	
	initial
		begin
			CLK = 1'b0;
			RESET = 1'b1;
			ENABLE = 1'b0;
			COUNT18 = 1'b0;
			COUNT32 = 1'b0;

			#5 RESET = 1'b0;

			#10 ENABLE = 1'b1;
			#10 ENABLE = 1'b0;

			#20 COUNT18 = 1'b1;
			#2 COUNT18 = 1'b0;

			#20 COUNT32 = 1'b1;
			#2 COUNT32 = 1'b0;

		end

endmodule
