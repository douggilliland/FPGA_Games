module peripheral_bt(clk , rst , d_in , cs , addr , rd , wr, d_out,  uart_tx, clk_uart );
  
  input clk;
  input rst;
  input [15:0]d_in;
  input cs;
  input [3:0]addr; // 4 LSB from j1_io_addr
  input rd;
  input wr;
  output reg [15:0]d_out;
  output clk_uart;
   output uart_tx;

//------------------------------------ regs and wires-------------------------------

reg [2:0] s; 	//selector mux_4  and demux_4

reg [7:0] d_in_uart; // data in uart

wire uart_busy;  // out_uart
wire uart_done;
//------------------------------------ regs and wires-------------------------------

transmision tx(.reset(rst), .clk(clk), .din(d_in_uart), .tx(uart_tx), .busy(uart_busy), .done(uart_done), .clk_uart(clk_f));

always @(*) begin//----address_decoder------------------
case (addr)
4'h0:begin s = (cs && wr) ? 3'b001 : 3'b000 ;end //din_uart
4'h2:begin s = (cs && rd) ? 3'b010 : 3'b000 ;end //busy
4'h4:begin s = (cs && rd) ? 3'b100 : 3'b000 ;end //done
default:begin s=3'b000 ; end
endcase
end//-----------------address_decoder--------------------





always @(negedge clk) begin//-------------------- escritura de registros

d_in_uart= (s[0]) ? d_in[7:0] : d_in_uart; // data in uart

end//------------------------------------------- escritura de registros	




always @(negedge clk) begin//-----------------------mux_4 :  multiplexa salidas del periferico
case (s)
3'b010: d_out[0]= uart_busy;	
3'b100: d_out[0]= uart_done;	


default: d_out=0;
endcase
end//----------------------------------------------mux_4

									//(addr != 4'h4): se hace para evitar escrituras fantasm

endmodule
