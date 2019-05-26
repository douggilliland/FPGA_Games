module fifo # (parameter abits = 3800, dbits = 1)(
    input  reset, clock,
    input  rd, wr,
    input  [dbits-1:0] din,
    output [dbits-1:0] dout,
    output empty,
    output full
    //output reg ledres
    );



wire db_wr, db_rd;
//reg dffw1, dffw2, dffr1, dffr2;
reg [dbits-1:0] out;
//initial ledres = 0;

//always @ (posedge clock) dffw1 <= wr; 
//always @ (posedge clock) dffw2 <= dffw1;
 
assign db_wr = wr; //monostable multivibrator to detect only one pulse of the button
 
//always @ (posedge clock) dffr1 <= rd;
//always @ (posedge clock) dffr2 <= dffr1;
 
assign db_rd = rd; //monostable multivibrator to detect only one pulse of the button
 
 
reg [dbits-1:0] regarray[2**abits-1:0]; //number of words in fifo = 2^(number of address bits)
reg [abits-1:0] wr_reg, wr_next, wr_succ; //points to the register that needs to be written to
reg [abits-1:0] rd_reg, rd_next, rd_succ; //points to the register that needs to be read from
reg full_reg, empty_reg, full_next, empty_next;
 
assign wr_en = db_wr & ~full; //only write if write signal is high and fifo is not full
 
//always block for write operation
always @ (posedge clock)
 begin
  if(wr_en)
	begin
   regarray[wr_reg] <= din;  //at wr_reg location of regarray store what is given at din
   out <= regarray[rd_reg];
 end
 end
  
//always block for read operation
//always @ (posedge clock)
 //begin
  //if(db_rd)
   //out <= regarray[rd_reg];
 //end

always @ (posedge clock or posedge reset)
 begin
  if (reset)
   begin
   
   wr_reg <= 0;
   rd_reg <= 0;
   full_reg <= 1'b0;
   empty_reg <= 1'b1;
   //ledres=0;
   end
   
  else
   begin
   wr_reg <= wr_next; //created the next registers to avoid the error of mixing blocking and non blocking assignment to the same signal
   rd_reg <= rd_next;
   full_reg <= full_next;
   empty_reg <= empty_next;
   //ledres=1;
   end
 end
  
always @(*)
 begin
  wr_succ = wr_reg + 1; //assigned to new value as wr_next cannot be tested for in same always block
  rd_succ = rd_reg + 1; //assigned to new value as rd_next cannot be tested for in same always block
  wr_next = wr_reg;  //defaults state stays the same
  rd_next = rd_reg;  //defaults state stays the same
  full_next = full_reg;  //defaults state stays the same
  empty_next = empty_reg;  //defaults state stays the same
   
   case({db_wr,db_rd})
    //2'b00: do nothing LOL..
     
    2'b01: //read
     begin
      if(~empty) //if fifo is not empty continue
       begin
        rd_next = rd_succ;
        full_next = 1'b0;
       if(rd_succ == wr_reg) //all data has been read
         empty_next = 1'b1;  //its empty again
       end
     end
2'b10: //write
     begin
       
      if(~full) //if fifo is not full continue
       begin
        wr_next = wr_succ;
        empty_next = 1'b0;
        if(wr_succ == (2**abits-1)) //all registers have been written to
         full_next = 1'b1;   //its full now
       end
     end
      
    2'b11: //read and write
     begin
      wr_next = wr_succ;
      rd_next = rd_succ;
     end
     //no empty or full flag will be checked for or asserted in this state since data is being written to and read from together it can  not get full in this state.
    endcase
    
 
 end
 
assign full = full_reg;
assign empty = empty_reg;
assign dout = out;
endmodule



