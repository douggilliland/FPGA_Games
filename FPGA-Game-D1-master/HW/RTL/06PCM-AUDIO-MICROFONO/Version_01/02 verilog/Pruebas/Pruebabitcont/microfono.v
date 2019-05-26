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
	input		rd,wr,
	output		empty,
	output		full
	//output reg	done
	 

);

wire  dout;
wire dout1;

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

reg micData1;
assign dout1=dout;

initial micLRSel <= 0;

fifo fi(.reset(reset),.din(micData1),.dout(dout),.clock(mclk5),.rd(rd),.wr(wr),.empty(empty),.full(full));
pwm pw(.ampSD(ampSD), .reset(reset),.mcl(mclk3),.ampPWM(ampPWM),.clk(clk),.dout(dout1));
div_freq df(.clk(clk), .reset(reset),.clkout(mclk1),.led(ledres));




always @(posedge  mclk)
begin

	if (reset)
		begin
     		micData1=0;	
    		end 
	else 
		begin
		micData1=micData;
		end
	
	
end
endmodule

