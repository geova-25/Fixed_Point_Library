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


module LUT_Stage #(parameter Word_length = 32, fractional_bits = 24)(
    //input clk,
    input [31:0] Operand,
    output reg [Word_length-1:0] x1 = 0,
    output reg [Word_length-1:0] x2,
    output reg [Word_length-1:0] x3 = 0,
    output reg [Word_length-1:0] x4 = 0,
    output reg [Word_length-1:0] fint = 0,   
    output reg [Word_length-1:0] ffract = 0, 
    output reg sign = 0    
    );
       
    localparam bitsOfPolinomialCalc = 12;
    
    wire [Word_length-1:0] twoComplementOperand;
    wire [Word_length-1:0] fLUTValuePositive;
    wire [Word_length-1:0] fLUTValueNegative;
    wire [Word_length-1:0] fLUTValuePositive2;
    wire [Word_length-1:0] fLUTValueNegative2;
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

    Fract_LUT #(.Word_length(Word_length),.typeS(2)) fract_LUT_Negative (
        .address(twoComplementOperand[fractional_bits-1:fractional_bits-6]),
        .value(fLUTValueNegative)
    );
    
    Fract_LUT #(.Word_length(Word_length),.typeS(3)) fract_LUT_Positive2 (
        .address(Operand[fractional_bits-7:fractional_bits-12]),
        .value(fLUTValuePositive2)
    );

    Fract_LUT #(.Word_length(Word_length),.typeS(4)) fract_LUT_Negative2 (
        .address(twoComplementOperand[fractional_bits-7:fractional_bits-12]),
        .value(fLUTValueNegative2)
    );
    
    /*
    Fixed_Point_Mult #(.Word_length(Word_length),.fractional_bits(fractional_bits)) FPMult (
    .i_multiplicand(x1),
    .i_multiplier(x1),
    .o_result(x2)
    );
    */
    //always @(posedge clk)
    always @(*)
    begin
        if(Operand[Word_length-1] == 0)
            begin
                sign = 1'b0; 
                fint   = iLUTValuePositive;
                ffract = ({{32'b0}, fLUTValuePositive} * fLUTValuePositive2) >> fractional_bits;
                ffract[Word_length-1] = 1'b0;
                x1[fractional_bits-13:0] = Operand[fractional_bits-13:0];
                x2 = ({{32'b0}, x1} * x1) >> fractional_bits;
                x3 = ({{32'b0}, x1} * x2) >> fractional_bits;
                x4 = ({{32'b0}, x1} * x3) >> fractional_bits;
                //x3 = (((Operand[bitsOfPolinomialCalc-1:0] * Operand[bitsOfPolinomialCalc-1:0])) * ((Operand[bitsOfPolinomialCalc-1:0]))) >> 15;
                //x4 = ({{32'b0}, x3} * x1);
                                   
                /*                    
                x2 = ({{32'b0}, x1} * x1) >> fractional_bits;
                x3 = ({{32'b0}, x2} * x1) >> fractional_bits;
                x4 = ({{32'b0}, x3} * x1) >> fractional_bits;
                */
            end
        else
            begin
                sign = 1'b1;
                fint   =  iLUTValueNegative;
                ffract = ({{32'b0}, fLUTValueNegative} * fLUTValueNegative2) >> fractional_bits;
                ffract[Word_length-1] = 1'b0;
                x1[fractional_bits-13:0] = twoComplementOperand[fractional_bits-13:0];
                x2 = ({{32'b0}, x1} * x1) >> fractional_bits;
                x3 = ({{32'b0}, x1} * x2) >> fractional_bits;
                x4 = ({{32'b0}, x1} * x3) >> fractional_bits;
                //x3 = ({{32'b0}, x2} * x1) >> fractional_bits;
                //x4 = ({{32'b0}, x3} * x1) >> fractional_bits;
                                    
            end    
    
    end
endmodule
