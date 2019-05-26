module altavoz
(
	input		enable,
	input 		[15:0] sregt,
	input		clk,
	output		bclk,
	output		rlclk,
	output  	dataout,
	input		reset,
	output		done

);

reg [16:0] count=0;
reg done=0;
reg rlclk=0;
reg [15:0] sreg=16'h0;
wire init;



div_freq df(.clk(clk), .reset(reset),.clkout(bclk));
assign init =(count==0)?1:0;
assign dataout = sreg[15];

	
always @(posedge  bclk)
begin
	
	if (init)
		sreg <= sregt;	
	 if (enable) 
		begin
		if (count<=15)  /*envia bit por bit*/
			begin
			sreg<=sreg<<1;		
			count<=count+1;
			end
		
		else 
			begin
			rlclk=!rlclk;     /* habilita canal R/L*/
			count<=0;   
			done<=1;     /* confirma que ya se enviaron todos los bits*/
			end								
						
	end	


end

endmodule


