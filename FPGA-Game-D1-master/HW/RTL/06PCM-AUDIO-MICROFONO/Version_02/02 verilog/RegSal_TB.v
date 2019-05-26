`timescale 1ns / 1ns
module RegSal_TB;

	reg reset;
	reg load;
	reg [17:0] data;
	wire [17:0] d_out;

	RegSal DUT(
		.reset(reset),
		.load(load),
		.data(data),
		.d_out(d_out)
	);

	always
		begin
			#10 load = ~load;
		end	

	initial
		begin: TEST_CASE
   			$dumpfile("RegSal_TB.vcd");
     		$dumpvars(-1, DUT);
			#(300) $finish;
		end
	
	initial
		begin
			load = 1'b0;
			reset = 1'b1;
			data = 18'b101010101010101010;

			#5 reset = 1'b0;

			#7 data = 18'b101010101010101010;
			#14 data = 18'b111111111000000000;
			#21 data = 18'b000000111111100000;
			#28 data = 18'b111000111000111000;
			
			#30 reset = 1'b1;

		end

endmodule
