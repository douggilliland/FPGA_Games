module controlador #(
  	parameter adr_width = 12,
	parameter dat_width = 16
   )
(
	input 		reset,	
	output 		ledres,
	input		clk,
	output		mclk,
	output    reg   micLRSel,
        input           micData,    
        output      reg    ampPWM,
        output   reg       ampSD,
  	input  rd, wr,
    	input  [dat_width-1:0] data_in,
    output [dat_width-1:0] data_out,
    output empty,
    output full
   );

fifo fi(.data_out(data_out),.rd(rd),.wr(wr),.data_in(data_in),.empty(empty),.rd(rd),.wr(wr),.full(full));

microfono mi(.clk(clk),.reset(reset),.mclk(mclk),.micLRSel(micLRSel),.micData(micData),.ledres(ledres),.ampPWM(ampPWM),.ampSD(ampSD));

endmodule
