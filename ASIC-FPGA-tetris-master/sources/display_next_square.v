`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:22:42 05/07/2016 
// Design Name: 
// Module Name:    display_next_square 
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
module display_next_square
 (clk, rst_n, col_addr_sig, row_addr_sig, loading_square, next_yellow_display,square_type_out
 );
 input clk;
 input rst_n;
 input[10:0] col_addr_sig;
 input[10:0] row_addr_sig;
 input loading_square;
 input[2:0] square_type_out;
 output next_yellow_display;
 
 /**************************************************/
 
 wire[2:0] square_type;
 
assign square_type=square_type_out;
 /**************************************************/
   
 reg[15:0] enable_display_r;
 
 always @ ( posedge clk or negedge rst_n )
   begin
     if( !rst_n )
        enable_display_r <= 16'b0000_0111_0010_0000;
     else  
        begin
          case(square_type)
            3'b000: enable_display_r <= 16'b0000_0000_0111_0010;
            3'b001: enable_display_r <= 16'b0000_0110_0110_0000;
            3'b010: enable_display_r <= 16'b0010_0010_0010_0010; 
            3'b011: enable_display_r <= 16'b0000_0011_0110_0000;
            3'b100: enable_display_r <= 16'b0000_0110_0011_0000;
            3'b101: enable_display_r <= 16'b0000_0011_0010_0010;
            3'b110: enable_display_r <= 16'b0000_0011_0001_0001;
            default: enable_display_r <= 16'b0000_0110_0110_0000;
          endcase 
        end
   end
   
 /**************************************************/
 
 reg[15:0] enable_next_display_h;
 
 generate
   genvar i1,j1;
	  for(i1=0;i1<4;i1=i1+1)
	  begin:fwgwgwr
	     for(j1=0;j1<4;j1=j1+1)
		   begin:fewrgnfq
			  always @ ( posedge clk or negedge rst_n )
            begin
                   if( !rst_n )
                     enable_next_display_h[i1*4+j1] <= 1'b0;
                   else if( enable_display_r[i1*4+j1] == 1'b1 )
                      begin 
                        if( col_addr_sig == 11'd101+j1*20 )  
                             enable_next_display_h[i1*4+j1] <= 1'b1; 
                        else if( col_addr_sig == 11'd120+j1*20  )
                             enable_next_display_h[i1*4+j1] <= 1'b0; 
                        else 
                           enable_next_display_h[i1*4+j1] <= enable_next_display_h[i1*4+j1];
                      end
                   else 
                     enable_next_display_h[i1*4+j1] <= enable_next_display_h[i1*4+j1]; 
            end                       
			end	  
	  end
 endgenerate 
 
  reg[15:0] enable_next_display_v;
 generate
   genvar i2,j2;
	  for(i2=0;i2<4;i2=i2+1)
	  begin:gwhghw
	     for(j2=0;j2<4;j2=j2+1)
		   begin:whrwge
			  always @ ( posedge clk or negedge rst_n )
            begin
                   if( !rst_n )
                     enable_next_display_v[i2*4+j2] <= 1'b0;
                   else if( enable_display_r[i2*4+j2] == 1'b1 )
                      begin 
                        if( row_addr_sig == 11'd101+i2*20 )  
                             enable_next_display_v[i2*4+j2] <= 1'b1; 
                        else if( row_addr_sig == 11'd120+i2*20  )
                             enable_next_display_v[i2*4+j2] <= 1'b0; 
                        else 
                           enable_next_display_v[i2*4+j2] <= enable_next_display_v[i2*4+j2];
                      end
                   else 
                     enable_next_display_v[i2*4+j2] <= enable_next_display_v[i2*4+j2]; 
            end                       
			end	  
	  end
 endgenerate 
 

 /**************************************************/
 
 /**************************************************/
 
 reg[15:0] enable_next_display_r;
 
 always @ ( posedge clk or negedge rst_n )
   begin 
     if( !rst_n )
        enable_next_display_r <= 16'd0;
     else 
        enable_next_display_r <= enable_next_display_h & enable_next_display_v;
   end
   
 /**************************************************/
 
 assign next_yellow_display = | enable_next_display_r;   
 
 /**************************************************/    
                
 endmodule 