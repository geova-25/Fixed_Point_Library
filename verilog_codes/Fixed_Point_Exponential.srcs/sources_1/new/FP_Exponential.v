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
    output reg [Word_length-1:0] Result = 0,
    output reg [Word_length-1:0] ResultTaylor = 0,
    output reg [Word_length-1:0] ResultTaylorxFract = 0,
    output wire [Word_length-1:0] fLUTValuePositive,
    output wire [Word_length-1:0] fLUTValueNegative,
    output wire [Word_length-1:0] iLUTValuePositive,
    output wire [Word_length-1:0] iLUTValueNegative,
    output wire [Word_length-1:0] twoComplementOperand,
    output reg [Word_length-1:0]  x1 = 0,
    output reg [Word_length-1:0] x2 = 0,
    output reg [Word_length-1:0] x3 = 0,
    output reg [Word_length-1:0] x4 = 0,
    output reg [Word_length-1:0] fractx1 = 0,
    output reg [Word_length-1:0] fractx2 = 0,
    output reg [Word_length-1:0] fractx3 = 0,
    output reg [Word_length-1:0] fractx4 = 0
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
    localparam c5 = 32'b00000000000000000000000100010001;
    localparam one = {16'b0,1'b1,15'b0};
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

    /*
    reg [bitsOfPolinomialCalc-1:0]   x1;
    reg [2*bitsOfPolinomialCalc-1:0] x2;
    reg [2*bitsOfPolinomialCalc-1:0] x3;
    reg [2*bitsOfPolinomialCalc-1:0] x4;
    */

    always @*
        begin
            //x1[bitsOfPolinomialCalc-1:0] = Operand[bitsOfPolinomialCalc-1:0];
            //x2 = ({{32'd0, x1} * x1}) >> fractional_bits;
            /*
            x2 = ({{32'b0}, x1} * x1) >> fractional_bits;
            x3 = ({{32'b0}, x2} * x1) >> fractional_bits;
            x4 = ({{32'b0}, x3} * x1) >> fractional_bits;
            */
            if(Operand[Word_length-1] == 0)
                begin
                    //x1[bitsOfPolinomialCalc-1:0] = Operand[bitsOfPolinomialCalc-1:0];/
                    x1 = {{Word_length-fractional_bits{1'b0}},{Operand[bitsOfPolinomialCalc-1:0]}};
                    //x1 = {{17{1'b1}},{6{1'b0}},Operand[bitsOfPolinomialCalc-1:0]};
                    x2 = ({{32'b0}, x1} * x1) >> fractional_bits;
                    x3 = ({{32'b0}, x2} * x1) >> fractional_bits;
                    x4 = ({{32'b0}, x3} * x1) >> fractional_bits;                
                    fractx1 = ({{32'b0}, x1} * fLUTValuePositive) >> fractional_bits;
                    fractx2 = ({{32'b0}, x2} * fLUTValuePositive) >> fractional_bits;
                    fractx3 = ({{32'b0}, x3} * fLUTValuePositive) >> fractional_bits;
                    fractx4 = ({{32'b0}, x4} * fLUTValuePositive) >> fractional_bits;
                    fractx2 = fractx2 >> 1;
                    fractx3 = ({{32'b0}, fractx3} * c3) >> fractional_bits;
                    fractx4 = ({{32'b0}, fractx4} * c4) >> fractional_bits;
                    ResultTaylor = fLUTValuePositive + fractx1 + fractx2 + fractx3 + fractx4;
                    Result = ({{32'b0}, ResultTaylor} * iLUTValuePositive) >> fractional_bits;
                end
            else
                begin
                    x1[bitsOfPolinomialCalc-1:0] = Operand[bitsOfPolinomialCalc-1:0];

                    //x1 = {{17{1'b1}},{6{1'b1}},Operand[bitsOfPolinomialCalc-1:0]};
                    x2 = ({{32'b0}, x1} * x1) >> fractional_bits;
                    x3 = ({{32'b0}, x2} * x1) >> fractional_bits;
                    x4 = ({{32'b0}, x3} * x1) >> fractional_bits;
                    fractx2 = x2 >> 1;                    
                    fractx3 = ({{32'b0}, x3} * c3) >> fractional_bits;
                    fractx4 = ({{32'b0}, x4} * c4) >> fractional_bits;                    
                    ResultTaylor = (one - x1 + fractx2 - fractx3 + fractx4);
                    ResultTaylorxFract = ({{32'b0},fLUTValueNegative} * ResultTaylor) >> fractional_bits;
                    Result = ({{32'b0}, ResultTaylorxFract} * iLUTValueNegative) >> fractional_bits;                    
                                        
                    /*-------------------V2 
                    x1 = {{17{1'b0}},{6{1'b1}},twoComplementOperand[bitsOfPolinomialCalc-1:0]};
                    x2 = ({{32'b0}, x1} * x1) >> fractional_bits;
                    x3 = ({{32'b0}, x2} * x1) >> fractional_bits;
                    x4 = ({{32'b0}, x3} * x1) >> fractional_bits;
                    fractx1 = ({{32'b0}, x1} * fLUTValueNegative) >> fractional_bits;
                    fractx2 = ({{32'b0}, x2} * fLUTValueNegative) >> fractional_bits;
                    fractx3 = ({{32'b0}, x3} * fLUTValueNegative) >> fractional_bits;
                    fractx4 = ({{32'b0}, x4} * fLUTValueNegative) >> fractional_bits;
                    fractx2 = fractx2 >> 1;
                    fractx3 = ({{32'b0}, fractx3} * c3) >> fractional_bits;
                    fractx4 = ({{32'b0}, fractx4} * c4) >> fractional_bits;
                    ResultTaylor = fLUTValueNegative + fractx1 + fractx2 + fractx3 + fractx4;
                    Result = ({{32'b0}, ResultTaylor} * iLUTValueNegative) >> fractional_bits;
                    */
                        
                    /*------------V1
                    x1 = ({{32'd0,x1}  * fLUTValueNegative}) >> fractional_bits;
                    x2 = ({{32'd0,x2}  * fLUTValueNegative}) >> fractional_bits;
                    x3 = ({{32'd0,x3}  * fLUTValueNegative}) >> fractional_bits;
                    x4 = ({{32'd0,x4}  * fLUTValueNegative}) >> fractional_bits;
                    x2 = x2 >> 1;
                    x3 = ({{32'd0, x3} * c3}) >> fractional_bits;
                    x4 = ({{32'd0, x4} * c4}) >> fractional_bits;
                    ResultTaylor = fLUTValueNegative + x1 + x2 + x3 + x4;
                    Result = {{32'd0, ResultTaylor}*iLUTValueNegative} >> 15;
                    */
                end

        end

endmodule
