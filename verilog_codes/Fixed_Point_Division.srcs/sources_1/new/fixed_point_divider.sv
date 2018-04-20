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


module fixed_point_divider #(parameter Word_length = 64, fractional_bits = 56) (
    input wire clk, rst_n,
    input wire active,
    input wire [Word_length-1:0] divisor,
    input wire [Word_length-1:0] dividend,
    output reg [Word_length-1:0] result,
    output wire [2*Word_length-1:0] dvdAux,
    output wire [2*Word_length-1:0] dvrAux,
    output wire ready,
    output wire processing
    );
    
    //parameter Word_length = 64;
    //parameter fractional_bits = 56;

    wire ready_Multiply_Loop;
    wire [Word_length-1:0] Q;
    wire [Word_length-1:0] shifted_dvd;
    wire [Word_length-1:0] shifted_dvr;
    wire [Word_length-1:0] dvdOut;
    wire [Word_length-1:0] dvrOut;
    wire [Word_length-1:0] fOut;
    wire readyShifting;
    reg [Word_length-1:0] SDI_Dvd_Out;
    reg [Word_length-1:0] SDI_Dvr_Out;
    wire detectorSign;
    wire shifterSign;
    wire finalSign;
    wire startShifting;


    //---------------Module that detect and calculate the signs

    Sign_Detector #(.Word_length(Word_length)) Sign_Detector (
      dividend,
      divisor,
      SDI_Dvd_Out,
      SDI_Dvr_Out,
      detectorSign
    );

    //-----------------Module that will to the shift of the operands

    shifterOperands #(.Word_length(Word_length), .fractional_bits(fractional_bits)) sfop (
       SDI_Dvd_Out,
       SDI_Dvr_Out,
       shifted_dvd,
       shifted_dvr
       );
/*
    shifter #(.Word_length(Word_length), .fractional_bits(fractional_bits)) SHF (
        SDI_Dvd_Out ,
        SDI_Dvr_Out,
        shifted_dvd,
        shifted_dvr
        );
*/
     //-----------------Loop of the Goldschmidt Algorithm

      Multiply_Loop #(.Word_length(Word_length),.fractional_bits(fractional_bits)) ML (
        clk,
        active,
        shifted_dvr,
        shifted_dvd,
        detectorSign,
        finalSign,
        Q,
        ready_Multiply_Loop,
        dvdAux,
        dvrAux,
        processing
      );

    //------------------Final sign assigment based on the initial calculation


    Final_Sign_Usher #(.Word_length(Word_length)) Final_Sign_Usher(
        clk,
        Q,
        finalSign,
        ready_Multiply_Loop,
        result,
        ready
    );

endmodule
