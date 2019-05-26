module microfono
(
	input 		reset,	
	output 		ledres,
	input		clk,
	output		mclk,
	output    reg   micLRSel,
        input           micData,    
        output    reg   ampPWM,
        output    reg   ampSD,
	output          mclk2,
	input		rd,wr,
	output		empty,
	output		full,
	output    	dout  

);

fifo fi(.reset(reset),.din(micData),.dout(dout),.clock(mclk),.rd(rd),.wr(wr),.empty(empty),.full(full));

wire mclk1;


assign mclk2=mclk1;
assign mclk=mclk1;
reg [31:0] count= 0;

initial micLRSel <= 0;
initial ampSD <= 1;
div_freq df(.clk(clk), .reset(reset),.clkout(mclk1),.led(ledres));

always @(posedge  mclk)
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
