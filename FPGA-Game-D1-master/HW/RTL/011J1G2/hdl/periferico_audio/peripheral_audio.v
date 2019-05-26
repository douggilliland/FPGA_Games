module peripheral_audio(clk , rst , d_in , cs,wr,rd , addr, d_out, mclk, ledres, micLRSel,micData );

  input clk;
  input rst;
  input [15:0] d_in;
  input cs;
  input wr;
  input rd;
  input [3:0]addr; // 4 LSB from j1_io_addr
  output reg [15:0]d_out;
  output ledres;
  output mclk;
  output micLRSel;
  input  micData; 
 
  wire doutmic;
  wire full;
  wire empty; 
  reg enable;	 



//------------------------------------ regs and wires-------------------------------

reg [2:0] s; 	//selector mux_4  and demux_4


//------------------------------------ regs and wires-------------------------------

microfono mic(.reset(rst),.clk(clk),.micLRSel(micLRSel),.empty(empty),.mclk(mclk),.micData(micData),.ledres(ledres),.enable(enable),.full(full));

always @(*) begin//----address_decoder------------------
case (addr)
4'h0:begin s = (cs && wr) ? 3'b001 : 3'b000 ;end //enable
4'h2:begin s = (cs && rd) ? 3'b010 : 3'b000 ;end //full
4'h4:begin s = (cs && rd) ? 3'b100 : 3'b000 ;end //empty
4'h8:begin s = (cs && rd) ? 3'b111 : 3'b000 ;end //dout
default:begin s=3'b000 ; end
endcase
end//-----------------address_decoder--------------------




always @(negedge clk) begin//-------------------- escritura de registros
if (s[0]==1) begin
    enable=1;
   
end
else begin
    enable=0;
end
end//------------------------------------------- escritura de registros	




always @(negedge clk) begin//-----------------------mux_4 :  multiplexa salidas del periferico
case (s)
3'b010: d_out[0]= full;	
3'b100: d_out[0]= empty;
3'b111: d_out[0]= dout;
default: d_out=0;
endcase
end//----------------------------------------------mux_4

									//(addr != 4'h4): se hace para evitar escrituras fantasm

endmodule
