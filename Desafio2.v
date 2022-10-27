module Desafio2(
input clk,
output reg [17:0] leds
);

reg sentido;

always @(posedge clk)
	begin
		if(!sentido)
			case(leds)
				18'b000000000000000000	:	leds = 18'b100000000000000000;
				18'b000000000000000001	:	sentido = ~sentido;
				default	:	leds = leds >> 1;
			endcase
		else
			case(leds)
				18'b100000000000000000	:	sentido = ~sentido;
				default	:	leds = leds << 1;
			endcase
	end
endmodule
			
				