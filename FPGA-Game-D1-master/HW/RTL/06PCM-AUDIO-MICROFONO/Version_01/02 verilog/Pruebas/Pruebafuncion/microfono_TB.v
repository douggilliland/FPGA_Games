
module microfono_TB;

reg reset, clk, micData;     

microfono uut(.reset(reset),.micData(micData),.clk(clk));

always
begin

clk =1'b1;
#2;
clk=1'b0;
#2;
end

initial
begin
reset =1'b0;
#10;
reset =1'b1;

end


initial begin
micData = 1'b0;
#100 micData = 1'b1;
#150 micData = 1'b0;
#150 micData = 1'b1;
#150 micData = 1'b0;
#150 micData = 1'b0;
#150 micData = 1'b1;
#150 micData = 1'b0;
#150 micData = 1'b1;
end
	
initial begin: TEST_CASE
     $dumpfile("microfono_TB.vcd");
     $dumpvars(-1, uut);
     #(10000) $finish;
   end

endmodule //

