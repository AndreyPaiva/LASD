module Desafio_TB;
  reg [3:0]A, B;
  reg [1:0]Sel;
  wire [3:0]Res;
  
  Desafio teste(A, B, Sel, Res);
  
  initial
    begin
      A = 4'd3;
      B = 4'd1;
      Sel = 2'b00;
    #1
      $display("SW1 = %b, SW2 = %b, SW3 = %b, LEDR = %b", A, B, Sel, Res);
    #1
      A = 4'd15;
      B = 4'd2;
      Sel = 2'b00;
    #1
      $display("SW1 = %b, SW2 = %b, SW3 = %b, LEDR = %b", A, B, Sel, Res);
    #1
      A = 4'd7;
      B = 4'd3;
      Sel = 2'b01;
    #1
      $display("SW1 = %b, SW2 = %b, SW3 = %b, LEDR = %b", A, B, Sel, Res);
    #1
      A = 4'd7;
      B = 4'd8;
      Sel = 2'b01;
    #1
      $display("SW1 = %b, SW2 = %b, SW3 = %b, LEDR = %b", A, B, Sel, Res);
    #1
      A = 4'd8;
      B = 4'd2;
      Sel = 2'b10;
    #1
      $display("SW1 = %b, SW2 = %b, SW3 = %b, LEDR = %b", A, B, Sel, Res);
    #1
      A = 4'd7;
      B = 4'd1;
      Sel = 2'b10;
    #1
      $display("SW1 = %b, SW2 = %b, SW3 = %b, LEDR = %b", A, B, Sel, Res);
    #1
      A = 4'd14;
      B = 4'd3;
      Sel = 2'b11;
    #1
      $display("SW1 = %b, SW2 = %b, SW3 = %b, LEDR = %b", A, B, Sel, Res);
    #1
      A = 4'd10;
      B = 4'd2;
      Sel = 2'b11;
    #1
      $display("SW1 = %b, SW2 = %b, SW3 = %b, LEDR = %b", A, B, Sel, Res);
      $stop;
      $finish;
    end
endmodule
      
