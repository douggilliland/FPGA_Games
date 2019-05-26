`timescale 1ns / 1ps

module v_speed_debouncer(clk,rst_n,invs,outvs
    );
	 
input clk;
input rst_n;
input invs;
output outvs;

reg[2:0] counter;
reg outvs;


always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
	begin
		counter<=3'd0;
		outvs<=1'b0;
	end
else 
	begin
		if(invs)
			begin
				counter<=3'b0;
				outvs<=1'b0;
			end
		else
		begin
		if(counter<3'd7)
			begin
				counter<=counter+1'b1;
				outvs<=1'b0;
			end
		else 
			begin
				counter<=counter;
				outvs<=1'b1;
			end
		end
	end


end



endmodule
