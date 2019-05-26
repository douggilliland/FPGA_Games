`timescale 10ns / 1ps
module genpulsosprueba_TB;

	reg		pulse;
	reg		clk;
	reg		reset;
	genpulsosprueba  uut(.pulse(pulse),.reset(reset),.clk(clk));

	always
	begin
		clk =1'b0;
		#0.5;
		clk =1'b1;
		#0.5;
	end

	initial 
	begin
		pulse= 0;
		reset=1;
		#40000;
		reset =0;
		#50000;
		pulse = 1;
		#50000;
		reset =0;
		#10000;
		reset=1;
		pulse=1;
		#60000;
		reset=0;
		pulse=0;
		#90000;
		pulse=1;
		#40000;
		pulse=0;
		#40000;
		pulse=1;
		#40000;
		pulse=0;
		#40000;
		pulse=1;
		#50000;
		pulse=0;
		reset=1;
		#50000;
		pulse=0;
		reset=0;
		#50000;
		pulse=1;
		#50000;
		reset=1;
		#50000;
	end


initial begin: TEST_CASE
     $dumpfile("genpulsosprueba_TB.vcd");
     $dumpvars(-1, uut);
     #(1000000) $finish;
   end

endmodule //
