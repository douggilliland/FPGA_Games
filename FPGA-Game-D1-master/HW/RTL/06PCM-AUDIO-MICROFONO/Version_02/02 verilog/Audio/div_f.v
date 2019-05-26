module div_f #(
              parameter   fi     = 1 ,           
              parameter   fs	 = 4        
)(clk,reset,bclk);
input clk; //fpga
input  reset;
output reg bclk;

reg [15:0] count;
always @(posedge clk) 

begin
	if (reset)
			begin
			count <= fi/fs;
			bclk<=0;
			end
	else
		begin
		count <= count-1;
		if (count==0)
			begin
			bclk <=~bclk;
			count <= fi/fs;
			end	
		end
end
endmodule
