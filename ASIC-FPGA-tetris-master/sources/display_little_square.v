`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:57:21 05/07/2016 
// Design Name: 
// Module Name:    display_little_square 
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
module display_little_square
 (clk, rst_n, col_addr_sig, row_addr_sig, enable_little, enable_blue_little_flag
 );
 input clk;
 input rst_n;
 input[10:0] col_addr_sig;
 input[10:0] row_addr_sig;
 input[499:0] enable_little;
 output enable_blue_little_flag;
 
 /**************************************************/
 /**************************************************/
 
 reg[499:0] enable_blue_little_h;
 
 
 //边界全部都赋值为0
 always @ ( posedge clk or negedge rst_n )
   begin 
     if( !rst_n )
        begin
          enable_blue_little_h[4:0] <= 5'b00000;
          enable_blue_little_h[24:20] <= 5'b00000;
          enable_blue_little_h[44:40] <= 5'b00000;
          enable_blue_little_h[64:60] <= 5'b00000;
          enable_blue_little_h[84:80] <= 5'b00000;
          enable_blue_little_h[104:100] <= 5'b00000;
          enable_blue_little_h[124:120] <= 5'b00000;
          enable_blue_little_h[144:140] <= 5'b00000;
          enable_blue_little_h[164:160] <= 5'b00000;
          enable_blue_little_h[184:180] <= 5'b00000;
          enable_blue_little_h[204:200] <= 5'b00000;
          enable_blue_little_h[224:220] <= 5'b00000;
          enable_blue_little_h[244:240] <= 5'b00000;
          enable_blue_little_h[264:260] <= 5'b00000;
			 enable_blue_little_h[284:280] <= 5'b00000;			 
			 enable_blue_little_h[304:300] <= 5'b00000;
			 enable_blue_little_h[324:320] <= 5'b00000;
			 enable_blue_little_h[344:340] <= 5'b00000;
			 enable_blue_little_h[364:360] <= 5'b00000;
			 enable_blue_little_h[384:380] <= 5'b00000;
          
          enable_blue_little_h[19:15] <= 5'b00000;
          enable_blue_little_h[39:35] <= 5'b00000;
          enable_blue_little_h[59:55] <= 5'b00000;
          enable_blue_little_h[79:75] <= 5'b00000;
          enable_blue_little_h[99:95] <= 5'b00000;
          enable_blue_little_h[119:115] <= 5'b00000;
          enable_blue_little_h[139:135] <= 5'b00000;
          enable_blue_little_h[159:155] <= 5'b00000;
          enable_blue_little_h[179:175] <= 5'b00000;
          enable_blue_little_h[199:195] <= 5'b00000;
          enable_blue_little_h[219:215] <= 5'b00000;
          enable_blue_little_h[239:235] <= 5'b00000;
          enable_blue_little_h[259:255] <= 5'b00000;
          enable_blue_little_h[279:275] <= 5'b00000;
			 enable_blue_little_h[299:295] <= 5'b00000;
			 enable_blue_little_h[319:315] <= 5'b00000;
			 enable_blue_little_h[339:335] <= 5'b00000; 
          enable_blue_little_h[359:355] <= 5'b00000;
			 enable_blue_little_h[379:375] <= 5'b00000;
			 enable_blue_little_h[399:395] <= 5'b00000;
          enable_blue_little_h[499:400] <= 80'd0;
			 
        end
     else 
        begin
          enable_blue_little_h[4:0] <= 5'b00000;
          enable_blue_little_h[24:20] <= 5'b00000;
          enable_blue_little_h[44:40] <= 5'b00000;
          enable_blue_little_h[64:60] <= 5'b00000;
          enable_blue_little_h[84:80] <= 5'b00000;
          enable_blue_little_h[104:100] <= 5'b00000;
          enable_blue_little_h[124:120] <= 5'b00000;
          enable_blue_little_h[144:140] <= 5'b00000;
          enable_blue_little_h[164:160] <= 5'b00000;
          enable_blue_little_h[184:180] <= 5'b00000;
          enable_blue_little_h[204:200] <= 5'b00000;
          enable_blue_little_h[224:220] <= 5'b00000;
          enable_blue_little_h[244:240] <= 5'b00000;
          enable_blue_little_h[264:260] <= 5'b00000;
			 enable_blue_little_h[284:280] <= 5'b00000;			 
			 enable_blue_little_h[304:300] <= 5'b00000;
			 enable_blue_little_h[324:320] <= 5'b00000;
			 enable_blue_little_h[344:340] <= 5'b00000;
			 enable_blue_little_h[364:360] <= 5'b00000;
			 enable_blue_little_h[384:380] <= 5'b00000;
          
          enable_blue_little_h[19:15] <= 5'b00000;
          enable_blue_little_h[39:35] <= 5'b00000;
          enable_blue_little_h[59:55] <= 5'b00000;
          enable_blue_little_h[79:75] <= 5'b00000;
          enable_blue_little_h[99:95] <= 5'b00000;
          enable_blue_little_h[119:115] <= 5'b00000;
          enable_blue_little_h[139:135] <= 5'b00000;
          enable_blue_little_h[159:155] <= 5'b00000;
          enable_blue_little_h[179:175] <= 5'b00000;
          enable_blue_little_h[199:195] <= 5'b00000;
          enable_blue_little_h[219:215] <= 5'b00000;
          enable_blue_little_h[239:235] <= 5'b00000;
          enable_blue_little_h[259:255] <= 5'b00000;
          enable_blue_little_h[279:275] <= 5'b00000;
			 enable_blue_little_h[299:295] <= 5'b00000;
			 enable_blue_little_h[319:315] <= 5'b00000;
			 enable_blue_little_h[339:335] <= 5'b00000; 
          enable_blue_little_h[359:355] <= 5'b00000;
			 enable_blue_little_h[379:375] <= 5'b00000;
			 enable_blue_little_h[399:395] <= 5'b00000;
          enable_blue_little_h[499:400] <= 80'd0;
        end
   end
   
 /**************************************************/
 
 reg[499:0] enable_blue_little_v;
 //边界全部都赋值为0
 always @ ( posedge clk or negedge rst_n )
   begin 
     if( !rst_n )
        begin
          enable_blue_little_v[4:0] <= 5'b00000;
          enable_blue_little_v[24:20] <= 5'b00000;
          enable_blue_little_v[44:40] <= 5'b00000;
          enable_blue_little_v[64:60] <= 5'b00000;
          enable_blue_little_v[84:80] <= 5'b00000;
          enable_blue_little_v[104:100] <= 5'b00000;
          enable_blue_little_v[124:120] <= 5'b00000;
          enable_blue_little_v[144:140] <= 5'b00000;
          enable_blue_little_v[164:160] <= 5'b00000;
          enable_blue_little_v[184:180] <= 5'b00000;
          enable_blue_little_v[204:200] <= 5'b00000;
          enable_blue_little_v[224:220] <= 5'b00000;
          enable_blue_little_v[244:240] <= 5'b00000;
          enable_blue_little_v[264:260] <= 5'b00000;
			 enable_blue_little_v[284:280] <= 5'b00000;			 
			 enable_blue_little_v[304:300] <= 5'b00000;
			 enable_blue_little_v[324:320] <= 5'b00000;
			 enable_blue_little_v[344:340] <= 5'b00000;
			 enable_blue_little_v[364:360] <= 5'b00000;
			 enable_blue_little_v[384:380] <= 5'b00000;
          
          enable_blue_little_v[19:15] <= 5'b00000;
          enable_blue_little_v[39:35] <= 5'b00000;
          enable_blue_little_v[59:55] <= 5'b00000;
          enable_blue_little_v[79:75] <= 5'b00000;
          enable_blue_little_v[99:95] <= 5'b00000;
          enable_blue_little_v[119:115] <= 5'b00000;
          enable_blue_little_v[139:135] <= 5'b00000;
          enable_blue_little_v[159:155] <= 5'b00000;
          enable_blue_little_v[179:175] <= 5'b00000;
          enable_blue_little_v[199:195] <= 5'b00000;
          enable_blue_little_v[219:215] <= 5'b00000;
          enable_blue_little_v[239:235] <= 5'b00000;
          enable_blue_little_v[259:255] <= 5'b00000;
          enable_blue_little_v[279:275] <= 5'b00000;
			 enable_blue_little_v[299:295] <= 5'b00000;
			 enable_blue_little_v[319:315] <= 5'b00000;
			 enable_blue_little_v[339:335] <= 5'b00000; 
          enable_blue_little_v[359:355] <= 5'b00000;
			 enable_blue_little_v[379:375] <= 5'b00000;
			 enable_blue_little_v[399:395] <= 5'b00000;
          enable_blue_little_v[499:400] <= 80'd0;
			 
        end
     else 
        begin
          enable_blue_little_v[4:0] <= 5'b00000;
          enable_blue_little_v[24:20] <= 5'b00000;
          enable_blue_little_v[44:40] <= 5'b00000;
          enable_blue_little_v[64:60] <= 5'b00000;
          enable_blue_little_v[84:80] <= 5'b00000;
          enable_blue_little_v[104:100] <= 5'b00000;
          enable_blue_little_v[124:120] <= 5'b00000;
          enable_blue_little_v[144:140] <= 5'b00000;
          enable_blue_little_v[164:160] <= 5'b00000;
          enable_blue_little_v[184:180] <= 5'b00000;
          enable_blue_little_v[204:200] <= 5'b00000;
          enable_blue_little_v[224:220] <= 5'b00000;
          enable_blue_little_v[244:240] <= 5'b00000;
          enable_blue_little_v[264:260] <= 5'b00000;
			 enable_blue_little_v[284:280] <= 5'b00000;			 
			 enable_blue_little_v[304:300] <= 5'b00000;
			 enable_blue_little_v[324:320] <= 5'b00000;
			 enable_blue_little_v[344:340] <= 5'b00000;
			 enable_blue_little_v[364:360] <= 5'b00000;
			 enable_blue_little_v[384:380] <= 5'b00000;
          
          enable_blue_little_v[19:15] <= 5'b00000;
          enable_blue_little_v[39:35] <= 5'b00000;
          enable_blue_little_v[59:55] <= 5'b00000;
          enable_blue_little_v[79:75] <= 5'b00000;
          enable_blue_little_v[99:95] <= 5'b00000;
          enable_blue_little_v[119:115] <= 5'b00000;
          enable_blue_little_v[139:135] <= 5'b00000;
          enable_blue_little_v[159:155] <= 5'b00000;
          enable_blue_little_v[179:175] <= 5'b00000;
          enable_blue_little_v[199:195] <= 5'b00000;
          enable_blue_little_v[219:215] <= 5'b00000;
          enable_blue_little_v[239:235] <= 5'b00000;
          enable_blue_little_v[259:255] <= 5'b00000;
          enable_blue_little_v[279:275] <= 5'b00000;
			 enable_blue_little_v[299:295] <= 5'b00000;
			 enable_blue_little_v[319:315] <= 5'b00000;
			 enable_blue_little_v[339:335] <= 5'b00000; 
          enable_blue_little_v[359:355] <= 5'b00000;
			 enable_blue_little_v[379:375] <= 5'b00000;
			 enable_blue_little_v[399:395] <= 5'b00000;
          enable_blue_little_v[499:400] <= 80'd0;
        end
   end
   
 /**************************************************/
 //以下的模块是给每小方块定义它在图像中的位置
 generate
      genvar i,j;
		for(i=0;i<20;i=i+1)
		begin:haha
		 
		 for(j=0;j<10;j=j+1)
		 begin :hehe
		   always @ ( posedge clk or negedge rst_n )
          begin
            if( !rst_n )
             enable_blue_little_h[5+i*20+j] <= 1'b0;
            else if( enable_little[5+i*20+j] == 1'b1 )
                begin
              if( col_addr_sig == 11'd401+j*20 )
                  enable_blue_little_h[5+i*20+j] <= 1'b1;
               else if( col_addr_sig == 11'd420+j*20 )
                 enable_blue_little_h[5+i*20+j] <= 1'b0;
                  else 
                enable_blue_little_h[5+i*20+j] <= enable_blue_little_h[5+i*20+j];
              end
           else 
              enable_blue_little_h[5+i*20+j] <= enable_blue_little_h[5+i*20+j];
           end
		 end
		end
 endgenerate
 
  /*********************************************/
  generate
      genvar ii,jj;
		for(ii=0;ii<20;ii=ii+1)
		begin:gregher
		 
		 for(jj=0;jj<10;jj=jj+1)
		 begin :hwrgw
		   always @ ( posedge clk or negedge rst_n )
          begin
            if( !rst_n )
             enable_blue_little_v[5+ii*20+jj] <= 1'b0;
            else if( enable_little[5+ii*20+jj] == 1'b1 )
                begin
              if( row_addr_sig == 11'd41+ii*20 )
                  enable_blue_little_v[5+ii*20+jj] <= 1'b1;
               else if( row_addr_sig == 11'd60+ii*20 )
                 enable_blue_little_v[5+ii*20+jj] <= 1'b0;
                  else 
                enable_blue_little_v[5+ii*20+jj] <= enable_blue_little_v[5+ii*20+jj];
              end
           else 
              enable_blue_little_v[5+ii*20+jj] <= enable_blue_little_v[5+ii*20+jj];
           end
		 end
		end
 endgenerate
   
 /**************************************************/
 
 wire[499:0] enable_blue_little;
 generate
   genvar k,h;
   for(k=0;k<20;k=k+1)
	begin :shs
	    for(h=0;h<10;h=h+1)
		 begin:fewjg
		  assign enable_blue_little[5+k*20+h] = enable_blue_little_v[5+k*20+h] && enable_blue_little_h[5+k*20+h];
		 
		 end
	end
 endgenerate
 /******************************************/
 
assign    enable_blue_little[4:0] = 5'b00000;
assign    enable_blue_little[24:20] = 5'b00000;
assign    enable_blue_little[44:40] = 5'b00000;
assign    enable_blue_little[64:60] = 5'b00000;
assign    enable_blue_little[84:80] = 5'b00000;
assign    enable_blue_little[104:100] = 5'b00000;
assign    enable_blue_little[124:120] = 5'b00000;
assign    enable_blue_little[144:140] = 5'b00000;
assign    enable_blue_little[164:160] = 5'b00000;
assign    enable_blue_little[184:180] = 5'b00000;
assign    enable_blue_little[204:200] = 5'b00000;
assign    enable_blue_little[224:220] = 5'b00000;
assign    enable_blue_little[244:240] = 5'b00000;
assign    enable_blue_little[264:260] = 5'b00000;
assign    enable_blue_little[284:280] = 5'b00000;			 
assign    enable_blue_little[304:300] = 5'b00000;
assign    enable_blue_little[324:320] = 5'b00000;
assign    enable_blue_little[344:340] = 5'b00000;
assign    enable_blue_little[364:360] = 5'b00000;
assign    enable_blue_little[384:380] = 5'b00000;
          
assign    enable_blue_little[19:15] = 5'b00000;
assign    enable_blue_little[39:35] = 5'b00000;
assign    enable_blue_little[59:55] = 5'b00000;
assign    enable_blue_little[79:75] = 5'b00000;
assign    enable_blue_little[99:95] = 5'b00000;
assign    enable_blue_little[119:115] = 5'b00000;
assign    enable_blue_little[139:135] = 5'b00000;
assign    enable_blue_little[159:155] = 5'b00000;
assign    enable_blue_little[179:175] = 5'b00000;
assign    enable_blue_little[199:195] = 5'b00000;
assign    enable_blue_little[219:215] = 5'b00000;
assign    enable_blue_little[239:235] = 5'b00000;
assign    enable_blue_little[259:255] = 5'b00000;
assign    enable_blue_little[279:275] = 5'b00000;
assign    enable_blue_little[299:295] = 5'b00000;
assign    enable_blue_little[319:315] = 5'b00000;
assign    enable_blue_little[339:335] = 5'b00000; 
assign    enable_blue_little[359:355] = 5'b00000;
assign    enable_blue_little[379:375] = 5'b00000;
assign    enable_blue_little[399:395] = 5'b00000;
assign    enable_blue_little[499:400] = 80'd0;
 
 /**************************************************/
 
 wire[19:0] enable_blue_little_flag_tmp;
 wire enable_blue_little_flag_tmp1;
 

 generate
   genvar m;
   for(m=0;m<20;m=m+1)
	begin :shs1
	 assign enable_blue_little_flag_tmp[m] = |enable_blue_little[(5+20*m+4'd9):5+20*m];   
	end
 endgenerate
 

 assign enable_blue_little_flag_tmp1 = | enable_blue_little_flag_tmp[19:0];
 
 /**************************************************/
 
 reg enable_blue_little_flag_r;
 
 always @ ( posedge clk or negedge rst_n )
   begin
     if( !rst_n )
        enable_blue_little_flag_r <= 1'b0;
     else 
        enable_blue_little_flag_r <= enable_blue_little_flag_tmp1;
   end      
   
 /**************************************************/
  
 assign enable_blue_little_flag = enable_blue_little_flag_r;
 
 /**************************************************/
 
 endmodule
 
 
