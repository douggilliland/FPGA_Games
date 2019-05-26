`timescale 1ns / 1ns
module Comp_TB;

	reg [5:0] COUNT;
	wire COUNT18;
	wire COUNT32;

	Comp DUT(
		.COUNT(COUNT),
		.COUNT18(COUNT18),
		.COUNT32(COUNT32)
	);	

	initial
		begin: TEST_CASE
   			$dumpfile("Comp_TB.vcd");
     			$dumpvars(-1, DUT);
			#(500) $finish;
		end
	
	initial
		begin
			COUNT = 0;

			#5 COUNT = 17;
			#5 COUNT = 18;
			#5 COUNT = 19;
			#5 COUNT = 31;
			#5 COUNT = 32;
			#5 COUNT = 33;

		end

endmodule
