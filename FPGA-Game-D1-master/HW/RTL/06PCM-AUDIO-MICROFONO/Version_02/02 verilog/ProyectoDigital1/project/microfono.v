module microfono (input reset, input clk, input enable, input d_in, output reg [17:0] d_out, output ws, output bclk);


wire reset_in;
reg [4:0] count;
DivFreq (.RESET(reset_in),.CLK(clk),.EN_CLK(enable),.BCLK(bclk));
Comp (.COUNT(count),.COUNT18,.COUNT32);//

always @(posedge  clk) begin
	if (reset) begin
	reset_in<=1;
	end
		
end

always @(posedge BCLK)
		if (reset_in) begin
			d_out<=0;
			count <=0;
			done =0;
			ws =0;
			EN_CLK=0;//

		end else begin 

			
			if (count < 24) begin 
			d_out = d_out << 1;
			d_out[0] = d_in;

			end else if (count ==32) begin 
				count <=0;
				done <=1;
				ws=~ws;
			end
			count>=count +1;
			
				
		end
		end
endmodule
