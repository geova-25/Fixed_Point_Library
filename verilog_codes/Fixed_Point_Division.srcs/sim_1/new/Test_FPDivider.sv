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

    parameter Word_length_local = 32;
    parameter fractional_bits__local = 24;
    reg clk = 0;
    reg [31:0] divisor = 0;
    reg [31:0] dividend = 0;
    wire [31:0] Q, shifted_dvd,shifted_dvr,dvdOut,dvrOut, dvd;
    wire done;
  
    wire [Word_length_local-1:0] dvdAux = 0;
    wire [Word_length_local-1:0] dvrAux = 0;
    wire [Word_length_local-1:0] fOut = 0;
    
    fixed_point_divider #(.Word_length(Word_length_local),.fractional_bits(fractional_bits__local)) FPD(
        clk,
        divisor,  //M
        dividend, //Q
        Q,
        shifted_dvd,
        shifted_dvr,
        dvdOut,
        dvrOut,
        fOut,
        done,
        dvdAux,
        dvrAux
    );

    

    always
      #50 clk = !clk;

    initial
      begin
      #5;
        assign divisor = {1'b0,7'd7,24'd0};
        assign dividend = {1'b0,7'd60,24'd0};
      end

endmodule
