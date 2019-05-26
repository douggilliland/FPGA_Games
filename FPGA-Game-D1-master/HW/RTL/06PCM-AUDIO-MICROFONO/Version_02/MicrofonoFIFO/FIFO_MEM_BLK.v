`define FWIDTH 1 
`define FDEPTH 200000 
`define FCWIDTH 20 

module FIFO_MEM_BLK(clk,writeN,wr_addr, rd_addr, data_in,data_out);

input clk; //input clk
input writeN; //write signal to put data into FIFO
input [(`FCWIDTH-1):0] wr_addr; //write address
input [(`FCWIDTH-1):0] rd_addr; //read address
input [(`FWIDTH-1):0] data_in; //datain in to memory block
output [(`FWIDTH-1):0] data_out; //data out from the memory block FIFO

wire [(`FWIDTH-1):0] data_out;
reg [(`FWIDTH-1):0] FIFO [0:(`FDEPTH-1)];

assign data_out =FIFO[rd_addr];

always@(posedge clk)
	 begin if(writeN==1'b0)
 		FIFO[wr_addr]<= data_in;
 	end

endmodule

