module pwm
(
	input 		reset,	
	output 		ledres,
	input		clk,
	output		mclk,		   
        output    reg   ampPWM,
        output    reg	ampSD,
	output 		full,
	output		empty,
	input		doutmic,
	input 		enable	

);
wire done;
wire dout;
wire mclk1;
wire mclk3;
wire mclk2;

assign mclk3=mclk2;
assign mclk2=mclk1;
assign mclk=mclk1;
wire done1;
assign done1=done;

div_freq df(.clk(clk), .reset(reset),.clkout(mclk1),.led(ledres));
fifo fi(.reset(reset),.din(doutmic),.dout(dout),.clock(mclk3),.rd(done1),.wr(wr),.empty(empty),.full(full));

initial ampSD <= 1;
initial done=0;

always @(posedge  mclk)
begin

	if (reset)
		begin
     		ampPWM=0;
    		end 
	else 
		begin
		if (enable)
		ampPWM=dout;
		done=~done;
		end
		

end

endmodule
