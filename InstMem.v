module InstMem(
input [7:0] A,
output reg [31:0] RD
);

always @(*) begin
	case(A)
		8'd0	:	RD = 32'b_001000_00000_00001_00000_00000_000011;
		8'd1	:	RD = 32'b_001000_00000_00010_00000_00000_001001;
		8'd2	:	RD = 32'b_000000_00001_00010_00010_00000_100000;
		8'd3	:	RD = 32'b_000000_00001_00010_00011_00000_100100;
		8'd4	:	RD = 32'b_000000_00001_00010_00100_00000_100101;
		8'd5	:	RD = 32'b_000000_00001_00010_00101_00000_100111;
		8'd6	:	RD = 32'b_000000_00101_00100_00110_00000_101010;
		//desafio
		8'd7	:	RD = 32'b_001000_00000_00001_00000_00011_001010;
		8'd8	:	RD = 32'b_001000_00000_00010_00000_00001_110110;
		8'd9	:	RD = 32'b_000000_00001_00001_00011_00000_100111;
		8'd10	:	RD = 32'b_000000_00010_00010_00100_00000_100111;
		8'd11	:	RD = 32'b_000000_00001_00010_00101_00000_100111;
		8'd12	:	RD = 32'b_000000_00011_00100_00110_00000_100111;
		8'd13	:	RD = 32'b_000000_00101_00110_00111_00000_100111;
		
		default	:	RD = 0;
	endcase
end

endmodule