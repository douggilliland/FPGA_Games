`timescale 1ns / 1ps
module show_score(
	clk,
	rst_n,
	col_addr_sig,
	row_addr_sig,
	levelup_sig,
	score_out_c
);
parameter bling = 26'd12_500_000;
input clk;
input rst_n;
input[10:0] col_addr_sig;
input[10:0] row_addr_sig;
input levelup_sig;
output  score_out_c;


reg[14:0] addra;
wire next;
wire next_sp;
reg next_c;
assign score_out_c=next_c;

reg show;
reg[25:0] count_down;
	
always @ ( posedge clk or negedge rst_n )
	begin 
		
		if( !rst_n )
			begin
				count_down	<=	26'd0;
				show <= 0;
			end
		else if( count_down >= bling)
			begin
				count_down	<=	26'd0;
				show <= ~show;
			end
		else
			count_down	<=	count_down + 1'b1;
	end
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
	begin
		addra <= 0;
	end
	else
	begin
		if (col_addr_sig >= 12'd40 && col_addr_sig < 12'd280 && row_addr_sig >= 12'd210 && row_addr_sig < 12'd330)
			begin
				addra <= (row_addr_sig - 12'd210) * 240 + col_addr_sig - 12'd40;
			end		
	else
		addra <= 0;
	end
end

always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		begin
			next_c <= 0;
		end
	else
	begin
		if (col_addr_sig >= 12'd40 && col_addr_sig < 12'd280 && row_addr_sig >= 12'd210 && row_addr_sig < 12'd330)
		begin
			if (levelup_sig && show)
				next_c <= ~next_sp;
			else
				next_c <= ~next;
      end		
		else
			next_c <= 0;
	end
end

score score (
	.clka(clk), // input clka
	.addra(addra), // input [15 : 0] addra
	.douta(next) // output [1 : 0] douta
);

spscore spscore (
	.clka(clk), // input clka
	.addra(addra), // input [15 : 0] addra
	.douta(next_sp) // output [1 : 0] douta
);

endmodule
