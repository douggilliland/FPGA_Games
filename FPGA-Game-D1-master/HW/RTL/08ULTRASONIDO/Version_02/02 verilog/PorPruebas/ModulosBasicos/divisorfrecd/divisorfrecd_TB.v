`timescale 1ns / 1ps
module divisorfrecd_TB;

	reg		clk;
	divisorfrecd  uut(.clk(clk));

	always
	begin
		clk =1'b1;
		#2;
		clk =1'b0;
		#2;
	end


initial begin: TEST_CASE
     $dumpfile("divisorfrecd_TB.vcd");
     $dumpvars(-1, uut);
     #(100000) $finish;
   end

endmodule //
