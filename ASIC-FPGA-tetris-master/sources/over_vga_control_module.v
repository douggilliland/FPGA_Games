`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:12:35 05/04/2016 
// Design Name: 
// Module Name:    over_vga_control_module 
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
module over_vga_control_module
 (clk, rst_n, over_col_addr_sig, over_row_addr_sig, ready_sig, over_sig,
	over_rom_data, red, green, blue, over_rom_addr, 
	over_red_sig, over_green_sig, over_blue_sig
 );
 input clk;
 input rst_n;
 input[10:0] over_col_addr_sig;
 input[10:0] over_row_addr_sig;
 input ready_sig;
 input over_sig;
 input[2:0] over_rom_data;
 input red;
 input green;
 input blue;
 output[18:0] over_rom_addr;
 output over_red_sig;
 output over_green_sig;
 output over_blue_sig;
 parameter flush = 30'd500_000;
 /**************************************************/
 
 reg[21:0] m;
 reg[30:0] vcnt;
 reg[10:0] nowv;
 // assign nowv = 20'd000;
 always @ ( posedge clk or negedge rst_n )
   begin
     if( !rst_n )
        m <= 9'd0;
     else if(over_row_addr_sig < 480 ) 
        m <= over_row_addr_sig[10:0]*640+over_col_addr_sig[10:0];
   end
   
 always @ ( posedge clk or negedge rst_n)
   begin
		if( !rst_n )
			begin
				vcnt <= 0;
				nowv <= 0;
			end
		else 
		if (over_sig)
		begin
		if (nowv > 480)
			nowv <= 480;
		else
		if (vcnt == flush)
			begin
				vcnt <= 0;
				nowv <= nowv + 1;
			end
		else
			vcnt <= vcnt + 1;
		end
	end   
 

   
 /**************************************************/
 
 assign over_rom_addr = m;
 assign over_red_sig = (over_sig && (over_row_addr_sig < nowv))?over_rom_data[0]:red;
 assign over_green_sig = (over_sig && (over_row_addr_sig < nowv)) ? over_rom_data[1] : green;
 assign over_blue_sig = (over_sig&& (over_row_addr_sig < nowv))?over_rom_data[2]:blue;
 
 /**************************************************/
 
endmodule 