module	display	(
			input		[1:0]	mostrar,
			input		[3:0]	digito,
			output	reg	[3:0]	an,
			output	reg	[6:0]	seg
		);

	always@(mostrar or digito)
	begin
		case(mostrar)
			2'b01:
			begin
				an=4'b1000;
			end
			2'b10:
			begin
				an=4'b0100;
			end
			2'b11:
			begin
				an=4'b0010;
			end
			default:
			begin
				an=4'b1000;
			end
		endcase		
		case (digito)
			4'h0:    seg <= 7'b1000000;
			4'h1:    seg <= 7'b1111001;
			4'h2:    seg <= 7'b0100100;
			4'h3:    seg <= 7'b0110000;
			4'h4:    seg <= 7'b0011001;
			4'h5:    seg <= 7'b0010010;
			4'h6:    seg <= 7'b0000010;
			4'h7:    seg <= 7'b1111000;
			4'h8:    seg <= 7'b0000000;
			4'h9:    seg <= 7'b0010000;
		endcase
	end
endmodule
