module	controlfifo		#(
					parameter dat_width = 8,
					parameter adr_width = 4
				 )
				(
					input				clk,
					input				Rx_error,
					input		[7:0]		DATA,
					input				DONE,
					input				empty,
					input				full,
					input		[dat_width-1:0]	data_out,	
    					output  			rd, 
					output				wr,
    					output		[dat_width-1:0]	data_in,
					output		[7:0]		lose_data
				);
	reg	registro;
	initial
	begin
		registro=0;
	end
	always@(posedge clk)
	begin
		if(Rx_error)
		begin
			wr=0;
			rd=0;
		end
		else
		begin
			if(DONE)
			begin
				if(full)
				begin
					
				end
				registro = DATA;
				wr	 = 1;
				rd	 = 0;
			end
		end
		
		
	end
	
endmodule
