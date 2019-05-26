`timescale 1ns / 1ps
module game_display
(clk, rst_n, ready_sig, enable_red_border, enable_blue_moving, enable_blue_little_flag, 
	next_yellow_display, red, green, blue,next_c,score_out_c,score
);
input clk;
input rst_n;
input ready_sig;
input enable_red_border;
input enable_blue_moving;
input enable_blue_little_flag;
input next_yellow_display;
input next_c;
input score_out_c;
input score;
output red;
output green;
output blue;
 
 

				
reg isred;
reg isgreen;
reg isblue;

always @ ( posedge clk or negedge rst_n )
	begin 
		if( !rst_n )
		begin 
			isred <= 1'b0;
			isgreen <= 1'b0;
			isblue <= 1'b0;
		end
	else if( ready_sig )
		begin
			isgreen <= score|enable_red_border | next_yellow_display|enable_blue_little_flag| score|next_c;			
			isred <= next_yellow_display|next_c|score_out_c;//ÓÃÓÚÏÔÊ¾next×Ö·û
			isblue <= score|enable_blue_little_flag|enable_blue_moving|next_c;
		end
	end
          
 /**************************************************/
 
 assign red = isred;
 assign green = isgreen;
 assign blue = isblue;
 
 /**************************************************/
 
 endmodule