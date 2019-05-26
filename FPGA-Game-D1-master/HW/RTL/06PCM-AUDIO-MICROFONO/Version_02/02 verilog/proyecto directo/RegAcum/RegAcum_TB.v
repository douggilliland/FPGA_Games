`timescale 1ns / 1ns
module RegAcum_TB;

	reg RESET;
	reg BCLK;
	reg SET;
	wire [5:0] COUNT;

	RegAcum DUT(
		.RESET(RESET),
		.BCLK(BCLK),
		.SET(SET),
		.COUNT(COUNT)
	);

	always
		begin
			#1 BCLK = ~BCLK;
		end	

	initial
		begin: TEST_CASE
   			$dumpfile("RegAcum_TB.vcd");
     		$dumpvars(-1, DUT);
			#(300) $finish;
		end
	
	initial
		begin
			BCLK = 1'b0;
			RESET = 1'b1;
			SET = 1'b0;

			#5 RESET = 1'b0;

			#37 SET = 1'b1;
			#5 SET = 1'b0;

			
			#10 RESET = 1'b1;

		end

endmodule
