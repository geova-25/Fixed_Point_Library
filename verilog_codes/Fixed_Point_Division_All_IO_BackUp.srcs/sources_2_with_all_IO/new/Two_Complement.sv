`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 03/28/2018 12:52:21 PM
// Design Name:
// Module Name: Two_Complement
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


module Two_Complement #(parameter Word_length = 32) (
    input [Word_length-1:0] Number_2C_In,
    output [Word_length-1:0] Number_2C_Out
    );

    assign Number_2C_Out = ~Number_2C_In + 1'b1;


endmodule
