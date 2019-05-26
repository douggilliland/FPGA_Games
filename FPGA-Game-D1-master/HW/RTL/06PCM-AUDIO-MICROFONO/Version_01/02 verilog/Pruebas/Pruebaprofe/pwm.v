module pwm
(
	input 		reset,	
	output 		ledres,
	input		clk,
	output		mcl,
        input           micData,    
        output    reg   ampPWM,
        output    reg	ampSD,
	input     	dout,
	output 	reg	done1,
	input 		empty1
 

);


initial ampSD <= 1;
initial done1<= 0;

always @(posedge  mcl )
begin

	if (reset)
		begin
     		ampPWM<=0;
    		end 
	else 
		begin
			if(~empty1)
			begin
			ampPWM<=dout;
			done1<=~done1;
			end
			else 
			begin
		        done1<=0;
			end
		end
		

		
	
end

endmodule
