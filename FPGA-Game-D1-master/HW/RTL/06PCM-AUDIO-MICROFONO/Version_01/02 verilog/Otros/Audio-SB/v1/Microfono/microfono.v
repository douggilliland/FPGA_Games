module microfono
(
	input		enable,
	input		clk,
	output reg 	[17:0]  sdata,
	output		mclk,
	output		ws,
	input		dataint,
	input		reset,
	output		done

);

reg [0:31] count;
reg [17:0] sregt;
reg done;
reg ws=0;


div_freq df(.clk(clk), .reset(reset),.clkout(mclk));

always @(negedge  mclk, posedge enable)

	if (enable) 
	begin	
		done=0;
		count<=0;
		if (count<=17)  /* guarda 18 bits */
			begin
			sregt<= {sregt[16:0],dataint};
			count<=count+1;
			end
		
		else if(dataint<=1'b0) /* Verificar que despues del bit 18 todos sean 0 */
			begin
				if(count<=31) /* Verificar 32 bits de llegada*/
				begin		
				sdata<= sregt[17:0];
				count<=count+1;
				end
				else
				begin
				ws=!ws;     /* habilita canal R/L*/
				count<=0;   
				done=1;     /* confirma que ya esta el registro del canal*/
				end								
			end	
		else
			begin
			sregt<=0; /* si despues del bit 18 no sigue un 0 se pierde el registro */
			done=1;
				
		end	
						
	end	
	else
	begin
	end



endmodule
