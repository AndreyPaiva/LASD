module DivFrequencia(
input clk50M,
output reg clk1
);

reg [25:0] contador;

always @(posedge clk50M)
	begin
		if(contador == 25000000)
			begin
				clk1 = ~clk1;
				contador = 0;
			end
		else
			contador = contador + 1;
	end
endmodule