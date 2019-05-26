`timescale 1ns / 1ps

module game_sync_module
 (clk, rst_n, col_addr_sig, row_addr_sig, hsync, vsync, ready_sig
 );
 input clk;
 input rst_n;
 output[10:0] col_addr_sig;
 output[10:0] row_addr_sig;
 output hsync;
 output vsync;
 output ready_sig;
 
 /**************************************************/
 
 reg[10:0] cnt_h;
 
 always @ ( posedge clk or negedge rst_n )
   begin
     if( !rst_n )
        cnt_h <= 11'd0;
     else if( cnt_h == 11'd799 )
        cnt_h <= 11'd0;
     else cnt_h <= cnt_h + 1'b1;
   end
   
 /**************************************************/   
         
 reg[10:0] cnt_v;
 
 always @ ( posedge clk or negedge rst_n )
   begin  
     if( !rst_n )
       cnt_v <= 11'd0;
     else if( cnt_v == 11'd523 )
       cnt_v <= 11'd0;
     else if( cnt_h == 11'd799 )
       cnt_v <= cnt_v + 1'b1;
   end 
   
 /**************************************************/
 
 reg isready;
 
 always @ ( posedge clk or negedge rst_n )
   begin
     if( !rst_n )
        isready <= 1'b0;
     else if( cnt_h >= 11'd143 && cnt_h < 11'd783 && cnt_v >= 11'd32 && cnt_v < 11'd512 )
        isready <= 1'b1;
     else isready <= 1'b0;
   end
   
 /**************************************************/
 
 assign hsync = ( cnt_h <= 11'd95 ) ? 1'b0 : 1'b1;
 assign vsync = ( cnt_v <= 11'd1 ) ? 1'b0 : 1'b1;
 assign col_addr_sig = isready ? ( cnt_h - 11'd143 ) : 11'd0;
 assign row_addr_sig = isready ? ( cnt_v - 11'd32 ) : 11'd0;
 assign ready_sig = isready;
 
 /**************************************************/
 
 endmodule