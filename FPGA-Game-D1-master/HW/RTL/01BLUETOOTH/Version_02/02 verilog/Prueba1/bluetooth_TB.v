module bluetooth_TB;
    reg rx=1;
    wire avail;
	reg clk_in;
    wire clk_div;
	reg reset=0;
	wire [7:0] dout;
    reg enable=0;
    wire busy;
    wire done;
    wire tx;

    bluetooth bt(.rx(rx),.clk_in(clk_in),.reset(reset),.dout(dout),.avail(avail),.clk_div(clk_div),.enable(enable),.busy(busy),.done(done),.tx(tx));

    reg [3:0] bitpos = 0; 
    reg [3:0] counter = 0;  
    reg [19:0]count=0;
    reg [7:0] data = 8'b0;

     always #1 clk_in = ~clk_in;

    initial begin        
        clk_in=0;   
        reset=0;
    end

    always @(posedge clk_in)begin
        count<=count+1;
        if(count<=150000)
            data<=8'b10101010;
        else
            data<=8'b11110000;
            
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
                if (avail)begin
                    counter<=0;
                    bitpos<=0;
                    enable<=1;      
                end
            end
        end    
        else if (counter<3)            
            rx=1;
            if(counter<1)
                enable<=0;
        else if (counter==3)
            rx=0; 
    end


    initial begin: TEST_CASE

      $dumpfile("bluetooth_TB.vcd");
      $dumpvars(0, bluetooth_TB);


      $display("FIN de la simulacion");
      #1000000 $finish;
    end

endmodule
