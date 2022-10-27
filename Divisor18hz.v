module Divisor18hz(
input clk50M,
output reg clk18
);

reg [25:0] contador;

always @(posedge clk50M)
	begin
		if(contador == 25000000/18)
			begin
				clk18 = ~clk18;
				contador = 0;
			end
		else
			contador = contador + 1;
	end
endmodule