module acc (clk , A, add, rst, pp);
  input clk;
  input [31:0] A;
  input add;
  input rst; 
  output reg [31:0] pp;

initial pp = 0;

always @(negedge clk)
  if (rst) 
   pp = 32'h00000000;
  else
     begin
      if (add) pp = pp + A;
      else pp = pp;
     end
endmodule
