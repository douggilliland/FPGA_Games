module i2c_send (
     clk, //the clock, max 526kHz * 8 for the dac
	  rst,
     sclk, //i2c sclk
     sdat, //i2c sdat
    
     start, //starts the send/recieve 
     done, //set to high when transfer complete
     ack, //will be high if all three acks are correct

    data //data to be sent
	 
);

    input  clk; //the clock, max 526kHz * 8 for the dac
	 input rst;
    output sclk; //i2c sclk
    inout  sdat; //i2c sdat
    
    input  start; //starts the send/recieve 
    output done; //set to high when transfer complete
    output ack; //will be high if all three acks are correct

    input [23:0] data; //data to be sent


   reg sclk; //i2c sclk
   reg done; //set to high when transfer complete
   reg ack; //will be high if all three acks are correct

reg sdat_md;

assign sdat = sdat_md ? 1'bz : 1'b0;
 
reg [23:0] data_shifter;
reg [5:0] bit_count;
reg [2:0] acks;
reg [6:0] clk_divider;
reg clk_hold;
reg done_bit;

always_comb 
begin

	sclk <= clk_divider[6] | clk_hold;
	ack <= ~|acks;
	
end

always @(posedge clk)
begin
   if(rst) begin
		done = 1'b1;
	end else if(start & done) begin
		data_shifter = data;
		bit_count = 5'd0;
		clk_hold = 1'b1;
		clk_divider = 7'b0;
		done = 1'b0;
		sdat_md = 1'b1;
		acks = 3'b111;
	end else begin
		if(clk_divider == 7'd127) begin
			
			case (bit_count)
				5'd0: clk_hold = 1'b0;		
				5'd9: acks[0] = sdat;					
				5'd18: acks[1] = sdat;					
				5'd27: acks[2] = sdat;			
				5'd28: clk_hold = 1'b1;
				default: data_shifter = {data_shifter[22:0], 1'b0}; 
			endcase
			
			bit_count = bit_count + 1'b1;
			clk_divider = 7'b0;
			
		end else if (clk_divider == 7'd31) begin
			case (bit_count)
				5'd0: sdat_md = 1'b0;		
				5'd9: sdat_md = 1'b1;					
				5'd18: sdat_md = 1'b1;					
				5'd27: sdat_md = 1'b1;			
				5'd28: sdat_md = 1'b0;				
				5'd29: begin 
					sdat_md = 1'b1;
					done = 1'b1;
				end
				default:	sdat_md = data_shifter[23] ? 1'b1 : 1'b0;				
			endcase
		end
		
		clk_divider = clk_divider + 1'b1;
	
	end
end

endmodule