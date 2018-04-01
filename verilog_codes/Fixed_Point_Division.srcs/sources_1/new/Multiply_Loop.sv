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
    input wire go,
    input reg [Word_length-1:0] dvr,
    input reg [Word_length-1:0] dvd,
    input reg [Word_length-1:0] f,
    output reg [Word_length-1:0] result,
    output reg done = 0,
    output reg [Word_length-1:0] dvdAux = 0,
    output reg [Word_length-1:0] dvrAux = 0,
    output reg [Word_length-1:0] fAux = 0,
    output reg readyToGo = 1
    );

    wire [Word_length - 1:fractional_bits] two = 2;
    wire [Word_length - 1:fractional_bits] one = 1;
    wire [fractional_bits-1:0] fractional_ones = {fractional_bits{1'b1}};
    wire [fractional_bits - 1:0] cero = 0;
    wire [Word_length-1:0] result_f_x_dvd;
    wire [Word_length-1:0] result_f_x_dvr;
    wire ovr_f_x_dvr, ovr_f_x_dvd;
    reg [3:0] counter = 0;
    reg signal = 0;
    
   Multiplier #(.Q(24),.N(32)) multDVDF
      (
       fAux,
       dvrAux,
       result_f_x_dvr,
       ovr_f_x_dvr
       );

    Multiplier #(.Q(24),.N(32)) multDVSF
      (
       fAux,
       dvdAux,
       result_f_x_dvd,
       ovr_f_x_dvd
       );
       
    always @(posedge clk)
      begin
        if(result_f_x_dvr[fractional_bits-1:0] == fractional_ones )
        //if(counter == 5)
          begin
            //result = dvd;
            result = result_f_x_dvd;
            done = 1;
            counter = 1;
            signal = 1; 
            readyToGo = 1;
            dvdAux = dvd;
            dvrAux = dvr;
          end
        else if(counter == 0 && go == 1)
            begin
                signal = 1;
                dvdAux = dvd;
                dvrAux = dvr;
                fAux = f;
                counter = counter + 1;
                done = 0;
                readyToGo = 0;
            end
        else if(signal == 1)
          begin
            dvdAux = result_f_x_dvd;
            dvrAux = result_f_x_dvr;
            fAux = {two,cero} - dvrAux; // '
            counter = counter + 1;
            done = 0;
            readyToGo = 0;
          end
        else
            counter = 0;
            done = 0;
      end

endmodule
