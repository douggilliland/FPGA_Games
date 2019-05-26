module m_ra (reset,bclk,done,lrclk,act);

	// Declaracion de variables

	input wire reset;
	input wire bclk;
	output reg done;
	output reg lrclk;
	output reg act;
	integer count=0;

	//Registro ACUMULADOR

	always @(posedge bclk or posedge reset)
		begin
		if (reset)
			begin
				count <=0;
				lrclk <=0;
				done=0;
				act=0;
			end
		else if(count < 16)
				begin
				if(count==0) begin
					act <=1;
					count=count+1;
				end
				else begin
				count = count+1;
				lrclk <= lrclk;
				act=0;
				end
				end
			else
				begin
				lrclk <= ~lrclk;     
				count <= 0;   
				done <= 1;
				end 
			
	end
endmodule
