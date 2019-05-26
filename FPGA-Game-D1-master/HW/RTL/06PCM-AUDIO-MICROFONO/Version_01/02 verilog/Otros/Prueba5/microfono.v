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
	output		full,
	output reg	done
	//output 	  [7:0] dout,
	 

);

wire [320:0] dout;
wire [320:0] dout1;
wire mclk1;
wire mclk2;
assign mclk3=mclk2;
assign mclk2=mclk1;
assign mclk=mclk1;
reg [320:0] sregt1;

reg [320:0] sregt;

fifo fi(.reset(reset),.din(sregt1),.dout(dout),.clock(done),.rd(rd),.wr(wr),.empty(empty),.full(full));
pwm pw(.ampSD(ampSD), .reset(reset),.mclk(mclk2),.ampPWM(ampPWM),.clk(clk),.dout(dout1));
div_freq df(.clk(clk), .reset(reset),.clkout(mclk1),.led(ledres));


reg [320:0] count;


assign dout1=dout;

initial micLRSel <= 0;
initial count <= 0;
initial sregt <= 0;
initial sregt1 <= 0;

always @(posedge  mclk)
begin

	if (reset)
		begin
     		sregt<=0;
    		end 
	else 
		begin
		if(count<=320)
			begin
			sregt<= {sregt[320:0],micData};	
			count<=count+1;	
			done<=0;
			end
			else		
			begin
			count<=0;
			done<=1;
			sregt1<=sregt;
			end
		end
	
	
end

endmodule

