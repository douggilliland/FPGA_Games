module  teclado (
                  input		          Rx,
			            input		          clk,
			            //output	  	      Rx_error,
			            output	    [7:0]	DATA,
		            	output    	      DONE,
                  output            CLKOUTt
                );
  psdos	       psdos0     (
			                      .Rx         ( Rx        ),
			                      .CLKOUT     ( CLKOUT    ),
			                      //.Rx_error   ( Rx_error  ),
			                      .DATA       ( DATA      ),
		                      	.DONE       ( DONE      )
		                      );
  divisorfrec	 dfuno      (
				                    .clk        ( clk       ),
				                    .CLKOUT     ( CLKOUT    )
			                    );
  divisorfrec	 dfdos      (
				                    .clk        ( clk       ),
				                    .CLKOUT     ( CLKOUTt   )
			                    );
endmodule
