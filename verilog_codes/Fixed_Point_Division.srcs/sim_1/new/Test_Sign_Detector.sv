`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 03/28/2018 01:30:11 PM
// Design Name:
// Module Name: Test_Sign_Detector
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


module Test_Sign_Detector(
    );

    parameter Word_length_local = 32;
    reg[Word_length_local-1:0] ina,inb;
    wire[Word_length_local-1:0] outa,outb;
    wire sign;

    Sign_Detector #(.Word_length(Word_length_local)) SD(
      ina,
      inb,
      outa,
      outb,
      sign
    );

    initial
      begin
        #50;
          assign ina = {1'b0,31'd400};
          assign inb = {1'b0,31'd1};
        #50;
          assign ina = {1'b1,31'd400};
          assign inb = {1'b1,31'd1};
        #50;
          assign ina = {1'b0,31'd400};
          assign inb = {1'b1,31'd1};
        #50;
          assign ina = {1'b1,31'd400};
          assign inb = {1'b0,31'd1};
        #50;
      end

endmodule
