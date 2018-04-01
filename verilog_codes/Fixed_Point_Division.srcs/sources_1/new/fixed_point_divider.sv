`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 02/25/2018 02:37:02 PM
// Design Name:
// Module Name: fixed_point_divider
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


module fixed_point_divider #(parameter Word_length = 32, fractional_bits = 24)(
    input clk,
    input wire [Word_length-1:0] divisor,
    input wire [Word_length-1:0] dividend,
    output wire [Word_length-1:0] Q,
    output wire [Word_length-1:0] shifted_dvd,
    output wire [Word_length-1:0] shifted_dvr,
    output wire [Word_length-1:0] dvdOut,
    output wire [Word_length-1:0] dvrOut,
    output wire [Word_length-1:0] fOut,
    output wire done,
    output wire readyToGo,
    output wire readyShifting,
    output reg [Word_length-1:0] divisorAux,
    output reg [Word_length-1:0] dividendAux,
    output reg [Word_length-1:0] result,
    output wire SDI_Sign_Out
    );


    reg [Word_length-1:0] SDI_Dvd_Out;
    reg [Word_length-1:0] SDI_Dvr_Out;
    wire signShift,signMultLoop;

    Sign_Detector #(.Word_length(Word_length)) Sign_Detector (
      dividend,
      divisor,
      SDI_Dvd_Out,
      SDI_Dvr_Out,
      SDI_Sign_Out
    );
   

    shifter #(.Word_length(Word_length), .fractional_bits(fractional_bits)) SHF (
        clk,
        readyToGo,
        done,
        SDI_Dvd_Out ,
        SDI_Dvr_Out,
        SDI_Sign_Out,
        signShift,
        shifted_dvd,
        shifted_dvr,
        readyShifting,
        divisorAux,
        dividendAux        
        );

      Multiply_Loop #(.Word_length(Word_length),.fractional_bits(fractional_bits)) ML (
        clk,
        readyShifting, //'
        shifted_dvr,
        shifted_dvd,
        shifted_dvr,
        signShift,
        signMultLoop,
        Q,
        done,
        dvdOut,
        dvrOut,
        fOut,
        readyToGo
      );

    //-----------------------------------------------


    Final_Sign_Usher #(.Word_length(Word_length)) Final_Sign_Usher(Q,signMultLoop,result);

endmodule
