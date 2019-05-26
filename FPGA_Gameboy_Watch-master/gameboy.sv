
/*

Module: Top level gameboy implementation

Contrary to good design and practice there is some logic and fucntionality 
in this top level module that should be moved.


GPIO pinout for DE10 Standard:

       FPGA

34 32 30 28 26 3.3v 24 22 20 18 16 14 12 10 5.0v 08 06 04 02 00
35 33 31 29 27 GND  25 23 21 19 17 15 13 11 GND  09 07 05 03 01 


       HSMC Connector


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


module gameboy(

	//////////// CLOCK //////////
//	input 		          		CLOCK2_50,
//	input 		          		CLOCK3_50,
//	input 		          		CLOCK4_50,
	input 		          		CLOCK_50,
//
//	//////////// KEY //////////
	input 		     [3:0]		KEY,
//
//	//////////// SW //////////
	input 		     [9:0]		SW,
//
//	//////////// LED //////////
	output		     [9:0]		LEDR,

	//////////// Seg7 //////////
	output		     [6:0]		HEX0,
	output		     [6:0]		HEX1,
	output		     [6:0]		HEX2,
	output		     [6:0]		HEX3,
	output		     [6:0]		HEX4,
	output		     [6:0]		HEX5,

//	//////////// SDRAM //////////
//	output		    [12:0]		DRAM_ADDR,
//	output		     [1:0]		DRAM_BA,
//	output		          		DRAM_CAS_N,
//	output		          		DRAM_CKE,
//	output		          		DRAM_CLK,
//	output		          		DRAM_CS_N,
//	inout 		    [15:0]		DRAM_DQ,
//	output		          		DRAM_LDQM,
//	output		          		DRAM_RAS_N,
//	output		          		DRAM_UDQM,
//	output		          		DRAM_WE_N,
//
//	//////////// VGA //////////
	output		          		VGA_BLANK_N,
	output		     [7:0]		VGA_B,
	output		          		VGA_CLK,
	output		     [7:0]		VGA_G,
	output		          		VGA_HS,
	output		     [7:0]		VGA_R,
	output		          		VGA_SYNC_N,
	output		          		VGA_VS,
//
	//////////// Audio //////////
//	input 		          		AUD_ADCDAT,
//	inout 		          		AUD_ADCLRCK,
	inout 		          		AUD_BCLK,
	output		          		AUD_DACDAT,
	inout 		          		AUD_DACLRCK,
	output		          		AUD_XCK,

	//////////// I2C for Audio and Video-In //////////
	output		          		FPGA_I2C_SCLK,
	inout 		          		FPGA_I2C_SDAT,
//
//	//////////// GPIO, GPIO connect to GPIO Default //////////
	inout 		    [35:0]		GPIO
);


wire rst;
wire gbc = SW[0];  //flag to start up in gbc mode

//=======================================================
//  Clock generation
//=======================================================

wire cpu_clock;
wire uart_clock;
wire vga_clock;
wire mipi_clock;
wire memory_clock;


assign memory_clock = cpu_clock;

gb_clocks clocks(
		.refclk(CLOCK_50),   
	//	.rst(rst),      
		.outclk_0(cpu_clock), //4mhz ish clock	
		.outclk_1(uart_clock),
		.outclk_2(vga_clock),
		.outclk_3(mipi_clock),
		.outclk_4(AUD_XCK),
		.outclk_5(AUD_BCLK)
	);

	
//=======================================================
//  Some top level register stuff
//=======================================================
wire [7:0] cpu_data_bus_in;
reg [7:0] Reg_buttons_ff00;

always_comb
begin

	casex (cpu_addr_bus)
		//	7'h01: cpu_data_bus_in = serial_xfr_complete ? 8'hff : Reg_SB_ff01 ;
			16'hff08: cpu_data_bus_in = {7'b0,uart_data_rdy};
			16'hff09: cpu_data_bus_in = uart_data_rcv;
			16'hff00: cpu_data_bus_in = Reg_buttons_ff00 | 8'hC0;
			
		//	7'h1X, 7'h2X, 7'h3X: cpu_data_bus_in = sound_data_bus_out;
			default: cpu_data_bus_in <= video_controller_data_out;
	endcase	
	
	rst = ~KEY[0];
end

always @(posedge cpu_clock)
begin
	
	if(rst) begin
			Reg_buttons_ff00[5:4] = 2'b11;
	end else if(cpu_we) begin
		casex (cpu_addr_bus)
			16'hff00: Reg_buttons_ff00[5:4] = cpu_data_bus_out[5:4];
			default: begin end
		endcase
			
	end
	
	Reg_buttons_ff00[0] = ~(~Reg_buttons_ff00[5] & ~snes_buttons[8] | ~Reg_buttons_ff00[4] & ~snes_buttons[7]);
	Reg_buttons_ff00[1] = ~(~Reg_buttons_ff00[5] & ~snes_buttons[0] | ~Reg_buttons_ff00[4] & ~snes_buttons[6]);
	Reg_buttons_ff00[2] = ~(~Reg_buttons_ff00[5] & ~snes_buttons[2] | ~Reg_buttons_ff00[4] & ~snes_buttons[4]);
	Reg_buttons_ff00[3] = ~(~Reg_buttons_ff00[5] & ~snes_buttons[3] | ~Reg_buttons_ff00[4] & ~snes_buttons[5]);
	
	irq[4] = ~(&snes_buttons[8:2] & snes_buttons[0]); 
end

/// serial port 

reg [7:0] Reg_serialbyte_ff01 = 0;
reg [7:0] Reg_serialcontrol_ff02 = 0;
reg [12:0] serialCount = 13'h1fff;

always @(posedge cpu_clock)
begin
	
	if(rst) begin
			Reg_serialbyte_ff01 = 0;
			Reg_serialcontrol_ff02 = 0;
			serialCount = 13'h1fff;
	end else begin
	
		if(cpu_we) begin
			casex (cpu_addr_bus)
				16'hff01: Reg_serialbyte_ff01 = cpu_data_bus_out;
				16'hff02: begin
					Reg_serialcontrol_ff02 = cpu_data_bus_out;
					serialCount = (cpu_data_bus_out[7] &  cpu_data_bus_out[0]) ? 13'h0fff : 13'h1fff;
				end
				default: begin end
			endcase
			
		end else begin
		
			if(~serialCount[12]) begin
				serialCount = serialCount - 1'b1;
			end
		end
	
	
		irq[3] = ~|serialCount;
	end
	
end

//=======================================================
//  Snes controller module decleration
//=======================================================

wire [15:0] 		snes_buttons;

snes_controller snes_ctl_1(
   .clock(cpu_clock),              
	.rst(rst),            
	.snes_buttons(snes_buttons),   
	.snes_data (GPIO[0]),
   .snes_latch (GPIO[1]),
	.snes_clock (GPIO[2])
	
	);

//debug output for snes controller buttons
HexController hex0 ( .led_segments({HEX0}), .data(~snes_buttons[11:8]));
HexController hex1 ( .led_segments({HEX1}), .data(~snes_buttons[7:4]));
HexController hex2 ( .led_segments({HEX2}), .data(~snes_buttons[3:0]));


//=======================================================
// Gameboy CPU instantiation
//=======================================================
wire [15:0] cpu_addr_bus;
wire [7:0] cpu_data_bus_out;
wire cpu_we;
wire cpu_re;
wire [15:0] cpu_pc;

reg [7:0] irq;
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
.irq(irq | vga_irq), 
.cgb(cgb),
.initialized(initialized),
.gdma_happening(gdma_happening),
.speed_double(speed_double));

//=======================================================
// Gameboy memory controller instantiation
//=======================================================

wire [7:0] mem_controller_data_out;
wire [7:0] dma_wr_addr;
wire [15:0] dma_rd_addr;
wire [7:0] dma_data;
wire dma_we;
wire dma_happening;

wire [15:0] gdma_wr_addr;
wire [15:0] gdma_rd_addr;
wire [7:0] gdma_data;
wire gdma_we;
wire gdma_happening;

wire unloaded;
wire gb_rom;

gb_memory_controller mem_control(
.rst(rst), 
.clock(cpu_clock), 
.addr_bus(addr_bus), 
.data_in(cpu_data_bus_out), 
.data_out(mem_controller_data_out), 
.we(cpu_we),
.rd(cpu_re), 
.cgb(cgb), 
.initialized(initialized),
.unloaded(unloaded),
.gb_rom(gb_rom),
.uart_addr(uart_load_addr),
.uart_data_in(uart_data_rcv),
.uart_we(uart_load_we),
.uart_load(uart_loading));

gb_dma_controller dma_controller(
.clock(cpu_clock),
.rst(rst),
.addr_bus(addr_bus),
.we(cpu_we),
.data_in(cpu_data_bus_out),
.dma_wr_addr(dma_wr_addr),
.dma_rd_addr(dma_rd_addr),
.dma_we(dma_we),
.dma_happening(dma_happening),
.gdma_wr_addr(gdma_wr_addr),
.gdma_rd_addr(gdma_rd_addr),
.gdma_we(gdma_we),
.gdma_happening(gdma_happening)

);


wire [15:0] addr_bus;

assign addr_bus = gdma_happening ? gdma_rd_addr : dma_happening ? dma_rd_addr : cpu_addr_bus;

//=======================================================
// Video Hardware
//=======================================================


assign VGA_CLK = vga_clock;

wire [7:0] video_controller_data_out;
wire [7:0] vga_irq;

wire [7:0] the_data_bus = dma_happening ? mem_controller_data_out : cpu_data_bus_out;

gb_video video_controller(
.rst(rst),
.gbc(gbc),
.irq(vga_irq),
.initialized(initialized),
.gb_rom(gb_rom),
.unloaded(unloaded),

.vga_clock(vga_clock), //pixel clock for 1280x1024 vga clock
.pixel_clock(cpu_clock), //4mhz pixel clock
.cpu_clock(cpu_clock), //4 or 8 mhz (depending on speed mode in gbc)
.memory_clock(cpu_clock),
.mipi_clock(mipi_clock),  //20mhz clock to drive the mipi display

.cpu_addr_bus(addr_bus),
.data_bus_out(video_controller_data_out),
.data_bus_in(the_data_bus),
.memory_controller_data_in(mem_controller_data_out),
.cpu_we(cpu_we),

.dma_wr_addr(dma_wr_addr),
.dma_we(dma_we),
.dma_happening(dma_happening),
.gdma_wr_addr(gdma_wr_addr),
.gdma_we(gdma_we),
.gdma_happening(gdma_happening),

.vga_vs(VGA_VS),  //vga sync pulses
.vga_hs(VGA_HS),
.vga_hblank(VGA_SYNC_N),
.vga_vblank(VGA_BLANK_N),
.vga_red(VGA_R),
.vga_green(VGA_G),
.vga_blue(VGA_B),


.mipi_pwm(GPIO[18]), 
.mipi_rgb(GPIO[35:28]), 
.mipi_cm(GPIO[25]),
.mipi_rd(GPIO[23]), 
.mipi_cs(GPIO[22]), 
.mipi_shut(GPIO[27]), 
.mipi_wr(GPIO[24]), 
.mipi_dc(GPIO[26]),
.mipi_rst(GPIO[21]),
.mipi_vddio_ctrl(GPIO[20]),
.mipi_scale(SW[2])  
);


//=======================================================
// UART for rom loading and IO
//=======================================================

wire uart_data_rdy;
wire [7:0] uart_data_rcv;
wire uart_rst_req;
wire [27:0] uart_load_addr;
wire uart_load_we;
wire uart_loading;


uart load_uart(
.rst(rst),
.clk(uart_clock), 
.data_clk(cpu_clock), 
.send(cpu_we && cpu_addr_bus == 16'hFF01),
.data_send(cpu_data_bus_out), 
.data_rcv(uart_data_rcv), 
.rdy(uart_data_rdy),
.ack(cpu_we && cpu_addr_bus == 16'hFF08), 
.tx(GPIO[3]), 
.rx(GPIO[4]),
.rst_req(uart_rst_req),
.load_addr(uart_load_addr),
.load_we(uart_load_we),
.loading(uart_loading));


//=======================================================
// Sound subsystem
//=======================================================
wire sound_enabled;
wire [15:0] sound_left_out;
wire [15:0] sound_right_out;
wire [7:0] sound_data_bus_out;

gb_sound_hardware gbsh(
    .clk (cpu_clock), //the pixel clock
	 .rst (rst),
     
	 .left_out (sound_left_out),  
	 .right_out (sound_right_out),
	 .sound_enabled (sound_enabled),
	 
	 .addr_bus (cpu_addr_bus) ,
	 .data_bus_in (cpu_data_bus_out),
	 .data_bus_out (sound_data_bus_out),
	 .we (cpu_we),
	 .re (cpu_re),
	 .channel_enables (SW[9:6])
);





reg [7:0] sound_44khz_divider;
reg [5:0] sound_left_count;
reg [5:0] sound_right_count;

reg [15:0] sound_shifter;

wire sound_44khz_clk;

always @(posedge AUD_XCK) 
begin
	sound_44khz_divider = sound_44khz_divider + 1'b1;
end

always_comb 
begin
	sound_44khz_clk = sound_44khz_divider[7];
	AUD_DACLRCK <= sound_44khz_clk;
end

always @(posedge AUD_BCLK)
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
	AUD_DACDAT = sound_shifter[15];
	
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
reg [3:0] lut_index;
reg [1:0] sending_i2c;

wire i2c_init;

i2c_send i2c_dac(
    .clk (cpu_clock), //the clock, max 526kHz * 8 for the dac
	 .rst (rst),
    .sclk (FPGA_I2C_SCLK), //i2c sclk
    .sdat (FPGA_I2C_SDAT), //i2c sdat
    
    .start (start_i2c) , //starts the send/recieve 
    .done (done_i2c), //set to high when transfer complete
    .ack (ack_i2c), //will be high if all three acks are correct

    .data ({8'h34, lut_data}) //data to be sent 
);

always_comb begin
	// dac_mute <= 1'b1; //sockit only
	 i2c_init <= lut_index == 4'hb ? 1'b1 : 1'b0;
	 
	
	 
    case (lut_index)
        4'h0: lut_data <= {7'h06, 9'h07F};//16'h0C3F; // power on everything except out
        4'h1: lut_data <= {7'h00, 9'h080};//16'h0080; // Mute ADC Left
        4'h2: lut_data <= {7'h01, 9'h080};//16'h0280; // Mute ADC right
        4'h3: lut_data <= {7'h02, 9'h179};//16'h043F; // left output
        4'h4: lut_data <= {7'h03, 9'h179};//16'h063F; // right output
        4'h5: lut_data <= {7'h04, 9'h012};//16'h0802; // ADC (mute the mic)
        4'h6: lut_data <= {7'h05, 9'h000};//16'h0A00; // Digital audio stuff (hi pass filter enabled)
        4'h7: lut_data <= {7'h07, 9'h001};//16'h0E01; // Digital interface (MSB left justified) 
        4'h8: lut_data <= {7'h08, 9'h000};//16'h1000; // Default sample control
        4'h9: lut_data <= {7'h06, 9'h000};//16'h0C67; // power on dac and output 0110 0111
        4'ha: lut_data <= {7'h09, 9'h009};//16'h1201; // activate
        default: lut_data <= 16'h0000;
    endcase
end

always @(posedge cpu_clock) 
begin
	if(rst) begin
		lut_index = 4'hF;
		start_i2c = 1'b0;
		sending_i2c = 0;
	end else if (lut_index != 4'hb) begin
		if(done_i2c && ~|sending_i2c) begin
			start_i2c = 1;
			lut_index = lut_index + 1'b1;
			sending_i2c = 1;
		end else begin
			start_i2c = 0;
			sending_i2c = sending_i2c + 1'b1;
		end
		
		
	end
end















//=======================================================
//  Just playing around with buttons and switches
//=======================================================

HexController hex3 ( .led_segments({HEX3}), .data(SW[8:5]));
HexController hex4 ( .led_segments({HEX4}), .data(SW[4:1]));

reg [7:0] counter;
reg up_state;
reg down_state;

assign LEDR = SW;

always @(posedge CLOCK_50)
begin
	
	case (up_state)
		0: 
			begin
				counter = counter + (KEY[0] ? 1'b1 : 1'b0);
				up_state = KEY[0];
			end
		1:
			begin
				up_state = KEY[0];
			end
	endcase
	
	case (down_state)
		0: 
			begin
				counter = counter - (KEY[1] ? 1'b1 : 1'b0);
				down_state = KEY[1];
			end
		1:
			begin
				down_state = KEY[1];
			end
	endcase
end

endmodule
