`timescale 1ns / 1ps
module transmitirps2_TB;

	reg       [7:0] d_in   ;
  reg             enable ;
  reg             CLKOUT ;
  wire            Rx     ;
  
	transmitirps2  uut  (
                        .d_in     ( d_in    ),
                        .enable   ( enable  ),
                        .CLKOUT   ( CLKOUT  ),
                        .Rx       ( Rx      )
                      );

	always
	begin
		CLKOUT = 1'b1;
		#1;
		CLKOUT = 1'b0;
		#1;
	end
	initial
	begin
		d_in   = 7'd12;
    enable = 0;
    #4;
    enable=1;
	end

initial begin: TEST_CASE
     $dumpfile("transmitirps2_TB.vcd");
     $dumpvars(-1, uut);
     #(1000000) $finish;
   end

endmodule //
