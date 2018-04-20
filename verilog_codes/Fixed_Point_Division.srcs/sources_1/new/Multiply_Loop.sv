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


module Multiply_Loop #(parameter Word_length = 32,fractional_bits = 24) (
    input wire clk,
    input wire active,
    input wire [Word_length-1:0] dvr,
    input wire [Word_length-1:0] dvd,
    input wire signIn,
    output reg signOut,
    output reg [Word_length-1:0] result = 0,
    output reg readyToGo = 0,
    output reg [2*Word_length-1:0] dvdAux = 0,
    output reg [2*Word_length-1:0] dvrAux = 0,
    output reg processing = 0 
    );

    reg [Word_length-1:0] two = {{(Word_length-fractional_bits-2){1'b0}},{2'b10},{fractional_bits{1'b0}}};  //Reg to make the aproximation substraction
    reg [1:0] counter = 0; //Counter reg

    always @(posedge clk)  //This secuential block will do the goldschmidt algorithm for division
      begin
        if(dvrAux[fractional_bits+fractional_bits-1:fractional_bits] == {fractional_bits{1'b1}} )  //If the divisor is all ones in the fractional part then ir is ready to end        
            begin
                result = dvdAux[Word_length-1+fractional_bits:fractional_bits]; // The result is assign from the last multiplication
                dvdAux = 0;
                dvrAux = 0;     
                signOut = signOut;       //Sign still the same
                counter = 0;             // The counter is assigned to one because to avoid one cicle when assign the next one immediately
                readyToGo = 1;           // Signal that the algorithm ended
                 processing = 0;
            end
        else if(counter == 0 && active == 1) //This is for the first time that the algoritm takes a value
            begin
                result = result;
                dvdAux[Word_length-1+fractional_bits:fractional_bits] = dvd;
                dvrAux[Word_length-1+fractional_bits:fractional_bits] = dvr; //assign initial values of divisor and dividend
                signOut = signIn; //When new operands arrive we get his sign
                counter = counter + 1;
                readyToGo = 0;
                processing = 1;
            end
        else if(counter == 1)  //When counter is one then the first multiplication needs to be with the entry value of dvr
            begin
                result = result;
                dvdAux = dvdAux[Word_length-1+fractional_bits:fractional_bits] * dvrAux[Word_length-1+fractional_bits:fractional_bits]; //The first time the initial aproximation is just the dvr shifted
                dvrAux = dvrAux[Word_length-1+fractional_bits:fractional_bits] * dvrAux[Word_length-1+fractional_bits:fractional_bits];
                signOut = signOut;   
                counter = counter + 1;     //Add one to counter
                readyToGo = 0;             //No ready
            end            
        else if(counter > 1)  //When counter is mayor than 1 means that from this point on we have to calculate new aproximations
            begin
                result = result;
                dvdAux = dvdAux[Word_length-1+fractional_bits:fractional_bits] * (two - dvrAux[Word_length-1+fractional_bits:fractional_bits]); // Multiply dividend * (new aproximation that is: 2 - [previous aproximation that is stored in dvr])
                dvrAux = dvrAux[Word_length-1+fractional_bits:fractional_bits] * (two - dvrAux[Word_length-1+fractional_bits:fractional_bits]); // Multiply divisor  * (2 - [aproximation that is stored in dvr] )
                signOut = signOut; 
                counter = counter;
                readyToGo = 0;             //No ready
            end
        else                 //To avois latches
            begin
                result = result;
                dvdAux = dvdAux;
                dvrAux = dvrAux;
                signOut = signOut;
                counter = 0;               // Otherwise counter is maintained in cero
                readyToGo = readyToGo;             //No ready
            end                        
      end

endmodule
