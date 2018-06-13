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


module FP_Exponential #(parameter Word_length = 32, fractional_bits = 24)(
    input wire clk,
    input wire [Word_length-1:0] Operand,
    //input wire [19:0] OperandIn,
    //input wire sign,
    output wire [Word_length-1:0] Result,
    output wire sign1,sign2,sign3 
    //output wire [Word_length-1:0] Result
    /*
    output reg [Word_length-1:0] ResultTaylor = 0,
    output reg [Word_length-1:0] ResultTaylorxFract = 0 
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
    */
    );
    wire [Word_length-1:0] Result_Write;
    
    //wire [Word_length-1:0] Operand;
    wire [Word_length-1:0] Operand2;
    //assign Operand[19:0] = OperandIn;
    //assign Operand[31:20] = (sign == 1'b1) ? 12'b1111_1111_1111:
    //                        (sign == 1'b0) ? 12'b0000_0000_0000:
    //                        11'b0000_0000_0000;
    
    wire [Word_length-1:0] x1;
    wire [Word_length-1:0] x2;
    wire [Word_length-1:0] x3;
    wire [Word_length-1:0] x4;

    wire [Word_length-1:0] Reg_x1;
    wire [Word_length-1:0] Reg_x2;
    wire [Word_length-1:0] Reg_x3;
    wire [Word_length-1:0] Reg_x4;
    
    wire [Word_length-1:0] fint;
    wire [Word_length-1:0] fintReg1;
    wire [Word_length-1:0] fintReg2;
    //wire [Word_length-1:0] fintOutMult;
    wire [Word_length-1:0] fintOutAdd;
    wire [Word_length-1:0] ffract;
    wire [Word_length-1:0] ffractReg1;  
    wire [Word_length-1:0] ffractReg2;        
    //wire [Word_length-1:0] ffractOutMult;
    
    wire [Word_length-1:0] ffractx1;
    wire [Word_length-1:0] ffractx2;
    wire [Word_length-1:0] ffractx3;
    wire [Word_length-1:0] ffractx4;
    
    wire [Word_length-1:0] Reg_ffractx1_Add;
    wire [Word_length-1:0] Reg_ffractx2_Add;
    wire [Word_length-1:0] Reg_ffractx3_Add;
    wire [Word_length-1:0] Reg_ffractx4_Add;        
    
    wire [Word_length-1:0] ffract_x_fpoly;
    
    //wire sign1,sign2,sign3;
    
    Output_Reg #(.Word_length(Word_length), .fractional_bits(fractional_bits)) in_reg (
        .clk(clk),
        .Result_Write(Operand),
        .Result(Operand2) 
    );

    LUT_Stage #(.Word_length(Word_length), .fractional_bits(fractional_bits)) LUT_Stg(
        //.clk(clk),
        //.Operand(Operand),
        .Operand(Operand2),  
        //-----------Outputs      
        .x1(x1),
        .x2(x2),
        .x3(x3),
        .x4(x4),
        .fint(fint),   
        .ffract(ffract),
        .sign(sign1)
    );        
    
    Cm_Registers #(.Word_length(Word_length),.fractional_bits(fractional_bits)) CM_1(
        .clk(clk),        
        .signIn(sign1),
        .fint(fint),
        .ffract(ffract),
        .Entry1(x1),
        .Entry2(x2),
        .Entry3(x3),
        .Entry4(x4),
        //-------------Outputs
        .signOut(sign2),
        .Fint_Reg(fintReg1),
        .Ffract_Reg(ffractReg1),
        .Reg_1(Reg_x1),
        .Reg_2(Reg_x2),
        .Reg_3(Reg_x3),
        .Reg_4(Reg_x4)  
    );
    
 
    Mult_Stage #(.Word_length(Word_length), .fractional_bits(fractional_bits)) Mult_Stg (
        //.clk(clk),
        .x1(Reg_x1),
        .x2(Reg_x2),
        .x3(Reg_x3),
        .x4(Reg_x4),
        .ffract(ffractReg1),
        //.fint(fintReg1),
        //-------------Outputs
        //.ffractOut(ffractOutMult),
        //.fintOut(fintOutMult),
        .ffractx1(ffractx1),
        .ffractx2(ffractx2),
        .ffractx3(ffractx3),
        .ffractx4(ffractx4)
    );
  
    Cm_Registers #(.Word_length(Word_length),.fractional_bits(fractional_bits)) CM_2(
        .clk(clk),        
        .signIn(sign2),
        .fint(fintReg1),
        .ffract(ffractReg1),
        .Entry1(ffractx1),
        .Entry2(ffractx2),
        .Entry3(ffractx3),
        .Entry4(ffractx4),
        //-------------Outputs
        .signOut(sign3),        
        .Fint_Reg(fintReg2),
        .Ffract_Reg(ffractReg2),        
        .Reg_1(Reg_ffractx1_Add),
        .Reg_2(Reg_ffractx2_Add),
        .Reg_3(Reg_ffractx3_Add),
        .Reg_4(Reg_ffractx4_Add)        
    );
    
    Add_stage #(.Word_length(Word_length), .fractional_bits(fractional_bits)) Add_Stg (
        //.clk(clk),
        .sign(sign3),
        .fint(fintReg2),
        .ffract(ffractReg2),
        .ffractx1(Reg_ffractx1_Add),
        .ffractx2(Reg_ffractx2_Add),
        .ffractx3(Reg_ffractx3_Add),
        .ffractx4(Reg_ffractx4_Add),
        //-------------Outputs
        .ffract_x_fpoly(ffract_x_fpoly),
        .fintOut(fintOutAdd)
    );           
    
    wire  [Word_length-1:0] ffract_x_fpoly_Write;
    wire  [Word_length-1:0] fintOutAdd_Write;
    
    Reg_2_32Bits #(.Word_length(Word_length),.fractional_bits(fractional_bits)) mkjhgfh (
        .clk(clk),
        .Entry_1(ffract_x_fpoly),
        .Entry_2(fintOutAdd),
        .Out_1(ffract_x_fpoly_Write),
        .Out_2(fintOutAdd_Write)
    );

    
    
    Write_Stage #(.Word_length(Word_length), .fractional_bits(fractional_bits)) Wr_Stage (
        //.clk(clk),
        .fint(fintOutAdd_Write),
        .ffract_x_fpoly(ffract_x_fpoly_Write),
        //-------------Output
        .Result(Result_Write)
    );
    
    Output_Reg #(.Word_length(32), .fractional_bits(15)) out_reg (
        .clk(clk),
        .Result_Write(Result_Write),
        .Result(Result) 
    );


endmodule
