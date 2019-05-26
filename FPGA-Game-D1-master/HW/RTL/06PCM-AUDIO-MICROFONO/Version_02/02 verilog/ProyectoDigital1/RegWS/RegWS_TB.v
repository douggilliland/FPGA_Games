`timescale 1ns / 1ns
module RegWS_TB;

	reg reset;
	reg set32;
	wire ws;

	RegWS DUT(
		.reset(reset),
		.set32(set32),
		.ws(ws)
	);

	initial
		begin: TEST_CASE
   			$dumpfile("RegWS_TB.vcd");
	     		$dumpvars(-1, DUT);
			#(300) $finish;
		end
	
	always
		#5 set32 = ~set32;

	initial
		begin
			reset = 1'b1;
			set32 = 1'b0;

			#60 reset = 1'b0;
			
			#60 reset = 1'b1;

		end

endmodule
