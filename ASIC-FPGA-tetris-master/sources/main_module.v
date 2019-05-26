`timescale 1ns / 1ps
module main_module(sys_clk, rst_n,
	KEY_DATA,KEY_CLK,
	right, left, rotateR,verticalspeed,
	VGA_G,VGA_R,VGA_B,
	VGA_CLK,VGA_VSYNC,VGA_HSYNC,VGA_PSVAE_N,VGA_SYNC_N,VGA_BLANK_N,
);
input sys_clk;   
input rst_n;     
input right;
input left;
input rotateR;
input KEY_DATA;
input KEY_CLK;
input verticalspeed;
output[7:0] VGA_G;
output[7:0] VGA_R;
output[7:0] VGA_B;
output VGA_CLK;
output VGA_VSYNC;
output VGA_HSYNC;
output VGA_PSVAE_N;
output VGA_SYNC_N;
output VGA_BLANK_N;



//*********************************************************************
wire red;
wire green;
wire blue;
wire clk;
wire levelup_sig;

assign VGA_PSVAE_N=1'b1;
assign VGA_SYNC_N=1'b0;
assign VGA_BLANK_N=VGA_VSYNC&VGA_HSYNC;


//*********************************************************************
div_clk div_clk(
.rst_n(rst_n),
.sys_clk(sys_clk),
.clk(clk)
);

//*********************************************************************



wire w_right;
wire w_left;
wire w_rotateR;
wire verticalspeed_out;

debouncer m_right(.clk(clk),.rst_n(rst_n),.key_in(right),.key_out(w_right));
debouncer m_left(.clk(clk),.rst_n(rst_n),.key_in(left),.key_out(w_left));
debouncer m_rotateR(.clk(clk),.rst_n(rst_n),.key_in(rotateR),.key_out(w_rotateR));
v_speed_debouncer v_speed_debouncer(.clk(clk),.rst_n(rst_n),.invs(verticalspeed),.outvs(verticalspeed_out));
//*********************************************************************


//**********************************************************************

wire over_out;
wire start_sig;   
wire gameready_sig;
wire over_sig; 
automaton automaton(
.clk(clk),
.rst_n(rst_n), 
.over(over_out),
.start_sig(start_sig),
.gameready_sig(gameready_sig),
.over_sig(over_sig)
);
//***********************************************************************
//***********************************************************************




//**********************************************************************
//start_sync_module
wire[10:0] ready_col_addr_sig;
wire[10:0] ready_row_addr_sig;
wire ready_hsync;
wire ready_vsync;
wire ready_out_sig;
	
start_sync_module start_sync_module(
.clk(clk), 
.rst_n(rst_n),
.ready_col_addr_sig(ready_col_addr_sig), 
.ready_row_addr_sig(ready_row_addr_sig), 
.ready_hsync(ready_hsync),
.ready_vsync(ready_vsync),
.ready_out_sig(ready_out_sig)
 );
 
//start_vga_control_module
wire[18:0] tetris_rom_addr;
wire ready_red_sig;
wire ready_green_sig;
wire ready_blue_sig;
wire[2:0] ready_tetris_rom_data;

start_vga_control_module start_vga_control_module(
.clk(clk), 
.rst_n(rst_n), 
.ready_col_addr_sig(ready_col_addr_sig), 
.ready_row_addr_sig(ready_row_addr_sig), 
.ready_sig(ready_out_sig), 
.gameready_sig(gameready_sig),
.tetris_rom_data(ready_tetris_rom_data), 
.tetris_rom_addr(tetris_rom_addr), 
.ready_red_sig(ready_red_sig), 
.ready_green_sig(ready_green_sig), 
.ready_blue_sig(ready_blue_sig)  
); 

start_interface start_instance_name (
  .clka(clk), // input clka
  .addra(tetris_rom_addr), // input [18 : 0] addra
  .douta(ready_tetris_rom_data) // output [2 : 0] douta
);

//***********************************************************************
//***********************************************************************


//***********************************************************************
//***********************************************************************
//over_sync_module
wire[10:0] over_col_addr_sig;
wire[10:0] over_row_addr_sig;
wire over_hsync;
wire over_vsync;
wire over_out_sig;

over_sync_module over_sync_module(
.clk(clk), 
.rst_n(rst_n), 
.over_col_addr_sig(over_col_addr_sig), 
.over_row_addr_sig(over_row_addr_sig), 
.over_hsync(over_hsync), 
.over_vsync(over_vsync), 
.over_out_sig(over_out_sig)
 );

//over_vga_control_module
wire[18:0] over_rom_addr;
wire over_red_sig;
wire over_green_sig;
wire over_blue_sig;
wire[2:0] over_tetris_rom_data1;
over_vga_control_module over_vga_control_module(
.clk(clk), 
.rst_n(rst_n), 
.over_col_addr_sig(over_col_addr_sig), 
.over_row_addr_sig(over_row_addr_sig), 
.ready_sig(over_out_sig), 
.over_sig(over_sig),
.over_rom_data(over_tetris_rom_data1), 
.over_rom_addr(over_rom_addr), 
.over_red_sig(over_red_sig), 
.over_green_sig(over_green_sig), 
.over_blue_sig(over_blue_sig),
.red(red),
.blue(blue),
.green(green) 
 );

over_view over_view_mem (
  .clka(clk), // input clka
  .addra(over_rom_addr), // input [18 : 0] addra
  .douta(over_tetris_rom_data1) // output [2 : 0] douta
);

wire[10:0] col_addr_sig;
wire[10:0] row_addr_sig;
wire hsync;
wire vsync;
wire ready_sig; 

game_sync_module game_sync_module(
.clk(clk), 
.rst_n(rst_n), 
.col_addr_sig(col_addr_sig), 
.row_addr_sig(row_addr_sig), 
.hsync(hsync), 
.vsync(vsync), 
.ready_sig(ready_sig)
 );
 
//loading happen module
//******************************************
 wire[10:0] h;
 wire[10:0] v;
 wire[499:0] enable_little;
 wire[15:0] enable_moving;
 wire loading_square;
 wire[8:0] little_square_num;
 wire[15:0] score_out;

 loading_happen loading_happen 
 (
  .clk(clk),
  .rst_n(rst_n),
  .move_right(w_right),
  .move_left(w_left),
  .start_sig(start_sig),
  .row_addr_sig(row_addr_sig),
  .blue(blue),
  .h(h),
  .v(v),
  .enable_little(enable_little),
  .enable_moving(enable_moving),
  .loading_square(loading_square),
  .little_square_num(little_square_num),
  .over_out(over_out),
  .verticalspeed_out(verticalspeed_out),
  .score_out(score_out),
  .level_up(levelup_sig)
 );
//*******************************************

//*******************************************
wire enable_red_border;

display_border display_border
(
.clk(clk), 
.rst_n(rst_n), 
.col_addr_sig(col_addr_sig), 
.row_addr_sig(row_addr_sig), 
.enable_red_border(enable_red_border)
 );
//*******************************************



//*******************************************
wire enable_blue_moving;
                                    
display_moving_square display_moving_square 
(
 .clk(clk),
 .rst_n(rst_n),
 .col_addr_sig(col_addr_sig),
 .row_addr_sig(row_addr_sig),
 .h(h),
 .v(v),
 .enable_blue_moving(enable_blue_moving),
 .enable_moving(enable_moving)
);
//*******************************************




//*******************************************
wire enable_blue_little_flag;

display_little_square display_little_square 
(
 .clk(clk),
 .rst_n(rst_n),
 .col_addr_sig(col_addr_sig),
 .row_addr_sig(row_addr_sig),
 .enable_little(enable_little),
 .enable_blue_little_flag(enable_blue_little_flag)
);
//*******************************************






//square_gen
//***********************************************************************
wire[2:0] square_type_out;

square_gen square_gen
(
.clk(clk),
.rst_n(rst_n),
.enable_moving(enable_moving),
.rotate_r(w_rotateR),
.rotate_l(w_rotateL),
.loading_square(loading_square),
.little_square_num(little_square_num),
.enable_little(enable_little),
.square_type_out(square_type_out)									
);
//***********************************************************************

wire color_score_out;

display_score display_score(
.clk(clk),
.rst_n(rst_n),
.col_addr_sig(col_addr_sig),
.row_addr_sig(row_addr_sig),
.score_out(score_out),
.color_score_out(color_score_out)
  );




//***********************************************************************
wire next_yellow_display;
 
display_next_square display_next_square
(
.clk(clk), 
.rst_n(rst_n), 
.col_addr_sig(col_addr_sig), 
.row_addr_sig(row_addr_sig), 
.loading_square(loading_square), 
.next_yellow_display(next_yellow_display),
.square_type_out(square_type_out)
); 
//***********************************************************************
wire score_out_c;

show_score show_score(
.clk(clk),
.rst_n(rst_n),
.col_addr_sig(col_addr_sig),
.row_addr_sig(row_addr_sig),
.levelup_sig(levelup_sig),
.score_out_c(score_out_c)
    );






//************************************************************************
wire next_c;
 game_display game_display
 (
  .clk(clk),
  .rst_n(rst_n),
  .ready_sig(ready_sig),
  .enable_red_border(enable_red_border),
  .enable_blue_moving(enable_blue_moving),
  .enable_blue_little_flag(enable_blue_little_flag),
  .next_yellow_display(next_yellow_display),
  .red(red),
  .green(green),
  .blue(blue),
  .next_c(next_c),
  .score_out_c(score_out_c),
  .score(color_score_out)
 );
//************************************************************************

show_next show_next(
.clk(clk),
.rst_n(rst_n),
.col_addr_sig(col_addr_sig),
.row_addr_sig(row_addr_sig),
.next_c(next_c)
);

//*************************************************************************
wire hsync_out;
wire vsync_out;
wire red_out;
wire green_out;
wire blue_out;


 vga_select_module vga_select_module
 (
  .clk(clk),
  .rst_n(rst_n),
  .start_sig(start_sig),
  .hsync(hsync),
  .vsync(vsync),
  .red(red),
  .green(green),
  .blue(blue),
  .gameready_sig(gameready_sig),
  .ready_hsync(ready_hsync),
  .ready_vsync(ready_vsync),
  .ready_red_sig(ready_red_sig),
  .ready_green_sig(ready_green_sig),
  .ready_blue_sig(ready_blue_sig),
  .over_sig(over_sig),
  .over_hsync(over_hsync),
  .over_vsync(over_vsync),
  .over_red_sig(over_red_sig),
  .over_green_sig(over_green_sig),
  .over_blue_sig(over_blue_sig),
  .hsync_out(hsync_out),
  .vsync_out(vsync_out),
  .red_out(red_out),
  .green_out(green_out),
  .blue_out(blue_out)
 );

//*************************************************************************

assign VGA_VSYNC=vsync_out;
assign VGA_HSYNC=hsync_out;
assign VGA_CLK=clk;
assign VGA_R[7]=red_out;
assign VGA_R[6:0]=0;
assign VGA_G[7]=green_out;
assign VGA_G[6:0]=0;
assign VGA_B[7]=blue_out;
assign VGA_B[6:0]=0;
assign w_rotateL=1'b1;
		
endmodule
