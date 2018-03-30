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
    //input clk,
    input reg [Word_length-1:0] divisor,
    input reg [Word_length-1:0] dividend,
    output wire [Word_length-1:0] Q,
    output wire [Word_length-1:0] R
    );

    reg type_Initial_SD = 1'b0; //'
    reg type_Final_SD = 1'b1;   //'
    wire [Word_length-1:0] SDI_Dvd_Out;
    wire [Word_length-1:0] SDI_Dvr_Out;
    wire SDI_Sign_Out;

    Sign_Detector #(.Word_length(Word_length)) Sign_Detector(dividend,divisor,SDI_Dvd_Out,SDI_Dvr_Out,SDI_Sign_Out);
    //assign Q = SDI_Dvd_Out;
    assign R = SDI_Dvr_Out;
    Final_Sign_Usher #(.Word_length(Word_length)) Final_Sign_Usher(SDI_Dvd_Out,SDI_Sign_Out,Q);

endmodule
