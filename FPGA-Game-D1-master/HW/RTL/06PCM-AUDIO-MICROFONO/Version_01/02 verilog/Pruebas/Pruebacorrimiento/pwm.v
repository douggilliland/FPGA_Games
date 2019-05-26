module pwm
(
	input 		reset,	
	output 		ledres,
	input		clk,
	output		mclk,
        output    reg   ampPWM,
        output    reg	ampSD,
	input     [7:0] dout,
	input 		done1
 

);


reg [7:0] count;
initial ampSD <= 1;


always @(posedge  mclk )
begin

	if (reset)
		begin
     		ampPWM<=0;
    		end 
	else 
		begin
			if (count<8 && count >=0  )
				begin
				ampPWM<=dout[count];
				count<=count-1;
				end
			else
				begin
				count<=7;
				end
		end
		

		
	
end

endmodule
