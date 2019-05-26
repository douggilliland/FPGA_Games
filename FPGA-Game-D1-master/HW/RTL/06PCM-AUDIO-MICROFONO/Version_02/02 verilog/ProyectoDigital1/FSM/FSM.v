module FSM(reset,clk,enable,count18,count32,reset_int,done, en_bclk);

	input wire reset;
	input wire clk;
	input wire enable;
	input wire count18;
	input wire count32;
	output reg reset_int;
	output reg done;
	output reg en_bclk;

    localparam e_reset = 2'b00;
    localparam e_espera = 2'b01;
    localparam e_leer = 2'b11;

    reg [1:0] next_state =  e_reset;
    reg [1:0] state = e_reset;

	always@(reset, enable, count18, count32, state)
		begin
			if(reset)
				next_state = e_reset;
			    else
				if((state == e_reset) && enable)                
				    next_state = e_espera;
				else
				    if((state == e_espera) && count18)
				        next_state = e_leer;
				    else
				        if((state == e_leer) && count32)
				            next_state = e_espera;
				        else
				            next_state = state;
		end
    
    always@(posedge clk)
        if(reset)
            state = e_reset;
        else
            state = next_state;

    always@(state)
        case (state)
            e_reset:
                begin
                    done = 1'b0;
                    reset_int = 1'b1;
                    en_bclk = 1'b0;
                end
            e_espera:
                begin
                    done = 1'b0;
                    reset_int = 1'b0;
                    en_bclk = 1'b1;
                end
            e_leer:
                begin
                    done = 1'b1;
                    reset_int = 1'b0;
                    en_bclk = 1'b1;
                end
            default:
                begin
                    done = 1'b0;
                    reset_int = 1'b1;
                    en_bclk = 1'b0;
                end
		endcase
endmodule
