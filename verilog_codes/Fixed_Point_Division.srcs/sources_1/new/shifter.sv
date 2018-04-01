`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 03/28/2018 08:57:15 PM
// Design Name:
// Module Name: shifter
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


module shifter #(Word_length = 32, fractional_bits = 24) (
    input wire clk,
    input wire readyToGo,
    input  [Word_length-1:0] Shift_Dvd_In,
    input  [Word_length-1:0] Shift_Dvr_In,
    input  wire signIn,
    output reg signOut,
    output reg [Word_length-1:0] shifted_dvd = 0,
    output reg [Word_length-1:0] shifted_dvr = 0,
    output reg readyShifting = 0
    );


    reg [Word_length-1:0] divisorAux;
    reg [Word_length-1:0] dividendAux;
    reg firstOne = 1;

     always @(posedge clk)
         begin
            if(readyToGo && firstOne  == 1)
                begin
                    dividendAux = Shift_Dvd_In;
                    divisorAux = Shift_Dvr_In;
                    signOut = signIn;
                    readyShifting = 0;
                    firstOne = 0;
                end
             if(divisorAux[Word_length - 1:fractional_bits] == 0)
                 begin
                    shifted_dvd = dividendAux;
                    shifted_dvr = divisorAux;
                    readyShifting = 1;
                    firstOne = 1;

                 end
             else
                 begin
                     divisorAux = divisorAux >> 1;
                     dividendAux = dividendAux >> 1;
                     readyShifting = 0;
                 end
         end

endmodule
