
// ============================================================================
// TESTBENCH FOR TINYCPU
// ============================================================================

module j1_TB ();

reg sys_clk_i, sys_rst_i;
reg [15:0] io_din;

wire io_rd, io_wr; 
wire [11:0] io_addr; 
wire [15:0] io_dout; 

j1 uut (
	sys_clk_i, sys_rst_i, io_din, io_rd, io_wr, io_addr, io_dout
);

initial begin
  sys_clk_i   = 1;
  sys_rst_i = 1;
  #10 sys_rst_i = 0;
  io_din = 20;

end

always sys_clk_i = #1 ~sys_clk_i;


initial begin: TEST_CASE
  $dumpfile("j1_TB.vcd");
  $dumpvars(-1, uut);
  #100000 $finish;
end

endmodule
