module Sprint1(input [3:0]SW1,input [7:4]SW2,input SW17,output [3:0]LEDR);
  assign LEDR = SW17?SW1-SW2:SW1+SW2;
endmodule