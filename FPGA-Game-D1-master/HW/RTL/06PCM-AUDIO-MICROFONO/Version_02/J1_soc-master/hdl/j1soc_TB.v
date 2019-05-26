`timescale 1ns / 1ns
// ============================================================================
// TESTBENCH FOR TINYCPU
// ============================================================================

module j1soc_TB ();

reg sys_clk_i, sys_rst_i, miso;
wire  uart_tx, ledout, sclk, mosi, ss, cs, j1_io_addr; 

j1soc uut (.sys_clk_i(sys_clk_i), .sys_rst_i(sys_rst_i), .miso(miso), .sclk(sclk), .mosi(mosi), .ss(ss));

initial begin
  sys_clk_i   = 0;
  sys_rst_i = 1;
  #10 sys_rst_i = 0;
  	

end

always sys_clk_i = #1 ~sys_clk_i;


initial begin: TEST_CASE
  $dumpfile("j1soc_TB.vcd");
  $dumpvars(-1, uut);
  #800000 $finish;
end

endmodule
