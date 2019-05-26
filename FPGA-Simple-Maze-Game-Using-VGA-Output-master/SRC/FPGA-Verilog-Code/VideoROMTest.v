`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:49:49 12/07/2013
// Design Name:   FinalProjectMainWrapper
// Module Name:   C:/Users/Nathaniel/Documents/school/2013 Fall/CMPEN417/Labs/FinalProject/FinalProjectVGA/VideoROMTest.v
// Project Name:  FinalProjectVGA
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: FinalProjectMainWrapper
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module VideoROMTest;

	// Inputs
	reg uclk;
	reg [4:0] btn;

	// Outputs
	wire hsync;
	wire vsync;
	wire [2:0] RED;
	wire [2:0] GREEN;
	wire [1:0] BLUE;

	// Instantiate the Unit Under Test (UUT)
	FinalProjectMainWrapper uut (
		.uclk(uclk), 
		.btn(btn), 
		.hsync(hsync), 
		.vsync(vsync), 
		.RED(RED), 
		.GREEN(GREEN), 
		.BLUE(BLUE)
	);

	initial begin
		// Initialize Inputs
		uclk = 0;
		btn = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	
	always @(*)
	begin
		#20 uclk = ~uclk;
	end
      
endmodule

