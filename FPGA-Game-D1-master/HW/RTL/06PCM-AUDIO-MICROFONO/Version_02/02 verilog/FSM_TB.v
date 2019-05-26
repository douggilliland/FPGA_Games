`timescale 1ns / 1ns
module FSM_TB;

	reg reset;
	reg clk;
	reg enable;
	reg count18;
	reg count32;
	wire reset_int;
	wire done;
	wire en_bclk;

	FSM DUT(
		.reset(reset),
		.clk(clk),
		.enable(enable),
		.count18(count18),
		.count32(count32),
		.reset_int(reset_int),
		.done(done),
		.en_bclk(en_bclk)
	);

	always
		begin
			#1 clk = ~clk;
		end	

	initial
		begin: TEST_CASE
   			$dumpfile("FSM_TB.vcd");
     			$dumpvars(-1, DUT);
			#(500) $finish;
		end
	
	initial
		begin
			clk = 1'b0;
			reset = 1'b1;
			enable = 1'b0;
			count18 = 1'b0;
			count32 = 1'b0;

			#5 reset = 1'b0;

			#10 enable = 1'b1;
			#10 enable = 1'b0;

			#20 count18 = 1'b1;
			#2 count18 = 1'b0;

			#20 count32 = 1'b1;
			#2 count32 = 1'b0;

		end

endmodule
