`timescale 1ns / 1ps
module divisorfrecme_TB;

	reg		clk;
	divisorfrecme  uut(.clk(clk));

	always
	begin
		clk =1'b1;
		#2;
		clk =1'b0;
		#2;
	end


initial begin: TEST_CASE
     $dumpfile("divisorfrecme_TB.vcd");
     $dumpvars(-1, uut);
     #(100000) $finish;
   end

endmodule //
