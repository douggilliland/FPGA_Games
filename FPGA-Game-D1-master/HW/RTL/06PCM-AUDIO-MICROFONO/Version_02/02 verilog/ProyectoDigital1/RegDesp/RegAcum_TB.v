`timescale 1ns / 1ns
module RegAcum_TB;

	reg reset;
	reg bclk;
	reg set;
	wire [5:0] count;

	RegAcum DUT(
		.reset(reset),
		.bclk(bclk),
		.set(set),
		.count(count)
	);

	always
		begin
			#1 bclk = ~bclk;
		end	

	initial
		begin: TEST_CASE
   			$dumpfile("RegAcum_TB.vcd");
     		$dumpvars(-1, DUT);
			#(300) $finish;
		end
	
	initial
		begin
			bclk = 1'b0;
			reset = 1'b1;
			set = 1'b0;

			#5 reset = 1'b0;

			#37 set = 1'b1;
			#5 set = 1'b0;

			
			#10 reset = 1'b1;

		end

endmodule
