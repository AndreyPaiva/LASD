module Sprint1_TB;
  reg [3:0]in1, in2;
  reg switch;
  wire [3:0]out;
  Sprint1 teste(in1, in2, switch, out);
  initial
    begin
      in1 = 4'd3;
      in2 = 4'd1;
      switch = 0;
    #1
      $display("SW1 = %b, SW2 = %b, SW17 = %b, LEDR = %b", in1, in2, switch, out);
    #1
      in1 = 4'd15;
      in2 = 4'd2;
      switch = 0;
    #1
      $display("SW1 = %b, SW2 = %b, SW17 = %b, LEDR = %b", in1, in2, switch, out);
    #1
      in1 = 4'd7;
      in2 = 4'd3;
      switch = 1;
    #1
      $display("SW1 = %b, SW2 = %b, SW17 = %b, LEDR = %b", in1, in2, switch, out);
    #1
      in1 = 4'd7;
      in2 = 4'd8;
      switch = 1;
    #1
      $display("SW1 = %b, SW2 = %b, SW17 = %b, LEDR = %b", in1, in2, switch, out);
      $stop;
      $finish;
    end
endmodule