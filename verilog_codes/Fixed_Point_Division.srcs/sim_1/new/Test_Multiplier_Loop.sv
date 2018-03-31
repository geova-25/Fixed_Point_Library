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
    reg [Word_length-1:0] dvr, dvrOut;
    reg [Word_length-1:0] dvd, dvdOut;
    reg [Word_length-1:0] f;
    reg [Word_length-1:0] result;
    reg done,go;


Multiply_Loop #(.Word_length(Word_length),.fractional_bits(fractional_bits)) ML (
        clk,
        go,
        dvr,
        dvd,
        f,
        result,
        done,
        dvdOut,
        dvrOut
);


  always
    #50 clk = !clk;

  initial
    begin
    #5;
      dvd = {1'b0,7'd0,8'b11010110,16'b0}; //'
      dvr = {1'b0,7'd0,6'b111101,18'b0}; //'
      //dvd = dvd >> 7;
      //dvr = dvr >> 7;
      f   = dvr ;
      go = 1;
    end


endmodule
