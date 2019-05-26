module  maquinadeestados  (
                                  input   clk,
                                  input   orden,
                                  output  ENABLE,
                                  output  reset
                           );
meultrasonido meultrasonido0    (
                                  .reset    ( reset   ),
                                  .ENABLE   ( ENABLE  ),
                                  .CLKOUT2  ( CLKOUT2 ),
                                  .orden    ( orden   )
                                );

divisorfrecme divisorfrecme0    (
                                  .clk      ( clk     ),
                                  .CLKOUT2  ( CLKOUT2 )
                                );
endmodule
