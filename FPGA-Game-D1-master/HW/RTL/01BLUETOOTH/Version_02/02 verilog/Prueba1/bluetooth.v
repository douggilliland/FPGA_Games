module bluetooth(input rx,
                 output avail, 
                 input clk_in,
                 input reset,
                 output [7:0] dout,
                 input enable,
                 output busy,
                 output done,
                 output tx);



wire clk_div;
Divisor_Frecuencia div(.clk_in(clk_in), .clk_div(clk_div), .reset(reset));

recepcion rcp(.rx(rx),.avail(avail),.dout(dout),.clk_div(clk_div));

transmision trs(.enable(enable),.dout(dout),.busy(busy),.done(done),.clk_div(clk_div),.tx(tx));


endmodule


