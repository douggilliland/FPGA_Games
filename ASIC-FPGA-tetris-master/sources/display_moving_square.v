`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:54:02 05/07/2016 
// Design Name: 
// Module Name:    display_moving_square 
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
//////////////////////////////////////////////////////////////////////////////////
module display_moving_square
 (clk, rst_n, col_addr_sig, row_addr_sig, h, v, enable_moving, enable_blue_moving 
 );
 input clk;
 input rst_n;
 input[10:0] col_addr_sig;
 input[10:0] row_addr_sig;
 input[10:0] h;
 input[10:0] v;
 input[15:0] enable_moving;
 output enable_blue_moving;
 
 /**************************************************/
 
 reg[15:0] enable_blue_moving_h;
 
 always @ ( posedge clk or negedge rst_n )
   begin
     if( !rst_n )
        enable_blue_moving_h[0] <= 1'b0;
     else if( enable_moving[0] == 1'b1 )
        begin
          if( col_addr_sig == h - 11'd2 )
             enable_blue_moving_h[0] <= 1'b1;
          else if( col_addr_sig == h + 11'd17 )
             enable_blue_moving_h[0] <= 1'b0;
          else 
             enable_blue_moving_h[0] <= enable_blue_moving_h[0]; 
        end
     else
        enable_blue_moving_h[0] <= 1'b0;
   end
   
 always @ ( posedge clk or negedge rst_n )
   begin
     if( !rst_n )
        enable_blue_moving_h[1] <= 1'b0;
     else if( enable_moving[1] == 1'b1 )
        begin
          if( col_addr_sig == h + 11'd18 )
             enable_blue_moving_h[1] <= 1'b1;
          else if( col_addr_sig == h + 11'd37 )
             enable_blue_moving_h[1] <= 1'b0;
          else 
             enable_blue_moving_h[1] <= enable_blue_moving_h[1]; 
        end
     else
        enable_blue_moving_h[1] <=1'b0;
   end
   
 always @ ( posedge clk or negedge rst_n )
   begin
     if( !rst_n )
        enable_blue_moving_h[2] <= 1'b0;
     else if( enable_moving[2] == 1'b1 )
        begin
          if( col_addr_sig == h + 11'd38 )
             enable_blue_moving_h[2] <= 1'b1;
          else if( col_addr_sig == h + 11'd57 )
             enable_blue_moving_h[2] <= 1'b0;
          else 
             enable_blue_moving_h[2] <= enable_blue_moving_h[2]; 
        end
     else
        enable_blue_moving_h[2] <=1'b0;
   end
   
 always @ ( posedge clk or negedge rst_n )
   begin
     if( !rst_n )
        enable_blue_moving_h[3] <= 1'b0;
     else if( enable_moving[3] == 1'b1 )
        begin
          if( col_addr_sig == h + 11'd58 )
             enable_blue_moving_h[3] <= 1'b1;
          else if( col_addr_sig == h + 11'd77 )
             enable_blue_moving_h[3] <= 1'b0;
          else 
             enable_blue_moving_h[3] <= enable_blue_moving_h[3]; 
        end
     else
        enable_blue_moving_h[3] <= 1'b0;
   end                   
                        
 always @ ( posedge clk or negedge rst_n )
   begin
     if( !rst_n )
        enable_blue_moving_h[4] <= 1'b0;
     else if( enable_moving[4] == 1'b1 )
        begin
          if( col_addr_sig == h - 11'd2 )
             enable_blue_moving_h[4] <= 1'b1;
          else if( col_addr_sig == h + 11'd17 )
             enable_blue_moving_h[4] <= 1'b0;
          else 
             enable_blue_moving_h[4] <= enable_blue_moving_h[4]; 
        end
     else
        enable_blue_moving_h[4] <= 1'b0;
   end 
   
 always @ ( posedge clk or negedge rst_n )
   begin
     if( !rst_n )
        enable_blue_moving_h[5] <= 1'b0;
     else if( enable_moving[5] == 1'b1 )
        begin
          if( col_addr_sig == h + 11'd18 )
             enable_blue_moving_h[5] <= 1'b1;
          else if( col_addr_sig == h + 11'd37 )
             enable_blue_moving_h[5] <= 1'b0;
          else 
             enable_blue_moving_h[5] <= enable_blue_moving_h[5]; 
        end
     else
        enable_blue_moving_h[5] <=1'b0;
   end 
   
 always @ ( posedge clk or negedge rst_n )
   begin
     if( !rst_n )
        enable_blue_moving_h[6] <= 1'b0;
     else if( enable_moving[6] == 1'b1 )
        begin
          if( col_addr_sig == h + 11'd38 )
             enable_blue_moving_h[6] <= 1'b1;
          else if( col_addr_sig == h + 11'd57 )
             enable_blue_moving_h[6] <= 1'b0;
          else 
             enable_blue_moving_h[6] <= enable_blue_moving_h[6]; 
        end
     else
        enable_blue_moving_h[6] <= 1'b0;
   end 
   
 always @ ( posedge clk or negedge rst_n )
   begin
     if( !rst_n )
        enable_blue_moving_h[7] <= 1'b0;
     else if( enable_moving[7] == 1'b1 )
        begin
          if( col_addr_sig == h + 11'd58 )
             enable_blue_moving_h[7] <= 1'b1;
          else if( col_addr_sig == h + 11'd77 )
             enable_blue_moving_h[7] <= 1'b0;
          else 
             enable_blue_moving_h[7] <= enable_blue_moving_h[7]; 
        end
     else
        enable_blue_moving_h[7] <=1'b0;
   end 
   
 always @ ( posedge clk or negedge rst_n )
   begin
     if( !rst_n )
        enable_blue_moving_h[8] <= 1'b0;
     else if( enable_moving[8] == 1'b1 )
        begin
          if( col_addr_sig == h - 11'd2 )
             enable_blue_moving_h[8] <= 1'b1;
          else if( col_addr_sig == h + 11'd17 )
             enable_blue_moving_h[8] <= 1'b0;
          else 
             enable_blue_moving_h[8] <= enable_blue_moving_h[8]; 
        end
     else
        enable_blue_moving_h[8] <= 1'b0;
   end
   
 always @ ( posedge clk or negedge rst_n )
   begin
     if( !rst_n )
        enable_blue_moving_h[9] <= 1'b0;
     else if( enable_moving[9] == 1'b1 )
        begin
          if( col_addr_sig == h + 11'd18 )
             enable_blue_moving_h[9] <= 1'b1;
          else if( col_addr_sig == h + 11'd37 )
             enable_blue_moving_h[9] <= 1'b0;
          else 
             enable_blue_moving_h[9] <= enable_blue_moving_h[9]; 
        end
     else
        enable_blue_moving_h[9] <= 1'b0;
   end 
   
 always @ ( posedge clk or negedge rst_n )
   begin
     if( !rst_n )
        enable_blue_moving_h[10] <= 1'b0;
     else if( enable_moving[10] == 1'b1 )
        begin
          if( col_addr_sig == h + 11'd38 )
             enable_blue_moving_h[10] <= 1'b1;
          else if( col_addr_sig == h + 11'd57 )
             enable_blue_moving_h[10] <= 1'b0;
          else 
             enable_blue_moving_h[10] <= enable_blue_moving_h[10]; 
        end
     else
        enable_blue_moving_h[10] <=1'b0;
   end                            

 always @ ( posedge clk or negedge rst_n )
   begin
     if( !rst_n )
        enable_blue_moving_h[11] <= 1'b0;
     else if( enable_moving[11] == 1'b1 )
        begin
          if( col_addr_sig == h + 11'd58 )
             enable_blue_moving_h[11] <= 1'b1;
          else if( col_addr_sig == h + 11'd77 )
             enable_blue_moving_h[11] <= 1'b0;
          else 
             enable_blue_moving_h[11] <= enable_blue_moving_h[11]; 
        end
     else
        enable_blue_moving_h[11] <=1'b0;
   end 
   
 always @ ( posedge clk or negedge rst_n )
   begin
     if( !rst_n )
        enable_blue_moving_h[12] <= 1'b0;
     else if( enable_moving[12] == 1'b1 )
        begin
          if( col_addr_sig == h - 11'd2 )
             enable_blue_moving_h[12] <= 1'b1;
          else if( col_addr_sig == h + 11'd17 )
             enable_blue_moving_h[12] <= 1'b0;
          else 
             enable_blue_moving_h[12] <= enable_blue_moving_h[12]; 
        end
     else
        enable_blue_moving_h[12] <=1'b0;
   end 
   
 always @ ( posedge clk or negedge rst_n )
   begin
     if( !rst_n )
        enable_blue_moving_h[13] <= 1'b0;
     else if( enable_moving[13] == 1'b1 )
        begin
          if( col_addr_sig == h + 11'd18 )
             enable_blue_moving_h[13] <= 1'b1;
          else if( col_addr_sig == h + 11'd37 )
             enable_blue_moving_h[13] <= 1'b0;
          else 
             enable_blue_moving_h[13] <= enable_blue_moving_h[13]; 
        end
     else
        enable_blue_moving_h[13] <= 1'b0;
   end 
   
 always @ ( posedge clk or negedge rst_n )
   begin
     if( !rst_n )
        enable_blue_moving_h[14] <= 1'b0;
     else if( enable_moving[14] == 1'b1 )
        begin
          if( col_addr_sig == h + 11'd38 )
             enable_blue_moving_h[14] <= 1'b1;
          else if( col_addr_sig == h + 11'd57 )
             enable_blue_moving_h[14] <= 1'b0;
          else 
             enable_blue_moving_h[14] <= enable_blue_moving_h[14]; 
        end
     else
        enable_blue_moving_h[14] <=1'b0;
   end 
   
 always @ ( posedge clk or negedge rst_n )
   begin
     if( !rst_n )
        enable_blue_moving_h[15] <= 1'b0;
     else if( enable_moving[15] == 1'b1 )
        begin
          if( col_addr_sig == h + 11'd58 )
             enable_blue_moving_h[15] <= 1'b1;
          else if( col_addr_sig == h + 11'd77 )
             enable_blue_moving_h[15] <= 1'b0;
          else 
             enable_blue_moving_h[15] <= enable_blue_moving_h[15]; 
        end
     else
        enable_blue_moving_h[15] <=1'b0;
   end 
   
 /**************************************************/
 
 reg[15:0] enable_blue_moving_v;
 
 always @ ( posedge clk or negedge rst_n )
   begin
     if( !rst_n )
        enable_blue_moving_v[0] <= 1'b0;
     else if( enable_moving[0] == 1'b1 )
        begin
          if( row_addr_sig == v )
             enable_blue_moving_v[0] <= 1'b1;
          else if( row_addr_sig == v + 11'd19 )
             enable_blue_moving_v[0] <= 1'b0; 
          else 
             enable_blue_moving_v[0] <= enable_blue_moving_v[0];
        end
     else 
        enable_blue_moving_v[0] <=1'b0;
   end 
   
 always @ ( posedge clk or negedge rst_n )
   begin
     if( !rst_n )
        enable_blue_moving_v[4] <= 1'b0;
     else if( enable_moving[4] == 1'b1 )
        begin
          if( row_addr_sig == v + 11'd20 )
             enable_blue_moving_v[4] <= 1'b1;
          else if( row_addr_sig == v + 11'd39 )
             enable_blue_moving_v[4] <= 1'b0; 
          else 
             enable_blue_moving_v[4] <= enable_blue_moving_v[4];
        end
     else 
        enable_blue_moving_v[4] <=1'b0;
   end                             
 
 always @ ( posedge clk or negedge rst_n )
   begin
     if( !rst_n )
        enable_blue_moving_v[8] <= 1'b0;
     else if( enable_moving[8] == 1'b1 )
        begin
          if( row_addr_sig == v + 11'd40 )
             enable_blue_moving_v[8] <= 1'b1;
          else if( row_addr_sig == v + 11'd59 )
             enable_blue_moving_v[8] <= 1'b0; 
          else 
             enable_blue_moving_v[8] <= enable_blue_moving_v[8];
        end
     else 
        enable_blue_moving_v[8] <=1'b0;
   end  
   
 always @ ( posedge clk or negedge rst_n )
   begin
     if( !rst_n )
        enable_blue_moving_v[12] <= 1'b0;
     else if( enable_moving[12] == 1'b1 )
        begin
          if( row_addr_sig == v + 11'd60 )
             enable_blue_moving_v[12] <= 1'b1;
          else if( row_addr_sig == v + 11'd79 )
             enable_blue_moving_v[12] <= 1'b0; 
          else 
             enable_blue_moving_v[12] <= enable_blue_moving_v[12];
        end
     else 
        enable_blue_moving_v[12] <= 1'b0;
   end
   
 always @ ( posedge clk or negedge rst_n )
   begin
     if( !rst_n )
        enable_blue_moving_v[1] <= 1'b0;
     else if( enable_moving[1] == 1'b1 )
        begin
          if( row_addr_sig == v )
             enable_blue_moving_v[1] <= 1'b1;
          else if( row_addr_sig == v + 11'd19 )
             enable_blue_moving_v[1] <= 1'b0; 
          else 
             enable_blue_moving_v[1] <= enable_blue_moving_v[1];
        end
     else 
        enable_blue_moving_v[1] <=1'b0;
   end 
   
 always @ ( posedge clk or negedge rst_n )
   begin
     if( !rst_n )
        enable_blue_moving_v[5] <= 1'b0;
     else if( enable_moving[5] == 1'b1 )
        begin
          if( row_addr_sig == v + 11'd20 )
             enable_blue_moving_v[5] <= 1'b1;
          else if( row_addr_sig == v + 11'd39 )
             enable_blue_moving_v[5] <= 1'b0; 
          else 
             enable_blue_moving_v[5] <= enable_blue_moving_v[5];
        end
     else 
        enable_blue_moving_v[5] <=1'b0;
   end 
   
 always @ ( posedge clk or negedge rst_n )
   begin
     if( !rst_n )
        enable_blue_moving_v[9] <= 1'b0;
     else if( enable_moving[9] == 1'b1 )
        begin
          if( row_addr_sig == v + 11'd40 )
             enable_blue_moving_v[9] <= 1'b1;
          else if( row_addr_sig == v + 11'd59 )
             enable_blue_moving_v[9] <= 1'b0; 
          else 
             enable_blue_moving_v[9] <= enable_blue_moving_v[9];
        end
     else 
        enable_blue_moving_v[9] <=1'b0;
   end 
   
 always @ ( posedge clk or negedge rst_n )
   begin
     if( !rst_n )
        enable_blue_moving_v[13] <= 1'b0;
     else if( enable_moving[13] == 1'b1 )
        begin
          if( row_addr_sig == v + 11'd60 )
             enable_blue_moving_v[13] <= 1'b1;
          else if( row_addr_sig == v + 11'd79 )
             enable_blue_moving_v[13] <= 1'b0; 
          else 
             enable_blue_moving_v[13] <= enable_blue_moving_v[13];
        end
     else 
        enable_blue_moving_v[13] <=1'b0;
   end 
   
 always @ ( posedge clk or negedge rst_n )
   begin
     if( !rst_n )
        enable_blue_moving_v[2] <= 1'b0;
     else if( enable_moving[2] == 1'b1 )
        begin
          if( row_addr_sig == v )
             enable_blue_moving_v[2] <= 1'b1;
          else if( row_addr_sig == v + 11'd19 )
             enable_blue_moving_v[2] <= 1'b0; 
          else 
             enable_blue_moving_v[2] <= enable_blue_moving_v[2];
        end
     else 
        enable_blue_moving_v[2] <=1'b0;
   end 
   
 always @ ( posedge clk or negedge rst_n )
   begin
     if( !rst_n )
        enable_blue_moving_v[6] <= 1'b0;
     else if( enable_moving[6] == 1'b1 )
        begin
          if( row_addr_sig == v + 11'd20 )
             enable_blue_moving_v[6] <= 1'b1;
          else if( row_addr_sig == v + 11'd39 )
             enable_blue_moving_v[6] <= 1'b0; 
          else 
             enable_blue_moving_v[6] <= enable_blue_moving_v[6];
        end
     else 
        enable_blue_moving_v[6] <=1'b0;
   end 
   
 always @ ( posedge clk or negedge rst_n )
   begin
     if( !rst_n )
        enable_blue_moving_v[10] <= 1'b0;
     else if( enable_moving[10] == 1'b1 )
        begin
          if( row_addr_sig == v + 11'd40 )
             enable_blue_moving_v[10] <= 1'b1;
          else if( row_addr_sig == v + 11'd59 )
             enable_blue_moving_v[10] <= 1'b0; 
          else 
             enable_blue_moving_v[10] <= enable_blue_moving_v[10];
        end
     else 
        enable_blue_moving_v[10] <=1'b0;
   end  
   
 always @ ( posedge clk or negedge rst_n )
   begin
     if( !rst_n )
        enable_blue_moving_v[14] <= 1'b0;
     else if( enable_moving[14] == 1'b1 )
        begin
          if( row_addr_sig == v + 11'd60 )
             enable_blue_moving_v[14] <= 1'b1;
          else if( row_addr_sig == v + 11'd79 )
             enable_blue_moving_v[14] <= 1'b0; 
          else 
             enable_blue_moving_v[14] <= enable_blue_moving_v[14];
        end
     else 
        enable_blue_moving_v[14] <=1'b0;
   end 
   
 always @ ( posedge clk or negedge rst_n )
   begin
     if( !rst_n )
        enable_blue_moving_v[3] <= 1'b0;
     else if( enable_moving[3] == 1'b1 )
        begin
          if( row_addr_sig == v )
             enable_blue_moving_v[3] <= 1'b1;
          else if( row_addr_sig == v + 11'd19 )
             enable_blue_moving_v[3] <= 1'b0; 
          else 
             enable_blue_moving_v[3] <= enable_blue_moving_v[3];
        end
     else 
        enable_blue_moving_v[3] <=1'b0;
   end  
   
 always @ ( posedge clk or negedge rst_n )
   begin
     if( !rst_n )
        enable_blue_moving_v[7] <= 1'b0;
     else if( enable_moving[7] == 1'b1 )
        begin
          if( row_addr_sig == v + 11'd20 )
             enable_blue_moving_v[7] <= 1'b1;
          else if( row_addr_sig == v + 11'd39 )
             enable_blue_moving_v[7] <= 1'b0; 
          else 
             enable_blue_moving_v[7] <= enable_blue_moving_v[7];
        end
     else 
        enable_blue_moving_v[7] <= 1'b0;
   end 
   
 always @ ( posedge clk or negedge rst_n )
   begin
     if( !rst_n )
        enable_blue_moving_v[11] <= 1'b0;
     else if( enable_moving[11] == 1'b1 )
        begin
          if( row_addr_sig == v + 11'd40 )
             enable_blue_moving_v[11] <= 1'b1;
          else if( row_addr_sig == v + 11'd59 )
             enable_blue_moving_v[11] <= 1'b0; 
          else 
             enable_blue_moving_v[11] <= enable_blue_moving_v[11];
        end
     else 
        enable_blue_moving_v[11] <=1'b0;
   end 
   
 always @ ( posedge clk or negedge rst_n )
   begin
     if( !rst_n )
        enable_blue_moving_v[15] <= 1'b0;
     else if( enable_moving[15] == 1'b1 )
        begin
          if( row_addr_sig == v + 11'd60 )
             enable_blue_moving_v[15] <= 1'b1;
          else if( row_addr_sig == v + 11'd79 )
             enable_blue_moving_v[15] <= 1'b0; 
          else 
             enable_blue_moving_v[15] <= enable_blue_moving_v[15];
        end
     else 
        enable_blue_moving_v[15] <=1'b0;
   end 
   
 /**************************************************/
 
wire[15:0] enable_blue_moving_r;
 

assign  enable_blue_moving_r[0] = enable_blue_moving_h[0]&enable_blue_moving_v[0];
assign  enable_blue_moving_r[1] = enable_blue_moving_h[1]&enable_blue_moving_v[1];
assign  enable_blue_moving_r[2] = enable_blue_moving_h[2]&enable_blue_moving_v[2];
assign  enable_blue_moving_r[3] = enable_blue_moving_h[3]&enable_blue_moving_v[3];
assign  enable_blue_moving_r[4] = enable_blue_moving_h[4]&enable_blue_moving_v[4];
assign  enable_blue_moving_r[5] = enable_blue_moving_h[5]&enable_blue_moving_v[5];
assign  enable_blue_moving_r[6] = enable_blue_moving_h[6]&enable_blue_moving_v[6];
assign  enable_blue_moving_r[7] = enable_blue_moving_h[7]&enable_blue_moving_v[7];
assign  enable_blue_moving_r[8] = enable_blue_moving_h[8]&enable_blue_moving_v[8];
assign  enable_blue_moving_r[9] = enable_blue_moving_h[9]&enable_blue_moving_v[9];
assign  enable_blue_moving_r[10] = enable_blue_moving_h[10]&enable_blue_moving_v[10];
assign  enable_blue_moving_r[11] = enable_blue_moving_h[11]&enable_blue_moving_v[11];
assign  enable_blue_moving_r[12] = enable_blue_moving_h[12]&enable_blue_moving_v[12];
assign  enable_blue_moving_r[13] = enable_blue_moving_h[13]&enable_blue_moving_v[13];
assign  enable_blue_moving_r[14] = enable_blue_moving_h[14]&enable_blue_moving_v[14];
assign  enable_blue_moving_r[15] = enable_blue_moving_h[15]&enable_blue_moving_v[15];

 
   
 /**************************************************/
 
 assign enable_blue_moving =|enable_blue_moving_r;
 
 /**************************************************/
 
 endmodule
 