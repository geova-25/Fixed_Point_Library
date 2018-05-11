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
    output wire [Word_length-1:0] fLUTValue,
    output wire [Word_length-1:0] iLUTValue
    );
    
    localparam bitsOfPolinomialCalc = 9;
    
    //------------------------------------Testing 5.5
    
    //localparam fLUT =  32'b00000000000000001101001100001001;
    //localparam iLUT =  32'b00000000010010100011010011100010;
    //wire [Word_length-1:0] fLUTValue;
    //wire [Word_length-1:0] iLUTValue;
    
    localparam c3 = 3;
    localparam c4 = 3;
    
    
    Int_LUT #(.Word_length(Word_length), .fractional_bits(fractional_bits)) int_LUT (
        .address(Operand[Word_length-1:fractional_bits]),
        .value(iLUTValue)
    );
    
    
    /*Fract_LUT #(.Word_length(Word_length)) fract_LUT (
        .address({Operand[9],Operand[10],Operand[11],Operand[12],Operand[13],Operand[14]}),
        .value(fLUTValue) 
        );
    */
    
    Fract_LUT #(.Word_length(Word_length)) fract_LUT (
            .address(Operand[fractional_bits-1:bitsOfPolinomialCalc]),
            .value(fLUTValue) 
            );        
    
    reg [bitsOfPolinomialCalc-1:0]   x1;
    reg [2*bitsOfPolinomialCalc-1:0] x2;
    reg [2*bitsOfPolinomialCalc-1:0] x3;
    reg [2*bitsOfPolinomialCalc-1:0] x4;
    
    always @(*)
        begin
            x1 = Operand[bitsOfPolinomialCalc-1:0];
            x2 = x1*x1;
            x3 = x2*x1;
            x4 = x3*x1;
            
            x1 = x1 * fLUTValue;
            x2 = x2 * fLUTValue;
            x3 = x3 * fLUTValue;
            x4 = x4 * fLUTValue;
            
            x3 = x3 * c3;
            x4 = x4 * c4;
            
            x4 = fLUTValue + x1 + x2 + x3 + x4;
            
            Result = {{32'd0, x4}*iLUTValue} >> 15;
            //Result = x4 * iLUT;
            
        end
   
endmodule
