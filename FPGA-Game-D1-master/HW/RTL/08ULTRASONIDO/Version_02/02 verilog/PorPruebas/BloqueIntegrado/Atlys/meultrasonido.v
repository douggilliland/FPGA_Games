module  meultrasonido  (
                            input	CLKOUT2,
                            input	orden,
                            output	reg	ENABLE,
                            output	reg	reset
                          );
	always@(posedge CLKOUT2)
	begin
	case(orden)
		1'b0:	
		begin
			ENABLE <=  0;
	      		reset  <=  1;
		end
		1'b1:
		begin
			reset  <=  0;
	     		ENABLE <=  1;
		end
		default:
		begin
			reset  <=  0;
	     		ENABLE <=  0;
		end
	endcase
	end
endmodule
