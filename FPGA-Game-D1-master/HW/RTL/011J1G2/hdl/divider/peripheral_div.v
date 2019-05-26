module peripheral_div(clk , rst , d_in , cs , addr , rd , wr, d_out );
  
  input clk;
  input rst;
  input [15:0]d_in;
  input cs;
  input [3:0]addr; // 4 LSB from j1_io_addr
  input rd;
  input wr;
  output reg [15:0]d_out;

//------------------------------------ regs and wires-------------------------------

reg [5:0] s; 	//selector mux_4  and write registers

reg [15:0] A=0;//---div_16 input registers
reg [15:0] B=0;
reg init=0;

wire [15:0] C;	//div_16 output Reg
wire done;


//------------------------------------ regs and wires-------------------------------




always @(*) begin//---address_decoder--------------------------
case (addr)
4'h0:begin s = (cs && wr) ? 6'b000001 : 6'b000000 ;end //A
4'h2:begin s = (cs && wr) ? 6'b000010 : 6'b000000 ;end //B
4'h4:begin s = (cs && wr) ? 6'b000100 : 6'b000000 ;end //init

4'h6:begin s = (cs && rd) ? 6'b001000 : 6'b000000 ;end //done
4'h8:begin s = (cs && rd) ? 6'b010000 : 6'b000000 ;end //C[15:0]
default:begin s = 6'b000000 ; end
endcase
end//-----------------address_decoder--------------------------




always @(negedge clk) begin//-------------------- escritura de registros 

A    = (s[0]) ? d_in : A;	//Write Registers
B    = (s[1]) ? d_in : B;	//Write Registers
init = s[2] ; // (s[2]) ? d_in : init;	//Write Registers

end//------------------------------------------- escritura de registros 




always @(negedge clk) begin//-----------------------mux_4 :   multiplexa salidas del periferico
case (s[5:3])
3'b001: d_out[0] = done ;
3'b010: d_out    = C ;
default: d_out   = 0 ;
endcase

end//-------------------------------------mux_4

div_16 d_16(.clk(clk), .rst(rst), .init_in(init) , .A(A), .B(B), .Result(C), .done(done));

endmodule
