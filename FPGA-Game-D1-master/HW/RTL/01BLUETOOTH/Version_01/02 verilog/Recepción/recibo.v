
module recibo ( input clk,
                input rw,
                input reset,
                input Rx,
                output busy, 
                output clk_blu, 
                output reg[7:0]dout 
                 
                );

wire clk_f;
Divisor_frecuencia div(.clk(clk), .clk_f(clk_f), .reset(reset));




reg[1:0]estado, estado_sig;
parameter inactivo =2'b00;
parameter inicio   =2'b01;

reg control;
reg done = 0;
reg[8:0]tmp=9'b000000000;
reg[3:0]contador=4'b0000;

//maquina de estados
always@(posedge clk_f, posedge reset)
  if(reset)estado <= inactivo;
  else estado <= estado_sig;

always@(*)
  begin

    case(estado)

      inactivo:
      if(Rx==1 && done==0)
        begin
          control=0;
          estado_sig = inactivo;
        end
      else if (Rx==0 && done==0 && rw==1)
        begin
          control=1;
          estado_sig = inicio;
        end 
      else
        begin
          control=0;
          estado_sig = inactivo;
        end

      inicio:
        begin
          if(done==0)
            begin
              control=1;
              estado_sig = inicio;
            end
          else
            begin
              control=0;
              estado_sig = inactivo;
            end
        end

      default
      estado_sig = inactivo;

    endcase

  end

//hasta aqui se describe como se pasa de un estado a otro
//ahora viene el bloque de decision que descibe de que manera capturamos la informacion


always@(posedge clk_f)
  begin
    if(control==1 && done==0)
      begin
        tmp<={Rx,tmp[8:1]};
      end
  end

always@(posedge clk_f)
  begin
    if(control)
    if(contador>=10)
      begin
        contador=0;
        done=1;
        dout<=tmp[8:1];
      end
    else 
      begin
        contador=contador+1;
        done=0;
      end
    else
      done=0;
  end

endmodule




