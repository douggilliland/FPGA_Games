`timescale 1ns / 1ps

 module debouncer
 (clk, rst_n, key_in, key_out
 );
 input clk;
 input rst_n;
 input key_in;
 output key_out;
 
 /**************************************************/

 reg key_in_dly1;
 reg key_in_dly2;
 
 always @ ( posedge clk or negedge rst_n )
   begin
     if( !rst_n )
        begin
          key_in_dly1 <= 1'b0;
          key_in_dly2 <= 1'b0;
        end
     else    
        begin
          key_in_dly1 <= key_in;
          key_in_dly2 <= key_in_dly1;
        end
   end
 
 /**************************************************/
 
 reg[17:0] count_debouncer;
 reg key_out_tmp;
 
 always @ ( posedge clk or negedge rst_n )
   begin
     if( !rst_n )
        begin
	      count_debouncer <= 18'd260_000;
		  key_out_tmp <= 1'b0;
	    end
     else if(key_in_dly2)
        begin
	      count_debouncer <= 18'd0;
		  key_out_tmp <= 1'b0;
	    end
     else if( count_debouncer == 18'd250_000 )
	    begin
	      key_out_tmp <= 1'b1;
	    end
     else if( count_debouncer == 18'd260_000 )
        begin
	      key_out_tmp <= 1'b0;
	    end
     else
	    count_debouncer <= count_debouncer + 1'b1;
   end
 
 /**************************************************/
 
 reg key_out_tmp_dly1;
 
 always @ ( posedge clk or negedge rst_n )
   begin
     if( !rst_n )
        key_out_tmp_dly1 <= 1'b0;
     else
        key_out_tmp_dly1 <= key_out_tmp;
   end
   
 /**************************************************/  

 assign key_out = key_out_tmp & ( ~key_out_tmp_dly1 );

 
 /**************************************************/
 
 endmodule
 