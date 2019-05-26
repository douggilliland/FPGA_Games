module subtractor (clk , rst, DV0, in_A , in_B , MSB , Result); // Result = in_A  - in_B   // Reslut en C2s
  input clk;
  input rst;
  input DV0;
  input [15:0] in_A;
  input [15:0] in_B;  
  
  output reg MSB=0;
  output reg [15:0] Result=0;



always @(negedge clk) begin
  if(rst) begin 
	Result=0;
  end
  else 
  if(DV0==1) begin
  Result= in_A + (~in_B)+1;
  end 
  else Result=Result;
end


always @(*) begin
if(in_A < in_B) MSB=1;
else MSB=0;
end

endmodule
