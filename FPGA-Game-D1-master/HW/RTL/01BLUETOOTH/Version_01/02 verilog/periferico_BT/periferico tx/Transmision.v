module Transmision (input rw, //rw=1 para transmitir
                    input clk,
                    input reset, //reset=0 para transmitir
                    input wire [7:0] din,   
                    output busy, 
                    output reg done,
                    output clk_blu, 
                    output reg tx
                   );

wire clk_f;
Divisor_frecuencia div(.clk(clk), .clk_f(clk_f), .reset(reset));

parameter count = 8;

assign clk_blu = clk_f;

initial begin
	tx <= 1'b1;
    done=0;
end

reg [7:0] dato = 8'b11111111;
reg [2:0] bitcount = 0;


parameter ESTADO_INACTIVO = 2'b00;
parameter ESTADO_INICIO	  = 2'b01;
parameter ESTADO_DATO	  = 2'b10;
parameter ESTADO_FINAL	  = 2'b11;
reg [1:0] estado = ESTADO_INACTIVO;


always @(posedge clk_f) begin 
    //done <= ~done; //done??
    if (reset)
        tx <= 1'b1; //busy=0?
    else begin
        case (estado)
	        ESTADO_INACTIVO: begin
                        if(rw)
	    		estado <= ESTADO_INICIO;
	    		dato <= din;
	    		bitcount <= 0;
                done<=0;
                tx <= 1'b1;
    	    end
    	    ESTADO_INICIO: begin
    			tx <= 1'b0;
    			estado <= ESTADO_DATO;
    	    end
    	    ESTADO_DATO: begin
    			if (bitcount == count-1)begin
    				tx<=dato[bitcount]; 
    				estado <= ESTADO_FINAL;
    			end
    			else begin
    				tx<=dato[bitcount];
    				bitcount <= bitcount + 1;
    			end
    	    end
        	ESTADO_FINAL: begin
    			tx <= 1'b1;
                done<=1;
    			estado <= ESTADO_INACTIVO;
    	    end
    	    default: begin
    		    tx <= 1'b1;
    	    	estado <= ESTADO_INACTIVO;
    	    end
    	endcase
    end
end

assign busy = (estado != ESTADO_INACTIVO);

endmodule
