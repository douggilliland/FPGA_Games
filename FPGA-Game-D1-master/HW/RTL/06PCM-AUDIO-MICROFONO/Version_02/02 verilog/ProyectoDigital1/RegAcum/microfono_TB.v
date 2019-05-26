`timescale 1ns / 1ns
module RegDes_TB;

	reg RESET;
	reg BCLK;
	reg D_IN;
	wire [17:0] DATA;

	RegDes DUT(
		.RESET(RESET),
		.BCLK(BCLK),
		.D_IN(D_IN),
		.DATA(DATA)
	);

	always
		begin
			#1 BCLK = ~BCLK;
		end	

	initial
		begin: TEST_CASE
   			$dumpfile("RegDes_TB.vcd");
     		$dumpvars(-1, DUT);
			#(300) $finish;
		end
	
	initial
		begin
        	//$monitor("DATA=%b", DATA);
			BCLK = 1'b0;
			RESET = 1'b1;
			D_IN = 1'b0;

			#5 RESET = 1'b0;

			#7 D_IN = 1'b1;
			#10 D_IN = 1'b0;
			#13 D_IN = 1'b1;
			#15 D_IN = 1'b0;
			#20 D_IN = 1'b1;
			
			#5 RESET = 1'b1;

		end

endmodule
