`timescale 1ns / 1ps

module bloqueultrasonido_TB;

	// Inputs
	reg		ECHO;
	reg		clk;
	reg		orden;

	// Outputs
	wire	[7:0]	d;
	wire		trigg;
	wire		DONE;

	// Instantiate the Unit Under Test (UUT)
	bloqueultrasonido	uut	(
						.d	(	d	), 
						.trigg	(	trigg	), 
						.DONE	(	DONE	), 
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
		orden=1'bx;
		ECHO = 0;
		#3000;
		orden=1'b0;
		ECHO = 0;
		#3000;
		orden=1'b1;
		ECHO = 0;
		#10000;
		ECHO = 1;
		#100000;
		ECHO = 0;
		#10000;
	end
	initial
	begin: TEST_CASE
		     $dumpfile("bloqueultrasonido_TB.vcd");
		     $dumpvars(-1, uut);
		     #(500000) $finish;
	end
      
endmodule

