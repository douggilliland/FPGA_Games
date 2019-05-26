module pwm
(
	input 		reset,	
	output 		ledres,
	input		clk,
	output		mclk,
        input           micData,    
        output    reg   ampPWM,
        output    reg	ampSD,
	input     [7:0] dout
 

);


reg [7:0] count;
initial ampSD <= 1;


always @(posedge  mclk)
begin
count<=0;
	if (reset)
		begin
     		ampPWM<=0;
    		end 
	else 
		begin
		if (count<=7)
			begin
			ampPWM<=dout[count];
			count<=count+1;
			end
		else
			begin
			count<=0;
			end
		end
	
	
end

endmodule
