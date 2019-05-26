module j1soc#(
              //parameter   bootram_file     = "../../firmware/hello_world/j1.mem"    // For synthesis            
              parameter   bootram_file     = "../firmware/Hello_World/j1.mem"       // For simulation         
)
    (uart_tx, ledout,
   sys_clk_i, sys_rst_i,
    bt_tx, bt_rx,ledres,mclk,micLRSel,micData, ampPWM,ampSD);

   input sys_clk_i, sys_rst_i;
   output uart_tx;
   output ledout;
    input bt_rx;
    output bt_tx;
    output mclk;
    output ledres;
    output micLRSel;
    input micData;
    output trigg;
    input echo;

//------------------------------------ regs and wires-------------------------------

   wire                 j1_io_rd;//********************** J1
   wire                 j1_io_wr;//********************** J1
   wire                 [15:0] j1_io_addr;//************* J1
   reg                  [15:0] j1_io_din;//************** J1
   wire                 [15:0] j1_io_dout;//************* J1


 
   reg [1:8]cs;  // CHIP-SELECT

   wire			[15:0] mult_dout;  
   wire			[15:0] div_dout;
   wire			uart_dout;	// misma señal que uart_busy from uart.v
   wire			[15:0] dp_ram_dout;
   wire         [15:0] bt_dout;
   wire         [15:0] audio_dout;
   wire		[15:0] ultra_dout;
 

//------------------------------------ regs and wires-------------------------------


  j1 #(bootram_file)  cpu0(sys_clk_i, sys_rst_i, j1_io_din, j1_io_rd, j1_io_wr, j1_io_addr, j1_io_dout);

  peripheral_mult  per_m (.clk(sys_clk_i), .rst(sys_rst_i), .d_in(j1_io_dout), .cs(cs[5]), .addr(j1_io_addr[3:0]), .rd(j1_io_rd), .wr(j1_io_wr), .d_out(mult_dout) );

  peripheral_div  per_d (.clk(sys_clk_i), .rst(sys_rst_i), .d_in(j1_io_dout), .cs(cs[6]), .addr(j1_io_addr[3:0]), .rd(j1_io_rd), .wr(j1_io_wr), .d_out(div_dout));

  peripheral_uart  per_u (.clk(sys_clk_i), .rst(sys_rst_i), .d_in(j1_io_dout), .cs(cs[7]), .addr(j1_io_addr[3:0]), .rd(j1_io_rd), .wr(j1_io_wr), .d_out(uart_dout), .uart_tx(uart_tx), .ledout(ledout));

 peripheral_bt  per_bt (.clk(sys_clk_i), .rst(sys_rst_i), .d_in(j1_io_dout), .cs(cs[8]), .addr(j1_io_addr[3:0]), .rd(j1_io_rd), .wr(j1_io_wr), .d_out(bt_dout), .uart_tx(bt_tx), .uart_rx(bt_rx));

 peripheral_audio  per_audio (.clk(sys_clk_i), .rst(sys_rst_i), .d_in(j1_io_dout), .cs(cs[3]), .addr(j1_io_addr[3:0]), .rd(j1_io_rd), .wr(j1_io_wr), .d_out(audio_dout),.mclk(mclk),. ledres(ledres),. micLRSel(micl),.micData(micData)  );
 peripheral_altavoz  per_altavoz (.clk(sys_clk_i), .rst(sys_rst_i), .d_in(j1_io_dout), .cs(cs[1]), .addr(j1_io_addr[3:0]), .rd(j1_io_rd), .wr(j1_io_wr), .d_out(audio_dout),.mclk(mclk),. ledres(ledres),. ampPWM(ampPWM),.ampSD(ampSD)  );


  peripheral_ultra per_ultra ( .clk(sys_clk_i) , .rst(sys_rst_i) , .d_in(j1_io_dout) , .cs(cs[2]) , .addr(j1_io_addr[3:0]) , .rd(j1_io_rd) , .wr(j1_io_wr), .d_out(ultra_dout),  .trigg(trigg), .echo(echo) )


  dpRAM_interface dpRm(.clk(sys_clk_i), .d_in(j1_io_dout), .cs(cs[9]), .addr(j1_io_addr[7:0]), .rd(j1_io_rd), .wr(j1_io_wr), .d_out(dp_ram_dout));


  // ============== Chip_Select (Addres decoder) ========================  // se hace con los 8 bits mas significativos de j1_io_addr
  always @*
  begin
      case (j1_io_addr[15:8])
	8'h63: cs= 8'b10000000;	// direcciones - altavoz
	8'h64: cs= 8'b01000000; 		//ultra
	8'h65: cs= 8'b00100000; 		//audio
        8'h66: cs= 8'b00010000; 		//bt
        8'h67: cs= 8'b00001000; 		//mult
        8'h68: cs= 8'b00000100;		//div
        8'h69: cs= 8'b00000010;		//uart
        8'h70: cs= 8'b00000001;		//dp_ram
        default: cs= 8'b0000000;
      endcase
  end
  // ============== Chip_Select (Addres decoder) ========================  //




  // ============== MUX ========================  // se encarga de lecturas del J1
  always @*
  begin
      case (cs)  
	8'b10000000: j1_io_din = pwm_dout; 	
	8'b01000000: j1_io_din = ultra_dout;
	8'b00100000: j1_io_din = audio_dout;
        8'b00010000: j1_io_din = bt_dout; 
        8'b00001000: j1_io_din = mult_dout; 
        8'b00000100: j1_io_din = div_dout;
        8'b00000010: j1_io_din = uart_dout; 
        8'b00000001: j1_io_din = dp_ram_dout; 
        default: j1_io_din = 16'h0666;
      endcase
  end
 // ============== MUX ========================  // 

endmodule // top
