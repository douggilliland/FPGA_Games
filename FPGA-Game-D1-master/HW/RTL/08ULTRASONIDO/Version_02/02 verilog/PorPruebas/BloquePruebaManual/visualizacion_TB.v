`timescale 1ns / 1ps

module visualizacion_TB;

	// Inputs
	reg			clk;
	reg			ECHO;
	reg			orden;

	// Outputs
	wire			trigg;
	wire		[3:0]	anodo;
	wire		[6:0]	seg;

	// Instantiate the Unit Under Test (UUT)
	visualizacion	uut	(
						.ECHO	(	ECHO	), 
						.clk	(	clk	),
						.orden	(	orden	)
					);
	
	always
	begin
		clk =1'b1;
		#2;
		clk =1'b0;
		#2;
	end

	initial 
	begin
		orden=1'b0;
		ECHO = 0;
		#1300000;
		orden=1'b1;
		ECHO = 0;
		#3000;
		orden=1'b0;
		ECHO = 0;
		#3000;
		orden=1'b1;
		ECHO = 0;
		#3000;
		orden=1'b1;
		ECHO = 0;
		#3000;
		ECHO = 1;
		#200000;
		ECHO = 0;//1
		#1600000;
		orden=1'b0;
		#50000;
		orden=1'b1;
		#400000;
		ECHO = 1;
		#1600000;
		ECHO = 0;//2
		#10000;
	end
	initial
	begin: TEST_CASE
		     $dumpfile("visualizacion_TB.vcd");
		     $dumpvars(-1, uut);
		     #(12000000) $finish;
	end
      
endmodule

