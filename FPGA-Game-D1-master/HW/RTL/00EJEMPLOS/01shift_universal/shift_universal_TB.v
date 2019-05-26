module shift_universal_TB;

reg [7:0] d_s;
reg [1:0] ctrl;
reg clk;
reg reset;
shift_universal  uut(.d(d_s),.ctrl(ctrl),.reset(reset),.clk(clk));

always
begin
clk =1'b1;
#2;
clk=1'b0;
#2;
end

initial begin
d_s= 8'b10101110;

reset=1;
#4;
reset=0;
#3;
ctrl = 2'b00;
#5;
ctrl =2'b11;
#20;
ctrl =2'b01;



end


initial begin: TEST_CASE
     $dumpfile("shift_universal_TB.vcd");
     $dumpvars(-1, uut);
     #(200) $finish;
   end

endmodule //
