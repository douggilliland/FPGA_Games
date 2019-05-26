module microfono
(
	input 		reset,	
	output 		ledres,
	input		clk,
	output		mclk,
	output    reg   micLRSel,
        input           micData,   
	output 	        dout,
	output 		full,
	output		empty,
	input		enable,
	output          dout
	 

);
reg micData1;
reg done;
wire mclk1;
wire mclk3;
wire mclk2;

assign mclk3=mclk2;
assign mclk2=mclk1;
assign mclk=mclk1;

initial micLRSel <= 0;
initial done=0;
wire rd1;
assign rd1=0;


fifo fi(.reset(reset),.din(micData1),.dout(dout),.clock(mclk3),.rd(rd1),.wr(done),.empty(empty),.full(full));

div_freq df(.clk(clk), .reset(reset),.clkout(mclk1),.led(ledres));




always @(posedge  mclk)
begin

	if (reset)
		begin
     		micData1<=0;
    		end 
	else 
		begin
			if(enable)
			begin
			micData1<=micData;
			done=~done;
			end
		end
	
	
end

endmodule

