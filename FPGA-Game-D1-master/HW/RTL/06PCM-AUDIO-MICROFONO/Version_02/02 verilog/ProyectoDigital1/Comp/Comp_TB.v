`timescale 1ns / 1ns
module Comp_TB;

	reg [5:0] count;
	wire count18;
	wire count32;

	Comp DUT(
		.count(count),
		.count18(count18),
		.count32(count32)
	);	

	initial
		begin: TEST_CASE
   			$dumpfile("Comp_TB.vcd");
     			$dumpvars(-1, DUT);
			#(500) $finish;
		end
	
	initial
		begin
			count = 0;

			#5 count = 17;
			#5 count = 18;
			#5 count = 19;
			#5 count = 31;
			#5 count = 32;
			#5 count = 33;

		end

endmodule
