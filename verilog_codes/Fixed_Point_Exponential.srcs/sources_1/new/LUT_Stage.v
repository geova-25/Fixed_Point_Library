`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2018 04:04:33 PM
// Design Name: 
// Module Name: LUT_Stage
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


module LUT_Stage #(parameter Word_length = 32, fractional_bits = 15)(
    //input clk,
    input [31:0] Operand,
    output reg [Word_length-1:0] x1 = 0,
    output reg [Word_length-1:0] x2 = 0,
    output reg [Word_length-1:0] x3 = 0,
    output reg [Word_length-1:0] x4 = 0,
    output reg [Word_length-1:0] fint = 0,   
    output reg [Word_length-1:0] ffract = 0    
    );
       
    localparam bitsOfPolinomialCalc = 9;
    
    wire [Word_length-1:0] twoComplementOperand;
    wire [Word_length-1:0] fLUTValuePositive;
    wire [Word_length-1:0] fLUTValueNegative;
    wire [Word_length-1:0] iLUTValuePositive;
    wire [Word_length-1:0] iLUTValueNegative;
    
    assign twoComplementOperand = ~(Operand) + 32'd1;
    
    Int_LUT #(.Word_length(Word_length), .fractional_bits(fractional_bits), .typeS(1)) int_LUT_Positive (
        .address(Operand[Word_length-1:fractional_bits]),
        .value(iLUTValuePositive)
    );

    Int_LUT #(.Word_length(Word_length), .fractional_bits(fractional_bits), .typeS(0)) int_LUT_Negative (
        .address(twoComplementOperand[Word_length-1:fractional_bits]),
        .value(iLUTValueNegative)
    );

    Fract_LUT #(.Word_length(Word_length),.typeS(1)) fract_LUT_Positive (
        .address(Operand[fractional_bits-1:fractional_bits-6]),
        .value(fLUTValuePositive)
    );

    Fract_LUT #(.Word_length(Word_length),.typeS(0)) fract_LUT_Negative (
        .address(twoComplementOperand[fractional_bits-1:fractional_bits-6]),
        .value(fLUTValueNegative)
    );

    //always @(posedge clk)
    always @(*)
    begin
           if(Operand[Word_length-1] == 0)
                begin
                    fint   =  iLUTValuePositive;
                    ffract = fLUTValuePositive;
                    x1 = {{Word_length-fractional_bits + 6{1'b0}},{Operand[bitsOfPolinomialCalc-1:0]}};
                    x2 = ({{32'b0}, x1} * x1) >> fractional_bits;
                    x3 = ({{32'b0}, x2} * x1) >> fractional_bits;
                    x4 = ({{32'b0}, x3} * x1) >> fractional_bits;
                end
            else
                begin
                    fint   =  iLUTValueNegative;
                    ffract = fLUTValueNegative;
                    x1 = {{Word_length-fractional_bits + 6{1'b0}},{twoComplementOperand[bitsOfPolinomialCalc-1:0]}};
                    x2 = ({{32'b0}, x1} * x1) >> fractional_bits;
                    x3 = ({{32'b0}, x2} * x1) >> fractional_bits;
                    x4 = ({{32'b0}, x3} * x1) >> fractional_bits;
                                        
                end    
    
    end
endmodule
