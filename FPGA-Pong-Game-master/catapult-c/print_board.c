/* this module gets the data from ball_update.c ( which updates the position of the ball on the monitor )
   and draws the white pixels on the black background of the monitor - the white pixels here https://raw.githubusercontent.com/Jiantastic/FPGA-Pong-Game/master/images/FPGA-Pong-Game.JPG
   to correspond to user input ( left and right paddles ) + ball position
*/

#include "stdio.h"
#include "ac_int.h"

#define COLOR_WL          10
#define PIXEL_WL          (3*COLOR_WL)
#define  COORD_WL         10

#pragma hls_design top
void print_board(ac_int<(COORD_WL+COORD_WL), false> *vga_xy,ac_int<PIXEL_WL, false> *video_in,ac_int<COORD_WL,false> *ball_x_in, ac_int<COORD_WL,false> *ball_y_in,ac_int<PIXEL_WL,false> *video_out,ac_int<3,false> *right_count,ac_int<3,false> *left_count,ac_int<30,false> *YUV_out) // 50 bit video out
{
    	ac_int<10,false> i_red, i_green, i_blue; // current pixel
    	ac_int<10,false> o_red, o_green, o_blue; // output pixel
    	ac_int<10,false> YUV_red, YUV_green, YUV_blue;
    	ac_int<10,false> vga_x, vga_y,  		 // screen coordinates
    	ac_int<20,true> mat_1,mat_2,mat_3,V;	
    	static ac_int<10,false> red_detect = 0;

    	i_red = (*video_in).slc<COLOR_WL>(20);
    	i_green = (*video_in).slc<COLOR_WL>(10);
    	i_blue = (*video_in).slc<COLOR_WL>(0);

    // extract VGA pixel X-Y coordinates from data stream slice
    	vga_x = (*vga_xy).slc<COORD_WL>(0);
    	vga_y = (*vga_xy).slc<COORD_WL>(10);

    // does a mathematical operation to convert RGB ( red-green-blue color model ) to YUV color model
    // this is done as the YUV model is less affected by changes in the ambient condition, to be exact - the lighting of the environment
	
        mat_1 = i_red * 127;
        mat_2 = i_green * (-106);
        mat_3 = i_blue * (-21);
	
    	V = mat_1 + mat_2 + mat_3;
	
	V = ( V + 128) >> 8;
	
    	V = V + 128;

	o_red = 0;
	o_green = 0;
	o_blue = 0;
	
	YUV_red = 0;
	YUV_green = 0;
	YUV_blue = 0;
	
	// for anything past the threshold V > 250, set it to white
	if(V > 250){
		YUV_red = 1000;
		YUV_green = 1000;
		YUV_blue = 1000;
	}
	
	// SCREEN RESOLUTION : X from 140 - 780
	//                     Y from 30 - 520
	// can be modified according to your needs
	
	// set counter = zero every time the first pixel enters.
	
	// set ball pixels to white
	if((vga_x > ( *ball_x_in - 20)) && (vga_x < (*ball_x_in)) && (vga_y > ( *ball_y_in - 20 )) && (vga_y < (*ball_y_in))){
		o_red = 1000;
		o_green = 1000;
		o_blue = 1000;
	}
	
	// set board outline colour to white
	if((vga_x >= 200 && vga_x < 680 && vga_y >= 100 && vga_y < 120) || (vga_x >= 200 && vga_x < 220 && vga_y >= 100 && vga_y < 420) || (vga_x >= 200 && vga_x < 680 && vga_y >= 400 && vga_y < 420) || (vga_x >= 660 && vga_x < 680 && vga_y >= 100 && vga_y < 420)){
		o_red = 1000;
		o_green = 1000;
		o_blue = 1000;
	}
	
	// set paddles to white IF object is RED
	if(((vga_x >= 150 && vga_x < 420 && vga_y >= 120 && vga_y < 420)) || ((vga_x >= 550 && vga_x < 750 && vga_y >= 120 && vga_y < 420))){
	   if ( V > 300){
			if(((vga_x >= 220 && vga_x < 240 && vga_y >= 120 && vga_y < 420)) || ((vga_x >= 640 && vga_x < 660 && vga_y >= 120 && vga_y < 420))){
				o_red = 1000;
				o_green = 1000;
				o_blue = 1000;
			}
		}
	}
	
	// Displays the number of wins for the left player in white rectangular blocks - upper left corner of https://raw.githubusercontent.com/Jiantastic/jiantastic.github.io/master/Images/FPGA-Pong-Game.JPG
	for(int i=0;i<*left_count;i++){
		if(vga_x >= (160+(i*20)) && vga_x < (170+(i*20)) && vga_y >= 60 && vga_y < 80){
			o_red = 1000;
			o_green = 1000;
			o_blue = 1000;
		}
	}
	
	// Displays the number of wins for the right player in white rectangular blocks - upper right corner of https://raw.githubusercontent.com/Jiantastic/jiantastic.github.io/master/Images/FPGA-Pong-Game.JPG
	for(int i=0;i<*right_count;i++){
		if(vga_x >= (600+(i*20)) && vga_x < (610+(i*20)) && vga_y >= 60 && vga_y < 80){
			o_red = 1000;
			o_green = 1000;
			o_blue = 1000;
		}
	}
		
	// Pong game video output to monitor
	
	*video_out = ((((ac_int<PIXEL_WL, false>)o_red) << 20) | (((ac_int<PIXEL_WL, false>)o_green) << 10) | (ac_int<PIXEL_WL, false>)o_blue);

	// YUV_out is a separate data stream to analyse the YUV color model ( color conversion from RGB -> YUV )
	
	*YUV_out = ((((ac_int<PIXEL_WL, false>)YUV_red) << 20) | (((ac_int<PIXEL_WL, false>)YUV_green) << 10) | (ac_int<PIXEL_WL, false>)YUV_blue);	

}
