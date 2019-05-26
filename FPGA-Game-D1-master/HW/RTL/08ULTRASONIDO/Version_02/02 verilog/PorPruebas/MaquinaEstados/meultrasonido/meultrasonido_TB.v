`timescale 1ns / 1ps

module meultrasonido_TB;

	// Inputs
	reg	CLKOUT2;
        reg	orden;

	// Outputs
	//wire	ENABLE;
        //wire	reset;

	// Instantiate the Unit Under Test (UUT)
	meultrasonido uut ( 
		.orden(orden), 
		.CLKOUT2(CLKOUT2)
	);
	
	always
	begin
		CLKOUT2 =1'b0;
		#2;
		CLKOUT2 =1'b1;
		#2;
	end

	initial 
	begin
		// Initialize Inputs
		orden=1'bx;
		#50;
		orden=0;
		#50;
		orden=1;
		#50;
		orden=0;
		#50;
		orden=1;
		#50;


		// Wait 100 ns for global reset to finish
		//for(int i=0;i<=10;i=i+1)
		//begin
		#50;
		//end
		// Add stimulus here

	end
	initial
	begin: TEST_CASE
		     $dumpfile("meultrasonido_TB.vcd");
		     $dumpvars(-1, uut);
		     #(200) $finish;
	end
      
endmodule

