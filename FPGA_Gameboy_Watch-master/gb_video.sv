
/*

Module: Gameboy/Gameboy Color video hardware module

This thing is mostly a great big mess of hacky and magical things...slowly
refactoring.


85% complete

Features missing: Background tile flipping in gb color mode.

TODO: Refactor timer stuff into a seperate module

Author: Jason Rogers
Contact: jasonrogers@alumni.stanford.edu


LICENSE

Copyright (c) 2017 Jason Rogers

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

Attribution is given to the author(s) of the software where such attribution is 
convenient.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

*/



module gb_video(
input rst,
input gbc,

input vga_clock, //108mhz pixel clock for 1280x1024 vga clock
input pixel_clock, //4mhz pixel clock
input cpu_clock, //4 or 8 mhz (depending on speed mode in gbc)
input memory_clock,
input mipi_clock,  //20mhz clock to drive the mipi display

input [15:0] cpu_addr_bus,
output [7:0]  data_bus_out,
input[7:0]  data_bus_in, //todo: rename...should just be data in and data out not cpu and memory controller
input [7:0]  memory_controller_data_in,
input        cpu_we,

output [7:0] irq,
input initialized,
input gb_rom,
input unloaded,

input gdma_we,
input [15:0] gdma_wr_addr,
input gdma_happening,
input [7:0] gdma_data,

input dma_happening,
input dma_we,
input [15:0] dma_wr_addr,
input [7:0] dma_data,

output vga_vs, 
output vga_hs, //vga sync pulses
output [7:0] vga_red,
output [7:0] vga_green,
output [7:0] vga_blue,
output vga_hblank,
output vga_vblank,

output mipi_pwm, 
output [7:0] mipi_rgb, 
output mipi_cm,
output mipi_rd, 
output mipi_cs, 
output mipi_shut, 
output mipi_wr, 
output mipi_dc,
output mipi_rst,
output mipi_vddio_ctrl,
input  mipi_scale  
);

//reg [7:0]		vga_red;
//reg [7:0]		vga_green;
//reg [7:0]		vga_blue;
//reg 				vga_vs;
//reg				vga_hs;
//reg			   vga_vblank;
//reg 			   vga_hblank;

//-------------------------------------------
//
//	GB Registers
//
//-------------------------------------------

reg [7:0] Reg_buttons_ff00=0;
reg [7:0] Reg_SB_ff01=8'h00; 
reg [7:0] Reg_SC_ff02=8'h00; 
reg [7:0] Reg_palette_ff47=8'hC9; //zelda title screen palette
reg [7:0] Reg_palette_ff48=8'hC9; //zelda title screen palette
reg [7:0] Reg_palette_ff49=8'hC9; //zelda title screen palette
reg [7:0] Reg_lyc_ff45=8'b0;
reg [7:0] Reg_xscroll_ff43=0; 
reg [7:0] Reg_yscroll_ff42=0; 
reg [7:0] Reg_LCDcontrol_ff40=8'h00; 
reg [7:0] Reg_LCDstatus_ff41=8'h00; 
reg [7:0] Reg_winX_ff4b=8'h00; 
reg [7:0] Reg_winY_ff4a=8'h00;

reg [7:0] Reg_vbank_ff4f = 0;

reg [7:0] Reg_TIMA_ff05 =8'h00;
reg [7:0] Reg_TMA_ff06 =8'h00;
reg [7:0] Reg_TAC_ff07 =8'h00;


//-------------------------------------------
//
//	Pixel offsets
//
//-------------------------------------------
reg [8:0] x_offset;
reg [8:0] y_offset;


//------------------------------------------
//
// Timer / Div  (todo:THIS DOES NOT BELONG HERE...MOVE)
//
//------------------------------------------
reg [15:0] timer_accumulator;

wire timer_tick;
reg timer_tick_flag;
reg timer_tick_flag_last;

//-------------------------------------------
//
//	Timer
//
//-------------------------------------------
always @(negedge timer_tick)
begin
	if(Reg_TAC_ff07[2]) 
	begin
		timer_tick_flag = ~timer_tick_flag;
	end
end


always @(posedge cpu_clock)
begin

	if(rst) begin

		Reg_TIMA_ff05 = 8'b0;
		Reg_TMA_ff06 = 8'b0;
		Reg_TAC_ff07 = 8'hF8;
		timer_accumulator = 16'b0;
		irq[2] = 0;
	end else begin
	
	casex (cpu_addr_bus)
		16'b111111110xxxxxxx: begin
			if(cpu_we) begin
				case (cpu_addr_bus[6:0])
					7'h04: timer_accumulator = 0;
					7'h05: Reg_TIMA_ff05 = data_bus_in;
					7'h06: Reg_TMA_ff06 = data_bus_in;
					7'h07: Reg_TAC_ff07[2:0] = data_bus_in[2:0];
				default: begin end
				endcase
			end
		end
		default: begin
		end
	endcase
	
		if(timer_tick_flag_last ^ timer_tick_flag) 
		begin
			timer_tick_flag_last = timer_tick_flag;
			
			Reg_TIMA_ff05 = Reg_TIMA_ff05 + 1'b1;
			
			irq[2] =  ~|Reg_TIMA_ff05 ;
			
			if(~|Reg_TIMA_ff05)
			begin
					Reg_TIMA_ff05 = Reg_TMA_ff06;
			end
		end else begin
			irq[2] = 1'b0;
		end
		
		timer_accumulator = timer_accumulator + 1'b1;
	end
end


//-------------------------------------------
//
//	Vga driver
//
//-------------------------------------------

reg 				hs_;
reg				vs_;

//vga pixel counters
wire [12:0] x;
wire [12:0] y;

wire _vblank;
wire _hblank;

vga_controller_1280x1024 vga (vga_clock, vs_, hs_, _vblank, _hblank, x, y);

//-------------------------------------------
//
//	Frame buffer 
//
//-------------------------------------------


reg [1:0] fb_data_in;
reg [15:0] fb_data_out;
reg [15:0] fb_write_addr;
reg [15:0] fb_read_addr;
reg fb_we;

framebuffer fb(
	mipi_color,
	fb_read_addr,
	vga_clock,
	fb_write_addr,
	pixel_clock,
	fb_we,
	fb_data_out);
	


//-------------------------------------------
//
//	Video memory
//
//-------------------------------------------

reg vram_we;
reg [7:0] vram_data_in;

reg [7:0] vram1_data_out;
reg [15:0] vram1_addr_bus;
reg [15:0] vram1_search_addr;

reg [7:0] vram2_data_out;
reg [15:0] vram2_addr_bus;
reg [15:0] vram2_search_addr;

reg [7:0] vram_data_out;

gb_vram vram1(gdma_happening ? gdma_wr_addr : vram1_addr_bus[12:0],
	memory_clock,
	gdma_happening ? gdma_data :vram_data_in,
	(vram_we | (gdma_happening & gdma_we)) & ~Reg_vbank_ff4f[0],
	vram1_data_out);

gb_vram vram2(gdma_happening ? gdma_wr_addr : vram2_addr_bus[12:0],
	memory_clock,
	gdma_happening ? gdma_data :vram_data_in,
	(vram_we | (gdma_happening & gdma_we)) & Reg_vbank_ff4f[0],
	vram2_data_out);
//-------------------------------------------
//
//	OAM Mem
//
//-------------------------------------------

reg oam_we;
reg [7:0] oam_data_in;
reg [7:0] oam_data_out;
reg [7:0] oam_addr_bus;
reg [7:0] oam_wr_addr_bus;

gb_oam oam(
	memory_clock,
	oam_data_in,
	oam_addr_bus, oam_wr_addr_bus,
	oam_we | dma_we,
	oam_data_out);
	

//-------------------------------------------
//
//	Pixel clock state machine
//
//-------------------------------------------

reg [15:0] vram_search_addr;
reg [15:0] char_addr;
reg [7:0] tile_attr;
reg [7:0] tile_attr_cur;
reg [7:0] data;
reg [7:0] q;

reg [1:0] bg_color_index;
reg [1:0] sprite_color_index;
reg [1:0] color_index;
reg [15:0] color;

reg [8:0] pixel_x;
reg [8:0] pixel_y;

parameter [2:0] PIXEL_STATE_Ba=3'd0,PIXEL_STATE_0a=3'd2,PIXEL_STATE_1a=3'd4,PIXEL_STATE_Sa=3'd6,
					 PIXEL_STATE_Bb=3'd1,PIXEL_STATE_0b=3'd3,PIXEL_STATE_1b=3'd5,PIXEL_STATE_Sb=3'd7;

reg [2:0]	pixel_state;

reg [7:0]	in_x;

wire valid_vram_addr;

always_comb
begin
	
		vram_data_in <= data_bus_in;
		oam_wr_addr_bus <= dma_happening ? dma_wr_addr[7:0] : cpu_addr_bus[7:0];
		
		case (render_mode)
			0: begin
				vram1_addr_bus <= cpu_addr_bus;
				vram2_addr_bus <= cpu_addr_bus;
				oam_addr_bus <= cpu_addr_bus[7:0];
			end
			1: begin
				vram1_addr_bus <= cpu_addr_bus;
				vram2_addr_bus <= cpu_addr_bus;
				oam_addr_bus <= cpu_addr_bus[7:0];
			end
			2: begin
				vram1_addr_bus <= cpu_addr_bus;
				vram2_addr_bus <= cpu_addr_bus;
				oam_addr_bus <= Reg_LCDcontrol_ff40[7] ? oam_search_addr :cpu_addr_bus[7:0];
			end
			3: begin
				vram1_addr_bus <=  Reg_LCDcontrol_ff40[7] ? vram1_search_addr : cpu_addr_bus;
				vram2_addr_bus <=  Reg_LCDcontrol_ff40[7] ? vram2_search_addr : cpu_addr_bus;
				oam_addr_bus <= Reg_LCDcontrol_ff40[7] ? oam_search_addr : cpu_addr_bus[7:0];
			end
		endcase
		
		vram_data_out = (Reg_vbank_ff4f[0] & gbc) ? vram2_data_out : vram1_data_out;
		
		oam_data_in = dma_happening && (cpu_addr_bus[15:13] == 3'b100) ? vram_data_out : data_bus_in;
		
		
		//todo: why is timer crap here!?
		case (Reg_TAC_ff07[1:0])
			2'b00: timer_tick <= Reg_TAC_ff07[2] & timer_accumulator[9];
			2'b01: timer_tick <= Reg_TAC_ff07[2] & timer_accumulator[3];
			2'b10: timer_tick <= Reg_TAC_ff07[2] & timer_accumulator[5];
			2'b11: timer_tick <= Reg_TAC_ff07[2] & timer_accumulator[7];
		endcase
		
			casex (cpu_addr_bus)
		16'h8xxx, 16'h9xxx: begin
			data_bus_out = render_mode == 2'b11 ? 8'hFF : vram_data_out;
			vram_we = render_mode == 2'b11 ? 1'b0 :  cpu_we;
			oam_we = 1'b0;
		end
		16'b111111110xxxxxxx: begin
			vram_we <= 1'b0;
			oam_we <= 1'b0;
		
			casex (cpu_addr_bus[6:0])
					7'h02: data_bus_out = Reg_SC_ff02 ;
					
					7'h04: data_bus_out = timer_accumulator[15:8];
					7'h05: data_bus_out = Reg_TIMA_ff05;
					7'h06: data_bus_out = Reg_TMA_ff06;
					7'h07: data_bus_out = Reg_TAC_ff07;
					7'h45: data_bus_out = Reg_lyc_ff45;
					7'h44: data_bus_out = pixel_y[7:0];
					7'h40: data_bus_out = Reg_LCDcontrol_ff40;
					7'h41: data_bus_out = {Reg_LCDstatus_ff41[7:3],Reg_LCDcontrol_ff40[7] ? pixel_y == Reg_lyc_ff45 : 1'b1, Reg_LCDcontrol_ff40[7] ? render_mode : 2'b00};
					7'h43: data_bus_out = Reg_xscroll_ff43;
					7'h42: data_bus_out = Reg_yscroll_ff42;
					7'h47: data_bus_out = Reg_palette_ff47;
					7'h48: data_bus_out = Reg_palette_ff48;
					7'h49: data_bus_out = Reg_palette_ff49;
					7'h4b: data_bus_out = Reg_winX_ff4b;
					7'h4a: data_bus_out = Reg_winY_ff4a;
					7'h00: data_bus_out = Reg_buttons_ff00;
					7'h4f: data_bus_out = Reg_vbank_ff4f | 8'hfe;
					
					7'h68: data_bus_out = {Reg_bgPalCtl_ff68, 1'b0, bg_palette_mem_index};
					7'h69: data_bus_out = bg_palette_mem_index[0] ? bg_palette_mem1_data_out : bg_palette_mem2_data_out;
					7'h6a: data_bus_out = {Reg_oamPalCtl_ff6a, 1'b0, oam_palette_mem_index};
					7'h6b: data_bus_out = oam_palette_mem_index[0] ? oam_palette_mem1_data_out : oam_palette_mem2_data_out;
					
					//7'h1X, 7'h2X, 7'h3X: data_bus_out = sound_data_bus_out;
					default: data_bus_out = 8'hff; 
				endcase	
		end
		16'b11111110xxxxxxxx: begin //0xfe00 oam
			data_bus_out <=  oam_data_out;  //todo, this probably just gets oam_Dat
			oam_we <=   ((render_mode[1] & ~dma_happening) ) ? 1'b0 :  cpu_we;
			vram_we <= 1'b0;
		end
		
		default: begin
			vram_we <= 1'b0;
			oam_we <= 1'b0;
			data_bus_out <= memory_controller_data_in;
		end
	endcase
end





//-------------------------------------------
//
//	Line Render
//
//-------------------------------------------

reg [5:0] bg_palette_mem_index;
reg [5:0] bg_palette_mem_index_next;
reg [4:0] bg_palette_mem_index_vr;
reg [7:0] bg_palette_mem1_data_out;
reg [7:0] bg_palette_mem2_data_out;

reg [5:0] oam_palette_mem_index;
reg [5:0] oam_palette_mem_index_next;
reg [4:0] oam_palette_mem_index_vr;
reg [7:0] oam_palette_mem1_data_out;
reg [7:0] oam_palette_mem2_data_out;


gb_palette_mem bg_palette_mem1(
	.address(render_mode == 2'b11 ? bg_palette_mem_index_vr : bg_palette_mem_index[5:1]),
	.clock(cpu_clock), //cpu and pixel clock might be different
	.data(data_bus_in),
	.wren((cpu_we && cpu_addr_bus == 16'hff69) && bg_palette_mem_index[0]),
	.q(bg_palette_mem1_data_out)
);

gb_palette_mem bg_palette_mem2(
	.address(render_mode == 2'b11 ? bg_palette_mem_index_vr : bg_palette_mem_index[5:1]),
	.clock(cpu_clock),
	.data(data_bus_in),
	.wren((cpu_we && cpu_addr_bus == 16'hff69) & ~bg_palette_mem_index[0]),
	.q(bg_palette_mem2_data_out)
);

gb_palette_mem oam_palette_mem1(
	.address(render_mode == 2'b11 ? oam_palette_mem_index_vr : oam_palette_mem_index[5:1]),
	.clock(cpu_clock),
	.data(data_bus_in),
	.wren((cpu_we && cpu_addr_bus == 16'hff6b) & oam_palette_mem_index[0]),
	.q(oam_palette_mem1_data_out)
);

gb_palette_mem oam_palette_mem2(
	.address(render_mode == 2'b11 ? oam_palette_mem_index_vr : oam_palette_mem_index[5:1]),
	.clock(cpu_clock),
	.data(data_bus_in),
	.wren((cpu_we && cpu_addr_bus == 16'hff6b)  & ~oam_palette_mem_index[0]),
	.q(oam_palette_mem2_data_out)
);


reg Reg_bgPalCtl_ff68;
reg Reg_oamPalCtl_ff6a;


reg [7:0] bitplain_0;
reg [7:0] bitplain_1;
reg [7:0] bitplain_0_next;
reg [7:0] bitplain_1_next;

reg  [7:0][2:0] bg_palette_sel;

//-------------------------------------------
//
//	Sprites 
//
//-------------------------------------------

typedef struct packed
{
	reg [5:0] oam_index;
	reg [7:0] x;
	reg [7:0] y;
}sprite;

sprite sprites[9:0];

reg [1:0] render_mode;
reg [1:0] oam_search_state;
reg [6:0] oam_search_count;
reg [7:0] oam_search_addr;
reg [7:0] oam_search_y;
reg [7:0] oam_search_x;
reg [7:0] oam_active_y;
reg [7:0] oam_active_attr;
reg [7:0] oam_active_addr;
reg [7:0] oam_active_index;

reg [7:0] oam_bitplain0;
reg [7:0] oam_bitplain1;
reg [7:0] oam_palette_sel;
reg [7:0][2:0] oam_palette_sel_gbc;
reg [2:0] oam_palette_gbc;

reg oam_priority;
reg oam_palette;
reg [7:0] oam_priority_sel;
reg [7:0] oam_active_pixel;

reg [9:0] oam_processed;
reg [2:0] oam_fetch_state;
reg [2:0] reset_ctr;
reg [3:0] oam_y_off; 
reg [9:0] oam_hit;
reg oam_processing;

reg in_window;
reg load_window;

reg [7:0] vram_data_sel;

wire [7:0] pal; 

reg vblank_stat_toggle;
reg hblank_stat_toggle;
reg oam_stat_toggle;
reg lcy_stat_toggle;
	
reg LCD_power_cycle;

reg oam_edge_det;
reg bg_edge_det;
reg bg_or_pal;
reg bg_or_pal2;

reg lcy_zero_hack;

always @(posedge pixel_clock)
begin
	
	bg_palette_mem_index = bg_palette_mem_index_next;
	oam_palette_mem_index = oam_palette_mem_index_next;
	
	if(rst) begin
			Reg_buttons_ff00[5:4] = 2'b0;
			Reg_SB_ff01 = 8'b0;
			Reg_LCDcontrol_ff40 = 8'b0;
			Reg_LCDstatus_ff41[6:3] = 4'b0;
			Reg_xscroll_ff43 = 8'b0;
			Reg_yscroll_ff42 = 8'b0;
			Reg_palette_ff47 = 8'b0;
			Reg_palette_ff48 = 8'b0;
			Reg_palette_ff49 = 8'b0;
			Reg_vbank_ff4f[0] = 0;
			render_mode = 2'b10;
			pixel_x = 0;
			pixel_y = 0;
			oam_fetch_state = 0;
			oam_bitplain0 = 0;
			oam_bitplain1 = 0;
			oam_fetch_state = 0;
			in_window = 0;
			LCD_power_cycle = 0;
			bg_palette_mem_index = 0;
			oam_palette_mem_index = 0;
			bg_palette_mem_index_next = 0;
			oam_palette_mem_index_next = 0;
			irq[1:0] = 0;
			vblank_stat_toggle = 0;
			hblank_stat_toggle = 0;
			oam_stat_toggle = 0;
			lcy_stat_toggle = 0;
			lcy_zero_hack = 0;
	end else begin
	
	if(~Reg_LCDcontrol_ff40[7]) begin
			render_mode = 2'b10;
			pixel_x = 0;
			pixel_y = 0;
			oam_fetch_state = 0;
			oam_bitplain0 = 0;
			oam_bitplain1 = 0;
			oam_fetch_state = 0;
			in_window = 0;
			lcy_zero_hack = 0;
	end
	
	casex (cpu_addr_bus)
		16'b111111110xxxxxxx: begin
			if(cpu_we) begin
				case (cpu_addr_bus[6:0])
					7'h44: begin end // lcd y (read only)
					7'h00: Reg_buttons_ff00[5:4] = data_bus_in[5:4];
					7'h01: Reg_SB_ff01 = data_bus_in;
					7'h40: Reg_LCDcontrol_ff40 = data_bus_in;							
					7'h41: Reg_LCDstatus_ff41[6:3] = data_bus_in[6:3];
					7'h43: Reg_xscroll_ff43 = data_bus_in;
					7'h45: Reg_lyc_ff45 = data_bus_in;
					7'h42: Reg_yscroll_ff42 = data_bus_in;
					7'h47: Reg_palette_ff47 = data_bus_in;
					7'h48: Reg_palette_ff48 = data_bus_in;
					7'h49: Reg_palette_ff49 = data_bus_in;
					7'h4b: Reg_winX_ff4b = data_bus_in;
					7'h4f: Reg_vbank_ff4f[0] = data_bus_in[0];
					7'h4a: Reg_winY_ff4a = data_bus_in;
					
					7'h68: begin 
						Reg_bgPalCtl_ff68 = data_bus_in[7];
						bg_palette_mem_index_next = data_bus_in[5:0];
					end
					7'h69: begin
						bg_edge_det = 1'b1;
					end
					7'h6a: begin 
						Reg_oamPalCtl_ff6a = data_bus_in[7];
						oam_palette_mem_index_next = data_bus_in[5:0];
					end
					7'h6b: begin 
						oam_edge_det = 1'b1;
					end
					
					default: begin end
				endcase
			end
		end
		default: begin end
	endcase
	
   if(oam_edge_det & ~cpu_we) begin
		oam_edge_det = 0;
		oam_palette_mem_index_next = oam_palette_mem_index + Reg_oamPalCtl_ff6a;
	end
	
	if(bg_edge_det & ~cpu_we) begin
		bg_edge_det = 0;
		bg_palette_mem_index_next = bg_palette_mem_index + Reg_bgPalCtl_ff68;
	end
	
	if(Reg_LCDcontrol_ff40[7]) begin
	
	
		//vblank_stat_toggle = pixel_x == 448 && pixel_y == 144;
	   //hblank_stat_toggle = in_x == 160;
		
//		vblank_stat_toggle = pixel_y >= 144;
//	   hblank_stat_toggle = in_x == 160;
//		lcy_stat_toggle = pixel_y == Reg_lyc_ff45;
		
		irq[0] = render_mode == 3'b01;//vblank_stat_toggle;
		irq[1] = (Reg_LCDstatus_ff41[6] && pixel_y == Reg_lyc_ff45)//lcy_stat_toggle) 
					| (Reg_LCDstatus_ff41[4] && render_mode == 3'b01)//vblank_stat_toggle)
					| (Reg_LCDstatus_ff41[3] && render_mode == 3'b00)//hblank_stat_toggle
					| (Reg_LCDstatus_ff41[5] && render_mode == 3'b10);//oam_stat_toggle);
		
		pixel_x = pixel_x + 1'b1;
		
		case (render_mode)
			3'b10: begin  //searching oam
				pixel_state = 0;
				oam_stat_toggle = 0;
				
				case (oam_search_state)
					0: begin //initialize
						for(int i = 0; i < 10; i++)
							sprites[i].x = 8'd255;
						oam_search_count = 39;
						oam_search_addr = {oam_search_count[5:0], 2'b0};
						oam_search_state = 8'd1;
					end
					1: begin
						oam_search_addr = {oam_search_count[5:0], 2'b1};
						oam_search_state = 8'd2;
					end
					2: begin
						oam_search_y = oam_data_out;					
						oam_search_count = oam_search_count - 1'b1;
						oam_search_addr = {oam_search_count[5:0], 2'b0};
						oam_search_state = 8'd3;
					end
					3: begin			
						oam_search_x = oam_data_out-2'd2;
						oam_search_addr = {oam_search_count[5:0], 2'b1};		
		
						if(pixel_y + 8'd16 >= oam_search_y  && pixel_y + 8'd16  < oam_search_y + (Reg_LCDcontrol_ff40[2] ? 8'd16 : 8'd8)) begin 
							for(int i = 0; i < 9; i++) begin
								sprites[9-i].x = sprites[8-i].x;
								sprites[9-i].y = sprites[8-i].y;
								sprites[9-i].oam_index = sprites[8-i].oam_index ;
							end
							sprites[0].x = oam_search_x + Reg_xscroll_ff43[2:0];
							sprites[0].y = oam_search_y;
							sprites[0].oam_index = oam_search_count + 1'b1;
						end 
						oam_search_state = 8'd2;
						render_mode = oam_search_count[6] ? 2'b11 : 2'b10;
					end		
					
				endcase
				
				oam_bitplain0 = 0;
				oam_bitplain1 = 0;
				oam_fetch_state = 0;
				
				oam_hit = {~|sprites[0].x, ~|sprites[1].x,~|sprites[2].x,~|sprites[3].x,~|sprites[4].x,
						~|sprites[5].x, ~|sprites[6].x, ~|sprites[7].x, ~|sprites[8].x, ~|sprites[9].x};
	
				in_window = 0;
				load_window = 0;
				x_offset=Reg_xscroll_ff43 ;
				y_offset=Reg_yscroll_ff42 + pixel_y;
				in_x = -(8'd8 + Reg_xscroll_ff43[2:0]);
				
			end	
			3'b11: begin  //rendering the line
				oam_search_state = 0;			
				
			  	y_offset=in_window ?  pixel_y - Reg_winY_ff4a: Reg_yscroll_ff42 + pixel_y;
				  			
				case (oam_fetch_state)
					0: begin 
						if(Reg_LCDcontrol_ff40[1] & |oam_hit) begin
							for(int i = 0; i < 10; i++) begin
								if(oam_hit & (1<<(9-i))) begin  
									oam_active_index = sprites[i].oam_index;
									oam_active_y = sprites[i].y;
									oam_search_addr = {oam_active_index[5:0],2'd3};
									oam_fetch_state = 1;
									oam_hit = oam_hit & ~(1'b1<<(4'd9-i));
									break;
								end 
							end
						end
					end
					1: begin
						oam_search_addr = {oam_active_index[5:0],2'd2};
						oam_fetch_state = 2;
					end
					2: begin 
						oam_active_attr = oam_data_out;
						if(Reg_LCDcontrol_ff40[2]) begin
							oam_y_off = oam_active_attr[6] ? oam_active_y[3:0] - pixel_y[3:0] - 1'b1: pixel_y[3:0] - oam_active_y[3:0] ;
						end else begin
							oam_y_off = oam_active_attr[6] ? oam_active_y[2:0] - pixel_y[2:0] - 1'b1: pixel_y[2:0] - oam_active_y[2:0] ;
						end
						oam_fetch_state = 3;
					end
					3: begin
						oam_active_addr = oam_data_out;
						vram1_search_addr = {4'h8, oam_active_addr[7:1], Reg_LCDcontrol_ff40[2] ? oam_y_off[3] : oam_active_addr[0], oam_y_off[2:0], 1'b0};
						vram2_search_addr = {4'h8, oam_active_addr[7:1], Reg_LCDcontrol_ff40[2] ? oam_y_off[3] : oam_active_addr[0], oam_y_off[2:0], 1'b0};
						oam_fetch_state = 4;
					end
					4: begin
						vram1_search_addr = {4'h8, oam_active_addr[7:1], Reg_LCDcontrol_ff40[2] ? oam_y_off[3] : oam_active_addr[0], oam_y_off[2:0], 1'b1};
						vram2_search_addr = {4'h8, oam_active_addr[7:1], Reg_LCDcontrol_ff40[2] ? oam_y_off[3] : oam_active_addr[0], oam_y_off[2:0], 1'b1};
						oam_fetch_state = 5;
					end
					5: begin
						vram_data_sel = oam_active_attr[3] & gbc ? vram2_data_out : vram1_data_out;
						for(int i = 0; i<8;i++) begin
							oam_bitplain0[i] = oam_bitplain0[i] | ((oam_active_attr[5] ? vram_data_sel[7-i] : vram_data_sel[i]) & ~oam_active_pixel[i]);
						end
						oam_fetch_state = 6;
					end
					6: begin
						vram_data_sel = oam_active_attr[3] & gbc ? vram2_data_out : vram1_data_out;
						for(int i = 0; i < 8; i++) begin
							oam_bitplain1[i] = oam_bitplain1[i] | ((oam_active_attr[5] ? vram_data_sel[7-i] : vram_data_sel[i]) & ~oam_active_pixel[i]);
							oam_palette_sel[i] = oam_active_pixel[i] ? oam_palette_sel[i] : oam_active_attr[4];
							
							oam_palette_sel_gbc[i] = oam_active_pixel[i] ? oam_palette_sel_gbc[i] : oam_active_attr[2:0];
							
							oam_priority_sel[i] = oam_active_pixel[i] ? oam_priority_sel[i] : oam_active_attr[7];
						end
						oam_active_pixel = oam_bitplain0 | oam_bitplain1;
						
						if(|oam_hit) begin
							oam_fetch_state = 0;
						end else begin
							reset_ctr = pixel_state;
							case(pixel_state)
								0,7: oam_fetch_state = 0;
								default: begin
									x_offset = x_offset - pixel_state;
									pixel_state = 0;
									oam_fetch_state = 7;
									
								end
							endcase
						end
					end
					7: begin
						pixel_state = pixel_state + 1'b1;
						if(pixel_state == reset_ctr) begin
							oam_fetch_state = 0;
							x_offset = x_offset + reset_ctr;
						end
					end

				endcase
				
				oam_processing = (|oam_fetch_state | |oam_hit) & Reg_LCDcontrol_ff40[1];
	
				if((~oam_processing | oam_fetch_state == 3'd7) & (Reg_LCDcontrol_ff40[0] )) begin
				

					
					case (pixel_state)
						0: begin
							vram1_search_addr={2'b11,in_window ? Reg_LCDcontrol_ff40[6] : Reg_LCDcontrol_ff40[3], y_offset[7:3],x_offset[7:3]};
							vram2_search_addr={2'b11,in_window ? Reg_LCDcontrol_ff40[6] : Reg_LCDcontrol_ff40[3], y_offset[7:3],x_offset[7:3]};
						end
						1: begin				
						end
						2: begin //todo, handle flipping
							
							char_addr = (Reg_LCDcontrol_ff40[4] ) ? {1'b0,vram1_data_out,y_offset[2:0]} : {~vram1_data_out[7],vram1_data_out,y_offset[2:0]};
							tile_attr = vram2_data_out;
							vram1_search_addr={char_addr[14:0],1'b0};
							vram2_search_addr={char_addr[14:0],1'b0};
						end
						3: begin
							
						end
						4: begin
							bitplain_0_next= tile_attr[3] & gbc ? vram2_data_out : vram1_data_out;
							vram1_search_addr={char_addr[14:0],1'b1};
							vram2_search_addr={char_addr[14:0],1'b1};
						end
						5: begin
						end

						6: begin
							bitplain_1_next= tile_attr[3] & gbc ? vram2_data_out : vram1_data_out;
						end
						7: begin
							bitplain_0=bitplain_0_next;
							bitplain_1=bitplain_1_next;
							tile_attr_cur = tile_attr;
						end
					endcase
					
					if(load_window) begin
						if(pixel_state == 7) begin
							load_window = 0;
						end else begin
							pixel_state = pixel_state + 1'b1;
							x_offset = x_offset + 1'b1;
						end
					end
					
				end
				
				if(~oam_processing & ~load_window) begin
				
					bg_color_index={bitplain_1[7], bitplain_0[7]};
					sprite_color_index = {oam_bitplain1[7],oam_bitplain0[7]};
					oam_priority = oam_priority_sel[7];
					oam_palette = oam_palette_sel[7];
					oam_palette_gbc = oam_palette_sel_gbc[7];
					
					bitplain_0 = {bitplain_0[6:0],1'b0};
					bitplain_1 = {bitplain_1[6:0],1'b0};
					
					oam_bitplain0 = {oam_bitplain0[6:0],1'b0};
					oam_bitplain1 = {oam_bitplain1[6:0],1'b0};
					
					oam_palette_sel = {oam_palette_sel[6:0],1'b0};
					oam_palette_sel_gbc = {oam_palette_sel_gbc[6:0],{3'b0}};
					oam_priority_sel = {oam_priority_sel[6:0],1'b0};
					
					oam_active_pixel = {oam_active_pixel[6:0],1'b0};
			
					oam_hit = {~|sprites[0].x, ~|sprites[1].x,~|sprites[2].x,~|sprites[3].x,~|sprites[4].x,
						~|sprites[5].x, ~|sprites[6].x, ~|sprites[7].x, ~|sprites[8].x, ~|sprites[9].x};					
					
					for(int i = 0; i < 10; i++) begin
						sprites[i].x = sprites[i].x - 1'b1;
					end
				
					x_offset = x_offset + 1'b1;
					pixel_state = pixel_state + 1'b1;
										
					fb_we = 1'b1;
					
					if (in_x == Reg_winX_ff4b - 8'd8 && pixel_y >= Reg_winY_ff4a && Reg_LCDcontrol_ff40[5] && Reg_LCDcontrol_ff40[0]) begin
						x_offset = 1;
						y_offset = pixel_y - Reg_winY_ff4a;
						in_window = 1;
						pixel_state = 0;
						load_window = 1;
					end
					
					in_x = in_x + 1'b1;
					
				end else begin
					fb_we = 0;
				end
								
				render_mode = in_x != 160 ? 2'b11 : 2'b0;
				
				
	
			end
			3'b00: begin // in hblank
			
				
				oam_search_state = 0;
				pixel_state = 0;
				in_x = 8'hff;
				fb_we = 0;
				

				
				if(pixel_x == 456) begin
					pixel_x = 0;
					
					y_offset=Reg_yscroll_ff42 + pixel_y;			
					x_offset=Reg_xscroll_ff43 ;
					
					if(pixel_y == 144) begin
						render_mode = 2'b01;
					end else begin
						oam_stat_toggle = 1;
						render_mode = 2'b10;
					end
				end 
				
			end
			3'b01: begin //in vblank
				oam_search_state = 0;
				pixel_state = 0;
				in_x = 8'hff;
				
				if(pixel_x == 456) begin
					pixel_x = 0;
					
					if(lcy_zero_hack) begin
						render_mode = 2'b10;
					end
				end
			end
		endcase
		
		if((pixel_x == 10 && pixel_y == 8'h99) || (pixel_x == 448 && pixel_y != 8'h99 && ~lcy_zero_hack)) begin
			pixel_y = pixel_y + 1'b1;
			if(pixel_y == 154) begin
			   lcy_zero_hack = 1;
				pixel_y = 0;
			end
		//	lcy_stat_toggle = pixel_y == Reg_lyc_ff45;
		end else begin
		//	lcy_stat_toggle = 0;
		end
		
		if(pixel_x == 0) begin
			lcy_zero_hack = 0;
		end
		

		
		if(in_x < 8'd162 && pixel_y < 8'd144) begin
			
			
			fb_write_addr = {pixel_y[7:0],in_x };
			mipi_line_buffer_wr_addr = in_x;
			
			mipi_color = bg_or_pal ? {bg_palette_mem1_data_out, bg_palette_mem2_data_out} : {oam_palette_mem1_data_out, oam_palette_mem2_data_out};
			
				
			if(((|bg_color_index & oam_priority) | ~|sprite_color_index | (tile_attr_cur[0] & gbc))
			& (Reg_LCDcontrol_ff40[0] | (Reg_LCDcontrol_ff40[5] & in_window))) begin
				color_index = bg_color_index; 
				pal = Reg_palette_ff47;
  		      bg_or_pal = 1'b1;	
			end else begin
				color_index = sprite_color_index;  
				pal = oam_palette ? Reg_palette_ff49 : Reg_palette_ff48;
			   bg_or_pal = 1'b0;
			end 

			case(color_index)
				2'b00: begin
					fb_data_in = pal[1:0];
				end
				2'b01: begin
					fb_data_in = pal[3:2];
				end
				2'b10: begin
					fb_data_in = pal[5:4];
				end
				2'b11: begin 
					fb_data_in = pal[7:6];
				end
			endcase

				
			bg_palette_mem_index_vr = {tile_attr_cur[2:0], (initialized & gb_rom) ? fb_data_in : color_index};
			oam_palette_mem_index_vr = {oam_palette_gbc | (gb_rom & oam_palette), (initialized & gb_rom) ? fb_data_in : color_index};
	
			
			if(~gbc) begin
			
				case(fb_data_in)
						2'b11: mipi_color = 16'b0; 
						2'b10: mipi_color = {1'b0, 5'b01010, 5'b01010,5'b01010};  							
						2'b01: mipi_color = {1'b0, 5'b10101, 5'b10101,5'b10101};  		
						2'b00: mipi_color = {1'b0, 5'b11111, 5'b11111,5'b11111};  
				endcase
			end
			
		
		end
		else mipi_color = 0;
	end
end 		

end 


//-------------------------------------------
//
//	VGA signal generation
//
//-------------------------------------------

reg signed [10:0]	out_x;
reg [10:0]	out_y;
reg [12:0]	shift_x;
reg [12:0]	shift_y;

always @(posedge vga_clock)
begin
	
	
	shift_x = x - 13'd320;
	shift_y = y - 13'd224;	
	
	out_x = shift_x[12:2];
	out_y = shift_y[12:2];
	
	fb_read_addr = {out_y[7:0],out_x[7:0]};
	
	if(out_x < 162 && out_y < 144 && out_x > 2) begin
		color=fb_data_out;
	end else begin
		color=16'h0;
	end
	
	vga_vs<=vs_;
	vga_hs<=hs_;
end



always_comb 
begin
	//blank signals to the adv7123 chip 
	//vs and hs go directly to the vga connector
	vga_hblank<=1;  //unused (required only if sync on green)
   vga_vblank<=vga_vs; //
	

		
	if((_vblank & _hblank)) begin	
		
		vga_red <= {color[4:0], 3'b0};
		vga_green <= {color[9:5], 3'b0};
		vga_blue <= {color[14:10], 3'b0};
	
	end else begin
		vga_red<=0;
		vga_green<=0;
		vga_blue<=0;
	end
end



//-------------------------------------------
//
//	MIPI signal generation
//
//-------------------------------------------

reg [7:0] mipi_pwm_duty;
reg [2:0] mipi_state;
reg [7:0] mipi_data_out;
reg [7:0] mipi_control_out;
reg [8:0] mipi_x;
reg [2:0] mipi_wr_state;
reg [15:0] mipi_color;
reg [1:0] mipi_x_toggle; //scalling
reg [2:0] mipi_y_toggle; //scalling
reg  mipi_line_toggle;  
//clock crossing
reg mipi_line_toggle_pixel_clock[1:0];
reg [8:0] mipi_pixel_y[1:0];
reg mipi_Reg_LCDcontrol_ff40[1:0];
reg [2:0] mipi_render_mode[1:0];
reg mipi_unloaded[1:0];

reg [7:0] mipi_index;

reg [7:0] mipi_cmd;
reg [7:0] mipi_y;

reg [15:0] mipi_data_out1;
reg [15:0] mipi_data_out2;

reg [7:0] mipi_line_buffer_wr_addr;

mipi_line_buffer mipi_line_buffer1(
	.data({mipi_color[4:0], mipi_color[9:5], 1'b0, mipi_color[14:10]}),
	.rdaddress(mipi_index),
	.rdclock(mipi_clock),
	.wraddress(mipi_line_buffer_wr_addr),
	.wrclock(pixel_clock),
	.wren(fb_we & mipi_line_toggle_pixel_clock[1]),
	.q(mipi_data_out1)
	);
mipi_line_buffer mipi_line_buffer2(
	.data({mipi_color[4:0], mipi_color[9:5], 1'b0, mipi_color[14:10]}),
	.rdaddress(mipi_index),
	.rdclock(mipi_clock),
	.wraddress(mipi_line_buffer_wr_addr),
	.wrclock(pixel_clock),
	.wren(fb_we & ~mipi_line_toggle_pixel_clock[1]),
	.q(mipi_data_out2)
	);

//clock crossing	
always @(posedge pixel_clock)
begin
	mipi_line_toggle_pixel_clock[1] <= mipi_line_toggle_pixel_clock[0];
	mipi_line_toggle_pixel_clock[0] <= mipi_line_toggle;
	
end

always @(posedge mipi_clock)
begin

mipi_pixel_y[1] <= mipi_pixel_y[0];
mipi_pixel_y[0] <= pixel_y;

mipi_Reg_LCDcontrol_ff40[1] <= mipi_Reg_LCDcontrol_ff40[0];
mipi_Reg_LCDcontrol_ff40[0] <= Reg_LCDcontrol_ff40[7];


mipi_render_mode[1] <= mipi_render_mode[0];
mipi_render_mode[0] <= render_mode;


mipi_unloaded[1] <= mipi_unloaded[0];
mipi_unloaded[0] <= unloaded;


end

always @(posedge cpu_clock)
begin
	if(rst) begin
		mipi_pwm_duty = 8'h3f;
	end else begin
		if(cpu_we && cpu_addr_bus == 16'hff84) begin
			mipi_data_out = data_bus_in;
		end else if (cpu_we && cpu_addr_bus == 16'hff85 && unloaded) begin
			mipi_control_out = data_bus_in;
		end
		
		mipi_pwm_duty = {mipi_pwm_duty[0],mipi_pwm_duty[7:1]};
		mipi_pwm =  mipi_pwm_duty[7];
	end
end

always @(posedge mipi_clock)
begin
	if(rst) begin
		mipi_state = 0;
		mipi_x = 0;
		mipi_wr_state = 0;
		mipi_line_toggle = 0;
		mipi_index = 2;
		mipi_y = 0;
		mipi_cmd = 8'h0;
	end else begin

		
		
		case (mipi_state)
			0: begin  //resetting
	
				{mipi_rd, mipi_wr, mipi_cs, mipi_dc, mipi_rst, mipi_cm, mipi_shut, mipi_vddio_ctrl} = {mipi_control_out[7:3], 1'b0, 1'b0, 1'b1};
				mipi_rgb = mipi_data_out;
				mipi_state = (~mipi_unloaded[1] && (mipi_pixel_y[1] != 8'd145));
			end
			1: begin
				if(~mipi_Reg_LCDcontrol_ff40[1] && mipi_cmd != 8'h23) begin
					mipi_cmd = 8'h23;
					mipi_state = 3'd2;	
				end else if (mipi_cmd == 8'h23 ) begin
					mipi_cmd = 8'h13;
					mipi_state = 3'd2;	
				end else begin
				
					mipi_state = (mipi_render_mode[1] == 2'd0 ? 3'd2 : 3'd1) ;
					
					mipi_index = 2;
					mipi_x = 9'd0;
					mipi_x_toggle = 0;
										
					mipi_cmd = (mipi_pixel_y[1] == 9'd0 ? 8'h2C : 8'h3C);
					
					if(mipi_render_mode[1] == 2'd0) begin
						mipi_line_toggle = mipi_line_toggle ^ 1'b1;
					end
				end
				
				mipi_wr_state = 0;
						
				
			end

			2:begin  //write start byte
				mipi_y = mipi_y + 1'b1;
				
				case(mipi_wr_state)
					0: begin
						mipi_rgb = mipi_cmd;
						mipi_wr = 1;
						mipi_cs = 1;
						mipi_dc = 0;
						mipi_rd = 1;
					end
					1: begin
						mipi_wr = 1;
						mipi_cs = 0;
						mipi_dc = 0;
						mipi_rd = 1;
					end
					2: begin
						mipi_wr = 0;
						mipi_cs = 0;
						mipi_dc = 0;
						mipi_rd = 1;
					end
					3: begin
						mipi_wr = 1;
						mipi_cs = 1;
						mipi_dc = 1;
						mipi_rd = 1;
					end
					4: begin
						mipi_wr = 1;
						mipi_cs = 0;
						mipi_dc = 1;
						mipi_rd = 1;
					end
					default: begin end
				endcase 
				
					mipi_wr_state  = mipi_wr_state + 1'b1;
					
					if(~|mipi_wr_state) begin
						mipi_state = (mipi_cmd == 8'd23 || mipi_cmd == 8'd13) ? 3'd1 : 3'd3;
					end
					
					
					mipi_x = 0;
					mipi_index = 2;
	
			end
			3: begin
			
		
   			case(mipi_wr_state[1:0])
					0: begin
						mipi_rgb =  mipi_line_toggle ? mipi_data_out2[7:0] : mipi_data_out1[7:0];
						mipi_wr = 0;
						mipi_cs = 0;
						mipi_dc = 1;
						mipi_rd = 1;
	
					end
					1: begin
						mipi_wr = 1;
						mipi_cs = 0;
						mipi_dc = 1;
						mipi_rd = 1;
					
					end
					2: begin
						mipi_rgb = mipi_line_toggle ? mipi_data_out2[15:8] : mipi_data_out1[15:8];
						mipi_wr = 0;
						mipi_cs = 0;
						mipi_dc = 1;
						mipi_rd = 1;
					
				   	mipi_x = mipi_x + 1'b1;
						
						if(mipi_x_toggle != 2'd3 || mipi_scale) begin
						
							mipi_index = mipi_index + 1'b1;
						end else begin
							mipi_x_toggle = 0;
						end
						
						mipi_x_toggle = mipi_x_toggle + 1'b1;	
					end
					3: begin
						mipi_wr = 1;
						mipi_cs = 0;
						mipi_dc = 1;
						mipi_rd = 1;
						
					end
					default: begin end
				endcase 
									
				mipi_wr_state = mipi_wr_state + 1'b1;
				
				if(mipi_x > 240) begin
					mipi_x = 0;
					mipi_index = 2;
					mipi_x_toggle = 0;
					mipi_wr_state = 0;
					
					if(((mipi_y_toggle != 3'd3 && mipi_y_toggle != 3'd5) |  mipi_scale)) begin
						mipi_state = 3'd4;							
					end else begin
						mipi_state = 3'd2;
						mipi_y_toggle = mipi_y_toggle == 3'd5 ? 3'd0 : mipi_y_toggle;
					end
					
					mipi_y_toggle = mipi_y_toggle + 1'b1;

				end
	
		end
		4: begin
			mipi_state = mipi_render_mode[1] == 2'd0 ? 3'd4 : 3'd1;
		end

		default: 
		
			begin 
				mipi_state = 2'b01;
			end
		
		endcase
		
		if(~mipi_Reg_LCDcontrol_ff40[1]) begin
			mipi_state = mipi_state ? 3'd1 : 3'd0;
		end
		
	end
	
end


endmodule
