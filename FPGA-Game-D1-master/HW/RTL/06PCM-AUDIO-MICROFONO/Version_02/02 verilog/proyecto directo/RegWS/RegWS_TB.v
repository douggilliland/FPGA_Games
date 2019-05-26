`timescale 1ns / 1ns
module RegWS_TB;

	reg RESET;
	reg SET32;
	wire WS;

	RegWS DUT(
		.RESET(RESET),
		.SET32(SET32),
		.WS(WS)
	);

	initial
		begin: TEST_CASE
   			$dumpfile("RegWS_TB.vcd");
	     		$dumpvars(-1, DUT);
			#(300) $finish;
		end
	
	always
		#5 SET32 = ~SET32;

	initial
		begin
			RESET = 1'b1;
			SET32 = 1'b0;

			#60 RESET = 1'b0;
			
			#60 RESET = 1'b1;

		end

endmodule
