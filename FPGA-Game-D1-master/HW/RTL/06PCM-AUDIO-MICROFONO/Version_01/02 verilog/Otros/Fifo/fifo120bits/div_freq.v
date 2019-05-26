module div_freq #(
              parameter   fi     = 50000000,        //<- fFPGA/2=fi  
              parameter   fs	 = 15000        //<- flckout=fs
  )(input clk, output reg clkout,input reset);

 //reg led

//initial led=0;

reg [31:0] count;
initial count<= fi/fs;

always @(posedge  clk)
begin
	if (reset) 
	begin
//	led=0;
	count <= fi/fs;
	clkout <=0;
	end
	else 	
	begin
//	led=1;
		
		if (count==0)begin
			clkout <=~clkout;
			count <= fi/fs;
		end	
		else begin
		count <=count-1;
		end

	end
end


endmodule
