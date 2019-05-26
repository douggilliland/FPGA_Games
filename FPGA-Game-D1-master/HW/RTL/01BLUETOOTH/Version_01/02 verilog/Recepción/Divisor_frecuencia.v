module Divisor_frecuencia
(
	input reset, 
	input clk, 
	output reg clk_f
);

reg [31:0] count;

initial begin
clk_f=0;
end

always @(posedge  clk)
begin
    if (reset)
    begin
        count<=0;
        clk_f<=0;
    end
    else
    begin
		if (count==5200)
        begin
			clk_f <=~clk_f;
			count <= 0;
	    end	
        else begin
            count <= count + 1;
        end
    end
end
endmodule
