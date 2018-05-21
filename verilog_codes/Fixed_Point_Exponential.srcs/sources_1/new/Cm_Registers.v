`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/21/2018 02:19:22 PM
// Design Name: 
// Module Name: Cm_Registers
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


module Cm_Registers #(parameter Word_length = 32, fractional_bits = 15) (
    input clk,
    input [Word_length-1:0] fint,
    input [Word_length-1:0] ffract,
    input [Word_length-1:0] Entry1,
    input [Word_length-1:0] Entry2,
    input [Word_length-1:0] Entry3,
    input [Word_length-1:0] Entry4,
    output reg [Word_length-1:0] Fint_Reg,
    output reg [Word_length-1:0] Ffract_Reg,
    output reg [Word_length-1:0] Reg_1,
    output reg [Word_length-1:0] Reg_2,
    output reg [Word_length-1:0] Reg_3,
    output reg [Word_length-1:0] Reg_4
    );
    
    always @(posedge clk)
    begin
        Fint_Reg = fint;
        Ffract_Reg = ffract;
        Reg_1 = Entry1;
        Reg_2 = Entry2;
        Reg_3 = Entry3;
        Reg_4 = Entry4;
    end
    
    
    
endmodule
