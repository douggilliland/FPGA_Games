module dpRAM_interface(clk, addr, d_in, d_out, cs, wr,  rd);
  
  input clk;
  input [15:0]d_in;
  input cs;
  input [7:0]addr; // 8 LSB from j1_io_addr
  input rd;
  input wr;
  output [15:0]d_out;

//------------------------------------ regs and wires-------------------------------
  wire [15:0]d_in_p;
  wire [15:0]d_out_p;
  wire [7:0]addr_p; // 8 LSB from address
  wire rd_p;
  wire wr_p;
//------------------------------------ regs and wires-------------------------------


dualport_RAM dlptRAM (.clk(clk), .d_in_1(d_in), .d_out_1(d_out), .addr_1(addr), .rd_1(cs && rd), .wr_1(cs && wr), .d_in_2(d_in_p), .d_out_2(d_out_p), .addr_2(addr_p), .rd_2(rd_p), .wr_2(wr_p) );


core_peripheric c_p ( .clk(clk), .addr(addr_p), .d_in(d_out_p), .d_out(d_in_p), .wr(wr_p),  .rd(rd_p) );


endmodule
