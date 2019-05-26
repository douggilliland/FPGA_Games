module FSM(RESET,CLK,ENABLE,COUNT18,COUNT32,RESET_INT,DONE, EN_BCLK);

	input wire RESET;
	input wire CLK;
	input wire ENABLE;
	input wire COUNT18;
	input wire COUNT32;
	output reg RESET_INT;
	output reg DONE;
	output reg EN_BCLK;

    localparam E_RESET = 2'b00;
    localparam E_ESPERA = 2'b01;
    localparam E_LEER = 2'b11;

    reg [1:0] NEXT_STATE = E_RESET;
    reg [1:0] STATE = E_RESET;

	always@(RESET, ENABLE, COUNT18, COUNT32, STATE)
		begin
			if(RESET)
				NEXT_STATE = E_RESET;
			    else
				if((STATE == E_RESET) && ENABLE)                
				    NEXT_STATE = E_ESPERA;
				else
				    if((STATE == E_ESPERA) && COUNT18)
				        NEXT_STATE = E_LEER;
				    else
				        if((STATE == E_LEER) && COUNT32)
				            NEXT_STATE = E_ESPERA;
				        else
				            NEXT_STATE = STATE;
		end
    
    always@(posedge CLK)
        if(RESET)
            STATE = E_RESET;
        else
            STATE = NEXT_STATE;

    always@(STATE)
        case (STATE)
            E_RESET:
                begin
                    DONE = 1'b0;
                    RESET_INT = 1'b1;
                    EN_BCLK = 1'b0;
                end
            E_ESPERA:
                begin
                    DONE = 1'b0;
                    RESET_INT = 1'b0;
                    EN_BCLK = 1'b1;
                end
            E_LEER:
                begin
                    DONE = 1'b1;
                    RESET_INT = 1'b0;
                    EN_BCLK = 1'b1;
                end
            default:
                begin
                    DONE = 1'b0;
                    RESET_INT = 1'b1;
                    EN_BCLK = 1'b0;
                end
		endcase
endmodule
