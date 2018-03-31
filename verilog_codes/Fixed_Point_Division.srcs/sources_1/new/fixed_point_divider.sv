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
    input reg [Word_length-1:0] divisor,
    input reg [Word_length-1:0] dividend,
    output wire [Word_length-1:0] Q,
    output wire [Word_length-1:0] R,
    output wire readyShifting,
    output reg [Word_length-1:0] shifted_dvd,
    output reg [Word_length-1:0] shifted_dvr
    );


    wire [Word_length-1:0] SDI_Dvd_Out;
    wire [Word_length-1:0] SDI_Dvr_Out;
    wire SDI_Sign_Out;

    Sign_Detector #(.Word_length(Word_length)) Sign_Detector(dividend,divisor,SDI_Dvd_Out,SDI_Dvr_Out,SDI_Sign_Out);

    wire [Word_length-1:0] Shift_Dvd_Out;
    wire [Word_length-1:0] Shift_Dvr_Out;

    shifter #(.Word_length(Word_length), .fractional_bits(fractional_bits)) SHF (
        clk,
        SDI_Dvd_Out ,
        SDI_Dvr_Out,
        Shift_Dvd_Out,
        Shift_Dvr_Out,
        readyShifting
        );

    //-----------------------------------------------
    //This Goes inside the multiplier
    always @(posedge readyShifting)
      begin
        shifted_dvd = Shift_Dvd_Out;
        shifted_dvr = Shift_Dvr_Out;
      end

      Multiplier #(.Q(24),.N(32)) multA
      	(
      	 shifted_dvd,
      	 shifted_dvr,
      	 o_result,
      	 ovr
      	 );

      Multiplier #(.Q(24),.N(32)) multB
      	(
      	 shifted_dvd,
      	 shifted_dvr,
      	 o_result,
      	 ovr
      	 );

    //-----------------------------------------------


    Final_Sign_Usher #(.Word_length(Word_length)) Final_Sign_Usher(shifted_dvd,SDI_Sign_Out,Q);

endmodule
