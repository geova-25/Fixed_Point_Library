`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 03/28/2018 05:07:51 PM
// Design Name:
// Module Name: Test_FPDivider
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

module Test_FPDivider();

    reg clk = 0;
    reg [31:0] divisor, dividend;
    wire [31:0] Q,R, shifted_dvd,shifted_dvr;
    wire readyShifting;
    parameter Word_length_local = 32;
    parameter fractional_bits__local = 24;
    fixed_point_divider #(.Word_length(Word_length_local),.fractional_bits(fractional_bits__local)) FPD(
        clk,
        divisor,  //M
        dividend, //Q
        Q,
        R,
        readyShifting,
        shifted_dvd,
        shifted_dvr
    );

    reg [Word_length_local-1:0] dvd_aux = 0;
    reg [Word_length_local-1:0] dvs_aux = 0;

    always
      #50 clk = !clk;

    initial
      begin
      #5;
        dvs_aux = {1'b1,7'd80,24'd0}; //'
        dvd_aux = {1'b0,7'd80,24'd0}; //'
        assign divisor = dvs_aux;
        assign dividend = dvd_aux;
      end

endmodule
