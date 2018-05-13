`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 04/30/2018 10:23:57 AM
// Design Name:
// Module Name: FP_Exponential
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


module FP_Exponential #(parameter Word_length = 32, fractional_bits = 15)(
    input wire [Word_length-1:0] Operand,
    output reg [Word_length-1:0] Result,
    output wire [Word_length-1:0] fLUTValuePositive,
    output wire [Word_length-1:0] fLUTValueNegative,
    output wire [Word_length-1:0] iLUTValuePositive,
    output wire [Word_length-1:0] iLUTValueNegative,
    output wire [Word_length-1:0] twoComplementOperand
    );

    localparam bitsOfPolinomialCalc = 9;

    //------------------------------------Testing 5.5

    //localparam fLUT =  32'b00000000000000001101001100001001;
    //localparam iLUT =  32'b00000000010010100011010011100010;
    //wire [Word_length-1:0] fLUTValue;
    //wire [Word_length-1:0] iLUTValue;

    //-----------Precalculated so this are left as localparam

    localparam c3 = 32'b00000000000000000001010101010100;
    localparam c4 = 32'b00000000000000000000010110000000;

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
        .address(Operand[fractional_bits-1:bitsOfPolinomialCalc]),
        .value(fLUTValuePositive)
    );

    Fract_LUT #(.Word_length(Word_length),.typeS(0)) fract_LUT_Negative (
        .address(Operand[fractional_bits-1:bitsOfPolinomialCalc]),
        .value(fLUTValueNegative)
    );

    reg [bitsOfPolinomialCalc-1:0]   x1;
    reg [2*bitsOfPolinomialCalc-1:0] x2;
    reg [2*bitsOfPolinomialCalc-1:0] x3;
    reg [2*bitsOfPolinomialCalc-1:0] x4;

    always @*
        begin
            x1 = Operand[bitsOfPolinomialCalc-1:0];
            x2 = x1*x1 >> fractional_bits;
            x3 = x2*x1 >> fractional_bits;
            x4 = x3*x1 >> fractional_bits;

            if(Operand[Word_length-1] == 0)
                begin
                    x1 = x1 * fLUTValuePositive >> fractional_bits;
                    x2 = x2 * fLUTValuePositive >> fractional_bits;
                    x3 = x3 * fLUTValuePositive >> fractional_bits;
                    x4 = x4 * fLUTValuePositive >> fractional_bits;
                    x3 = x3 * c3 >> fractional_bits;
                    x4 = x4 * c4 >> fractional_bits;
                    Result = fLUTValuePositive + x1 + x2 + x3 + x4;
                    Result = {{32'd0, Result}*iLUTValuePositive} >> 15;
                end
            else
                begin
                    x1 = x1 * fLUTValueNegative >> fractional_bits;
                    x2 = x2 * fLUTValueNegative >> fractional_bits;
                    x3 = x3 * fLUTValueNegative >> fractional_bits;
                    x4 = x4 * fLUTValueNegative >> fractional_bits;
                    x3 = x3 * c3 >> fractional_bits;
                    x4 = x4 * c4 >> fractional_bits;
                    Result = fLUTValueNegative + x1 + x2 + x3 + x4;
                    Result = {{32'd0, Result}*iLUTValueNegative} >> 15;
                end

            //x4 = fLUTValue + x1 + x2 + x3 + x4;
            //Result = Result * iLUTValue >> fractional_bits;
            //Result = {{32'd0, Result}*iLUTValuePositive} >> 15;
        end

endmodule
