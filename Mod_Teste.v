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

endmodule