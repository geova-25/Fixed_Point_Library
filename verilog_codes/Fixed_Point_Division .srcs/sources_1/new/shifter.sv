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
// This module will do the shifting of the operands for the initial aproximation.
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


module shifter #(Word_length = 32, fractional_bits = 24) (
    input wire clk,
    input wire readyToGo,           //This signal will tell if the shifter shoud start processing
    input  [Word_length-1:0] Shift_Dvd_In,
    input  [Word_length-1:0] Shift_Dvr_In,
    input  wire signIn,
    output reg signOut,
    output reg [Word_length-1:0] shifted_dvd = 0,
    output reg [Word_length-1:0] shifted_dvr = 0,
    output reg readyShifting = 0
    );

    reg [Word_length-1:0] divisorAux;  // The auxiliary divisor register for saving the result step by step
    reg [Word_length-1:0] dividendAux; // The auxiliary dividend register for saving the result step by step
    reg firstOne = 1;  // This signal is to internally control the loop with the initialvalues

     always @(posedge clk)
         begin
            if(readyToGo && firstOne  == 1)     // If it is the first time and the shifter was tell to start then
                begin
                    dividendAux = Shift_Dvd_In; //We assign the initial values and sign
                    divisorAux = Shift_Dvr_In;
                    signOut = signIn;
                    readyShifting = 0;          //Put the signal of ready in off because is processing
                    firstOne = 0;
                end
             if(divisorAux[Word_length - 1:fractional_bits] == 0)  //When the divisor has all integer part in ceros then is ready to end
                 begin
                    shifted_dvd = dividendAux;
                    shifted_dvr = divisorAux;
                    readyShifting = 1;   //The signal is put in one because it ended
                    firstOne = 1;

                 end
             else   //Otherwise it will be doing a shift
                 begin
                     divisorAux = divisorAux >> 1;
                     dividendAux = dividendAux >> 1;
                     readyShifting = 0;
                 end
         end

endmodule
