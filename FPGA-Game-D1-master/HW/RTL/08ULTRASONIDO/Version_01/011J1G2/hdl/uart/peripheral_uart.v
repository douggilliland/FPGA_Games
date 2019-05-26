module peripheral_uart(clk , rst , d_in , cs , addr , rd , wr, d_out,  uart_tx, ledout );
  
  input clk;
  input rst;
  input [15:0]d_in;
  input cs;
  input [3:0]addr; // 4 LSB from j1_io_addr
  input rd;
  input wr;
  output reg [15:0]d_out;

   output uart_tx;
   output reg ledout=0;

//------------------------------------ regs and wires-------------------------------

reg [2:0] s; 	//selector mux_4  and demux_4

reg [7:0] d_in_uart; // data in uart

wire uart_busy;  // out_uart

//------------------------------------ regs and wires-------------------------------




always @(*) begin//----address_decoder------------------
case (addr)
4'h0:begin s = (cs && rd) ? 3'b001 : 3'b000 ;end //busy

4'h2:begin s = (cs && wr) ? 3'b010 : 3'b000 ;end //data
4'h4:begin s = (cs && wr) ? 3'b100 : 3'b000 ;end //ledout
default:begin s=3'b000 ; end
endcase
end//-----------------address_decoder--------------------





always @(negedge clk) begin//-------------------- escritura de registros

d_in_uart= (s[1]) ? d_in[7:0] : d_in_uart; // data in uart
ledout = (s[2]) ? d_in[0] : ledout;	// write ledout register

end//------------------------------------------- escritura de registros	




always @(negedge clk) begin//-----------------------mux_4 :  multiplexa salidas del periferico
case (s)
3'b001: d_out[0]= uart_busy;	// data out uart
default: d_out=0;
endcase
end//----------------------------------------------mux_4

									//(addr != 4'h4): se hace para evitar escrituras fantasma
uart uart(.uart_busy(uart_busy), .uart_tx(uart_tx), .uart_wr_i(cs && wr && (addr != 4'h4) ), .uart_dat_i(d_in_uart), .sys_clk_i(clk), .sys_rst_i(rst));// System clock, 


endmodule
