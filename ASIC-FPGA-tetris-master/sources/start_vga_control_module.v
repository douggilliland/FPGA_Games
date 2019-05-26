`timescale 1ns / 1ps
module start_vga_control_module
 (clk, rst_n, ready_col_addr_sig, ready_row_addr_sig, ready_sig, gameready_sig,
  tetris_rom_data, tetris_rom_addr, ready_red_sig, ready_green_sig, ready_blue_sig  
 );
 input clk;
 input rst_n;
 input[10:0] ready_col_addr_sig;
 input[10:0] ready_row_addr_sig;
 input ready_sig;
 input gameready_sig;
 input[2:0] tetris_rom_data;
 output[18:0] tetris_rom_addr;
 output ready_red_sig;
 output ready_green_sig;
 output ready_blue_sig;
 
 /**************************************************/
 
 reg[21:0] m;
 parameter flush = 30'd250_000;
 /**************************************************/
 
 reg[30:0] hcnt;
 reg[10:0] lefth;
 reg[10:0] righth;
  
 always @ ( posedge clk or negedge rst_n)
   begin
		if( !rst_n )
			begin
				hcnt <= 0;
				righth <= 320;
				lefth <= 320;
			end
		else 
		if (ready_sig)
		begin
		if (righth > 640)
			begin
				lefth <= 0;
				righth <= 640;
			end
		else
		if (hcnt == flush)
			begin
				hcnt <= 0;
				lefth <= lefth - 1;
				righth <= righth + 1;
			end
		else
			hcnt <= hcnt + 1;
		end
	end   
 
 always @ ( posedge clk or negedge rst_n )
   begin
     if( !rst_n )
        m <= 9'd0;
     else if( ready_sig && ready_row_addr_sig <480) //经过仿真比较可知verilog中的比较都是无符号数的比较,显示512行
        m <= ready_row_addr_sig[10:0]*640+ready_col_addr_sig[10:0];
   end
   
 /**************************************************/
 
 reg[9:0] n;
 
 always @ ( posedge clk or negedge rst_n )
   begin 
     if( !rst_n )
        n <= 6'd0;
     else if( ready_sig && ready_col_addr_sig < 640) //显示640行
        n <= ready_col_addr_sig[9:0];
   end
   
 /**************************************************/
 assign show_block = ready_col_addr_sig > lefth && ready_col_addr_sig < righth;
 assign tetris_rom_addr = m[18:0];
 assign ready_red_sig = (ready_sig && gameready_sig && show_block)? tetris_rom_data[0]: 1'b0;
 assign ready_green_sig = (ready_sig && gameready_sig && show_block)? tetris_rom_data[1]: 1'b0;
 assign ready_blue_sig = (ready_sig && gameready_sig && show_block)? tetris_rom_data[2]: 1'b0;
 
 /**************************************************/
 
 endmodule
