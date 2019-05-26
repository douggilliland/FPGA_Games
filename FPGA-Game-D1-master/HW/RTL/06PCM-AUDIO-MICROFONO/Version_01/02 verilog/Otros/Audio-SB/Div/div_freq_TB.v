module div_freq_TB;

  reg clk=0;
 reg reset;
div_freq uut(.clk(clk), .reset(reset));

always #1 clk = ~clk;

initial begin
reset=0;
#40;
reset=1;  
end


always clk = #1 ~clk;

initial begin: TEST_CASE
     $dumpfile("div_freq_TB.vcd");
     $dumpvars(-1, uut);
     #(1000000) $finish;
   end

endmodule //
