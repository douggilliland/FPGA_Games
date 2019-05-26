module div_freq #(
              parameter   fi     = 100000000 ,           
              parameter   fs	 = 20000000        
  )(input clk, output reg clkout,input reset);





reg [15:0] count;

always @(posedge  clk)
begin
	if (reset) begin
		count <= fi/fs;
		clkout <=0;
	end
	else begin
		count <=count-1;
		if (count==0)begin
			clkout <=~clkout;
			count <= fi/fs;
		end	
	end	
end


endmodule
