module interface_microfono(clk, reset, d_in, cs, addr, rd, wr, d_out, bclk, lrsel, mic_in);
	
	input wire clk;
	input wire reset;
	input wire [15:0] d_in;
	input wire cs;
	input wire [3:0] addr;
	input wire rd;
	input wire wr;
	output wire d_out;
	output wire bclk;
	output wire lrsel;
	input wire mic_in;

	DivFreq _DivFreq(
		.reset(reset),
		.clk(clk),
		.bclk(bclk)	// reloj de 1MHz para microfono
	);

	assign lrsel = 1'b0;      //mic LRSel

	wire fclk; //reloj de lectura de la fifo
	assign fclk = clk;

	wire empty;
	wire full;
	wire RstN;
	wire FClrN;
	wire F_LastN;
	wire F_SLastN;
	wire F_FirstN;
	reg wr_fifo;
	reg rd_fifo;
	wire d_out_fifo;
	reg data = 1'b0;
	
	assign FClrN = 1'b1;

	fifo _fifo(
		.Clk(fclk),	// reloj de la fifo
		.RstN(~reset),
		.Data_In(mic_in),
		.FClrN(FClrN),
		.FInN(~wr_fifo),
		.FOutN(~rd_fifo),
		.F_Data(d_out_fifo),
		.F_FullN(full),
		.F_LastN(F_LastN),
		.F_SLastN(F_SLastN),
		.F_FirstN(F_FirstN),
		.F_EmptyN(empty)		
	);

	reg [3:0] s; 	//selector de comandos para la fifo

	always @(*) begin//------address_decoder------------------------------
	case (addr)
	4'h0:begin s = (cs && wr) ? 4'b0001 : 4'b0000 ;end //Inicie grabacion
	4'h2:begin s = (cs && wr) ? 4'b0010 : 4'b0000 ;end //Detenga grabacion
	4'h6:begin s = (cs && wr) ? 4'b0011 : 4'b0000 ;end //Inicie reproduccion
	4'h8:begin s = (cs && wr) ? 4'b0100 : 4'b0000 ;end //Detenga reproduccion

	4'ha:begin s = (cs && rd) ? 4'b0101 : 4'b0000 ;end //done
	4'hc:begin s = (cs && rd) ? 4'b0110 : 4'b0000 ;end //dataout
	default:begin s = 4'b0000 ; end
	endcase
	end//------------------address_decoder--------------------------------

	always@(negedge clk)
		if(reset)
			data <=1'b0;
		else
			data <= d_out_fifo;

	assign d_out = {15'h0000, data};

	always@(negedge clk) begin
		if(reset) begin
			wr_fifo <= 1'b0;
			rd_fifo <= 1'b0;
		end
		else begin
			case(s)
				4'b0001:
					begin
						wr_fifo <= 1'b1;
						rd_fifo <= 1'b0;
					end
				4'b0010:
					begin
						wr_fifo <= 1'b0;
						rd_fifo <= 1'b0;
					end
				4'b0011:
					begin
						wr_fifo <= 1'b0;
						rd_fifo <= 1'b1;
					end
				4'b0100:
					begin
						wr_fifo <= 1'b0;
						rd_fifo <= 1'b0;
					end
				default:
					begin
						wr_fifo <= 1'b0;
						rd_fifo <= 1'b0;
					end
			endcase
		end
	end

endmodule
