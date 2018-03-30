`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 02/14/2018 03:50:06 PM
// Design Name:
// Module Name: Adder
// Project Name: 
// Target Devices:
// Tool Versions:
// Description:
// This module perform a adder of sign numbers originally created for fixed point numbers
// This module perform a adder of sign numbers originally created for fixed point numbers
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////



module Adder(op1, op2, result);

    //The following parameters are usefull to change the quantity of bits 
    //so the coud is easy to change in future implementations

    parameter Number_of_bits_op1 = 16;
    parameter Number_of_bits_op2 = 16;
    parameter Number_of_bits_result = 16;

    input  [Number_of_bits_op1 - 1 : 0] op1;
    input  [Number_of_bits_op1 - 1 : 0] op2;
    output reg [15:0] result;


    always @(*)
        begin
             if(op1[Number_of_bits_op1 - 1] == op2[Number_of_bits_op2 - 1]) //If the operands has the same number
                begin
                    result[Number_of_bits_result-1] =  op1[Number_of_bits_result-1]; // Sign is equal to op1 (or it coulb be op2)
                    result[Number_of_bits_result-2:0] = op1[Number_of_bits_op1-2:0] + op2[Number_of_bits_op1-2:0]; //Add the magnitude
                end
             else if(op1[Number_of_bits_op1-2:0] > op2[Number_of_bits_op2-2:0]) //else if means one of the two is negative, here if the op1 is bigger, then :
                begin
                    result[Number_of_bits_result-1] =  op1[Number_of_bits_result-1]; // Sign is equal to op1 as is the biggest
                    result[Number_of_bits_result-2:0] = op1[Number_of_bits_op1-2:0] - op2[Number_of_bits_op2-2:0];//Substract the magnitude
                end
             else   //else means here that op2 is bigger, then 
                begin
                    result[Number_of_bits_result-1] =  op2[Number_of_bits_result-1]; // Sign is equal to op2 as is the biggest
                    result[Number_of_bits_result-2:0] = op2[Number_of_bits_op2-2:0] - op1[Number_of_bits_op1-2:0];//Substract the magnitude of op2 first 
                end
        end

endmodule
