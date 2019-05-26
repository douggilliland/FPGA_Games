
// ============================================================================
// TESTBENCH FOR TINYCPU
// ============================================================================

module j1soc_TB ();

reg sys_clk_i, sys_rst_i;
wire  uart_tx, ledout; 

j1soc uut (
	 uart_tx, ledout, sys_clk_i, sys_rst_i
);

initial begin
  sys_clk_i   = 1;
  sys_rst_i = 1;
  #10 sys_rst_i = 0;

end

always sys_clk_i = #1 ~sys_clk_i;


initial begin: TEST_CASE
  $dumpfile("j1soc_TB.vcd");
  $dumpvars(-1, uut);
  #80000 $finish;
end

endmodule
