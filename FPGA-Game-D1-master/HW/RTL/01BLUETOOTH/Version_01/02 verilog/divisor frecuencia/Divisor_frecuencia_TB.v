module Divisor_frecuencia_TB;
reg clk =0;
reg reset;

Divisor_frecuencia uut(.clk(clk), .reset(reset));

always #1 clk = ~clk;

initial begin
reset=1;
#40;
reset=0;  
end

initial begin: TEST_CASE
     $dumpfile("Divisor_frecuencia_TB.vcd");
     $dumpvars(-1, uut);
     #(1000000) $finish;
   end
endmodule
