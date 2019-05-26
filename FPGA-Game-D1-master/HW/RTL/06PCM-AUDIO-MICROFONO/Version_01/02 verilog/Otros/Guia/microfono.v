module microfono
(
	input 		reset,	
	output 		ledres,
	input		clk,
	output		mclk,
	output    reg   micLRSel,
        input           micData,    
        output      reg    ampPWM,
        output   reg       ampSD,
	output           mclk2,
	output  reg [15:0] sregt

);

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
     		ampPWM <= micData;
		sregt<= {sregt[15:0],micData};
    		end 
	else ampPWM<=0;
	
end




endmodule
