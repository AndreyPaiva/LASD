module ContM10(
input clk,
input rst,
output reg [3:0] cont
);

always @(posedge clk, negedge rst)
	begin
		if(rst == 0)
			cont = 9;
		else
			begin
				if(cont == 0)
					cont = 9;
				else
					cont = cont - 1;
			end
	end
endmodule