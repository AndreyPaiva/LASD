module ControlUnit(
input [5:0] OP,
input [5:0] Funct,
output reg Jump,
output reg MemtoReg,
output reg MemWrite,
output reg Branch,
output reg [2:0] ULAControl,
output reg ULASrc,
output reg RegDst,
output reg RegWrite
);

always @(*)begin

	if(OP == 6'b000000) begin
	
	case(Funct)
		6'b100000	:	begin //ADD
								RegWrite = 1'b1;
								RegDst = 1'b1;
								ULASrc = 1'b0;
								ULAControl = 3'b010;
								Branch = 1'b0;
								MemWrite = 1'b0;
								MemtoReg = 1'b0;
								Jump = 1'b0;
							end
							
		6'b100010	:	begin //SUB
								RegWrite = 1'b1;
								RegDst = 1'b1;
								ULASrc = 1'b0;
								ULAControl = 3'b110;
								Branch = 1'b0;
								MemWrite = 1'b0;
								MemtoReg = 1'b0;
								Jump = 1'b0;
							end
		
		6'b100100	:	begin //AND
								RegWrite = 1'b1;
								RegDst = 1'b1;
								ULASrc = 1'b0;
								ULAControl = 3'b000;
								Branch = 1'b0;
								MemWrite = 1'b0;
								MemtoReg = 1'b0;
								Jump = 1'b0;
							end
									
		6'b100101	:	begin //OR
								RegWrite = 1'b1;
								RegDst = 1'b1;
								ULASrc = 1'b0;
								ULAControl = 3'b001;
								Branch = 1'b0;
								MemWrite = 1'b0;
								MemtoReg = 1'b0;
								Jump = 1'b0;
							end
																
		6'b100111	:	begin //NOR
								RegWrite = 1'b1;
								RegDst = 1'b1;
								ULASrc = 1'b0;
								ULAControl = 3'b011;
								Branch = 1'b0;
								MemWrite = 1'b0;
								MemtoReg = 1'b0;
								Jump = 1'b0;
							end
																							
		6'b101010	:	begin //SLT
								RegWrite = 1'b1;
								RegDst = 1'b1;
								ULASrc = 1'b0;
								ULAControl = 3'b111;
								Branch = 1'b0;
								MemWrite = 1'b0;
								MemtoReg = 1'b0;
								Jump = 1'b0;
							end
							
		default		:	begin
								RegWrite = 1'b0;
								RegDst = 1'b0;
								ULASrc = 1'b0;
								ULAControl = 3'b000;
								Branch = 1'b0;
								MemWrite = 1'b0;
								MemtoReg = 1'b0;
								Jump = 1'b0;
							end
							
	endcase
	
	end
	
	else begin
	
		case(OP)
			6'b100011	:	begin //LW
									RegWrite = 1'b1;
									RegDst = 1'b0;
									ULASrc = 1'b1;
									ULAControl = 3'b010;
									Branch = 1'b0;
									MemWrite = 1'b0;
									MemtoReg = 1'b1;
									Jump = 1'b0;
								end
			
			6'b101011	:	begin //SW
									RegWrite = 1'b0;
									RegDst = 1'bx;
									ULASrc = 1'b1;
									ULAControl = 3'b010;
									Branch = 1'b0;
									MemWrite = 1'b1;
									MemtoReg = 1'bx;
									Jump = 1'b0;
								end
					
			6'b000100	:	begin //BEQ
									RegWrite = 1'b0;
									RegDst = 1'bx;
									ULASrc = 1'b0;
									ULAControl = 3'b110;
									Branch = 1'b1;
									MemWrite = 1'b0;
									MemtoReg = 1'bx;
									Jump = 1'b0;
								end					
							
			6'b001000	:	begin //ADDi
									RegWrite = 1'b1;
									RegDst = 1'b0;
									ULASrc = 1'b1;
									ULAControl = 3'b010;
									Branch = 1'b0;
									MemWrite = 1'b0;
									MemtoReg = 1'b0;
									Jump = 1'b0;
								end
									
			6'b000010	:	begin //J
									RegWrite = 1'b0;
									RegDst = 1'bx;
									ULASrc = 1'bx;
									ULAControl = 3'bxxx;
									Branch = 1'bx;
									MemWrite = 1'b0;
									MemtoReg = 1'bx;
									Jump = 1'b1;
								end
								
			default		:	begin 
									RegWrite = 1'b0;
									RegDst = 1'b0;
									ULASrc = 1'b0;
									ULAControl = 3'b000;
									Branch = 1'b0;
									MemWrite = 1'b0;
									MemtoReg = 1'b0;
									Jump = 1'b0;
								end	
								
		endcase
	end
end

endmodule