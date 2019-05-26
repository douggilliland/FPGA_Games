////////////////////////////////////////////////////////////////////////////////
//  _____                           _       _    _____      _ _
// |_   _|                         (_)     | |  / ____|    | | |
//   | |  _ __ ___  _ __   ___ _ __ _  __ _| | | |     ___ | | | ___  __ _  ___
//   | | | '_ ` _ \| '_ \ / _ \ '__| |/ _` | | | |    / _ \| | |/ _ \/ _` |/ _ \
//  _| |_| | | | | | |_) |  __/ |  | | (_| | | | |___| (_) | | |  __/ (_| |  __/
// |_____|_| |_| |_| .__/ \___|_|  |_|\__,_|_|  \_____\___/|_|_|\___|\__, |\___|
//                 | |                                                __/ |
//                 |_|                                               |___/
//  _                     _
// | |                   | |
// | |     ___  _ __   __| | ___  _ __
// | |    / _ \| '_ \ / _` |/ _ \| '_ \
// | |___| (_) | | | | (_| | (_) | | | |
// |______\___/|_| |_|\__,_|\___/|_| |_|
//
////////////////////////////////////////////////////////////////////////////////
//  File:           tb_blur.cpp
//  Description:    blur filter testbench
//  By:             rad09
////////////////////////////////////////////////////////////////////////////////
// Testbench to test the blur filter design.
// It uses an input BMP image with the same resolution as the VGA in the DE2
// Use images with the same size only and 24 bits (3colours*8bits)
// Source: icl1.bmp,  width = 640,  height = 480
// 
// Settings: 
// Exclude from compilation (same applies to bmp*.h/cpp files)
// Enable SCVerify in Flow Manager
////////////////////////////////////////////////////////////////////////////////
//
// WARNING: this testbench is incomplete.
//
////////////////////////////////////////////////////////////////////////////////

#include "mc_testbench.h"
#include <mc_scverify.h>


#include <iostream>
#include "ac_int.h"
// filter defs and protos
#include "blur.h"
// bmp lib
#include "bmp_io.h"

// file names
char *source_bmp_file = "icl1.bmp";
char *hw_bmp_file = "icl2.bmp";
char *sw_bmp_file = "icl3.bmp";

// pointers to input image contents
unsigned char *red_in, *green_in, *blue_in;
// image information
long int height;
unsigned long int width;
int num_pixels;   

   
// function prototypes:
void testbench();
void sw_test();





// Main Verification Function
CCS_MAIN(int argc, char *argv[])
{
	// teste your design
	// blur filter
    cout << "*** start testbench *** " << endl;
    testbench();
    cout << "*** end of testbench *** " << endl;

	// test your algorithm in sw
	// grayscale convertion
    cout << "*** start sw test *** " << endl;
    sw_test();
    cout << "*** end of sw test *** " << endl;


    //  Free the memory
    delete [] red_in;
    delete [] green_in;
    delete [] blue_in;
       
    CCS_RETURN(0);
}






// this function tests your image processing algorithm implmented 
// in hardware using the RGB streams from BMP file
void testbench()
{
 
    unsigned char *red_out, *green_out, *blue_out;
    bool error;
    int i, j;


	// these signals have to match the ones in the block diagram 
	// where they are connected
    ac_int<PIXEL_WL * KERNEL_WIDTH, false> *input_stream;
    ac_int<PIXEL_WL, false> *output_stream;



	/************************************************************************
    * reads the original/source BMP file, to emulate video frame
  	* colour arrays are automatically allocated inside the function
  	* size of the image is extracted from the BMP header
  	* bmp_read(filename, *width, *height, *red, *green, *blue);
	************************************************************************/
	error = bmp_read(source_bmp_file, &width, &height, &red_in, &green_in, &blue_in);
    if (error)
    {
        cout << "\n";
        cout << "bmp_read: ERROR" << endl;
        return ;
    }
    else {
        cout << "bmp_read: OK" << endl;
        cout << "bmp_read: " << width << "x" << height << endl;
    }


    num_pixels = width * abs (height) * sizeof ( unsigned char );     

    if(num_pixels != NUM_PIXELS) {
        cout << "ERROR: Expecting a 640x480 BMP image!" << endl;
        delete [] red_in;
        delete [] green_in;
        delete [] blue_in;
        return;
    }
    
    

    // need to reserve memory to store results from the filter
    // allocate memory to input & output streams from/to your hardware block
    input_stream = new ac_int<PIXEL_WL * KERNEL_WIDTH, false>[num_pixels];
    output_stream = new ac_int<PIXEL_WL, false>[num_pixels];


    // RGB colour components to be written in file
    // the output must have the same number of bytes/pixels as the input
    red_out = new unsigned char[num_pixels];
    green_out = new unsigned char[num_pixels];
    blue_out = new unsigned char[num_pixels];


    // filter buffer = shift register from input column (KERNEL_WIDTH columns)
    ac_int<PIXEL_WL, false>col_pixel_buf[KERNEL_WIDTH];

    // group the 3 colour components into 1 single steam
    // generate the input stream emulating the camera
    for(i = 0; i < num_pixels; i++) {
        for(j = 0; j < KERNEL_WIDTH; j++) {
			// bits 29..20 = RED,  19..10 = GREEN, 9..0 = BLUE
            col_pixel_buf[j] = ((((ac_int<PIXEL_WL, false>)red_in[i + j * width]) << (2*COLOUR_WL)) | 
                                (((ac_int<PIXEL_WL, false>)green_in[i + j * width]) << COLOUR_WL) 
                                | (ac_int<PIXEL_WL, false>)blue_in[i + j * width]);
        }
        input_stream[i] = 0;
        for(j = 0; j < KERNEL_WIDTH; j++) {
            input_stream[i] |= ((ac_int<PIXEL_WL * KERNEL_WIDTH, false>)col_pixel_buf[j]) << (j * PIXEL_WL);
        }
    }
    
    
    
    
    
    /******************************************************************/
    /* test your design                                               */
    /******************************************************************/

    CCS_DESIGN(mean_vga)(input_stream, output_stream); 

/*  by-pass your block - check I/Os  
	for(int i = 0; i < num_pixels; i++) {
        output_stream[i] = input_stream[i].slc<PIXEL_WL>(0); // copy current pixel (0,30,60,90,120)
    }    */


    
    
    // recover your RGB colour signals from the output stream
    for(int i = 0; i < num_pixels; i++) {
        red_out[i] = (output_stream[i].slc<COLOUR_WL>(2*COLOUR_WL));
        green_out[i] = (output_stream[i].slc<COLOUR_WL>(COLOUR_WL));
        blue_out[i] = (output_stream[i].slc<COLOUR_WL>(0));
    }    

 


    // write the new BMP file:  swap blue and green
	// bmp_24_write(filename, width, height, red, green, blue);
	error = bmp_24_write(hw_bmp_file, width, height, red_out, green_out, blue_out);
    if ( error ) {
        cout << "bmp_24_write: ERROR" << endl;
        return ;
    }
    else {
        cout << "bmp_24_write: OK" << endl;
    }




   // release memory
    delete [] input_stream;
    delete [] output_stream;
    

    delete [] red_out;
    delete [] green_out;
    delete [] blue_out;

    return;        

}






// this function tests your algorithm in software 
// usefull to generate the expected result
void sw_test()
{
   // this test copies the original image with swapped colours
    //unsigned char *red_in, *green_in, *blue_in;
    unsigned char *sw_red_out, *sw_green_out, *sw_blue_out;
    bool error;
    int i, j;



    
    
    
    // need to reserve memory to store results from the filter
    // the output must have the same number of bytes/pixels as the input
    sw_red_out = new unsigned char[num_pixels];
    sw_green_out = new unsigned char[num_pixels];
    sw_blue_out = new unsigned char[num_pixels];




    /************************************************************************/
	/* test of the algorithm in software  
	/* - data not being processed by your unit
    /* you can compare the results of your design block 
    /* e.g. convert from colour to grayscale 
    /************************************************************************/
    for(int i = 0; i < num_pixels; i++) {
        sw_red_out[i] = (red_in[i] + green_in[i] + blue_in[i]) / 3;
        sw_green_out[i] = (red_in[i] + green_in[i] + blue_in[i]) / 3;
        sw_blue_out[i] = (red_in[i] + green_in[i] + blue_in[i]) / 3;
    }



    /************************************************************************/
    // write the new BMP file:  swap blue and green
	// bmp_24_write(filename, width, height, red, green, blue);
	error = bmp_24_write(sw_bmp_file, width, height, sw_red_out, sw_green_out, sw_blue_out);
    if ( error ) {
        cout << "bmp_24_write: ERROR" << endl;
        return ;
    }
    else {
        cout << "bmp_24_write: OK" << endl;
    }

    /************************************************************************/
	//  Free the memory
    delete [] sw_red_out;
    delete [] sw_green_out;
    delete [] sw_blue_out;

    return;        
}





void bmp_io_test()
{
    // this test copies the original image with swapped colours
    unsigned char *barray, *garray, *rarray;
    bool error;
    long int height;
    unsigned long int width;

    //  read the original BMP file
  	// bmp_read(filename, *width, *height, *red, *green, *blue);
  	// colour arrays are automatically allocated inside the function
  	// size of the image is also extracted from the BMP header
	error = bmp_read("icl1.bmp", &width, &height, &rarray,&garray,&barray);
    if ( error )
    {
        cout << "\n";
        cout << "bmp_read: ERROR" << endl;
        return ;
    }
    else {
        cout << "bmp_read: OK" << endl;
        cout << "bmp_read: " << " width = " <<  width << ", height = " << height << endl;
    }

    // write the new BMP file:  swap blue and green
	// bmp_24_write(filename, width, height, red, green, blue);
	error = bmp_24_write("icl2.bmp", width, height, rarray, barray, garray );
    if ( error ) {
        cout << "bmp_24_write: ERROR" << endl;
        return ;
    }
    else {
        cout << "bmp_24_write: OK" << endl;
    }

    //  Free the memory
    delete [] rarray;
    delete [] garray;
    delete [] barray;

    return;
}

