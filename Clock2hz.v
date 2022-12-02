module Clock2Hz(
input clk50M,
output reg clk2
);

reg [25:0] contador;

always @(posedge clk50M)
	begin
		if(contador == 25000000/2)
			begin
				clk2 = ~clk2;
				contador = 0;
			end
		else
			contador = contador + 1;
	end
endmodule