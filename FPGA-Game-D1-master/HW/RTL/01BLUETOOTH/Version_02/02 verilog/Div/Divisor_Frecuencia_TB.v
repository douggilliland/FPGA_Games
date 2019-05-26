module Divisor_Frecuencia_TB;
reg clk_in=0;
reg reset;

Divisor_Frecuencia uut(.clk_in(clk_in), .reset(reset));

always #1 clk_in = ~clk_in;

initial begin
<<<<<<< HEAD
//reset=1;
//#10000;
=======
reset=1;
#10000;
>>>>>>> 689bd523948913939d4bb33f6c61e2ba807c0dab
reset=0;  
end

initial begin: TEST_CASE
     $dumpfile("Divisor_Frecuencia_TB.vcd");
     $dumpvars(-1, uut);
     #(1000000) $finish;
   end
endmodule
