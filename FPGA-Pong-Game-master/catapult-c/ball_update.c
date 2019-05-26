#include "stdio.h"
#include "ac_int.h"

#define COLOR_WL          10
#define PIXEL_WL          (3*COLOR_WL)

#define  COORD_WL          10

#pragma hls_design top
void ball_update(ac_int<PIXEL_WL, false> * video_in,ac_int<(COORD_WL+COORD_WL),false> *vga_xy, ac_int<PIXEL_WL,false> *video_out,ac_int<10,false> *ball_x_out, ac_int<10,false> *ball_y_out,ac_int<1,false> switch1 , ac_int <1,false> switch2,ac_int<3,false> *left, ac_int<3,false> *right){

	ac_int<10,false> i_red, i_green, i_blue; // current pixel
        ac_int<10,false> o_red, o_green, o_blue; // output pixel
	ac_int<COORD_WL,false> vga_x,vga_y;
	static ac_int<3,false> state; 			// ball state determines its direction ( up,down,left,right etc), ranges from 1 - 4
	static ac_int<10, false> ball_x, ball_y;	// x and y coordinates of the ball
	static bool init = false;
	static ac_int<3, false> left_miss = 0;		// points for 	
	static ac_int<3, false> right_miss = 0;		// points for 
	static ac_int<20,false> counter = 0;
	static ac_int<3,false> k;				// the rate to increase or decrease ball coordinates by - to simulate movement
	
	
	// slicing the data stream to receive x-y coordinates of the monitor, RGB value of the pixel in that particular x-y coordinate

	i_red = (*video_in).slc<COLOR_WL>(20);
        i_green = (*video_in).slc<COLOR_WL>(10);
        i_blue = (*video_in).slc<COLOR_WL>(0);
	
	vga_x = (*vga_xy).slc<COORD_WL>(0);
    	vga_y = (*vga_xy).slc<COORD_WL>(10);
	
	// game initialization

	if(!init){
		ball_x = 480;
		ball_y = 250;
		state = 1;
		init = true;
	 }
    
    // what happens when the ball hits the top wall - does a V shape redirection

	if(ball_y < 140 ){
		if(state == 4){
			state = 3;
		}
		else if(state == 1){
			state = 2;
		}
	}
	
	// what happens when the ball hits the bottom wall - does a V shape redirection

	else if(ball_y >= 400 ){ 
		if(state == 3){
			state = 4;
		}
		else if(state == 2){
			state = 1;
		}
	}
	
	// changes the ball state if it collides with LEFT paddle

	if((vga_x >= 220) && (vga_x < 240) && (vga_y >= 120) && (vga_y < 420) && (V > 300)){
		if(((ball_x - 20)  == vga_x) && (ball_y == vga_y)){
			if(state == 4){
				state = 1;
			}
			else if(state == 3){
				state = 2;
			}
	  	}
	 }
	  
	// change ball state if it collides with RIGHT paddle

	if((vga_x >= 640) && (vga_x < 660) && (vga_y >= 120) && (vga_y < 420) && (V > 300)){
		if((ball_x  == vga_x) && (ball_y == vga_y)){
			if(state == 1){		// possibility 1
				state = 4;
			}
			else if(state == 2){		// possibility 2
				state = 3;
			}
		}
	}
	
	// what the ball does when it hits the left wall

	if(ball_x < 240){
		if(left_miss >= 3){
			left_miss = 0;
			right_miss = 0;
		}
		left_miss ++;
		ball_x = 480;
		ball_y = 250;
		
		if(state >= 4){
			state = 1;
		}
		else{
			state++;
		}
	
	}
	
	// what the ball does when it hits the right wall

	if(ball_x >= 660){
		if(right_miss >= 3){
			right_miss = 0;
			left_miss = 0;
		}
		right_miss++;
		ball_x = 480;
		ball_y = 250;
		
		if(state >= 4){
			state = 1;
		}
		else{
			state++;
		}
	}
	
	//-------- Controls for physical switches --> switch controls configuration for ball speed, 4 possible speeds ------------------
	
	if( (!switch1) && (!switch2)){		// binary 00
		k = 1;
	}
	
	else if( (!switch1) && (switch2)){	// binary 01
		k = 2;
	}
	
	else if( (switch1) && (!switch2)){	// binary 10
		k = 3;
	}
	
	else if((switch1) && (switch2)){	// binary 11
		k = 4;
	}
	
	//------------- Controls the direction of the ball --> 4 possible directions in Cartesian coordinates (x,y) -------------------------------
	
	if((state == 1) && (counter == 313600)){		// ( +x , +y )
		ball_x += k;
		ball_y -= k;
		counter = 0;
	}
	
	else if((state == 2) && (counter == 313600)){		// ( +x , -y )
		ball_x += k;
		ball_y += k;
		counter = 0;
	}
	
	else if((state == 3) && (counter == 313600)){		// ( -x , -y )
		ball_x -= k;
		ball_y += k;
		counter = 0;
	}
	
	else if((state == 4) && (counter == 313600)){		// ( -x , +y )
		ball_x -= k;
		ball_y -= k;
		counter = 0;
	}

	// keeping track of monitor refresh rate
	counter++;
	
	o_red = i_red;
	o_green = i_green;
	o_blue = i_blue;
	
	*video_out = ((((ac_int<PIXEL_WL, false>)o_red) << 20) | (((ac_int<PIXEL_WL, false>)o_green) << 10) | ((ac_int<PIXEL_WL, false>)o_blue));
	*ball_x_out = ball_x;
	*ball_y_out = ball_y;
	*left = left_miss;
	*right = right_miss;
	
}
