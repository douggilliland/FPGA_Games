module Microfono(clk, reset, rec, play, bclk, lrsel, data_in, data_out, ampSD, rd, wr, emptyLED, fullLED);
	
	input wire clk;
	input wire reset;
	input wire rec;
	input wire play;
	output wire bclk;
	output wire lrsel;
	input wire data_in;
	output wire data_out;
	output wire ampSD;
	output wire rd;
	output wire wr;
	output wire emptyLED;
	output wire fullLED;

	wire empty;
	wire full;
	wire RstN;
	wire FClrN;
	wire F_LastN;
	wire F_SLastN;
	wire F_FirstN;
	
	reg [5:0] fifo_counter = 0;
	reg fclk = 1'b0;

	assign FClrN = 1'b1;
	assign emptyLED = ~empty;
	assign fullLED = ~full;

	always @(posedge bclk)	// bclk = 1MHz
			begin
				if (reset)
				begin
					fifo_counter = 0;
					fclk = 1'b1;
				end	
				else
				if (fifo_counter == 2) // fclk = 500KHz
					begin
						fifo_counter = 1;
						fclk = ~fclk;
					end
				else
					begin
						fifo_counter = fifo_counter + 1;
						fclk = fclk;
					end
			end
	

	assign lrsel = 1'b0;      //mic LRSel
	assign ampSD = 1'b1;

	DivFreq _DivFreq(
		.reset(reset),
		.clk(clk),
		.bclk(bclk)	// reloj de 1MHz
	);

	fifo _fifo(
		.Clk(bclk),	// reloj de la fifo
		.RstN(~reset),
		.Data_In(data_in),
		.FClrN(FClrN),
		.FInN(~wr),
		.FOutN(~rd),
		.F_Data(data_out),
		.F_FullN(full),
		.F_LastN(F_LastN),
		.F_SLastN(F_SLastN),
		.F_FirstN(F_FirstN),
		.F_EmptyN(empty)		
	);

	FSM _FSM(					
		.reset(reset),						
		.clk(clk),					
		.full(~full),				
		.empty(~empty),					
		.rec(rec),					
		.play(play),					
		.wr(wr),				
		.rd(rd)			
	);


endmodule
