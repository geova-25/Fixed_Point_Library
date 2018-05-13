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
   
    reg [Word_length-1:0]Operand;
    reg [Word_length-1: 0] Result;
    reg [Word_length-1: 0] fLUTValuePositive;
    reg [Word_length-1: 0] fLUTValueNegative;
    reg [Word_length-1: 0] iLUTValuePositive;
    reg [Word_length-1: 0] iLUTValueNegative;
    reg [Word_length-1:0] twoComplementOperand;
    
    
    FP_Exponential #(.Word_length(32), .fractional_bits(24)) FP_Exponential(
        .Operand(Operand),
        .Result(Result),
        .fLUTValuePositive(fLUTValuePositive),
        .fLUTValueNegative(fLUTValueNegative),
        .iLUTValuePositive(iLUTValuePositive),
        .iLUTValueNegative(iLUTValueNegative),
        .twoComplementOperand(twoComplementOperand)
    );
    
    initial 
    begin
        Operand = {1'b1,{13{1'b1}},3'b101,6'b001010,9'b10000};
        
        #25;
        
        //---------------------------
        Operand = {1'b0,{13{1'd0}},4'b110,6'b001011,9'b01000};
       
        #25;
        
        //---------------------------
        Operand = {1'b0,{13{1'd0000}},3'b110,6'b000011,9'b00100};        
        
        #25;
        
        //---------------------------
        Operand = {1'b1,{13{1'b1}},3'b010,6'b100001,9'b00010}; 
    end
    
endmodule
