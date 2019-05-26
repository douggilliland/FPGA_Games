`timescale 1ns / 1ps

module maquinadeestados_TB;

	// Inputs
	reg   clk;
        reg   orden;

	// Outputs
	//wire [7:0] d;
	//wire trigg;
	//wire DONE;

	// Instantiate the Unit Under Test (UUT)
	maquinadeestados uut (
		.orden(orden), 
		.clk(clk)
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
		// Initialize Inputs
		orden = 1'bx;
		#27000;
		orden = 0;
		#1000;
		orden = 1;
		#1000;
		orden = 0;
		#1000;
		orden = 1;
		#1000;
	end
	initial
	begin: TEST_CASE
		     $dumpfile("maquinadeestados_TB.vcd");
		     $dumpvars(-1, uut);
		     #(500000) $finish;
	end
      
endmodule

