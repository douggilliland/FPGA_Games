module transmision (input enable, 
                    input wire [7:0] dout,   
                    output busy,
                    output reg done,
                    input wire clk_div, 
                    output reg tx);

parameter count = 8;

initial begin
	tx <= 1'b1;
    done=0;
end

parameter STATE_IDLE	= 2'b00;
parameter STATE_START	= 2'b01;
parameter STATE_DATA	= 2'b10;
parameter STATE_STOP	= 2'b11;

reg [7:0] data = 8'b11111111;
reg [2:0] bitpos = 0;
reg [1:0] state = STATE_IDLE;

always @(posedge clk_div) begin 
        case (state)
	        STATE_IDLE: begin
                done<=0;
                tx <= 1'b1;
                if(enable)begin
	    		    state <= STATE_START;
	    		    data <= dout;
	    		    bitpos <= 0;
                end
    	    end
    	    STATE_START: begin
    			tx <= 1'b0;
    			state <= STATE_DATA;
    	    end
    	    STATE_DATA: begin
    			if (bitpos == count-1)begin
    				tx<=data[bitpos]; 
    				state <= STATE_STOP;
    			end
    			else begin
    				tx<=data[bitpos];
    				bitpos <= bitpos + 1;
    			end
    	    end
        	STATE_STOP: begin
    			tx <= 1'b1;
                done<=1;
    			state <= STATE_IDLE;
    	    end
    	    default: begin
    		    tx <= 1'b1;
    	    	state <= STATE_IDLE;
    	    end
    	endcase
end

assign busy = (state != STATE_IDLE);

endmodule
