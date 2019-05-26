module microfono
(
	input 		reset,	
	output 		ledres,
	input		clk,
	output		mclk,
	output    reg   micLRSel,
        input           micData,    
        output          ampPWM,
        output          ampSD,
	input		enable
	//output 	done
	 

);
reg micData1;
wire mclk1;
wire mclk3;
wire mclk2;
wire mclk4;
wire mclk5;
assign mclk5=mclk4;
assign mclk4=mclk3;
assign mclk3=mclk2;
assign mclk2=mclk1;
assign mclk=mclk1;

//wire dout1;
//assign dout1=dout;

initial micLRSel <= 0;
//initial done=0;

pwm pw(.ampSD(ampSD), .reset(reset),.mcl(mclk5),.ampPWM(ampPWM),.clk(clk),.dout(micData1),.enable(enable));
div_freq df(.clk(clk), .reset(reset),.clkout(mclk1),.led(ledres));



always @(posedge  mclk)
begin

	if (reset)
		begin
     		micData1<=0;
    		end 
	else 
		begin
		micData1<=micData;
		end
	
	
end

endmodule

