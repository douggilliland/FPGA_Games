`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:44:56 05/07/2016 
// Design Name: 
// Module Name:    display_border 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//



//边界显示模块，到时候只需要修改一下参数就可以了
//////////////////////////////////////////////////////////////////////////////////
 module display_border
 (clk, rst_n, col_addr_sig, row_addr_sig, enable_red_border
 );
 input clk;
 input rst_n;
 input[10:0] col_addr_sig;
 input[10:0] row_addr_sig;
 output enable_red_border;
 
 /**************************************************/
 
 parameter h_start = 11'd391;
 parameter v_start = 11'd31;
 parameter border_width = 11'd10;
 
 /**************************************************/
 
 reg enable_red_out_h;
 reg enable_red_out_v;
 
 always @ ( posedge clk or negedge rst_n )
   begin
     if( !rst_n )
        enable_red_out_h <= 1'b0;
     else if( col_addr_sig == h_start ) 
        enable_red_out_h <= 1'b1;
     else if( col_addr_sig == h_start + 11'd220 )
        enable_red_out_h <= 1'b0;
     else 
        enable_red_out_h <= enable_red_out_h;
   end
   
 always @ ( posedge clk or negedge rst_n )
   begin 
     if( !rst_n )
        enable_red_out_v <= 1'b0;
     else if( row_addr_sig == v_start )
        enable_red_out_v <= 1'b1;
     else if( row_addr_sig == v_start + 11'd420 ) 
        enable_red_out_v <= 1'b0;
     else 
        enable_red_out_v <= enable_red_out_v;
   end
   
 /**************************************************/
 
 reg enable_red_in_h;
 reg enable_red_in_v;
 
 always @ ( posedge clk or negedge rst_n )
   begin
     if( !rst_n )
        enable_red_in_h <= 1'b0;
     else if( col_addr_sig == h_start + border_width ) 
        enable_red_in_h <= 1'b1;
     else if( col_addr_sig == h_start + 11'd210 )
        enable_red_in_h <= 1'b0;
     else 
        enable_red_in_h <= enable_red_in_h;
   end
   
 always @ ( posedge clk or negedge rst_n )
   begin 
     if( !rst_n )
        enable_red_in_v <= 1'b0;
     else if( row_addr_sig == v_start + border_width )
        enable_red_in_v <= 1'b1;
     else if( row_addr_sig == v_start + 11'd410 ) 
        enable_red_in_v <= 1'b0;
     else 
        enable_red_in_v <= enable_red_in_v;
   end
   
 /**************************************************/
 
 reg rred_border;
 
 always @ ( posedge clk or negedge rst_n )
   begin 
     if( !rst_n )
        rred_border <= 1'b0;
     else 
        rred_border <= ( enable_red_out_h && enable_red_out_v ) && ( !( enable_red_in_h && enable_red_in_v ) );
   end
   
 /**************************************************/
 
 assign enable_red_border = rred_border;
 
 /**************************************************/
 
 endmodule
 
