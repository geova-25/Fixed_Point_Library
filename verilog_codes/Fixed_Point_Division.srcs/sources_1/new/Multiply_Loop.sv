`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 03/30/2018 07:17:21 PM
// Design Name:
// Module Name: Multiply_Loop
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


module Multiply_Loop #(Word_length = 32,fractional_bits = 24) (
    input wire clk,
    input reg [Word_length-1:0] dvr,
    input reg [Word_length-1:0] dvd,
    input reg [Word_length-1:0] f,
    output reg [Word_length-1:0] result,
    output reg done = 0,
    output reg [Word_length-1:0] previousResult = 0,
    output reg [Word_length-1:0] previousError = 0
    );

    wire [Word_length - 1:fractional_bits] two = 2;
    wire [Word_length - 1:fractional_bits] one = 1;
    wire [fractional_bits-1:0] fractional_ones = {fractional_bits{1'b1}};
    wire [fractional_bits - 1:0] cero = 0;
    wire [Word_length-1:0] result_f_x_dvd;
    wire [Word_length-1:0] result_f_x_dvr;
    wire ovr_f_x_dvr, ovr_f_x_dvd;
    reg [3:0] counter = 0;

   Multiplier #(.Q(24),.N(32)) multDVDF
      (
       f,
       dvr,
       result_f_x_dvr,
       ovr_f_x_dvr
       );

    Multiplier #(.Q(24),.N(32)) multDVSF
      (
       f,
       dvd,
       result_f_x_dvd,
       ovr_f_x_dvd
       );

    always @(posedge clk)
      begin
        if(result_f_x_dvr[fractional_bits-1:0] == fractional_ones)
        //if(counter == 5)
          begin
            //result = dvd;
            result = result_f_x_dvd;
            done = 1;
          end
        else
          begin
            dvd = result_f_x_dvd;
            dvr = result_f_x_dvr;
            f = {two,cero} - dvr; // '
            previousError  = {one,cero} - dvr;
            previousResult = dvd;
            counter = counter + 1;
          end
      end

endmodule
