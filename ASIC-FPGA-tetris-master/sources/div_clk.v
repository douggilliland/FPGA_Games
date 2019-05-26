`timescale 1ns / 1ps
module div_clk(
	rst_n,
	sys_clk,
	clk
);
input rst_n;
input sys_clk;
output clk;
reg clk;
reg[1:0] h;

always@(posedge sys_clk)
	if(!rst_n)
		begin
			h <= 0;
			clk <= 0;
		end


else
	if(h == 2'b00)
		begin
			clk <= 0;
			h <= h + 1;
		end
	else if(h == 2'b01)
		begin
			clk <= 0;
			h <= h + 1;
		end
	else if(h == 2'b10)
		begin
			clk <= 1'b1;
			h <= h + 1;
		end
	else
		begin
			clk <= 1'b1;
			h <= h + 1;
		end

endmodule
