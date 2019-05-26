module mult_32(clk , rst , init , A , B , pp , done);
  
  input rst;
  input clk;
  input init;
  input [15:0]A;
  input [15:0]B;
  output [31:0]pp;
  output done;

  wire w_sh;
  wire w_reset;
  wire w_add;
  wire w_z;
  
  wire [31:0]w_A;
  wire [15:0] w_B;
  
 
  rsr rsr0 (.clk(clk), .in_B(B) , .shift(w_sh) , .load(w_reset) , .s_B(w_B));
  lsr lsr0 (.clk(clk), .in_A(A) , .shift(w_sh) , .load(w_reset) , .s_A(w_A));
  comp comp0(.B(w_B), .z(w_z));
  acc acc0 (.clk(clk), .A(w_A) , .add(w_add), .rst(w_reset), .pp(pp));
  control_mult control0 (.clk(clk), .rst(rst) , .lsb_B(w_B[0]) , .init(init) , .z(w_z) , .done(done) , .sh(w_sh) , .reset(w_reset) , .add(w_add) );
  
  
  

endmodule


