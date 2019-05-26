//---------------------------------------
//very simple single mode (640x480x60hz) vga
//generator appropriately named: ledblink

module ledblink 
//---------------------------------------
(led, button, switches, clock_50mhz, 
r, g, b, vs, hs, vblank, hblank, clock_vga, 
i2c_sclk, i2c_sdata, dac_mute, dac_mclk, dac_LR_clk, dac_data, dac_bclk, 
rst_button,
snes_clk, snes_data, snes_latch,
uart_tx, uart_rx,
mipi_pwm, mipi_rgb, mipi_cm, mipi_rd, mipi_cs, mipi_shut, mipi_wr, mipi_dc, mipi_rst, mipi_vddio_ctrl  
);            

output [3:0] 	led;
output [7:0]	r;
output [7:0]	g;
output [7:0]	b;
output 			hs;
output 			vs;
output 			hblank;
output 			vblank;
output			clock_vga;
output 			snes_clk;
output			snes_latch;
input			snes_data;


output uart_tx;
input uart_rx;

input [3:0] 	button; 
input [3:0]    switches;
input 			clock_50mhz;
input 			rst_button;

output i2c_sclk;
inout i2c_sdata;
output dac_mute;
output dac_mclk;
output dac_bclk;
output dac_LR_clk;
output dac_data;

output mipi_pwm; 
output [7:0] mipi_rgb; 
output mipi_cm;
output mipi_rd; 
output mipi_cs; 
output mipi_shut; 
output mipi_wr; 
output mipi_dc;
output mipi_rst;
output mipi_vddio_ctrl;  

reg [15:0] 		snes_buttons;
reg [1:0]		snes_state;
reg [4:0] 		snes_ctr;
reg [15:0] 		snes_shift_reg;

reg [3:0] 		led;
wire 				clock_50mhz;

reg [7:0]		r;
reg [7:0]		g;
reg [7:0]		b;
reg 				hs;
reg				vs;
wire 				hblank;
wire				vblank;
wire				clock_vga;

wire i2c_sclk;
wire i2c_sdata;
wire dac_mute;
wire dac_mclk;
wire dac_bclk;
wire dac_LR_clk;
wire dac_data;


reg gbc;

//----------------------------------------


wire				clock_20mhz;
wire				clock_108;
wire				pixel_clock;
wire 				memory_clock;
reg				half_clock;
wire 				full_clock;
wire 				cpu_clock;
wire 				snes_clock;

reg 				hs_;
reg				vs_;
//vga pixel counters
wire [12:0] x;
wire [12:0] y;

wire _vblank;
wire _hblank;
wire locked;

wire reset;
wire rst;

//-------------------------------------------
//
// clock logic
//
//-------------------------------------------

assign cpu_clock = full_clock;//speed_double ? full_clock : half_clock;
assign pixel_clock = full_clock;
assign memory_clock = full_clock;

always @(posedge full_clock)
begin
	half_clock = ~half_clock;
end

//-------------------------------------------
//
// uart
//
//-------------------------------------------

wire uart_clk;
wire uart_data_rdy;
wire [7:0] uart_data_rcv;
wire uart_rst_req;
wire [27:0] uart_load_addr;
wire uart_load_we;
wire uart_loading;

uart load_uart(
.rst(rst),
.clk(uart_clk), 
.data_clk(cpu_clock), 
.send(cpu_we && cpu_addr_bus == 16'hFF01),
.data_send(cpu_data_bus_out), 
.data_rcv(uart_data_rcv), 
.rdy(uart_data_rdy),
.ack(cpu_we && cpu_addr_bus == 16'hFF08), 
.tx(uart_tx), 
.rx(uart_rx),
.rst_req(uart_rst_req),
.load_addr(uart_load_addr),
.load_we(uart_load_we),
.loading(uart_loading));

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

frame_buffer fb(
	mipi_color,
	fb_read_addr,
	clock_vga,
	fb_write_addr,
	pixel_clock,
	fb_we,
	fb_data_out);
	


//-------------------------------------------
//
//	Mipi driver
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
reg  mipi_line_toggle;  //scalling
reg [7:0] mipi_index;

reg [7:0] mipi_cmd;
reg [7:0] mipi_y;

reg [15:0] mipi_data_out1;
reg [15:0] mipi_data_out2;

reg [7:0] mipi_line_buffer_wr_addr;

mipi_line_buffer mipi_line_buffer1(
	.data({mipi_color[4:0], mipi_color[9:5], 1'b0, mipi_color[14:10]}),
	.rdaddress(mipi_index),
	.rdclock(clock_20mhz),
	.wraddress(mipi_line_buffer_wr_addr),
	.wrclock(pixel_clock),
	.wren(fb_we & mipi_line_toggle),
	.q(mipi_data_out1)
	);
mipi_line_buffer mipi_line_buffer2(
	.data({mipi_color[4:0], mipi_color[9:5], 1'b0, mipi_color[14:10]}),
	.rdaddress(mipi_index),
	.rdclock(clock_20mhz),
	.wraddress(mipi_line_buffer_wr_addr),
	.wrclock(pixel_clock),
	.wren(fb_we & ~mipi_line_toggle),
	.q(mipi_data_out2)
	);

always @(posedge cpu_clock)
begin
	if(rst) begin
		mipi_pwm_duty = 8'h3f;
	end else begin
		if(cpu_we && cpu_addr_bus == 16'hff84) begin
			mipi_data_out = cpu_data_bus_out;
		end else if (cpu_we && cpu_addr_bus == 16'hff85 && unloaded) begin
			mipi_control_out = cpu_data_bus_out;
		end
		
		mipi_pwm_duty = {mipi_pwm_duty[0],mipi_pwm_duty[7:1]};
		mipi_pwm =  mipi_pwm_duty[7];
	end
end

always @(posedge clock_20mhz)
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
				mipi_state = (~unloaded && (pixel_y != 8'd145));
			end
			1: begin
				if(~Reg_LCDcontrol_ff40[7] && mipi_cmd != 8'h23) begin
					mipi_cmd = 8'h23;
					mipi_state = 3'd2;	
				end else if (mipi_cmd == 8'h23 ) begin
					mipi_cmd = 8'h13;
					mipi_state = 3'd2;	
				end else begin
				
					mipi_state = (render_mode == 2'd0 ? 3'd2 : 3'd1) ;
					
					mipi_index = 2;
					mipi_x = 9'd0;
					mipi_x_toggle = 0;
										
					mipi_cmd = (pixel_y == 9'd0 ? 8'h2C : 8'h3C);
					
					if(render_mode == 2'd0) begin
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
						
						if(mipi_x_toggle != 2'd3 || ~switches[2]) begin
						
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
					
					if(((mipi_y_toggle != 3'd3 && mipi_y_toggle != 3'd5) |  ~switches[2])) begin
						mipi_state = 3'd4;							
					end else begin
						mipi_state = 3'd2;
						mipi_y_toggle = mipi_y_toggle == 3'd5 ? 3'd0 : mipi_y_toggle;
					end
					
					mipi_y_toggle = mipi_y_toggle + 1'b1;

				end
	
		end
		4: begin
			mipi_state = render_mode == 2'd0 ? 3'd4 : 3'd1;
		end

		default: 
		
			begin 
				mipi_state = 2'b01;
			end
		
		endcase
		
		if(~Reg_LCDcontrol_ff40[7]) begin
			mipi_state = mipi_state ? 3'd1 : 3'd0;
		end
		
	end
	
end

//-------------------------------------------
//
// snes controller
//
//-------------------------------------------

reg [12:0] snes_counter;

always @(posedge cpu_clock)
begin
	if(rst) begin
		snes_state = 0;
		snes_latch = 0;
		snes_ctr = 0;
		snes_buttons = 0;
		snes_shift_reg = 0;
	end else begin
		
		snes_clk = ~(~|snes_counter[3:0] & snes_state[1:0]==2);
		
		if(~|snes_counter[3:0]) begin
			case (snes_state)
			
			0: begin
				snes_latch = 0;
				snes_state = ~|snes_counter ? 2'b1 : 2'b0;
				
			end
			1: begin
				snes_latch = 1;
				snes_state = 2;
				snes_shift_reg = 0;
				snes_ctr = 0;
				
			end
			2: begin
				snes_shift_reg = {snes_data, snes_shift_reg[15:1]};
				snes_latch = 0;
				snes_ctr = snes_ctr + 1'b1;
				if(snes_ctr == 16) begin
					snes_buttons = snes_shift_reg;
					snes_state = 0;
				end
			end
			default: snes_state = 0;
			
			endcase
		end
		snes_counter = snes_counter + 1'b1;
		
		led = snes_buttons[8:5] | { snes_buttons[4:2],  snes_buttons[0]};
		
		//led = snes_buttons[12:9] ^ {3'b0, ^fb_data_out};
		
	end
	

	
	Reg_buttons_ff00[0] = ~Reg_buttons_ff00[5] & snes_buttons[8] | ~Reg_buttons_ff00[4] & snes_buttons[7];
	Reg_buttons_ff00[1] = ~Reg_buttons_ff00[5] & snes_buttons[0] | ~Reg_buttons_ff00[4] & snes_buttons[6];
	Reg_buttons_ff00[2] = ~Reg_buttons_ff00[5] & snes_buttons[2] | ~Reg_buttons_ff00[4] & snes_buttons[4];
	Reg_buttons_ff00[3] = ~Reg_buttons_ff00[5] & snes_buttons[3] | ~Reg_buttons_ff00[4] & snes_buttons[5];
	
end

//-------------------------------------------
//
// sound hardware
//
//-------------------------------------------
	
gb_sound_hardware gbsh(
    .clk (pixel_clock), //the pixel clock
	 .rst (rst),
     
	 .left_out (sound_left_out),  
	 .right_out (sound_right_out),
	 .sound_enabled (sound_enabled),
	 
	 .addr_bus (cpu_addr_bus) ,
	 .data_bus_in (cpu_data_bus_out),
	 .data_bus_out (sound_data_bus_out),
	 .we (cpu_we),
	 .re (cpu_re),
	 .channel_enables (switches)
);

wire sound_enabled;
wire [15:0] sound_left_out;
wire [15:0] sound_right_out;

wire [7:0] sound_data_bus_out;

reg [7:0] sound_44khz_divider;
reg [5:0] sound_left_count;
reg [5:0] sound_right_count;

reg [15:0] sound_shifter;

wire sound_44khz_clk;

always @(posedge dac_mclk) 
begin
	sound_44khz_divider = sound_44khz_divider + 1'b1;
end

always_comb 
begin
	sound_44khz_clk = sound_44khz_divider[7];
	dac_LR_clk <= sound_44khz_clk;
end

always @(posedge dac_bclk)
begin
	if (rst) begin
		sound_left_count = 6'b0;
		sound_right_count = 6'b0;
	end else if (~i2c_init) begin
		//do something here?
	end else if(sound_44khz_clk) begin
	   sound_right_count = 6'b0;
		
		if(~|sound_left_count) begin
			sound_shifter = sound_left_out;
		end
		
		if(~sound_left_count[5]) begin
			sound_shifter = {sound_shifter[14:0], 1'b0};
			sound_left_count = sound_left_count + 1'b1;
		end
	end else begin
		sound_left_count = 6'b0;
		
		if(~|sound_right_count) begin
			sound_shifter = sound_right_out;
		end
		
		if(~sound_right_count[5]) begin
			sound_shifter = {sound_shifter[14:0], 1'b0};
			sound_right_count = sound_right_count + 1'b1;
		end
	end
	dac_data = sound_shifter[15];
	
end
//-------------------------------------------
//
// I2C for audio DAC
//
//-------------------------------------------

reg start_i2c;
reg done_i2c;
wire ack_i2c;
wire [15:0] lut_data;
reg [3:0] lut_index = 0;
reg [7:0] dac_i2c_addr = 8'h34;
reg sending_i2c;

wire i2c_init;

i2c_send i2c_dac(
    .clk (pixel_clock), //the clock, max 526kHz * 8 for the dac
	 .rst (rst),
    .sclk (i2c_sclk), //i2c sclk
    .sdat (i2c_sdata), //i2c sdat
    
    .start (start_i2c) , //starts the send/recieve 
    .done (done_i2c), //set to high when transfer complete
    .ack (ack_i2c), //will be high if all three acks are correct

    .data ({dac_i2c_addr, lut_data}) //data to be sent
);

always_comb begin
	 dac_mute <= 1'b1;
	 i2c_init <= lut_index == 4'hb ? 1'b1 : 1'b0;
	 
    case (lut_index)
        4'h0: lut_data <= 16'h0c13; // power on everything except out
        4'h1: lut_data <= 16'h0017; // left input
        4'h2: lut_data <= 16'h0217; // right input
        4'h3: lut_data <= 16'h045c; // left output
        4'h4: lut_data <= 16'h065c; // right output
        4'h5: lut_data <= 16'h08d4; // analog path
        4'h6: lut_data <= 16'h0a04; // digital path
        4'h7: lut_data <= 16'h0e01; // digital IF
        4'h8: lut_data <= 16'h1020; // sampling rate
        4'h9: lut_data <= 16'h0c03; // power on everything
        4'ha: lut_data <= 16'h1201; // activate
        default: lut_data <= 16'h0000;
    endcase
end

always @(posedge pixel_clock) 
begin
	if(rst) begin
		lut_index = 1'b0;
		sending_i2c = 1'b0;
		start_i2c = 1'b0;
		dac_i2c_addr = 8'h34;
	end else if (lut_index != 4'hb) begin
		if(~sending_i2c) begin
			sending_i2c = 1'b1;
			start_i2c = 1'b1;
		end else if (done_i2c) begin
			lut_index = lut_index + 1'b1;
			start_i2c = 1'b0;
			sending_i2c = 1'b0;
		end
	end
end

//-------------------------------------------
//
// CPU 
//
//-------------------------------------------
wire [15:0] cpu_addr_bus;
wire [7:0] cpu_data_bus_out;
wire [7:0] cpu_data_bus_in;
wire cpu_we;
wire cpu_re;
wire [15:0] cpu_pc;

reg [7:0] irq;
wire button_pressed = 0;
wire cgb = 0;
wire initialized;
wire speed_double;

gb_cpu cpu(
.rst(rst),
.clock(cpu_clock), 
.addr_bus_out(cpu_addr_bus), 
.data_bus_in(cpu_data_bus_in), 
.data_bus_out(cpu_data_bus_out), 
.we(cpu_we), 
.re(cpu_re), 
.PC(cpu_pc), 
.irq(irq), 
.button_pressed(button_pressed), 
.cgb(cgb),
.initialized(initialized),
.gdma_happening(gdma_happening),
.speed_double(speed_double));

//-------------------------------------------
//
//	Memory controller
//
//-------------------------------------------

reg [7:0] mem_controller_data_out;
reg [7:0] dma_wr_addr;
reg [7:0] dma_data;
reg dma_we;
reg dma_happening;

wire [15:0] gdma_wr_addr;
wire [7:0] gdma_data;
wire gdma_we;
wire gdma_happening;

reg unloaded;
reg gb_rom;

gb_memory_controller mem_control(
.rst(rst), 
.clock(memory_clock), 
.addr_bus(cpu_addr_bus), 
.data_in(cpu_data_bus_out), 
.data_out(mem_controller_data_out), 
.we(cpu_we),
.rd(cpu_re), 
.cgb(cgb), 
.initialized(initialized),
.dma_wr_addr(dma_wr_addr),
.dma_we(dma_we),
.dma_happening(dma_happening),
.dma_data(dma_data),
.gdma_wr_addr(gdma_wr_addr),
.gdma_we(gdma_we),
.gdma_happening(gdma_happening),
.gdma_data(gdma_data),
.unloaded(unloaded),
.gb_rom(gb_rom),
.uart_addr(uart_load_addr),
.uart_data_in(uart_data_rcv),
.uart_we(uart_load_we),
.uart_load(uart_loading));

//-------------------------------------------
//
//	Video hardware 
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
//reg [7:0] Reg_IF_ff0f =8'h00;

//------------------------------------------
//
// Timer / Div
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
					7'h05: Reg_TIMA_ff05 = cpu_data_bus_out;
					7'h06: Reg_TMA_ff06 = cpu_data_bus_out;
					7'h07: Reg_TAC_ff07[2:0] = cpu_data_bus_out[2:0];
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
//	Pixel offsets
//
//-------------------------------------------
reg [8:0] x_offset;
reg [8:0] y_offset;





//-------------------------------------------

vga_controller_1280x1024 vga (clock_108, vs_, hs_, _vblank, _hblank, x, y);

vga_clock clocks(clock_50mhz, reset, clock_108, full_clock, dac_mclk, dac_bclk, uart_clk, clock_20mhz, locked);


//-------------------------------------------

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

//gb_vram vram2(gdma_happening ? gdma_wr_addr : vram2_addr_bus[12:0],
//	memory_clock,
//	gdma_happening ? gdma_data :vram_data_in,
//	(vram_we | (gdma_happening & gdma_we)) & Reg_vbank_ff4f[0],
//	vram2_data_out);
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

gb_oam2 oam(
	memory_clock,
	oam_data_in,
	oam_addr_bus[7:0], oam_wr_addr_bus,
	oam_we | dma_we,
	oam_data_out);
	

//-------------------------------------------
//
//	Pixel clock state machine
//
//-------------------------------------------

parameter [2:0] PIXEL_STATE_Ba=3'd0,PIXEL_STATE_0a=3'd2,PIXEL_STATE_1a=3'd4,PIXEL_STATE_Sa=3'd6,
					 PIXEL_STATE_Bb=3'd1,PIXEL_STATE_0b=3'd3,PIXEL_STATE_1b=3'd5,PIXEL_STATE_Sb=3'd7;

reg [2:0]	pixel_state;

reg [7:0]	in_x;

wire valid_vram_addr;

always_comb
begin
	
		vram_data_in <= cpu_data_bus_out;
		oam_wr_addr_bus <= dma_happening ? dma_wr_addr : cpu_addr_bus[7:0];
		
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
		
		vram_data_out <= Reg_vbank_ff4f[0] & gbc ? vram2_data_out : vram1_data_out;
		
		oam_data_in <= dma_happening ? dma_data : cpu_data_bus_out;
		
		
		rst <= ~rst_button ;
		
		gbc = ~switches[0];
		
		case (Reg_TAC_ff07[1:0])
			2'b00: timer_tick <= Reg_TAC_ff07[2] & timer_accumulator[9];
			2'b01: timer_tick <= Reg_TAC_ff07[2] & timer_accumulator[3];
			2'b10: timer_tick <= Reg_TAC_ff07[2] & timer_accumulator[5];
			2'b11: timer_tick <= Reg_TAC_ff07[2] & timer_accumulator[7];
		endcase
		
			casex (cpu_addr_bus)
		16'h8xxx, 16'h9xxx: begin
			cpu_data_bus_in = render_mode == 2'b11 ? 8'hFF : vram_data_out;
			vram_we = render_mode == 2'b11 ? 1'b0 :  cpu_we;
			oam_we = 1'b0;
		end
		16'b111111110xxxxxxx: begin
			vram_we <= 1'b0;
			oam_we <= 1'b0;
		
			casex (cpu_addr_bus[6:0])
					7'h01: cpu_data_bus_in = serial_xfr_complete ? 8'hff : Reg_SB_ff01 ;
					7'h02: cpu_data_bus_in = Reg_SC_ff02 ;
					
					7'h04: cpu_data_bus_in = timer_accumulator[15:8];
					7'h05: cpu_data_bus_in = Reg_TIMA_ff05;
					7'h06: cpu_data_bus_in = Reg_TMA_ff06;
					7'h07: cpu_data_bus_in = Reg_TAC_ff07;
					7'h08: cpu_data_bus_in = {7'b0,uart_data_rdy};
					7'h09: cpu_data_bus_in = uart_data_rcv;
					7'h45: cpu_data_bus_in = Reg_lyc_ff45;
					7'h44: cpu_data_bus_in = pixel_y[7:0];
					7'h40: cpu_data_bus_in = Reg_LCDcontrol_ff40;
					7'h41: cpu_data_bus_in = {Reg_LCDstatus_ff41[7:3],Reg_LCDcontrol_ff40[7] ? pixel_y == Reg_lyc_ff45 : 1'b1, Reg_LCDcontrol_ff40[7] ? render_mode : 2'b00};
					7'h43: cpu_data_bus_in = Reg_xscroll_ff43;
					7'h42: cpu_data_bus_in = Reg_yscroll_ff42;
					7'h47: cpu_data_bus_in = Reg_palette_ff47;
					7'h48: cpu_data_bus_in = Reg_palette_ff48;
					7'h49: cpu_data_bus_in = Reg_palette_ff49;
					7'h4b: cpu_data_bus_in = Reg_winX_ff4b;
					7'h4a: cpu_data_bus_in = Reg_winY_ff4a;
					7'h00: cpu_data_bus_in = Reg_buttons_ff00;
					7'h4f: cpu_data_bus_in = Reg_vbank_ff4f | 8'hfe;
					
					7'h68: cpu_data_bus_in = {Reg_bgPalCtl_ff68, 1'b0, bg_palette_mem_index};
					7'h69: cpu_data_bus_in = bg_palette_mem_index[0] ? bg_palette_mem1_data_out : bg_palette_mem2_data_out;
					7'h6a: cpu_data_bus_in = {Reg_oamPalCtl_ff6a, 1'b0, oam_palette_mem_index};
					7'h6b: cpu_data_bus_in = oam_palette_mem_index[0] ? oam_palette_mem1_data_out : oam_palette_mem2_data_out;
					
					7'h1X, 7'h2X, 7'h3X: cpu_data_bus_in = sound_data_bus_out;
					default: cpu_data_bus_in = 8'hff; 
				endcase	
		end
		16'b11111110xxxxxxxx: begin //0xfe00 oam
			cpu_data_bus_in <=  oam_data_out;  //todo, this probably just gets oam_Dat
			oam_we <=   ((render_mode[1] & ~dma_happening) ) ? 1'b0 :  cpu_we;
			vram_we <= 1'b0;
		end
		
		default: begin
			vram_we <= 1'b0;
			oam_we <= 1'b0;
			cpu_data_bus_in <= mem_controller_data_out;
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

//todo ...clock gate?
gb_palette_ram bg_palette_mem1(
	.address(render_mode == 2'b11 ? bg_palette_mem_index_vr : bg_palette_mem_index[5:1]),
	.clock(cpu_clock), //cpu and pixel clock might be different
	.data(cpu_data_bus_out),
	.wren((cpu_we && cpu_addr_bus == 16'hff69) && bg_palette_mem_index[0]),
	.q(bg_palette_mem1_data_out)
);

gb_palette_ram bg_palette_mem2(
	.address(render_mode == 2'b11 ? bg_palette_mem_index_vr : bg_palette_mem_index[5:1]),
	.clock(cpu_clock),
	.data(cpu_data_bus_out),
	.wren((cpu_we && cpu_addr_bus == 16'hff69) & ~bg_palette_mem_index[0]),
	.q(bg_palette_mem2_data_out)
);

gb_palette_ram oam_palette_mem1(
	.address(render_mode == 2'b11 ? oam_palette_mem_index_vr : oam_palette_mem_index[5:1]),
	.clock(cpu_clock),
	.data(cpu_data_bus_out),
	.wren((cpu_we && cpu_addr_bus == 16'hff6b) & oam_palette_mem_index[0]),
	.q(oam_palette_mem1_data_out)
);

gb_palette_ram oam_palette_mem2(
	.address(render_mode == 2'b11 ? oam_palette_mem_index_vr : oam_palette_mem_index[5:1]),
	.clock(cpu_clock),
	.data(cpu_data_bus_out),
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

reg [13:0] serial_clock_out;

reg serial_xfr_complete;

always @(posedge cpu_clock)
begin
	if(rst) begin 
		serial_clock_out = 14'b10000000000000;
		serial_xfr_complete = 0;
		Reg_SC_ff02 = 8'b0;
		irq[3] = 0;
	end else begin
		if(cpu_addr_bus == 16'hff02 && cpu_we) begin
			serial_xfr_complete = 0;
			Reg_SC_ff02 = cpu_data_bus_out;
			if(cpu_data_bus_out[7]) begin
				serial_clock_out = 14'b01111111111111;
			end
		end
		
	
	
		irq[3] = ~|serial_clock_out;
		
		if(serial_clock_out == 0) begin
			Reg_SC_ff02[7] = 0;
			serial_clock_out = 14'b10000000000000;
			serial_xfr_complete = 1;
		end else if (~serial_clock_out[13] & Reg_SC_ff02[0] ) begin
			serial_clock_out = serial_clock_out - 1'b1;
		end
	end
end

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
	
	if(LCD_power_cycle) begin
			render_mode = 2'b10;
			pixel_x = 0;
			pixel_y = 0;
			oam_fetch_state = 0;
			oam_bitplain0 = 0;
			oam_bitplain1 = 0;
			oam_fetch_state = 0;
			in_window = 0;
			LCD_power_cycle = 0;
			lcy_zero_hack = 0;
	end
	
	casex (cpu_addr_bus)
		16'b111111110xxxxxxx: begin
			if(cpu_we) begin
				case (cpu_addr_bus[6:0])
					7'h44: begin end // lcd y (read only)
					7'h00: Reg_buttons_ff00[5:4] = cpu_data_bus_out[5:4];
					7'h01: Reg_SB_ff01 = cpu_data_bus_out;
					7'h40: begin
							LCD_power_cycle =   ~cpu_data_bus_out[7];
							Reg_LCDcontrol_ff40 = cpu_data_bus_out;
							
					end
					7'h41: Reg_LCDstatus_ff41[6:3] = cpu_data_bus_out[6:3];
					7'h43: Reg_xscroll_ff43 = cpu_data_bus_out;
					7'h45: Reg_lyc_ff45 = cpu_data_bus_out;
					7'h42: Reg_yscroll_ff42 = cpu_data_bus_out;
					7'h47: Reg_palette_ff47 = cpu_data_bus_out;
					7'h48: Reg_palette_ff48 = cpu_data_bus_out;
					7'h49: Reg_palette_ff49 = cpu_data_bus_out;
					7'h4b: Reg_winX_ff4b = cpu_data_bus_out;
					7'h4f: Reg_vbank_ff4f[0] = cpu_data_bus_out[0];
					7'h4a: Reg_winY_ff4a = cpu_data_bus_out;
					
					7'h68: begin 
						Reg_bgPalCtl_ff68 = cpu_data_bus_out[7];
						bg_palette_mem_index_next = cpu_data_bus_out[5:0];
					end
					7'h69: begin
						bg_edge_det = 1'b1;
					end
					7'h6a: begin 
						Reg_oamPalCtl_ff6a = cpu_data_bus_out[7];
						oam_palette_mem_index_next = cpu_data_bus_out[5:0];
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
	
	
		vblank_stat_toggle = pixel_x == 448 && pixel_y == 144;
	   hblank_stat_toggle = in_x == 160;
		
		
		irq[0] = vblank_stat_toggle;
		irq[1] = (Reg_LCDstatus_ff41[6] && lcy_stat_toggle) 
					| (Reg_LCDstatus_ff41[4] &&  vblank_stat_toggle)
					| (Reg_LCDstatus_ff41[3] && hblank_stat_toggle)
					| (Reg_LCDstatus_ff41[5] && oam_stat_toggle);
		
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
			lcy_stat_toggle = pixel_y == Reg_lyc_ff45;
		end else begin
			lcy_stat_toggle = 0;
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

reg signed [10:0]	out_x;
reg [10:0]	out_y;
reg [12:0]	shift_x;
reg [12:0]	shift_y;

always @(posedge clock_vga)
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
	
	vs<=vs_;
	hs<=hs_;
end



always_comb 
begin
	//blank signals to the adv7123 chip 
	//vs and hs go directly to the vga connector
	hblank<=1;  //unused (required only if sync on green)
   vblank<=vs; //
	
	clock_vga<=clock_108;
		
	if((_vblank & _hblank)) begin	
		
		r <= {color[4:0], 3'b0};
		g <= {color[9:5], 3'b0};
		b <= {color[14:10], 3'b0};
	
		end else begin
		r<=0;
		g<=0;
		b<=0;
	end
end

endmodule 