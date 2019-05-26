`timescale 1ns / 1ps
module pruebaps2_TB;

	reg		       [7:0]  d_in;
  reg                 init;
  reg                 clk;
  reg                 reset;
  wire         [7:0]  DATA;
  wire                DONE;
  wire                Rx_error;
	pruebaps2  uut(.d_in(d_in),.init(init),.clk(clk),.DATA(DATA),.DONE(DONE),.Rx_error(Rx_error),.reset(reset));

	always
	begin
		clk =1'b1;
		#1;
		clk =1'b0;
		#1;
	end
	initial
	begin
		d_in=8'd12;
    init=0;
    reset = 0;
    #4;
    init=1;
	end

initial begin: TEST_CASE
     $dumpfile("pruebaps2_TB.vcd");
     $dumpvars(-1, uut);
     #(1000000) $finish;
   end

endmodule //
