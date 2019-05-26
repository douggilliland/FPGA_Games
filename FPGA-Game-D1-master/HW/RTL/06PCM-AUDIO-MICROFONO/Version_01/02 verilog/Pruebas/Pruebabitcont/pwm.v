module pwm
(
	input 		reset,	
	output 		ledres,
	input		clk,
	input		mcl,
        //input           micData,    
        output    reg   ampPWM,
        output    reg	ampSD,
	input      dout
 

);


	
initial ampSD <= 1;


always @(posedge  mcl)
begin
	if (reset)
		begin
     		ampPWM<=0;
    		end 
	else 
		begin
		ampPWM<=dout;
		
		end
	
	
end

endmodule
