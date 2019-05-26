module  pruebaps2 (
                    input       [7:0] d_in,
                    input             init,
                    input             clk,
                    input             reset,
                    output      [7:0]	DATA,
		        	      output    	      DONE,
		        	      output    	      Rx_error
                  );
  //wire    CLKOUT0;
  //assign  CLKOUT0 = 
   ps2	           p1   (
			                      .Rx       (  Rx       ),
			                      .CLKOUT   (  CLKOUT   ),
			                      .Rx_error (  Rx_error ),
                            .DATA     (  DATA     ),
		            	          .DONE     (  DONE     )
		                    );
  divisorfrec      df1	(
                            .clk      (  clk      ),
				                    .CLKOUT   (  CLKOUT   )
			                  );
  genpulsos	       gen  (
											      .init     (  init     ),
											      .CLKOUT1  (  CLKOUT1  ),
											      .reset    (  reset    ),
											      .enable   (  enable   )
			                  );
  divisorfrecgen   dfg  (
				                    .clk      (  clk      ),
				                    .CLKOUT1  (  CLKOUT1  )
			                  );


  divisorfrec      df2  (
                            .clk      (  clk      ),
				                    .CLKOUT   (  CLKOUT   )
			                  );

  transmitirps2    tp2  (
                            .d_in     (  d_in     ),
                            .enable   (  enable   ),
                            .CLKOUT   (  CLKOUT   ),
                            .Rx       (  Rx       )
                        );
endmodule
