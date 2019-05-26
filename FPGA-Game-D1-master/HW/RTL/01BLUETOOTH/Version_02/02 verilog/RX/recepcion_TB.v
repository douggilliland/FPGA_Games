module recepcion_TB;
    reg rx=1;
    wire avail;
	reg clk_in;
    wire clk_div;
	reg reset=0;
	wire [7:0] dout;

    recepcion rec(.rx(rx),.clk_in(clk_in),.reset(reset),.dout(dout),.avail(avail),.clk_div(clk_div));
 
    reg [3:0] bitpos = 0; 
    reg [3:0] counter = 0;  
    reg [7:0] data = 8'b10101010;    

     always #1 clk_in = ~clk_in;

    initial begin        
        clk_in=0;   
        reset=0;
    end

    always @(posedge clk_div)begin
    counter <= counter+1;
        if (counter >=4)begin            
            if(bitpos<=7)begin    
                rx<=data[bitpos];
                bitpos<=bitpos+1;    
            end
            else begin                           
                rx<=1; 
                if (avail==1)begin
                    counter<=0;
                    bitpos<=0;       
                end            
            end
        end        
        else if (counter<3)
            rx=1;
        else if (counter==3)
            rx=0;
    end


    initial begin: TEST_CASE

      $dumpfile("recepcion_TB.vcd");
      $dumpvars(0, recepcion_TB);


      $display("FIN de la simulacion");
      #1000000 $finish;
    end

endmodule
