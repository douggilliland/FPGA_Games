`timescale 1ns / 1ps
module vga_select_module
 (clk, rst_n, start_sig, hsync, vsync, red, green, blue, 
	gameready_sig, ready_hsync, ready_vsync, ready_red_sig, ready_green_sig, ready_blue_sig,
	over_sig, over_hsync, over_vsync, over_red_sig, over_green_sig, over_blue_sig,
	hsync_out, vsync_out, red_out, green_out, blue_out
 );
 input clk;
 input rst_n;
 input start_sig;
 input hsync;
 input vsync;
 input red;
 input green;
 input blue;
 input gameready_sig;
 input ready_hsync;
 input ready_vsync;
 input ready_red_sig;
 input ready_green_sig;
 input ready_blue_sig;
 input over_sig;
 input over_hsync;
 input over_vsync;
 input over_red_sig;
 input over_green_sig;
 input over_blue_sig;
 output hsync_out;
 output vsync_out;
 output red_out;
 output green_out;
 output blue_out;
 
 /**************************************************/
 
 reg hsync_out_r;
 reg vsync_out_r;
 reg red_out_r;
 reg green_out_r;
 reg blue_out_r;
 
 always @ ( posedge clk or negedge rst_n )
	begin 
		if( !rst_n )
		begin 
			hsync_out_r <= ready_hsync;
			vsync_out_r <= ready_vsync;
			red_out_r <= ready_red_sig;
			green_out_r <= ready_green_sig;
			blue_out_r <= ready_blue_sig; 
		end
		else if( { gameready_sig, start_sig, over_sig } == 3'b010 )
		begin
			hsync_out_r <= hsync;
			vsync_out_r <= vsync;
			red_out_r <= red;
			green_out_r <= green;
			blue_out_r <= blue; 
		end
		else if( { gameready_sig, start_sig, over_sig } == 3'b001 )
		begin
			hsync_out_r <= over_hsync;
			vsync_out_r <= over_vsync;
			red_out_r <= over_red_sig;
			green_out_r <= over_green_sig;
			blue_out_r <= over_blue_sig;  
		end
		else 
		begin
			hsync_out_r <= ready_hsync;
			vsync_out_r <= ready_vsync;
			red_out_r <= ready_red_sig;
			green_out_r <= ready_green_sig;
			blue_out_r <= ready_blue_sig; 
		end  
   end 
   
 /**************************************************/
 
 assign hsync_out = hsync_out_r;
 assign vsync_out = vsync_out_r;
 assign red_out = red_out_r;
 assign green_out = green_out_r;
 assign blue_out = blue_out_r;
 
 /**************************************************/
 
 endmodule
 