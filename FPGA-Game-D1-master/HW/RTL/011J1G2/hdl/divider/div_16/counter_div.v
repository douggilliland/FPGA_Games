module counter_div (clk , rst, DEC, z);

  input clk;
  input rst;
  input DEC;
  output reg z;

  reg [4:0] cont=16;


always @(negedge clk) begin


  if (rst) 
   cont = 5'b10000; //16
  else
     begin
      if (DEC) cont=cont-1;
      else cont=cont;
     end

 z = (cont==0) ? 1 : 0 ;


end

endmodule
