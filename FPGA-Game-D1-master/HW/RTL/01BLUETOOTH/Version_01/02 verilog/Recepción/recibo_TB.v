module recibo_TB();
  
                 reg clk;
                 reg clk_f;
                 reg rw;
                 reg reset;
                 reg Rx;
                 wire busy;



recibo dut(.clk(clk),.rw(rw),.busy(busy),.Rx(Rx),.reset(reset));

initial clk=0;


always #1 clk= ~clk;
initial begin
reset=1'b1;

#100
reset=1'b0;
#328000
reset = 1'b1;

end

initial begin
#20
rw=0;
#4000
rw = 1;
end
initial begin
#40
Rx = 1'b0;
#41600
Rx = 1'b1;
#20800
Rx = 1'b0;
#20800
Rx = 1'b1;
#20800
Rx = 1'b0;
#20800
Rx = 1'b1;
#20800
Rx = 1'b1;
#20800
Rx = 1'b0;
#20800
Rx = 1'b0;
end

initial begin 

$dumpfile("recibo_TB.vcd");
$dumpvars(0, recibo_TB);

$display ("fin de la simulacion");
#5000000 $finish;
end
endmodule


