module controlador_TB;

reg clk;
reg mclk;
reg ws;
reg reset;
reg lr;
reg rd;
reg wr;
reg [15:0]dataint;



fifo uttf(.rd(rd),.wr(wr),.clk(clk),.reset(reset),.data_in(dataint));

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
initial
begin
rd =1'b0;
end



initial begin
#10 dataint = 10'h0a;
wr=1'b1;
#1 wr=1'b0;
#10 dataint = 10'h0c;
wr=1'b1;
#1 wr=1'b0;
#10 dataint = 10'h1;
wr=1'b1;
#1 wr=1'b0;
#10 dataint = 10'b0;
wr=1'b1;
#1 wr=1'b0;
#10 dataint = 10'h11;
wr=1'b1;
#1 wr=1'b0;
#10 dataint = 10'h1e;
wr=1'b1;
#1 wr=1'b0;

#10 rd=1'b0;
#1 rd=1'b1;
#10 rd=1'b0;
#1 rd=1'b1;
#10 rd=1'b0;
#1 rd=1'b1;
#10 rd=1'b0;
#1 rd=1'b1;
#10 rd=1'b0;
#1 rd=1'b1;
#10 rd=1'b0;
#1 rd=1'b1;
#10 rd=1'b0;
#1 rd=1'b1;
#10 rd=1'b0;
#1 rd=1'b1;

end
	
initial begin: TEST_CASE
     $dumpfile("controlador_TB.vcd");
     $dumpvars(-1, uttf);

     #(10000) $finish;
   end

endmodule //

