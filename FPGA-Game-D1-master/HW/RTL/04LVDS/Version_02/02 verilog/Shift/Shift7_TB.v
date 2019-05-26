module Shift7_TB;

reg clk;
reg reset;
reg flag;
reg [6:0] di;
Shift7 uut(.clkS(clk), .reset(reset), .flag(flag), .Din(di));

always
begin
clk=1'b1;
flag=0;
#1;
clk=1'b0;
flag=1;
#1;
end

initial begin
di=7'b1010111;
reset=1;
#1;
reset=0;
#1;
end

initial begin: TEST_CASE

     $dumpfile("Shift7_TB.vcd");
     $dumpvars(-1, uut);
     #(200) $finish;
end
endmodule
