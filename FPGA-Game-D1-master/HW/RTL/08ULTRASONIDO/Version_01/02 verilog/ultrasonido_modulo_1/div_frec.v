module div_frec (input wire clk , output reg out_clk);
//Divisor de frecuencia 1/10
//Lo que permite tener un periodo T=10uS
reg [3:0] t;

initial t = 0;

always @ (posedge clk) begin
	if (t < 9)
		t <= t + 1;
	else  
		t <= 0;
end

always @ (t) begin
	if (t < 5)
		out_clk <= 1;
	else
		out_clk <= 0;
end
  
endmodule