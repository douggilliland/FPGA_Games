module touchModule(
			input		[7:0]	d_in,
			input 	[3:0]	addr,
			input				cs,
			input				rd,
			input				wr,
			input 			reset,
			input				clk,
			input				Rx,
			output	[7:0]	d_out,
			output			clkOut
    );

reg [3:0]	s;
reg			d1;
reg			d0;
wire			enableTouch;
wire			disp;
wire [8:0]	d;

touch		touch0		(	enableTouch, clk, Rx, reset, d, disp, clkOut	);

always @(posedge d1)
begin
	case({addr})
		4'h6700: s[1:0]=2'b01;
		4'h6701: s[1:0]=2'b10;
		4'h6702: s[1:0]=2'b11;
	endcase
end

always @(posedge clk)
begin
	if(d0) begin
		case({addr})
			4'h6703: s[3:2]=2'b01;
			4'h6704: s[3:2]=2'b10;
		endcase
	end
end

always @(posedge clk)
begin
	case({cs,wr,rd})
		3'b101: d0<=1;
		3'b110: d1<=1;
		3'b111: 
				begin
					d1<=1;
					d0<=1;
				end
	endcase
	d0<=0;
	d1<=0;
end

endmodule
