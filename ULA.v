module ULA(
input [7:0] SrcA,
input [7:0] SrcB, 
input [2:0] ULAControl, 
output Z,
output reg [7:0] ULAResult
);

always @(*)
begin
	case(ULAControl)
		3'b000	:	ULAResult = SrcA & SrcB;
		3'b001	:	ULAResult = SrcA | SrcB;
		3'b010	:	ULAResult = SrcA + SrcB;
		3'b011	:	ULAResult = ~(SrcA | SrcB);
		3'b110	:	ULAResult = SrcA + ~SrcB + 8'd1;
		3'b111	:	ULAResult = SrcA < SrcB ? 1 : 0;
	endcase
end
	
	assign Z = (ULAResult == 8'd0);
	
endmodule
		
