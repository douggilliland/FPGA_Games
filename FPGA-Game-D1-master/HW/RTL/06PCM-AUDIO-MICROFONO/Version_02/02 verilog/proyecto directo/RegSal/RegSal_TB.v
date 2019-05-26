`timescale 1ns / 1ns
module RegSal_TB;

	reg RESET;
	reg LOAD;
	reg [17:0] DATA;
	wire [17:0] D_OUT;

	RegSal DUT(
		.RESET(RESET),
		.LOAD(LOAD),
		.DATA(DATA),
		.D_OUT(D_OUT)
	);

	always
		begin
			#10 LOAD = ~LOAD;
		end	

	initial
		begin: TEST_CASE
   			$dumpfile("RegSal_TB.vcd");
     		$dumpvars(-1, DUT);
			#(300) $finish;
		end
	
	initial
		begin
			LOAD = 1'b0;
			RESET = 1'b1;
			DATA = 18'b101010101010101010;

			#5 RESET = 1'b0;

			#7 DATA = 18'b101010101010101010;
			#14 DATA = 18'b111111111000000000;
			#21 DATA = 18'b000000111111100000;
			#28 DATA = 18'b111000111000111000;
			
			#30 RESET = 1'b1;

		end

endmodule
