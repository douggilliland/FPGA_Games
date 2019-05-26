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
//  File:           tb_dot_product.cpp
//  Description:    dot product calculator testbench
//  By:             rad09
////////////////////////////////////////////////////////////////////////////////

#include "dot_product.h"
#include <mc_scverify.h>

CCS_MAIN(int argc, char *argv[])
{
  ac_int<8> inA[VECTOR_LEN] = {1,2,3,4,5};
  ac_int<8> inB[VECTOR_LEN] = {5,4,3,2,1};
  ac_int<8> output;
  int i, exp_out;

  // Test design
  CCS_DESIGN(dot_product)(inA,inB,&output);

  // Expected result  
  exp_out = 0;
  for(i = 0; i < VECTOR_LEN; i++) {
    exp_out += inA[i] * inB[i];
  }

  // Display results
  for(i = 0; i < VECTOR_LEN; i++) {
    printf ("Inputs: A = %d, B = %d \n", (int)inA[i], (int)inB[i]);
  }
  printf ("Design output  : %d \n", (int)output);
  printf ("Expected output: %d \n", exp_out);
   
  CCS_RETURN(0);
}

