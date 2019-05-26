module  touch (
                  input		          Rx,
			            input		          clk,
			            output	reg	      Rx_error,
			            output	    [7:0]	DATA,
		            	output	reg	      DONE,
                  output  reg       CLKOUT
                );
  ps2	         p1   (
			                .Rx         ( Rx        ),
			                .CLKOUT     ( CLKOUT    ),
			                .Rx_error   ( Rx_error  ),
			                .DATA       ( DATA      ),
		                	.DONE       ( DONE      )
		                );
  divisorfrec	 df1  (
				              .clk        ( clk       ),
				              .CLKOUT     ( CLKOUT    )
			              );
  divisorfrec	 df2  (
				              .clk        ( clk       ),
				              .CLKOUT     ( CLKOUT    )
			              );
