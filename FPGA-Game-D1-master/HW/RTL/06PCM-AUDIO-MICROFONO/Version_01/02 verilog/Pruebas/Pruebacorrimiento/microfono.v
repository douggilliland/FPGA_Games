module microfono
(
	input 		reset,	
	output 		ledres,
	input		clk,
	output		mclk,
	output    reg   micLRSel,
        input           micData,    
        output          ampPWM,
        output          ampSD
	 

);

wire mclk1;
wire mclk2;
assign mclk3=mclk2;
assign mclk2=mclk1;
assign mclk=mclk1;



reg [7:0] sregt;



initial micLRSel <= 0;

initial sregt <= 0;

pwm pw(.ampSD(ampSD), .reset(reset),.mclk(mclk3),.ampPWM(ampPWM),.clk(clk),.dout(sregt));
div_freq df(.clk(clk), .reset(reset),.clkout(mclk1),.led(ledres));


reg micData1;

always @(posedge  mclk)
begin

	if (reset)
		begin
     		sregt<=0;
    		end 
	else 
		begin
		micData1=micData;
		sregt<= {sregt[7:0],micData};
		end
	
	
end

endmodule

