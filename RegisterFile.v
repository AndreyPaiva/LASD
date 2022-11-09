module RegisterFile(
input [2:0] ra1, 
input [2:0] ra2, 
input [2:0] wa3, 
input we3,
input [7:0] wd3,
input clk,
output reg [7:0] rd1, 
output reg [7:0] rd2
);

reg [7:0] register [7:0];

always @(posedge clk) 
begin
	if(we3) 
		register[wa3] <= wd3;
		register[0] <= 8'd0;
end

always @ (*) 
begin
	rd1 <= register[ra1];
	rd2 <= register[ra2];
end

endmodule 