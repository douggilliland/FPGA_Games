module Shift7 (input clkS, input reset, input flag, input [6:0] Din, output Dout);

reg [6:0] temp;

always @(posedge clkS, posedge reset)
begin
	if(reset)
		temp<=Din;
	else
		temp<={temp[5:0],1'b0};
end

assign Dout=temp[6];
endmodule
