module Divisor_Frecuencia_TB;
reg clk_in=0;
reg reset;

Divisor_Frecuencia uut(.clk_in(clk_in), .reset(reset));

always #1 clk_in = ~clk_in;

initial begin
reset=1;
#1000;
reset=0;  
end

initial begin: TEST_CASE
     $dumpfile("Divisor_Frecuencia_TB.vcd");
     $dumpvars(-1, uut);
     #(1000000) $finish;
   end
endmodule
