`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/20/2018 12:14:58 PM
// Design Name: 
// Module Name: Test_Pipe
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


module Test_Pipe(
    );
    
    localparam Word_length = 32;
    localparam fractional_bits = 15;
    reg clk = 0;
    reg  [Word_length-1:0] Operand = 0;
    reg  [Word_length-1:0] OperandFractLutPart = 0;
    reg  [Word_length-1:0] OperandFractTaylorPart = 0;
    wire [Word_length-1:0] x1;
    wire [Word_length-1:0] x2;
    wire [Word_length-1:0] x3;
    wire [Word_length-1:0] x4;
    wire [Word_length-1:0] fint;
    wire [Word_length-1:0] ffract;
    
    wire [Word_length-1:0] fintOutMult;
    wire [Word_length-1:0] fintOutAdd;
    wire [Word_length-1:0] ffractOutMult;
    wire [Word_length-1:0] ffractx1;
    wire [Word_length-1:0] ffractx2;
    wire [Word_length-1:0] ffractx3;
    wire [Word_length-1:0] ffractx4;
    wire [Word_length-1:0] ffract_x_fpoly;
    wire [Word_length-1:0] Result;
    /*
    LUT_Stage #(.Word_length(32), .fractional_bits(15)) lut (
        .Operand(Operand),
        .clk(clk),
        .x1(x1),
        .x2(x2),
        .x3(x3),
        .x4(x4),
        .fint(fint),   
        .ffract(ffract)    
        );
        
    Mult_Stage #(.Word_length(32), .fractional_bits(15)) Mult_Stg (
        .clk(clk),
        .x1(x1),
        .x2(x2),
        .x3(x3),
        .x4(x4),
        .ffract(ffract),
        .fint(fint),
        .ffractOut(ffractOutMult),
        .fintOut(fintOutMult),
        .ffractx1(ffractx1),
        .ffractx2(ffractx2),
        .ffractx3(ffractx3),
        .ffractx4(ffractx4)
    );      
    
    
     Add_stage #(.Word_length(32), .fractional_bits(15)) Add_Stg (
        .clk(clk),
        .fint(fintOutMult),
        .ffract(ffractOutMult),
        .ffractx1(ffractx1),
        .ffractx2(ffractx2),
        .ffractx3(ffractx3),
        .ffractx4(ffractx4),
        .ffract_x_fpoly(ffract_x_fpoly),
        .fintOut(fintOutAdd)
    );
    
    
   Write_Stage #(.Word_length(32), .fractional_bits(15)) write_st (
        .clk(clk),
        .fint(fintOutAdd),
        .ffract_x_fpoly(ffract_x_fpoly),
        .Result(Result)
   );
   */
   // /*
    FP_Exponential #(.Word_length(32), .fractional_bits(15)) FP_Exp (
        .clk(clk),
        .Operand(Operand),
        .Result(Result)
    );
    //*/
  
    always #25 clk = ~clk;
    /*
    initial 
        begin
            Operand = {1'b0,{13{1'd0}},3'b110,6'b000011,9'b0000_0010_0};
            OperandFractLutPart = {{17{1'b1}},{Operand[14:9]},{9{1'b0}}};
            OperandFractTaylorPart = {{17{1'b1}},{6{1'b0}},{Operand[8:0]}};
        end
    */
endmodule
