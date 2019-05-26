module Divisor_Frecuencia(input clk_in, input reset, output reg clk_div);

reg [31:0] count;

initial begin
clk_div=0;
end

always @(posedge  clk_in)
begin
    if (reset)
    begin
        count<=0;
        clk_div<=0;
    end
    else
    begin
		if (count==1300)
        begin
			clk_div <=~clk_div;
			count <= 0;
	    end	
        else begin
            count <= count +1;
        end
    end
end
endmodule
