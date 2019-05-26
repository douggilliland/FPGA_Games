`timescale 1ns / 1ns
module RegDes_TB;

	reg reset;
	reg bclk;
	reg d_in;
	wire [17:0] data;

	RegDes DUT(
		.reset(reset),
		.bclk(bclk),
		.d_in(d_in),
		.data(data)
	);

	always
		begin
			#1 bclk = ~bclk;
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
			bclk = 1'b0;
			reset = 1'b1;
			d_in = 1'b0;

			#5 reset = 1'b0;

			#7 d_in = 1'b1;
			#10 d_in = 1'b0;
			#13 d_in = 1'b1;
			#15 d_in = 1'b0;
			#20 d_in = 1'b1;
			
			#5 reset = 1'b1;

		end

endmodule
