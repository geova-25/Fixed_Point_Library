`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 03/30/2018 07:45:05 PM
// Design Name:
// Module Name: Test_Multiplier_Loop
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


module Test_Multiplier_Loop (
    );

    parameter Word_length = 32;
    parameter fractional_bits = 24;

    reg clk = 0;
    reg [Word_length-1:0] dvr;
    reg [Word_length-1:0] dvd;
    reg [Word_length-1:0] f;
    reg [Word_length-1:0] result;
    reg done;


Multiply_Loop #(.Word_length(Word_length),.fractional_bits(fractional_bits)) ML (
        clk,
        dvr,
        dvd,
        f,
        result,
        done
);


  always
    #50 clk = !clk;

  initial
    begin
    #5;
      dvd = {1'b0,7'd60,24'd0}; //'
      dvr = {1'b0,7'd7,24'd0}; //'
      dvd = dvd >> 3;
      dvr = dvr >> 3;
      f   = dvr ;
    end


endmodule
