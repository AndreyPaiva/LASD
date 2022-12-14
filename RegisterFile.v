module RegisterFile(
input [2:0] ra1, 
input [2:0] ra2, 
input [2:0] wa3, 
input we3,
input [7:0] wd3,
input clk,
output reg [7:0] rd1, 
output reg [7:0] rd2,
output reg [7:0] S0, S1 ,S2 ,S3 ,S4 ,S5 ,S6, S7
);

reg [7:0] register [7:0];

always @(posedge clk) 
begin
	if(we3) 
		register[wa3] <= wd3;
		register[0] <= 8'd0;
	S0 <= register[0];
	S1 <= register[1];
	S2 <= register[2];
	S3 <= register[3];
	S4 <= register[4];
	S5 <= register[5];
	S6 <= register[6];
	S7 <= register[7];
end

always @ (*) 
begin
	rd1 <= register[ra1];
	rd2 <= register[ra2];
end

endmodule 