module altavoz_TB;

reg clk;
reg [15:0] sregt;
reg enable;
reg bclk;
reg rlclk;
reg done;
reg reset;

altavoz uut(.enable(enable),.reset(reset),.sregt(sregt),.clk(clk));

always
begin

clk =1'b1;
#2;
clk=1'b0;
#2;
end

initial
begin
reset =1'b1;
#10;
reset =1'b0;

sregt=16'b101000100101010;
#50; enable=1;
end 

	
initial begin: TEST_CASE
     $dumpfile("altavoz_TB.vcd");
     $dumpvars(-1, uut);
     #(1000) $finish;
   end

endmodule //

