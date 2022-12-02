`default_nettype none //Comando para desabilitar declaração automática de wires
module Mod_Teste (
//Clocks
input CLOCK_27, CLOCK_50,
//Chaves e Botoes
input [3:0] KEY,
input [17:0] SW,
//Displays de 7 seg e LEDs
output [0:6] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7,
output [8:0] LEDG,
output [17:0] LEDR,
//Serial
output UART_TXD,
input UART_RXD,
inout [7:0] LCD_DATA,
output LCD_ON, LCD_BLON, LCD_RW, LCD_EN, LCD_RS,
//GPIO
inout [35:0] GPIO_0, GPIO_1
);
assign GPIO_1 = 36'hzzzzzzzzz;
assign GPIO_0 = 36'hzzzzzzzzz;
assign LCD_ON = 1'b1;
assign LCD_BLON = 1'b1;
wire [7:0] w_d0x0, w_d0x1, w_d0x2, w_d0x3, w_d0x4, w_d0x5,
w_d1x0, w_d1x1, w_d1x2, w_d1x3, w_d1x4, w_d1x5;
LCD_TEST MyLCD (
.iCLK ( CLOCK_50 ),
.iRST_N ( KEY[0] ),
.d0x0(w_d0x0),.d0x1(w_d0x1),.d0x2(w_d0x2),.d0x3(w_d0x3),.d0x4(w_d0x4),.d0x5(w_d0x5),
.d1x0(w_d1x0),.d1x1(w_d1x1),.d1x2(w_d1x2),.d1x3(w_d1x3),.d1x4(w_d1x4),.d1x5(w_d1x5),
.LCD_DATA( LCD_DATA ),
.LCD_RW ( LCD_RW ),
.LCD_EN ( LCD_EN ),
.LCD_RS ( LCD_RS )
);
//---------- modifique a partir daqui --------
/* Sprint 1
assign LEDG[0]=KEY[1];

assign LEDR[3:0] = SW[17]?SW[3:0]-SW[7:4]:SW[3:0]+SW[7:4];

assign LEDR[3:0] = SW[17]?(SW[16]?SW[3:0]<<SW[7:4] : SW[3:0]>>SW[7:4]):(SW[16]?SW[3:0]-SW[7:4] : SW[3:0] + SW[7:4]);
*/

/* Sprint 2
wire clock;
wire [3:0] num;
wire clock18hz;

assign HEX0[0:6] = SW[6:0];

DecodificadorHexa7Seg decod(SW[11:8], HEX3[0:6]);

DivFrequencia divisor(CLOCK_50, clock);

assign LEDG[0] = clock;

ContM10 contador(clock, KEY[1], num);

DecodificadorHexa7Seg display(num, HEX4[0:6]);

Divisor18hz div(CLOCK_50, clock18hz);

assign LEDG[1] = clock18hz;

Desafio2 desafio(clock18hz, LEDR[17:0]);
*/

/* Sprint 3
assign LEDG[8] = ~KEY[1];
DecodificadorHexa7Seg hexa0(SW[3:0], HEX0[0:6]);
DecodificadorHexa7Seg hexa1(SW[7:4], HEX1[0:6]);
RegisterFile banco(SW[13:11], SW[10:8], SW[16:14], SW[17], SW[7:0], ~KEY[1], w_d0x0[7:0], w_d0x1[7:0]);
*/

/* Sprint 4
wire [7:0] w_rd1SrcA;
wire [7:0] w_rd2;
wire [7:0] w_ScrB;
wire [7:0] w_ULAResultWd3;
assign LEDG[8] = ~KEY[1];

DecodificadorHexa7Seg hexa0(SW[3:0], HEX0[0:6]);
DecodificadorHexa7Seg hexa1(SW[7:4], HEX1[0:6]);

RegisterFile register(.ra1(SW[13:11]), .ra2(3'b010), .wa3(SW[16:14]), .we3(1'b1), .wd3(SW[7:0]), .clk(~KEY[1]), .rd1(w_rd1SrcA[7:0]), .rd2(w_rd2[7:0]));

assign w_ScrB = SW[17]	?	8'h07	:	w_rd2;
assign w_d0x0[7:0] = w_rd1SrcA[7:0];
assign w_d1x0[7:0] = w_rd2[7:0];
assign w_d1x1[7:0] = w_ScrB[7:0];

ULA ula(.SrcA(w_rd1SrcA[7:0]), .SrcB(w_ScrB[7:0]), .ULAControl(SW[10:8]), .Z(LEDG[0]), .ULAResult(w_ULAResultWd3[7:0]));

assign w_d0x4[7:0] = w_ULAResultWd3[7:0];
*/

/* Sprint 5
wire w_ULASrc, w_RegWrite, w_RegDst;
wire [2:0] w_ULAControl, w_wa3;
wire [7:0] w_PCp1, w_PC, w_rd1SrcA, w_rd2, w_SrcB, w_ULAResultWd3;
wire [31:0] w_Inst;



PC pc(.PCin(w_PCp1[7:0]), .clk(KEY[1]), .PC(w_PC[7:0]));
InstMem memoria(.A(w_PC[7:0]), .RD(w_Inst[31:0]));
ControlUnit controle(.OP(w_Inst[31:26]), .Funct(w_Inst[5:0]), .Jump(LEDR[0]), .MemtoReg(LEDR[1]), .MemWrite(LEDR[2]), .Branch(LEDR[3]), .ULAControl(w_ULAControl[2:0]), .ULASrc(w_ULASrc), .RegDst(w_RegDst), .RegWrite(w_RegWrite));assign w_d0x4[7:0] = w_PC[7:0];
assign LEDR[6:4] = w_ULAControl[2:0];
assign LEDR[7] = w_ULASrc;
assign LEDR[8] = w_RegDst;
assign LEDR[9] = w_RegWrite;
assign w_wa3[2:0] = w_RegDst	?	w_Inst[15:11]	:	w_Inst[20:16];
assign w_PCp1[7:0] = w_PC[7:0] + 1;

RegisterFile registro(.ra1(w_Inst[25:21]), .ra2(w_Inst[20:16]), .wa3(w_wa3[2:0]), .we3(w_RegWrite), .wd3(w_ULAResultWd3[7:0]), .clk(KEY[1]), .rd1(w_rd1SrcA[7:0]), .rd2(w_rd2[7:0]), .S0(w_d0x0[7:0]), .S1(w_d0x1[7:0]), .S2(w_d0x2[7:0]), .S3(w_d0x3[7:0]), .S4(w_d1x0[7:0]),.S5(w_d1x1[7:0]), .S6(w_d1x2[7:0]), .S7(w_d1x3[7:0]));

assign w_SrcB[7:0] = w_ULASrc	?	w_Inst[7:0]	:	w_rd2[7:0];

ULA ulaula(.SrcA(w_rd1SrcA[7:0]), .SrcB(w_SrcB[7:0]), .ULAControl(w_ULAControl[2:0]), .Z(LEDG[0]), .ULAResult(w_ULAResultWd3[7:0]));

assign LEDG[1] = KEY[1];
*/

/* Sprint 6
wire w_ULASrc, w_RegWrite, w_RegDst, w_MemtoReg, w_MemWrite, clock1;
wire [2:0] w_ULAControl, w_wa3;
wire [7:0] w_PCp1, w_PC, w_rd1SrcA, w_rd2, w_SrcB, w_ULAResultWd3, w_wd3, w_RData;
wire [31:0] w_Inst;


DivFrequencia divisor(.clk50M(CLOCK_50), .clk1(clock1));
PC pc(.PCin(w_PCp1[7:0]), .clk(clock1), .PC(w_PC[7:0]));
RomInstMem memoria(.address(w_PC[7:0]), .clock(CLOCK_50), .q(w_Inst[31:0]));
ControlUnit controle(.OP(w_Inst[31:26]), .Funct(w_Inst[5:0]), .Jump(LEDR[0]), .MemtoReg(w_MemtoReg), .MemWrite(w_MemWrite), .Branch(LEDR[3]), .ULAControl(w_ULAControl[2:0]), .ULASrc(w_ULASrc), .RegDst(w_RegDst), .RegWrite(w_RegWrite));

assign w_d0x4[7:0] = w_PC[7:0];
assign LEDR[1] = w_MemtoReg;
assign LEDR[2] = w_MemWrite;
assign LEDR[6:4] = w_ULAControl[2:0];
assign LEDR[7] = w_ULASrc;
assign LEDR[8] = w_RegDst;
assign LEDR[9] = w_RegWrite;
assign w_wa3[2:0] = w_RegDst	?	w_Inst[15:11]	:	w_Inst[20:16];
assign w_PCp1[7:0] = w_PC[7:0] + 1;

RegisterFile registro(.ra1(w_Inst[25:21]), .ra2(w_Inst[20:16]), .wa3(w_wa3[2:0]), .we3(w_RegWrite), .wd3(w_wd3[7:0]), .clk(clock1), .rd1(w_rd1SrcA[7:0]), .rd2(w_rd2[7:0]), .S0(w_d0x0[7:0]), .S1(w_d0x1[7:0]), .S2(w_d0x2[7:0]), .S3(w_d0x3[7:0]), .S4(w_d1x0[7:0]),.S5(w_d1x1[7:0]), .S6(w_d1x2[7:0]), .S7(w_d1x3[7:0]));

assign w_SrcB[7:0] = w_ULASrc	?	w_Inst[7:0]	:	w_rd2[7:0];

ULA ulaula(.SrcA(w_rd1SrcA[7:0]), .SrcB(w_SrcB[7:0]), .ULAControl(w_ULAControl[2:0]), .Z(LEDG[0]), .ULAResult(w_ULAResultWd3[7:0]));
RamDataMem mem(.address(w_ULAResultWd3[7:0]), .clock(CLOCK_50), .data(w_rd2[7:0]), .wren(w_MemWrite), .q(w_RData));

assign w_wd3[7:0] = w_MemtoReg	?	w_RData[7:0]	:	w_ULAResultWd3[7:0];
assign LEDG[1] = clock1;
*/

wire w_ULASrc, w_RegWrite, w_RegDst, w_MemtoReg, w_MemWrite, clock2, w_PCSrc, w_Jump, w_Branch, w_Z;
wire [2:0] w_ULAControl, w_wa3;
wire [7:0] w_PCp1, w_PC, w_rd1SrcA, w_rd2, w_SrcB, w_ULAResultWd3, w_wd3, w_RData, w_m1, w_nPC, w_PCBranch;
wire [31:0] w_Inst;


Clock2Hz clk2(.clk50M(CLOCK_50), .clk2(clock2));
PC pc(.PCin(w_nPC[7:0]), .clk(clock2), .PC(w_PC[7:0]));
RomInstMem memoria(.address(w_PC[7:0]), .clock(CLOCK_50), .q(w_Inst[31:0]));
ControlUnit controle(.OP(w_Inst[31:26]), .Funct(w_Inst[5:0]), .Jump(w_Jump), .MemtoReg(w_MemtoReg), .MemWrite(w_MemWrite), .Branch(w_Branch), .ULAControl(w_ULAControl[2:0]), .ULASrc(w_ULASrc), .RegDst(w_RegDst), .RegWrite(w_RegWrite));

assign w_d0x4[7:0] = w_PC[7:0];
assign LEDR[0] = w_Jump;
assign LEDR[1] = w_MemtoReg;
assign LEDR[2] = w_MemWrite;
assign LEDR[3] = w_Branch;
assign LEDR[6:4] = w_ULAControl[2:0];
assign LEDR[7] = w_ULASrc;
assign LEDR[8] = w_RegDst;
assign LEDR[9] = w_RegWrite;
assign LEDG[0] = w_Z;
assign w_wa3[2:0] = w_RegDst	?	w_Inst[15:11]	:	w_Inst[20:16];
assign w_PCp1[7:0] = w_PC[7:0] + 1;
assign w_nPC[7:0] = w_Jump	?	w_Inst[7:0]	:	w_m1[7:0];
assign w_m1[7:0] = w_PCSrc	?	w_PCBranch[7:0]	:	w_PCp1[7:0];
assign w_PCBranch[7:0] = w_PCp1[7:0] + w_Inst[7:0];
assign w_PCSrc = w_Branch & w_Z;



RegisterFile registro(.ra1(w_Inst[25:21]), .ra2(w_Inst[20:16]), .wa3(w_wa3[2:0]), .we3(w_RegWrite), .wd3(w_wd3[7:0]), .clk(clock2), .rd1(w_rd1SrcA[7:0]), .rd2(w_rd2[7:0]), .S0(w_d0x0[7:0]), .S1(w_d0x1[7:0]), .S2(w_d0x2[7:0]), .S3(w_d0x3[7:0]), .S4(w_d1x0[7:0]),.S5(w_d1x1[7:0]), .S6(w_d1x2[7:0]), .S7(w_d1x3[7:0]));

assign w_SrcB[7:0] = w_ULASrc	?	w_Inst[7:0]	:	w_rd2[7:0];

ULA ulaula(.SrcA(w_rd1SrcA[7:0]), .SrcB(w_SrcB[7:0]), .ULAControl(w_ULAControl[2:0]), .Z(w_Z), .ULAResult(w_ULAResultWd3[7:0]));
RamDataMem mem(.address(w_ULAResultWd3[7:0]), .clock(CLOCK_50), .data(w_rd2[7:0]), .wren(w_MemWrite), .q(w_RData));

assign w_wd3[7:0] = w_MemtoReg	?	w_RData[7:0]	:	w_ULAResultWd3[7:0];
assign LEDG[1] = clock2;

endmodule