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
    localparam one = {16'b0,1'b1,15'b0};

    reg clk = 0;
    reg [Word_length-1:0]Operand = 0;
    reg [Word_length-1:0]OperandFractLutPart = 0;
    reg [Word_length-1:0]OperandFractTaylorPart = 0;
    reg [Word_length-1: 0] Result = 0;
    reg [Word_length-1: 0] ResultTaylor = 0;
    reg [Word_length-1: 0] ResultTaylorxFract = 0;
    reg [Word_length-1: 0] fLUTValuePositive = 0;
    reg [Word_length-1: 0] fLUTValueNegative = 0;
    reg [Word_length-1: 0] iLUTValuePositive = 0;
    reg [Word_length-1: 0] iLUTValueNegative = 0;
    reg [Word_length-1:0] twoComplementOperand = 0;

    localparam bitsOfPolinomialCalc = 9;
    reg [Word_length-1:0] x1 = 0;
    reg [Word_length-1:0] x2 = 0;
    reg [Word_length-1:0] x3 = 0;
    reg [Word_length-1:0] x4 = 0;

    int fpOpBin, fpReBin;
    int endCondition = 0;

    FP_Exponential #(.Word_length(Word_length), .fractional_bits(fractional_bits)) FP_Exponential(
        .Operand(Operand),
        .Result(Result),
        .ResultTaylor(ResultTaylor),
        .ResultTaylorxFract(ResultTaylorxFract),
        .fLUTValuePositive(fLUTValuePositive),
        .fLUTValueNegative(fLUTValueNegative),
        .iLUTValuePositive(iLUTValuePositive),
        .iLUTValueNegative(iLUTValueNegative),
        .twoComplementOperand(twoComplementOperand),
        .x1(x1),
        .x2(x2),
        .x3(x3),
        .x4(x4)
    );
    ///*
    always @(posedge clk)
        begin
            endCondition = $fscanf(fpOpBin,"%b",Operand);
            OperandFractLutPart = {{17{1'b1}},{Operand[14:9]},{9{1'b1}}};
            OperandFractTaylorPart = {{17{1'b1}},{6{1'b1}},{Operand[8:0]}};
            if(endCondition != -1)
            begin
                #50;
                fpReBin = $fopen("/home/giovanni/xilinx_projects/Fixed_Point_Exponential/Fixed_Point_Exponential.srcs/sources_1/new/ResultBinaryExp.txt","a+");
                $fwrite(fpReBin,"%b \n",Result);
                $fclose(fpReBin);
            end
            else
            begin
                $fclose(fpOpBin);
            end
        end


    always #100 clk = ~clk;
    //*/
    initial
    begin
    ///*
      fpOpBin = $fopen("/home/giovanni/xilinx_projects/Fixed_Point_Exponential/Fixed_Point_Exponential.srcs/sources_1/new/OperandsBinaryExp.txt","r");
      fpReBin = $fopen("/home/giovanni/xilinx_projects/Fixed_Point_Exponential/Fixed_Point_Exponential.srcs/sources_1/new/ResultBinaryExp.txt","w+");
      $fclose(fpReBin);
    //*/  
        /*     
        Operand = {1'b1,{13{1'b1}},3'b101,6'b000000,9'b0000_1001_0};
        OperandFractLutPart = {{17{1'b1}},{Operand[14:9]},{9{1'b1}}};
        OperandFractTaylorPart = {{17{1'b1}},{6{1'b1}},{Operand[8:0]}};
        
        #25;
        
        Operand = {1'b1,{13{1'b1}},3'b101,6'b011100,9'b0000_1001_0};
        OperandFractLutPart = {{17{1'b1}},{Operand[14:9]},{9{1'b1}}};
        OperandFractTaylorPart = {{17{1'b1}},{6{1'b1}},{Operand[8:0]}};
  
          #25;

        //---------------------------
        Operand = {1'b0,{13{1'd0}},4'b101,6'b011010,9'b1010_0000_0};
        OperandFractLutPart = {{17{1'b1}},{Operand[14:9]},{9{1'b0}}};
        OperandFractTaylorPart = {{17{1'b1}},{6{1'b0}},{Operand[8:0]}};

        #25;

        //---------------------------
        Operand = {1'b0,{13{1'd0}},3'b110,6'b000011,9'b0000_0010_0};
        OperandFractLutPart = {{17{1'b1}},{Operand[14:9]},{9{1'b0}}};
        OperandFractTaylorPart = {{17{1'b1}},{6{1'b0}},{Operand[8:0]}};

        #25;

        //---------------------------
        Operand = {1'b1,{13{1'b1}},3'b010,6'b000000,9'b1111_1111_1};
        OperandFractLutPart = {{17{1'b1}},{Operand[14:9]},{9{1'b0}}};
        OperandFractTaylorPart = {{17{1'b1}},{6{1'b0}},{Operand[8:0]}};
        
        #25;

        //---------------------------
        Operand = {1'b1,{13{1'b1}},3'b010,6'b000000,9'b1111_1111_1};
        OperandFractLutPart = {{17{1'b1}},{Operand[14:9]},{9{1'b0}}};
        OperandFractTaylorPart = {{17{1'b1}},{6{1'b0}},{Operand[8:0]}};
        */
    end

endmodule
