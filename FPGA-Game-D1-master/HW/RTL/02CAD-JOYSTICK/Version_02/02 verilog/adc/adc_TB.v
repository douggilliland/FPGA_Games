module adc_TB;
reg Din=0;
reg clk_in;
wire clk_div;
reg reset=0;
wire [7:0] D0;

    adc rec(.Din(Din), .reset(reset), .clk_in(clk_in), .clk_div(clk_div), .done(done));
 
    reg [7:0] dato = 8'b00110011;
    reg [3:0] counter = 0;    
    reg [3:0] bitpos = 0; 
     always #1 clk_in = ~clk_in;

    initial begin        
        clk_in=0;	
reset=1;	
#100 
reset=0;
    end
    always @(negedge clk_div)begin
            counter <= counter+1;
            if(bitpos<=7)begin    
                Din<=dato[bitpos];
                bitpos<=bitpos+1;    
            end
            else begin                           
            if (done==1)begin
                 counter<=0;
                 bitpos<=1; 
		 Din<=1;
                end           
       end        
       
    end


   initial begin: TEST_CASE

      $dumpfile("adc_TB.vcd");
      $dumpvars(0, adc_TB);


      $display("FIN de la simulacion");
      #1000000 $finish;
    end
     endmodule
