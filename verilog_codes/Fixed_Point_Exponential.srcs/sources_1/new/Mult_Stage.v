`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/20/2018 09:25:27 AM
// Design Name: 
// Module Name: Mult_Stage
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


module Mult_Stage #(parameter Word_length = 32, fractional_bits = 24)(
    //input clk,
    input [Word_length-1:0] x1,
    input [Word_length-1:0] x2,
    input [Word_length-1:0] x3,
    input [Word_length-1:0] x4,
    input [Word_length-1:0] ffract,
    //input [Word_length-1:0] fint,
    //output reg [Word_length-1:0] ffractOut,
    //output reg [Word_length-1:0] fintOut,
    output reg [Word_length-1:0] ffractx1,
    output reg [Word_length-1:0] ffractx2,
    output reg [Word_length-1:0] ffractx3,
    output reg [Word_length-1:0] ffractx4
    );
/*
    Fixed_Point_Mult #(.Word_length(Word_length),.fractional_bits(fractional_bits)) FPMult_m1 (
    .i_multiplicand(x1),
    .i_multiplier(ffract),
    .o_result(ffractx1)
    );
    
        Fixed_Point_Mult #(.Word_length(Word_length),.fractional_bits(fractional_bits)) FPMult_m2 (
    .i_multiplicand(x2),
    .i_multiplier(ffract),
    .o_result(ffractx2)
    );
*/
    always @(*)
    begin
        //ffractOut = ffract;
        //fintOut = fint;
        ffractx1 = ({{32'b0}, x1} * ffract) >> fractional_bits;
        //ffractx1 = ({{32'b0}, x1} * ffract) >> fractional_bits;
        ffractx2 = ({{32'b0}, x2} * ffract) >> fractional_bits;
        ffractx3 = ({{32'b0}, x3} * ffract) >> fractional_bits;
        ffractx4 = ({{32'b0}, x4} * ffract) >> fractional_bits;
    end

endmodule
