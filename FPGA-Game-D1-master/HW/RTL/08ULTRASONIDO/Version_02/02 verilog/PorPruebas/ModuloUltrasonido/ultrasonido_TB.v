`timescale 1ns / 1ps

module ultrasonido_TB;

	// Inputs
	reg	ENABLE;
	reg	ECHO;
	reg	clk;
	reg	reset;

	// Outputs
	wire	[7:0]	d;
	wire		trigg;
	wire		DONE;

	// Instantiate the Unit Under Test (UUT)
	ultrasonido uut (
		.d(d), 
		.trigg(trigg), 
		.DONE(DONE), 
		.ENABLE(ENABLE), 
		.ECHO(ECHO), 
		.clk(clk),
		.reset(reset)
	);
	
	always
	begin
		clk =1'b0;
		#2;
		clk =1'b1;
		#2;
	end

	initial 
	begin
		// Initialize Inputs
		ENABLE = 0;
		reset=0;
		ECHO = 0;
		#3000;
		ENABLE = 1;
		ECHO = 0;
		#10000;
		ECHO = 1;
		#100000;
		ECHO = 0;
		#10000;
		
		
	end
	initial
	begin: TEST_CASE
		     $dumpfile("ultrasonido_TB.vcd");
		     $dumpvars(-1, uut);
		     #(1000000) $finish;
	end
      
endmodule

