module microfono_TB;

reg dataint;
reg clk;
reg enable;
reg mclk;
reg ws;
reg done;
reg reset;
microfono uut(.enable(enable),.reset(reset),.dataint(dataint),.clk(clk));

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
end

initial begin
enable=0;
#10 enable=1;
end 
initial begin
dataint = 1'b0;
#40 dataint = 1'b1;
#40 dataint = 1'b0;
#40 dataint = 1'b1;
#40 dataint = 1'b0;
#40 dataint = 1'b0;
#40 dataint = 1'b1;
#40 dataint = 1'b0;
#40 dataint = 1'b1;
#40 dataint = 1'b0;
#40 dataint = 1'b1;
#40 dataint = 1'b0;
#40 dataint = 1'b1;
#40 dataint = 1'b1;
#40 dataint = 1'b0;
#40 dataint = 1'b1;
#70 dataint = 1'b0;
#650 dataint = 1'b0;
#40 dataint = 1'b1;
#40 dataint = 1'b0;
end
	
initial begin: TEST_CASE
     $dumpfile("microfono_TB.vcd");
     $dumpvars(-1, uut);
     #(10000) $finish;
   end

endmodule //

