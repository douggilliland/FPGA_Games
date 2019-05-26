`timescale 1ns / 1ps
//The papilio logic start wing has 4096 color depth.
//Each color R,G and B is 4 bits.
//The VGA section of the LogicStart Shield uses 12 resistors to implement
// 4096 color depth. VGA video is analog in nature so there needs to be
// some way to vary the RGB (Red, Green, and Blue) signals between 0V and
//.7V. For each RGB signal the shade, or intensity, of the color is
// controlled by varying the voltage of the pin between 0 and .7V.
//The finer control you have over the voltage the more colors you
//can create. For the LogicStart Shield we are able to control 4
// Red, 4 Green, and 4 Blue bits which allows us to generate 16
//different voltage levels between 0 and .7V for Red and Green and Blue.
//If we add all three colors together we have 12 bit video which gives
//us (2^12=4096) the possibility of 4096 colors.

module VgaController
(
input wire Clock,
input wire Reset,
output wire [3:0] oVgaRed,oVgaGreen,oVgaBlue,
output wire oVgaVsync,	//Polarity of horizontal sync pulse is negative.
output wire oVgaHsync,	//Polarity of vertical sync pulse is negative.
output wire [15:0]  oRow,oCol

);

wire wHSync,wVSync,wPolarity_V,wPolarity_H;



//The Papilio Duo clock is 32Mhz. We will create a 64Mhz to trick
//the VGA into thinking that we are XGA 1024x768@60 Hz (pixel clock 65.0 MHz)


//`define XGA_1280x1024_60Hz
//`define XGA_1024x768_60Hz
`ifdef XGA_1024x768_60Hz
//http://tinyvga.com/vga-timing/1024x768@60Hz
parameter HSYNC_VISIBLE_AREA = 1024;
parameter HSYNC_FRONT_PORCH  = 24;
parameter HSYNC_PULSE        = 136;
parameter HSYN_BACK_PORCH    = 48;
parameter HORIZONTAL_LINE    = 1344;


parameter VSYNC_VISIBLE_AREA = 768;
parameter VSYNC_FRONT_PORCH  = 3;
parameter VSYNC_PULSE        = 6;
parameter VSYN_BACK_PORCH    = 38;
parameter VERTICAL_LINE      = 806;

//65.0Mhz = 32Mhz*27/8 = 66Mhz
parameter CLK_M = 31;
parameter CLK_D = 15;

assign wPolarity_V  = 1'b0;
assign wPolarity_H  = 1'b0;

`elsif XGA_1280x1024_60Hz
//http://tinyvga.com/vga-timing/1280x1024@60Hz
//Tested in a Dell LCD Monitor from LICIT and also in my home LCD Monitor

parameter HSYNC_VISIBLE_AREA = 1280;
parameter HSYNC_FRONT_PORCH  = 48;
parameter HSYNC_PULSE        = 112;
parameter HSYNC_BACK_PORCH   = 248;
parameter HORIZONTAL_LINE    = 1688;


parameter VSYNC_VISIBLE_AREA = 1024;
parameter VSYNC_FRONT_PORCH  = 1;
parameter VSYNC_PULSE        = 3;
parameter VSYNC_BACK_PORCH   = 38;
parameter VERTICAL_LINE      = 1066;

//108.0Mhz = 32Mhz*27/8
parameter CLK_M = 27;
parameter CLK_D = 8;

assign wPolarity_V  = 1'b0;
assign wPolarity_H  = 1'b0;


`else

//http://tinyvga.com/vga-timing/640x480@60Hz
//Works fine on LICIT LCD Dell monitor
parameter HSYNC_VISIBLE_AREA = 640;
parameter HSYNC_FRONT_PORCH  = 16;
parameter HSYNC_PULSE        = 96;
parameter HSYNC_BACK_PORCH   = 48;
parameter HORIZONTAL_LINE    = 800;


parameter VSYNC_VISIBLE_AREA = 480;
parameter VSYNC_FRONT_PORCH  = 10;
parameter VSYNC_PULSE        = 2;
parameter VSYN_BACK_PORCH    = 33;
parameter VERTICAL_LINE      = 525;

//25.175Mhz = 32Mhz*27/28 = 25.14Mhz
parameter CLK_M = 25;
parameter CLK_D = 32;

assign wPolarity_V  = 1'b0;
assign wPolarity_H  = 1'b0;


`endif

wire wClockVga,wHCountEnd,wVCountEnd;
wire [15:0] wHCount,wVCount;
wire wPllLocked,wPsDone;


`ifdef XILINX_IP
DCM_SP
#
(
.CLKFX_MULTIPLY(CLK_M),	//Values range from 2..32
.CLKFX_DIVIDE(CLK_D)		//Values range from 1..32

)
ClockVga
(
.CLKIN(Clock),			//32Mhz
.CLKFB(wClockVga), 	//Feed back
.RST( Reset ),			//Global reset
.PSEN(1'b0), 			//Disable variable phase shift. Ignore inputs to phase shifter
.LOCKED(wPllLocked),	//Use this signal to make sure PLL is locked
.PSDONE(wPsDone),		//I am not really using this one
.CLKFX(wClockVga)		//FCLKFX = FCLKIN * CLKFX_MULTIPLY / CLKFX_DIVIDE

);
`else
	assign wClockVga = Clock;
	assign wPllLocked = 1'b1;
`endif
assign wHCountEnd = (wHCount == HORIZONTAL_LINE-1)? 1'b1 : 1'b0;
assign wVCountEnd = (wVCount == VERTICAL_LINE-1)  ? 1'b1 : 1'b0;

UPCOUNTER_POSEDGE # (.SIZE(16)) HCOUNT
(
.Clock(wClockVga),
.Reset(Reset | ~wPllLocked | wHCountEnd),
.Initial(16'b0),
.Enable(wPllLocked),
.Q(wHCount)
);

UPCOUNTER_POSEDGE # (.SIZE(16)) VCOUNT
(
.Clock(wClockVga),
.Reset(Reset | ~wPllLocked | wVCountEnd ),
.Initial( 16'b0 ),
.Enable(wHCountEnd),
.Q(wVCount)
);

assign wVSync =
(
	wVCount >=  (VSYNC_VISIBLE_AREA + VSYNC_FRONT_PORCH ) &&
	wVCount <=  (VSYNC_VISIBLE_AREA + VSYNC_FRONT_PORCH + VSYNC_PULSE )
) ? 1'b1 : 1'b0;

assign wHSync =
(
	wHCount >=  (HSYNC_VISIBLE_AREA + HSYNC_FRONT_PORCH ) &&
	wHCount <=  (HSYNC_VISIBLE_AREA + HSYNC_FRONT_PORCH  + HSYNC_PULSE )
) ? 1'b1 : 1'b0;


assign oVgaVsync = (wPolarity_V == 1'b1) ? wVSync : ~wVSync ;
assign oVgaHsync = (wPolarity_H == 1'b1) ? wHSync : ~wHSync ;



wire[3:0] wColorR, wColorG, wColorB;
assign wColorR = (wHCount < (HSYNC_VISIBLE_AREA/2)) ? 4'b1111 : 4'b0000;
assign wColorG = (wVCount < (VSYNC_VISIBLE_AREA/2)) ? 4'b1111 : 4'b0000;
assign wColorB = (wHCount >= (HSYNC_VISIBLE_AREA/2) && wVCount < (VSYNC_VISIBLE_AREA/2)) ?  4'b1111: 4'b0000;

assign {oVgaRed,oVgaGreen,oVgaBlue} = (wHCount < HSYNC_VISIBLE_AREA && wVCount < VSYNC_VISIBLE_AREA) ?
 {wColorR,wColorG,wColorB} :	//display color
 {4'b1111,4'b0,4'b0};			//black

assign oCol = wHCount;
assign oRow = wVCount;

endmodule
