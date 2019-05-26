`timescale 1ns / 1ps

`include "io.v"
`include "Defintions.v"

module tb_simple_io;

	// Inputs
	reg Clock;
	reg Reset;

	// Outputs
	wire [5:0] oP;
	wire oIE;

	reg [5:0] rBotcode;

	// Instantiate the Unit Under Test (UUT)
	io ionew (
		.Clock(Clock),
		.Reset(Reset),

		.iP(rBotcode),
      .oP(oP),
      .oIE(oIE)
	);

	always
	begin
		#5  Clock =  ! Clock;

	end

	initial begin
		$display("Starting GameBoy IO Test\n");

		$dumpfile("tb_simple_io.vcd");
		$dumpvars(0,tb_simple_io);

		// Initialize Inputs
		Clock = 0;
		Reset = 0;

		rBotcode = `NOBOT;

		// Wait 100 ns for global reset to finish
		#10;
		Reset = 1;
		#10
		Reset = 0;
		$display("Reset ready at time %dns", $time);
		#10
		rBotcode = `NOBOT;
		$display("No button pressed at time %dns", $time);

		#10
		rBotcode = `A;
		#10
		rBotcode = `NOBOT;
		#10
		rBotcode = `B;
		#10
		rBotcode = `START;
		#10
		rBotcode = `SELECT;
		#10
		rBotcode = `UP;
		#10
		rBotcode = `DOWN;
		#10
		rBotcode = `LEFT;
		#10
		rBotcode = `RIGHT;

		// #10
		// rBotcode = `A;
		// #10
		// rBotcode = `NOBOT;
		// #10
		// rBotcode = `B;
		// #10
		// rBotcode = `B & `DOWN;

		#100
		rBotcode = `NOBOT;
		$display("No button pressed at time %dns", $time);

		// All done
		#100
		$finish();

	end

endmodule
