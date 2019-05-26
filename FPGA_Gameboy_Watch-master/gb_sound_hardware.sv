module gb_sound_hardware (
    clk, //the pixel clock
	 rst,
    
	 
	 left_out,  
	 right_out,
	 sound_enabled,
	 
	 addr_bus,
	 data_bus_in,
	 data_bus_out,
	 we,
	 re,
	 
	 channel_enables
	 
);

    input  clk; //the pixel clock
	 input rst;
    
	 
	 output [15:0] left_out;  
	 output [15:0] right_out;
	 output sound_enabled;
	 
	 input [15:0] addr_bus;
	 input [7:0] data_bus_in;
	 output [7:0] data_bus_out;
	 input we;
	 input re;
	 
	 input [3:0] channel_enables;

 reg [15:0] left_out;  
 reg [15:0] right_out;
 reg sound_enabled;
 reg [7:0] data_bus_out;

reg [15:0] left_out_reg;
reg [15:0] right_out_reg;

reg [15:0] left_accumulator;
reg [15:0] right_accumulator;


// sound registers	 
reg [7:0] NR10;
reg [7:0] NR11;
reg [7:0] NR12;
reg [7:0] NR13;
reg [7:0] NR14;

reg [7:0] NR21;
reg [7:0] NR22;
reg [7:0] NR23;
reg [7:0] NR24;

reg [7:0] NR30;
reg [7:0] NR31;
reg [7:0] NR32;
reg [7:0] NR33;
reg [7:0] NR34;

reg [7:0] NR41;
reg [7:0] NR42;
reg [7:0] NR43;
reg [7:0] NR44;

reg [7:0] NR50;
reg [7:0] NR51;
reg [7:0] NR52;

reg [3:0] WaveSamples [31:0];

//11 bit freq up counters
reg [10:0] channel_1_freq;
reg [10:0] channel_2_freq;
reg [10:0] channel_3_freq;

//square wave bits
reg [7:0] channel_1_duty;
reg [7:0] channel_2_duty;

//output to DAC (if they each had a dac...)
reg [3:0] channel_1_out;
reg [3:0] channel_2_out;
reg [5:0] channel_3_out;
reg [3:0] channel_4_out;

reg [5:0] channel_1_out_latch;
reg [5:0] channel_2_out_latch;
reg [5:0] channel_3_out_latch;
reg [5:0] channel_4_out_latch;

//volume envelopes
reg [3:0] channel_1_vol_env;
reg [3:0] channel_2_vol_env;
reg [3:0] channel_4_vol_env;

//volume sweep counters
reg [2:0] channel_1_vol_sweep_ctr;
reg [2:0] channel_2_vol_sweep_ctr;
reg [2:0] channel_4_vol_sweep_ctr;

//channel length counter
reg [5:0] channel_1_len_ctr;
reg [5:0] channel_2_len_ctr;
reg [7:0] channel_3_len_ctr;
reg [5:0] channel_4_len_ctr;

reg [11:0] channel_1_swept_freq;
reg [10:0] channel_1_sweep_shift;
reg [2:0] channel_1_sweep_ctr;

reg [15:0] channel_4_lfsr;

reg [4:0] channel_3_byte_counter;

//-----------------------------
//
// sound time divider
//
//  clocked at system clock
//
//  [0] = 2.08 mhz
//  [1] = 1.04 mhz
//  [2] = 524 khz
//  [3] = 261 khz (white noise freq)
//  [4] = 131 khz (square and wave freq)
//  [5] = 64 khz
//  [6] = 32 khz
//  [7] = 16 khz
//  [8] = 8 khz
//  [9] = 4 khz
//  [10] = 2 khz
//  [11] = 1 khz
//  [12] = 512 hz
//  [13] = 256 hz (length)
//  [14] = 128 hz (Sweep)
//  [15] = 64 hz (vol env)
//
//-----------------------------

reg [15:0] time_divider;

always @(posedge clk)
begin
	time_divider = time_divider + 1'b1;
	
	//case (time_divider[2:0])
	//	3'd1: begin
			channel_1_out_latch = {channel_1_out, 2'b0};
			channel_2_out_latch = {channel_2_out, 2'b0};
			channel_3_out_latch = channel_3_out;
			channel_4_out_latch = {channel_4_out, 2'b0};
			
			left_accumulator = 0;
			right_accumulator = 0;
	//	end
	//	3'd2: begin
			if(channel_enables[0] & NR14[7]) begin
				left_accumulator = NR51[4] ? left_accumulator + {channel_1_out_latch} : left_accumulator;
				right_accumulator  = NR51[0] ? right_accumulator +  {channel_1_out_latch} : right_accumulator;
			end
//		end
//		3'd3: begin
			if(channel_enables[1] & NR24[7]) begin
				left_accumulator = NR51[5] ? left_accumulator + {channel_2_out_latch} : left_accumulator;
				right_accumulator  = NR51[1] ? right_accumulator +  {channel_2_out_latch} : right_accumulator;
			end
//		end
//		3'd4: begin
			if(channel_enables[2] & NR34[7]  & NR30[7]) begin
				left_accumulator = NR51[6] ? left_accumulator + {channel_3_out_latch} : left_accumulator;
				right_accumulator  = NR51[2] ? right_accumulator +  {channel_3_out_latch} : right_accumulator;
			end
//		end
//		3'd5: begin
			if(channel_enables[3] & NR44[7]) begin
				left_accumulator = NR51[7] ? left_accumulator + {channel_4_out_latch} : left_accumulator;
				right_accumulator  = NR51[3] ? right_accumulator +  {channel_4_out_latch} : right_accumulator;
			end
//		end	
//		3'd6: begin
			left_accumulator = left_accumulator * NR50[6:4];
			right_accumulator = right_accumulator * NR50[2:0];
//		end
//		3'd7: begin
			left_out_reg =  {left_accumulator[11:0],4'b0};
			right_out_reg = {right_accumulator[11:0],4'b0};
//		end
//	default: begin end
//	endcase
	
	
end


reg len_clk;
reg vol_env_clk;
reg sweep_clk;
reg sw_freq_clk;
reg wave_freq_clk;
reg r_clk;

reg [2:0] r_counter;

reg channel_1_init;
reg channel_2_init;
reg channel_3_init;
reg channel_4_init;
reg channel_1_stop;
reg channel_2_stop;
reg channel_3_stop;
reg channel_4_stop;

reg power_cycle;

always_comb
begin
	len_clk <= ~|time_divider[13:0]; //256 Hz
	vol_env_clk <= ~|time_divider[15:0]; //64 Hz
	sweep_clk <= ~|time_divider[14:0]; //128 Hz
	sw_freq_clk <= ~|time_divider[1:0]; //131 KHz * 8 (8 bits per waveform)
	wave_freq_clk <= ~|time_divider[0]; //64 KHz 

	channel_1_init <= (we && addr_bus == 16'hff14) & data_bus_in[7]; 
	channel_2_init <= (we && addr_bus == 16'hff19) & data_bus_in[7]; 
	channel_3_init <= (we && addr_bus == 16'hff1e) & data_bus_in[7]; 
	channel_4_init <= (we && addr_bus == 16'hff23) & data_bus_in[7]; 
	
	channel_1_stop <= ((we && addr_bus == 16'hff12) & ~|data_bus_in[7:4]); //~|NR12[7:4];//
	channel_2_stop <= ((we && addr_bus == 16'hff17) & ~|data_bus_in[7:4]); //~|NR22[7:4];//
	channel_3_stop <= ((we && addr_bus == 16'hff1a) & ~data_bus_in[7]); //~|NR30[7];//
	channel_4_stop <= ((we && addr_bus == 16'hff21) & ~|data_bus_in[7:4]); //~|NR42[7:4];//

	power_cycle  <= (we && addr_bus == 16'hff26) & ~data_bus_in[7];  	

	case(NR43[7:4])
		4'h0: r_clk <= ~|time_divider[0];
		4'h1: r_clk <= ~|time_divider[1:0];
		4'h2: r_clk <= ~|time_divider[2:0];
		4'h3: r_clk <= ~|time_divider[3:0];
		4'h4: r_clk <= ~|time_divider[4:0];	
		4'h5: r_clk <= ~|time_divider[5:0];
		4'h6: r_clk <= ~|time_divider[6:0];
		4'h7: r_clk <= ~|time_divider[7:0];
		4'h8: r_clk <= ~|time_divider[8:0];
		4'h9: r_clk <= ~|time_divider[9:0];
		4'ha: r_clk <= ~|time_divider[10:0];
		4'hb: r_clk <= ~|time_divider[11:0];
		4'hc: r_clk <= ~|time_divider[12:0];
		4'hd: r_clk <= ~|time_divider[13:0];
		4'he: r_clk <= ~|time_divider[14:0];
		4'hf: r_clk <= ~|time_divider[15:0];
   endcase		
	
	sound_enabled <= 1;
	
	left_out <= {left_out_reg};
	right_out <= {right_out_reg};
	
end




//----------------------------------------------------
//
//  Registers
//
//----------------------------------------------------
always @(posedge clk)
begin
		
		if (power_cycle | rst) begin
			NR10 = 8'h00;
			NR11 = 8'h00;
			NR12 = 8'h00;
			NR13 = 8'h00;
			NR14 = 8'h00;
			NR21 = 8'h00;
			NR22 = 8'h00;
			NR23 = 8'h00;
			NR24 = 8'h00;
			NR30 = 8'h00;
			NR31 = 8'h00;
			NR32 = 8'h00;
			NR33 = 8'h00;
			NR34 = 8'h00;
			NR41 = 8'h00;
			NR42 = 8'h00;
			NR43 = 8'h00;
			NR44 = 8'h00;
			NR50 = 8'h00;
			NR51 = 8'h00;
			NR52 = rst ? 8'hF0 : 8'h00;
			
			
		end else begin
		
			if(we & NR52[7]) begin
			casex (addr_bus)
				16'b11111111xxxxxxxx: begin
						casex (addr_bus[7:0])
							8'h10: NR10 = data_bus_in;
							8'h11: NR11 = data_bus_in;
							8'h12: NR12 = data_bus_in;
							8'h13: NR13 = data_bus_in;
							8'h14: begin
								NR14[6] = data_bus_in[6];
								NR14[2:0] = data_bus_in[2:0]; 
							end
							8'h16: NR21 = data_bus_in;
							8'h17: NR22 = data_bus_in;
							8'h18: NR23 = data_bus_in;
							8'h19: begin
								NR24[6] = data_bus_in[6];
								NR24[2:0] = data_bus_in[2:0]; 
							end
							8'h1a: NR30 = data_bus_in;
							8'h1b: NR31 = data_bus_in;
							8'h1c: NR32 = data_bus_in;
							8'h1d: NR33 = data_bus_in;
							8'h1e: begin
								NR34[6] = data_bus_in[6];
								NR34[2:0] = data_bus_in[2:0]; 
							end
							8'h20: NR41 = data_bus_in;
							8'h21: NR42 = data_bus_in;
							8'h22: NR43 = data_bus_in;
							8'h23: begin
								NR44[6] = data_bus_in[6];
								NR44[2:0] = data_bus_in[2:0]; 
							end
							8'h24: NR50 = data_bus_in;
							8'h25: NR51 = data_bus_in;
							8'h26: NR52[7] = data_bus_in[7];
							8'h3x: begin
								WaveSamples [{addr_bus[3:0], 1'b0}] = data_bus_in[7:4];		
								WaveSamples [{addr_bus[3:0], 1'b1}] = data_bus_in[3:0];	
							end
							default: begin end
						endcase
					end 
				endcase
			end else if (we && addr_bus==16'hff26) begin
				NR52[7] = data_bus_in[7];
			end else if(re) begin
				casex (addr_bus)
				16'b11111111xxxxxxxx: begin
						casex (addr_bus[7:0])
							8'h10:  data_bus_out = NR10 | 8'h80;
							8'h11:  data_bus_out = NR11 | 8'h3F;
							8'h12:  data_bus_out = NR12;
							8'h13:  data_bus_out = NR13 | 8'hFF;
							8'h14:  data_bus_out = NR14 | 8'hBF;
							
							8'h16:  data_bus_out = NR21 | 8'h3F;
							8'h17:  data_bus_out = NR22 ;
							8'h18:  data_bus_out = NR23 | 8'hFF;
							8'h19:  data_bus_out = NR24 | 8'hBF;
							
							8'h1a:  data_bus_out = NR30 | 8'h7F;
							8'h1b:  data_bus_out = NR31 | 8'hFF;
							8'h1c:  data_bus_out = NR32 | 8'h9F;
							8'h1d:  data_bus_out = NR33 | 8'hFF;
							8'h1e:  data_bus_out = NR34 | 8'hBF;
							
							8'h20:  data_bus_out = NR41 | 8'hFF;
							8'h21:  data_bus_out = NR42 ;
							8'h22:  data_bus_out = NR43;
							8'h23:  data_bus_out = NR44| 8'hBF;
							
							8'h24:  data_bus_out = NR50; 
							8'h25:  data_bus_out = NR51;
							8'h26:  data_bus_out = {NR52[7], 3'h7,   NR44[7], NR34[7],  NR24[7], NR14[7]};
							8'h3x:  data_bus_out = {WaveSamples [{addr_bus[3:0],1'b0}],WaveSamples [{addr_bus[3:0],1'b1}]} ;
							
							default: data_bus_out = 8'hff; 
						endcase
					end 
				endcase
			end


//----------------------------------------------------
//
//  Square wave channel 1
//
//----------------------------------------------------
			if (we && addr_bus == 16'hff11) begin
				channel_1_len_ctr = data_bus_in[5:0];
			end else if (channel_1_stop) begin
				NR14[7] = 0;
			end else if(channel_1_init) begin
				channel_1_freq = {NR14[2:0], NR13};
				channel_1_swept_freq = {1'b0,NR14[2:0], NR13};
				channel_1_vol_env = NR12[7:4];
				channel_1_vol_sweep_ctr = 3'b0;
				channel_1_sweep_ctr = 3'b0;
				NR14[7] = |NR12[7:3];
				
				case(NR11[7:6])
					2'b00:channel_1_duty = 8'b00000001;
					2'b01:channel_1_duty = 8'b10000001;
					2'b10:channel_1_duty = 8'b10000111;
					2'b11:channel_1_duty = 8'b01111000;
				endcase
				
			end else begin
				if(sw_freq_clk ) begin
					channel_1_freq = channel_1_freq + 1'b1;
				end
				
				if(sweep_clk & |NR10[6:0]) begin
				
					//verify this is on init
					case(NR10[2:0])

					  3'd0:	channel_1_sweep_shift = 0;
					  3'd1:	channel_1_sweep_shift = {1'b0, channel_1_swept_freq[7:1]};
					  3'd2:	channel_1_sweep_shift = {2'b0, channel_1_swept_freq[7:2]};
					  3'd3:	channel_1_sweep_shift = {3'b0, channel_1_swept_freq[7:3]};
					  3'd4:	channel_1_sweep_shift = {4'b0, channel_1_swept_freq[7:4]};
					  3'd5:	channel_1_sweep_shift = {5'b0, channel_1_swept_freq[7:5]};
					  3'd6:	channel_1_sweep_shift = {6'b0, channel_1_swept_freq[7:6]};
					  3'd7:	channel_1_sweep_shift = {7'b0, channel_1_swept_freq[7]};

					endcase

					channel_1_sweep_ctr = channel_1_sweep_ctr + 1'b1;

					if(channel_1_sweep_ctr == NR10[6:4]) begin
						channel_1_swept_freq = NR10[3] ? channel_1_swept_freq - channel_1_sweep_shift : channel_1_swept_freq + channel_1_sweep_shift;
					end 
					
					if(channel_1_swept_freq[11]) begin
						NR14[7] = 1'b0;
					end
				end 
				
				if(~|channel_1_freq) begin

					channel_1_out = channel_1_duty[0] ? channel_1_vol_env : 4'h0;

					channel_1_duty = {channel_1_duty[0],channel_1_duty[7:1]}; 
								
					channel_1_freq = (channel_1_swept_freq[11] & |NR10[6:0]) ? channel_1_freq : channel_1_swept_freq[10:0];
			
				end 
				
				if(vol_env_clk) begin
					
					if ((|channel_1_vol_env) & (|NR12[2:0]) & (channel_1_vol_sweep_ctr==NR12[2:0])) begin
						channel_1_vol_env = NR12[3] ? channel_1_vol_env + 1'b1 : channel_1_vol_env - 1'b1; 
						channel_1_vol_sweep_ctr = 3'b0;
					end
					
					channel_1_vol_sweep_ctr = channel_1_vol_sweep_ctr + 1'b1;
					
				end
			
				if(len_clk & NR14[6] ) begin
					channel_1_len_ctr = channel_1_len_ctr + 1'b1;
					
					if(~|channel_1_len_ctr) begin
						NR14[7] = 1'b0;
					end
				end
				
			end


//----------------------------------------------------
//
//  Square wave channel 2
//
//----------------------------------------------------	
			if (we && addr_bus == 16'hff16) begin
				channel_2_len_ctr = data_bus_in[5:0];
			end else if (channel_2_stop) begin
				NR24[7] = 0;
			end else if(channel_2_init) begin
				channel_2_freq = {NR24[2:0], NR23};
				channel_2_vol_env = NR22[7:4];
				channel_2_vol_sweep_ctr = 3'b0;
				NR24[7] = |NR22[7:3];
			
				
				case(NR21[7:6])
					2'b00:channel_2_duty = 8'b00000001;
					2'b01:channel_2_duty = 8'b10000001;
					2'b10:channel_2_duty = 8'b10000111;
					2'b11:channel_2_duty = 8'b01111000;
				endcase
				
			end else begin
				if(sw_freq_clk ) begin
					channel_2_freq = channel_2_freq + 1'b1;
				end
				
				if(~|channel_2_freq) begin

					channel_2_out = channel_2_duty[0] ? channel_2_vol_env : 4'h0;

					channel_2_duty = {channel_2_duty[0],channel_2_duty[7:1]}; 
								
					channel_2_freq = {NR24[2:0], NR23};
			
				end 
				
				if(vol_env_clk) begin
					
					if (|channel_2_vol_env & |NR22[2:0] & channel_2_vol_sweep_ctr==NR22[2:0]) begin
						channel_2_vol_env = NR22[3] ? channel_2_vol_env + 1'b1 : channel_2_vol_env - 1'b1; 
						channel_2_vol_sweep_ctr = 3'b0;
					end
					
					channel_2_vol_sweep_ctr = channel_2_vol_sweep_ctr + 1'b1;
					
				end
			
				if(len_clk & NR24[6] ) begin
					channel_2_len_ctr = channel_2_len_ctr + 1'b1;
					
					if(~|channel_2_len_ctr) begin
						NR24[7] = 1'b0;
					end
				end
			end


//----------------------------------------------------
//
//  Wave Samples channel 3
//
//----------------------------------------------------
			if (we && addr_bus == 16'hff1b) begin
				channel_3_len_ctr = data_bus_in;
			end else if (channel_3_stop) begin
				NR34[7] = 0;
			end else if(channel_3_init) begin
				channel_3_freq = {NR34[2:0], NR33};
				
				channel_3_byte_counter = 0;
				NR34[7] = NR30[7];
			
			
			end else begin
			
	
				case(NR32[6:5])
				 2'b00: channel_3_out = 6'b0;
				 2'b01: channel_3_out = {WaveSamples[channel_3_byte_counter], 2'b0};
				 2'b10: channel_3_out = {1'b0, WaveSamples[channel_3_byte_counter], 1'b0};
				 2'b11: channel_3_out = {2'b0, WaveSamples[channel_3_byte_counter]};
				endcase		
				
				if(wave_freq_clk ) begin
					channel_3_freq = channel_3_freq + 1'b1;
								
					if(~|channel_3_freq) begin
			
						channel_3_freq = {NR34[2:0], NR33};
						
						channel_3_byte_counter = channel_3_byte_counter + 1'b1;
				
					end 
				
				end
			
				if(len_clk & NR34[6]) begin
					channel_3_len_ctr = channel_3_len_ctr + 1'b1;
					
					if(~|channel_3_len_ctr) begin
						NR34[7] = 1'b0;
					end
				end
			end

//----------------------------------------------------
//
//  White Noise channel 4
//
//----------------------------------------------------
			if (we && addr_bus == 16'hff20) begin
				channel_4_len_ctr = data_bus_in[5:0];
			end else if (channel_4_stop) begin
				NR44[7] = 0;
			end else if(channel_4_init) begin
				channel_4_vol_env = NR42[7:4];
				channel_4_vol_sweep_ctr = 3'b0;
				channel_4_lfsr = 15'h7fff;
				NR44[7] = |NR42[7:3];
			
				r_counter = 3'b0;
	
		
			end else begin
				if(r_clk ) begin
					if(r_counter == NR43[2:0]) begin

						channel_4_out = channel_4_lfsr[0] ? channel_4_vol_env : 4'h0;

						channel_4_lfsr = {channel_4_lfsr[0] ^ channel_4_lfsr[1], 
												channel_4_lfsr[14:8], 
												NR43[3] ? channel_4_lfsr[0] ^ channel_4_lfsr[1]:  channel_4_lfsr[7],
												channel_4_lfsr[6:1]}; 
									
						r_counter = 1'b0;
				
					end 
					
					r_counter = r_counter + 1'b1;
				end
		
				if(vol_env_clk) begin
					
					if ((|channel_4_vol_env) & (|NR42[2:0]) & (channel_4_vol_sweep_ctr==NR42[2:0])) begin
						channel_4_vol_env = NR42[3] ? channel_4_vol_env + 1'b1 : channel_4_vol_env - 1'b1; 
						channel_4_vol_sweep_ctr = 3'b0;
					end
					
					channel_4_vol_sweep_ctr = channel_4_vol_sweep_ctr + 1'b1;
					
				end
	
				if(len_clk & NR44[6] ) begin
					channel_4_len_ctr = channel_4_len_ctr + 1'b1;
					
					if(~|channel_4_len_ctr) begin
						NR44[7] = 1'b0;
					end
				end
			end
		end
end
endmodule

