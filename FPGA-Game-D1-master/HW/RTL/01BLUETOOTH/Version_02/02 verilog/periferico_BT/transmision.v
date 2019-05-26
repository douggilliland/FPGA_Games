module transmision (input enable, 
                    input clk_in,
                    input reset,
                    input wire [7:0] din,   
                    output busy, 
                    output reg done, 
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

reg [8:0] data = 8'b11111111;
reg [3:0] bitpos = 0;
reg [1:0] state = STATE_IDLE;
reg [31:0] counter=0;

always @(posedge clk_in) begin 
    if (reset)
        tx <= 1'b1;
    else begin
        case (state)
	        STATE_IDLE: begin
                done<=0;
                tx <= 1'b1;
                if (enable)begin
	    		    state <= STATE_START;
	    		    data <= {1'h01,din};
	    		    bitpos <= 0;
                end
    	    end
    	    STATE_START: begin
    			tx <= 1'b0;
    			state <= STATE_DATA;
    	    end
    	    STATE_DATA: begin  
        			if(bitpos <= count)begin
                        counter <= counter +1; 
                        if (counter==5208) begin
           				tx<=data[bitpos];
    		    		bitpos <= bitpos + 1;
                        counter<=0;
                           if (bitpos==count)
                            state<=STATE_STOP;
    		    	    end
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
end

assign busy = (state != STATE_IDLE);

endmodule
