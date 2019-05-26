module peripheral_adc(input clk_in,
                      input cs,
                      input wr
                      input rd,
                      input din,
                      input rst,
                      input reg [3:0]addr,
                      output reg [7:0]d_out,
                      output clk_div, //ns
                      output done); //ns
                      
// regs and wires :v

reg [3:0] s;

wire clk_div; //clk_div
wire done; //done
wire dout; //d0 :v

// regs and wires :v

adc ad(.Din(din), .clk_in(clk_in), .reset(rst), .D0f(dout), .clk_div(clk_div), .done(done), .rd(rd));

//addr decoder

always @(*) begin
case (addr)
4'h0:begin s = (cs && rd) ? 3'b001 : 5'b000 ;end //clk_div
4'h2:begin s = (cs && rd) ? 3'b010 : 5'b000 ;end //done
4'h4:begin s = (cs && rd) ? 3'b100 : 5'b000 ;end //D0
default:begin s=3'b000 ; end
endcase
end

//addre decoder                        

always @(negedge clk) begin//-----------------------mux_4 :  multiplexa salidas del periferico
case (s)
3'b001: d_out[0]= clk_div;	
3'b010: d_out[0]= done;
3'b100: d_out[7:0]= dout;	

default: d_out=0;
endcase
end


endmodule
