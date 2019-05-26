module FSM(reset,clk, full, empty, rec, play, wr, rd);

	input wire reset;
	input wire clk;
	input wire full;
	input wire empty;
	input wire rec;
	input wire play;
	output reg wr;
	output reg rd;

    localparam e_espera = 2'b00;
    localparam e_rec = 2'b01;
    localparam e_play = 2'b11;

    reg [1:0] next_state =  e_espera;
    reg [1:0] state = e_espera;

	always@(reset, full, empty, rec, play, state)
		begin
			if(reset)
				next_state = e_espera;
			    else
				if((state == e_espera) && rec)                
				    next_state = e_rec;
				else
				    if((state == e_espera) && play)
				        next_state = e_play;
				    else
				        if((state == e_rec) && ~full)
				            next_state = e_rec;
				        else
				            if((state == e_play) && ~empty)
												next_state = e_play;
										else
												next_state = e_espera;
		end
    
    always@(posedge clk)
        if(reset)
            state = e_espera;
        else
            state = next_state;

    always@(state)
        case (state)
            e_espera:
                begin
                    wr = 1'b0;
                    rd = 1'b0;
                end
            e_rec:
                begin
                    wr = 1'b1;
                    rd = 1'b0;
                end
            e_play:
                begin
                    wr = 1'b0;
                    rd = 1'b1;
                end
            default:
                begin
                    wr = 1'b0;
                    rd = 1'b0;
                end
		endcase
endmodule
