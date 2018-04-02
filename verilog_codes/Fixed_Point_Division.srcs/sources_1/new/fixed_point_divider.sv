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
    output reg [Word_length-1:0] result,
    output wire ready
    );
    
    
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
      clk,
      ready,
      dividend,
      divisor,
      SDI_Dvd_Out,
      SDI_Dvr_Out,
      detectorSign,
      startShifting
    );
   
    //-----------------Module that will to the shift of the operands

    shifter #(.Word_length(Word_length), .fractional_bits(fractional_bits)) SHF (
        clk,
        startShifting,
        SDI_Dvd_Out ,
        SDI_Dvr_Out,
        detectorSign,
        shifterSign,
        shifted_dvd,
        shifted_dvr,
        readyShifting
        );
        
     //-----------------Loop of the Goldschmidt Algorithm

      Multiply_Loop #(.Word_length(Word_length),.fractional_bits(fractional_bits)) ML (
        clk,
        readyShifting, //'
        shifted_dvr,
        shifted_dvd,
        shifted_dvr,
        shifterSign,
        finalSign,
        Q,
        ready
      );

    //------------------Final sign assigment based on the initial calculation


    Final_Sign_Usher #(.Word_length(Word_length)) Final_Sign_Usher(Q,finalSign,result);

endmodule
