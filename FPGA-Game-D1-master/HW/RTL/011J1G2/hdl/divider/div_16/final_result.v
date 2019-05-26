module final_result ( clk, rst, DEC, MSB, Result);
  input clk;
  input rst;
  input DEC;
  input MSB;
  output reg [15:0] Result;

always @(posedge clk) begin
  if(rst)
	Result=0;
  else if(DEC) begin

	if (MSB==0)
		Result= {Result[14:0],1'b1};
	else
		Result= {Result[14:0],1'b0};
  end

end

endmodule
