// diseño de una fifo ciclica, para implementar en cada  bloque de proyecto
// ferney alberto beltran 2016 electrónica digital 1 universidad Nacional

module fifo
   #(
  	parameter adr_width = 12,
	parameter dat_width = 16
   )
   (
    input  reset, clk,
    input  rd, wr,
    input  [dat_width-1:0] data_in,
    output [dat_width-1:0] data_out,
    output empty,
    output full
   );


  parameter depth = (1 << adr_width);

   //declaración de registros 
 
   reg [dat_width-1:0] array_reg [depth-1:0];// register array FIFO

   reg [adr_width-1:0] w_ptr_reg;
   reg [adr_width-1:0] w_ptr_next=0;
   reg [adr_width-1:0] r_ptr_reg, r_ptr_next=0;
   reg full_reg, empty_reg, full_next=0, empty_next=1;
   wire wr_en;
   wire rw;
  
   assign data_out = array_reg[r_ptr_reg];
   assign wr_en = wr & ~full_reg;

   assign full = full_reg;
   assign empty = empty_reg;
   assign rw = rd | wr;
   always @(posedge clk) begin
      if (wr_en)
         array_reg[w_ptr_reg] = data_in;
   end

   // fifo control logic
   // register for read and write pointers
   always @(posedge clk) begin
      if (reset)
         begin
            w_ptr_reg = 0;
            r_ptr_reg = 0;
            full_reg = 1'b0;
            empty_reg = 1'b1;
         end
      else
         begin
            w_ptr_reg = w_ptr_next;
            r_ptr_reg = r_ptr_next;
            full_reg = full_next;
            empty_reg = empty_next;
         end
   end


   
   always @(posedge rw)
   begin
      if (reset) begin
	w_ptr_next =  0;
        r_ptr_next =  0;
	full_next=0;
	empty_next =1;
      end else begin
	      full_next = full_reg;
	      empty_next = empty_reg;
	      case ({wr, rd})
		 2'b01: // read
		    if (~empty_reg) // not empty
		       begin
		          r_ptr_next = r_ptr_reg + 1;
		          full_next = 1'b0;
		          if (r_ptr_next==w_ptr_reg)
		             empty_next = 1'b1;
		       end
		 2'b10: // write
		    if (~full_reg) // not full
		       begin
		          w_ptr_next = w_ptr_reg + 1;
		          empty_next = 1'b0;
		          if (w_ptr_next==r_ptr_reg)
		             full_next = 1'b1;
		       end
		 2'b11: // write and read
		    begin
		       w_ptr_next =  w_ptr_reg + 1;
		       r_ptr_next = r_ptr_reg + 1;
		    end
	      endcase
	end
   end


  
endmodule

