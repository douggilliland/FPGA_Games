module shift_universal #(parameter N=8)(input clk, input reset,input [N-1:0] d, input [1:0]ctrl, output [N-1:0] q);


// declaracion  de  variables
reg [N-1:0] r_reg;
reg [N-1:0] r_next;

//register
always @(posedge clk, posedge reset)
begin
if (reset)
	r_reg<=0;
else
	r_reg<=r_next;

end 
//Next_state
always  @(posedge reset, posedge clk)
begin
if(reset)
	r_next<=0;
else	
	case(ctrl)
	2'b00:r_next<=r_reg;
	2'b01:r_next<={r_reg[N-2:0], d[0]};
	2'b10:r_next<={d[N-1],r_reg[N-1:1]};
	2'b11: r_next<=d;
	endcase

end
// salida

assign q=r_reg ;




endmodule 
