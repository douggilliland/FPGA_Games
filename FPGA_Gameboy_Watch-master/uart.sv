/*

Module: Simple UART for transfering data too and from memory

Uses a pretty simple counter filter and tested at 2mb/s




Author: Jason Rogers
Contact: jasonrogers@alumni.stanford.edu


LICENSE

Copyright (c) 2017 Jason Rogers

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

Attribution is given to the author(s) of the software where such attribution is 
convenient.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

*/


module uart(rst, clk, data_clk,  send, data_send, data_rcv, rdy, ack, tx, rx, rst_req, load_addr, load_we, loading);

input clk;  //16x baudrate
input data_clk; //data clock 
input [7:0] data_send;
output [7:0] data_rcv;
output rdy;
output tx;
input send; //send request
input rx;
input ack;
input rst; 
output rst_req;
output [27:0] load_addr;
output load_we;
output loading;

reg [7:0] data_out;
reg [7:0] data_in;

reg [4:0] filter;
reg [3:0] snd_counter;
reg [3:0] rcv_counter;

reg [4:0] snd_clk_divider;
reg [4:0] rcv_clk_divider;

reg [2:0] snd_state;
reg [2:0] rcv_state;

wire rdy;
assign rdy = ~fifo_data_rdy;

reg rdy_sync;

wire [7:0] data_rcv;
assign data_rcv = data_latch;

reg tx;


//fifos for clock domain crossing
reg fifo_wr;
reg fifo_rd;
reg fifo_full;
reg [7:0] fifo_data_in;
reg [7:0] fifo_data_out;
reg fifo_data_rdy;

fifo f1(
	.aclr(rst),
	.data(fifo_data_in),
	.rdclk(data_clk),
	.rdreq(fifo_rd),
	.wrclk(clk),
	.wrreq(fifo_wr),
	.q(fifo_data_out),
	.rdempty(fifo_data_rdy),
	.rdfull(fifo_full));

reg fifo_s_rd;
reg [7:0] fifo_s_data_in;
reg [7:0] fifo_s_data_out;
reg fifo_s_data_rdy;
reg fifo_s_full;

fifo f2(
	.aclr(rst),
	.data(data_send),
	.rdclk(clk),
	.rdreq(fifo_s_rd),
	.wrclk(data_clk),
	.wrreq(send),
	.q(fifo_s_data_out),
	.rdempty(fifo_s_data_rdy),
	.rdfull(fifo_s_full));
	
always @(posedge clk)
begin
	if(rst) begin
		snd_state = 3'd0;
		rcv_state = 3'd0;
		fifo_wr = 0;
		filter = 0;
	end else begin

		fifo_wr = 0;
		
		case (rcv_state)
			0: begin //idle
				if(~rx) begin
					filter = filter + 1'b1;
				end else begin
					if(|filter) begin
						filter = filter - 1'b1;
					end
				end
				
				if(|filter) begin
					rcv_clk_divider = rcv_clk_divider + 1'b1;
				end else begin
					rcv_clk_divider = 1'b0;
				end
				
				if(rcv_clk_divider[4]) begin
					if(|filter[4:3]) begin
						rcv_state = 1;
						filter = 0;
						rcv_clk_divider = 0;
						rcv_counter = 0;
						data_in = 0;
					end
				end
			end
			1: begin //recieving
				
				rcv_clk_divider = rcv_clk_divider + 1'b1;
				
				filter = filter + (rx ? 1'b1 : 1'b0);
				
				if(rcv_clk_divider[4]) begin
					data_in = {|filter[4:3],data_in[7:1] };
					filter = 0;
					rcv_counter = rcv_counter + 1'b1;
					if(rcv_counter[3]) begin
						
						rcv_state = 2;
					end
				end
			end
			2: begin //stoping
				filter = filter + (rx ? 1'b1 : 1'b0);
				fifo_data_in = data_in;
				
				if(filter[3:2]) begin
					rcv_state = 0; 
					fifo_wr = 1'b1;
				end				
			end
			default: rcv_state = 0;
		endcase
		
		
		case(snd_state)
			0: begin  //idle
				snd_counter = 4'd0;
				snd_clk_divider = 5'b0;
				tx = 1'b1;
				fifo_s_rd =  0;
				snd_state = fifo_s_data_rdy ? 3'd0 : 3'd1;
			end
			1: begin //starting
				
				snd_clk_divider = snd_clk_divider + 1'b1;
				data_out = fifo_s_data_out;
				tx = 1'b0;
				fifo_s_rd =  0;
				snd_state = snd_clk_divider[4] ? 3'd2 : 3'd1; 
			end
			2: begin //sending
				snd_clk_divider = snd_clk_divider + 1'b1;
				tx = data_out[0];
				fifo_s_rd =  0;
				if(snd_clk_divider[4]) begin
					data_out = {1'b0,data_out[7:1]};
					snd_counter = snd_counter + 1'b1;
					snd_state =  snd_counter[3] ? 3'd3 : 3'd2; 
				end
			end
			3: begin //stopping
				snd_clk_divider = snd_clk_divider + 1'b1;
				tx = 1'b1;
				fifo_s_rd = snd_clk_divider[4];
				snd_state = snd_clk_divider[4] ? 3'd4 : 3'd3; 
			end
			4: begin //stopping 
				snd_clk_divider = snd_clk_divider + 1'b1;
				tx = 1'b1;
				fifo_s_rd =  0;
				snd_state = snd_clk_divider[4] ? 3'd0 : 3'd4; 
			end
			default: snd_state = 0;
		endcase	
		
		snd_clk_divider = snd_clk_divider[4] ? 5'b0 : snd_clk_divider;
		rcv_clk_divider = rcv_clk_divider[4] ? 5'b0 : rcv_clk_divider;
		snd_counter = snd_counter[3] ? 4'b0 : snd_counter;
		rcv_counter = rcv_counter[3] ? 4'b0 : rcv_counter;
	end
end

////---------------------------
//	
// 	UART memory loader
//
//=============================

reg loading;
reg [27:0] load_addr;
reg [23:0] move_counter;
reg load_we;

reg [3:0] load_state;

reg [3:0] load_next_state;

reg load_ack;

reg [7:0] data_latch;

always @(posedge data_clk)
begin
		if(rst) begin
			loading = 0;
			load_state = 4'h0;
			load_we = 0;
			fifo_rd = 0;
			move_counter=0;
			load_addr = 0;
			data_latch = 0;
		end else begin
		
			fifo_rd = load_state[0] & rdy_sync;
			
			case(load_state)
			

				4'h0: begin //waiting
					load_state = load_state + (rdy_sync ? 1'b0 : 1'b1);
					load_addr = 0;
					load_we = 0;
					loading = 0;
					
				end
				4'h1, 4'h3, 4'h5, 4'h7, 4'h9: begin //waiting
					load_state = load_state + (rdy_sync ? 1'b1 : 1'b0);
					data_latch = fifo_data_out;
				end
				4'h2: begin //recieving memory type
					load_state = load_state + (rdy_sync ? 1'b0 : 1'b1);
					load_addr[27:24] = data_latch[3:0];
					load_we = 0;
					loading = 0;
				end

				4'h4: begin //recieving memory addr b0
					load_state = load_state + (rdy_sync ? 1'b0 : 1'b1);
					move_counter[23:16] = data_latch;
					load_we = 0;
					loading = 0;
				end
				4'h6: begin //recieving memory addr b1
					load_state = load_state + (rdy_sync ? 1'b0 : 1'b1);
					move_counter[15:8] = data_latch;
					load_we = 0;
					loading = 0;
				end
				4'h8: begin //recieving memory addr b2
					load_state = load_state + (rdy_sync ? 1'b0 : 1'b1);
					move_counter[7:0] = data_latch;
					load_we = 0;
					loading = 0;
				end
				4'ha: begin //recieving data
					load_we = 1;
					loading = 1;
					
					load_state = load_state + (rdy_sync ? 1'b0 : 1'b1);
					
					
				end
				4'hb: begin
					if(rdy_sync) begin
						load_addr[23:0] = load_addr[23:0] + 1'b1;
						load_state = move_counter == load_addr[23:0] ? 4'h0 : 4'ha;
						data_latch = fifo_data_out;
					end
					
					loading = 1;
					load_we = 0;
				end
				default: begin load_state = 4'h0; end
			endcase
			
			rdy_sync = rdy;
			
		end
	
end
endmodule 