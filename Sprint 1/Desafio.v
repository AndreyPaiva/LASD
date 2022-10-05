module Desafio(input [3:0]SW1, input [7:4]SW2, input [17:16]SW3, output reg [3:0]LEDR);
  always @(*)
    begin
      case(SW3)
        2'b00	:	LEDR = SW1 + SW2;
        2'b01	:	LEDR = SW1 - SW2;
        2'b10	:	LEDR = SW1 >> SW2;
        2'b11	:	LEDR = SW1 << SW2;
      endcase
    end
endmodule