module peripheral_bt(clk , rst , d_in , cs , addr , rd , wr, d_out,  uart_tx, uart_rx );
  
  input clk;
  input rst;
  input [15:0]d_in;
  input cs;
  input [3:0]addr; // 4 LSB from j1_io_addr
  input rd;
  input wr;
  output reg [15:0]d_out;
  output uart_rx;
   output uart_tx;

//------------------------------------ regs and wires-------------------------------

reg [5:0] s; 	//selector mux_4  and demux_4

reg uart_enable;

reg [7:0] din_uart; // data in uart
wire dout_uart;
wire uart_busy;  // out_uart
wire uart_done;
wire uart_avail;
//------------------------------------ regs and wires-------------------------------

bluetooth bt(.rx(uart_rx), .avail(uart_avail), .clk_in(clk), .reset(rst), .dout(dout_uart), .din(din_uart), .enable(uart_enable), .busy(uart_busy), .done(uart_done), .tx(uart_tx));


always @(*) begin//----address_decoder------------------
case (addr)
4'h0:begin s = (cs && wr) ? 5'b00001 : 5'b00000 ;end //din_uart
4'h2:begin s = (cs && rd) ? 5'b00010 : 5'b00000 ;end //done
4'h4:begin s = (cs && rd) ? 5'b00100 : 5'b00000 ;end //avail
4'h6:begin s = (cs && rd) ? 5'b01000 : 5'b00000 ;end //busy
4'h8:begin s = (cs && rd) ? 5'b10000 : 5'b00000 ;end //dout_uart
default:begin s=5'b00000 ; end
endcase
end//-----------------address_decoder--------------------





always @(negedge clk) begin//-------------------- escritura de registros


if (s[0]==1) begin
    din_uart<=d_in[7:0];
    uart_enable=1;
end
else begin
    if (uart_busy)
        uart_enable=0;
end
end//------------------------------------------- escritura de registros	




always @(negedge clk) begin//-----------------------mux_4 :  multiplexa salidas del periferico
case (s)
5'b00010: d_out[0]= uart_done;	
5'b00100: d_out[0]= uart_avail;
5'b01000: d_out[0]= uart_busy;	
5'b10000: d_out[7:0] = dout_uart;

default: d_out=0;
endcase
end//----------------------------------------------mux_4

									//(addr != 4'h4): se hace para evitar escrituras fantasm

endmodule
