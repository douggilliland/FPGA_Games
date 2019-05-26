`define FWIDTH 1 //width of the FIFO 
`define FDEPTH 200000 //depth of the FIFO 
`define FCWIDTH 20 //counter width of the FIFO 2 to power FCWIDTH 

module fifo(Clk,RstN,Data_In,FClrN,FInN,FOutN, F_Data,F_FullN,F_LastN,F_SLastN,F_FirstN,F_EmptyN); 
input Clk; //clk signal 
input RstN; //low asserted reset signal 
input [(`FWIDTH-1):0] Data_In; //data into FIFO 
input FClrN; //clear signal to FIFO 
input FInN; //write into FIFO signal 
input FOutN; //read from FIFO signal

output [(`FWIDTH-1):0] F_Data; // FIFO data out 
output F_FullN; //FIFO full indicating signal 
output F_LastN; //FIFO last but one signal 
output F_SLastN; //FIFO Slast but one signal 
output F_EmptyN; //FIFO empty indicating signal 
output F_FirstN; // signal indicating only 1word in FIFO 
reg F_FullN; 
reg F_EmptyN; 
reg F_LastN; 
reg F_SLastN; 
reg F_FirstN; 
reg [`FCWIDTH:0] fcounter; //counter indicates num of data in FIFO 
reg [(`FCWIDTH-1):0] rd_ptr; // current read pointer 
reg [(`FCWIDTH-1):0] wr_ptr; //current write pointer 
wire [(`FWIDTH -1):0] FIFODataOut; //data out from FIFO MemBlk 
wire [(`FWIDTH-1):0] FIFODataIn; //data into FIFO MemBlk 
wire ReadN=FOutN; 
wire WriteN=FInN; 

assign F_Data = FIFODataOut; 
assign FIFODataIn = Data_In; 

FIFO_MEM_BLK memblk(
	.clk(Clk),
	.writeN(WriteN),
	.rd_addr(rd_ptr),
	.wr_addr(wr_ptr),
	.data_in(FIFODataIn),
	.data_out(FIFODataOut)
);

always@(posedge Clk or negedge RstN) begin
	if(!RstN) begin
		fcounter <= 0;
		rd_ptr <= 0;
		wr_ptr <= 0;
	end 
	else begin
		if(!FClrN) begin
			fcounter <= 0;
			rd_ptr <= 0;
			wr_ptr <= 0;
		end 
		else begin
			if (!WriteN && F_FullN)
				wr_ptr <= wr_ptr + 1;
			if(!ReadN && F_EmptyN)
				rd_ptr <= rd_ptr + 1;
			if(!WriteN && ReadN && F_FullN)
				fcounter <= fcounter + 1;
			else
				if(WriteN && !ReadN && F_EmptyN)
					fcounter <= fcounter -1;
		end
	end
end

always@(posedge Clk or negedge RstN) begin
	if(!RstN)
		F_EmptyN <= 1'b0;
	else begin
		if(FClrN== 1'b1) begin
			if(F_EmptyN==1'b0 && WriteN==1'b0)
				F_EmptyN <= 1'b1;
			else
				if(F_FirstN== 1'b0 && ReadN== 1'b0 && WriteN== 1'b1)
					F_EmptyN <= 1'b0;
		end
		else F_EmptyN <= 1'b0;
	end
end

always@(posedge Clk or negedge RstN) begin
	if(!RstN) F_FirstN <= 1'b1;
	else begin
		if(FClrN== 1'b1) begin
			if((F_EmptyN==1'b0 && WriteN==1'b0)||(fcounter==2 && ReadN==1'b0 && WriteN==1'b1))
				F_FirstN <= 1'b0;
			else
				if (F_FirstN==1'b0 && (WriteN ^ ReadN ))
					F_FirstN <= 1'b1;
		end
		else begin
			F_FirstN <= 1'b1;
		end
	end
end

always@(posedge Clk or negedge RstN) begin
	if(!RstN)
		F_SLastN <= 1'b1;
	else begin
		if(FClrN==1'b1) begin
			if((F_LastN==1'b0 && ReadN==1'b0 && WriteN== 1'b1)||(fcounter==(`FDEPTH -3) && WriteN==1'b0 && ReadN==1'b1))
				F_SLastN <= 1'b0;
			else
				if (F_SLastN==1'b0 && (ReadN ^ WriteN))
					F_SLastN <= 1'b1;
		end
		else
			F_SLastN <= 1'b1;
	end
end

always@(posedge Clk or negedge RstN) begin
	if(!RstN)
		F_LastN <= 1'b1;
	else begin
		if(FClrN== 1'b1) begin
			if((F_FullN== 1'b0 && ReadN== 1'b0)||(fcounter==(`FDEPTH-2) && WriteN==1'b0 && ReadN==1'b1))
				F_LastN <= 1'b0;
			else
				if(F_LastN==1'b0 && (ReadN ^ WriteN))
					F_LastN <=1'b1;
		end
		else
			F_LastN <= 1'b1;
	end
end

always@(posedge Clk or negedge RstN) begin
	if(!RstN)
		F_FullN <= 1'b1;
	else begin
		if(FClrN==1'b1) begin
			if(F_LastN==1'b0 && WriteN==1'b0 && ReadN==1'b1)
				F_FullN <= 1'b0;
			else
				if(F_FullN==1'b0 && ReadN==1'b0)
					F_FullN <= 1'b1;
		end
		else
			F_FullN <= 1'b1;
	end
end

endmodule
