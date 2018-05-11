`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/07/2018 05:23:03 PM
// Design Name: 
// Module Name: Test_Fp_Exponential
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


module Test_Fp_Exponential(

    );
    
    localparam Word_length = 32;
    localparam fractional_bits = 15; 
    
    reg [Word_length-1: 0] Operand;
    reg [Word_length-1: 0] Result;
    reg [Word_length-1: 0] fLUTValue;
    reg [Word_length-1: 0] iLUTValue;
    
    FP_Exponential #(.Word_length(32), .fractional_bits(24)) FP_Exponential(
        .Operand(Operand),
        .Result(Result),
        .fLUTValue(fLUTValue),
        .iLUTValue(iLUTValue)
    );
    
    initial begin 
        Operand = {17'd5,15'b0100_0000_0000_000};
        end
    
endmodule
