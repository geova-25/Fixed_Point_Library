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
    reg [Word_length-1:0] Operand;
    //reg [:0] Operand;

    
    wire [Word_length-1:0] Result;
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
    
    wire [Word_length-1:0] Reg_ffractx1;
    wire [Word_length-1:0] Reg_ffractx2;
    wire [Word_length-1:0] Reg_ffractx3;
    wire [Word_length-1:0] Reg_ffractx4;
    
    wire [Word_length-1:0] Reg_ffractx1_Add;
    wire [Word_length-1:0] Reg_ffractx2_Add;
    wire [Word_length-1:0] Reg_ffractx3_Add;
    wire [Word_length-1:0] Reg_ffractx4_Add;    
    
    wire [Word_length-1:0] ffract_x_fpoly;
/*
    LUT_Stage #(.Word_length(Word_length), .fractional_bits(fractional_bits)) LUT_Stg(
        //.clk(clk),
        //.Operand(Operand),
        .Operand(Operand),  
        //-----------Outputs      
        .x1(x1),
        .x2(x2),
        //.x3(x3),
        //.x4(x4),
        .fint(fint),   
        .ffract(ffract)    
    );        
    
    Cm_Registers #(.Word_length(Word_length),.fractional_bits(fractional_bits)) CM_1(
        .clk(clk),        
        .fint(fint),
        .ffract(ffract),
        .Entry1(x1),
        .Entry2(x2),
        //.Entry3(x3),
        //.Entry4(x4),
        //-------------Outputs
        .Fint_Reg(fintReg1),
        .Ffract_Reg(ffractReg1),
        .Reg_1(Reg_x1),
        .Reg_2(Reg_x2)
        //.Reg_3(Reg_x3),
        //.Reg_4(Reg_x4)  
    );
    
 
    Mult_Stage #(.Word_length(Word_length), .fractional_bits(fractional_bits)) Mult_Stg (
        //.clk(clk),
        .x1(Reg_x1),
        .x2(Reg_x2),
        //.x3(Reg_x3),
        //.x4(Reg_x4),
        .ffract(ffractReg1),
        //.fint(fintReg1),
        //-------------Outputs
        //.ffractOut(ffractOutMult),
        //.fintOut(fintOutMult),
        .ffractx1(ffractx1),
        .ffractx2(ffractx2)
        //.ffractx3(ffractx3),
        //.ffractx4(ffractx4)
    );
  
    Cm_Registers #(.Word_length(Word_length),.fractional_bits(fractional_bits)) CM_2(
        .clk(clk),        
        .fint(fintReg1),
        .ffract(ffractReg1),
        .Entry1(ffractx1),
        .Entry2(ffractx2),
        //.Entry3(ffractx3),
        //.Entry4(ffractx4),
        //-------------Outputs
        .Fint_Reg(fintReg2),
        .Ffract_Reg(ffractReg2),        
        .Reg_1(Reg_ffractx1_Add),
        .Reg_2(Reg_ffractx2_Add)
        //.Reg_3(Reg_ffractx3_Add),
        //.Reg_4(Reg_ffractx4_Add)        
    );
    
    Add_stage #(.Word_length(Word_length), .fractional_bits(fractional_bits)) Add_Stg (
        //.clk(clk),
        .fint(fintReg2),
        .ffract(ffractReg2),
        .ffractx1(Reg_ffractx1_Add),
        .ffractx2(Reg_ffractx2_Add),
        //.ffractx3(Reg_ffractx3_Add),
        //.ffractx4(Reg_ffractx4_Add),
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
        .clk(clk),
        .fint(fintOutAdd_Write),
        .ffract_x_fpoly(ffract_x_fpoly_Write),
        //-------------Output
        .Result(Result)
    );
 */
    
   //*/
   
    /*
    FP_Exponential #(.Word_length(32), .fractional_bits(15)) FP_Exp (
        .clk(clk),
        .Operand(Operand),
        .Result(Result)
    );   
    */
    
    FP_Exponential #(.Word_length(32), .fractional_bits(15)) FP_Exp (
        .clk(clk),
        .OperandIn(Operand[19:0]),
        .sign(Operand[31]),
        .Result(Result)
    );
    //*/
    
    int fpOpBin, fpReBin;
    int endCondition = 0;
  
    always #25 clk = ~clk;
    int counter = 0;
     always @(posedge clk)
               begin
                   if(counter == 0)
                   begin
                        counter = counter + 1;

                       endCondition = $fscanf(fpOpBin,"%b",Operand);
                       //OperandFractLutPart = {{17{1'b1}},{Operand[14:9]},{9{1'b1}}};
                       //OperandFractTaylorPart = {{17{1'b1}},{6{1'b1}},{Operand[8:0]}};
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
                   else if (counter == 4)
                        counter = 0;
                   else
                        counter = counter + 1;
               end    
    
    initial 
        begin        
            fpOpBin = $fopen("/home/giovanni/xilinx_projects/Fixed_Point_Exponential/Fixed_Point_Exponential.srcs/sources_1/new/OperandsBinaryExp.txt","r");
            fpReBin = $fopen("/home/giovanni/xilinx_projects/Fixed_Point_Exponential/Fixed_Point_Exponential.srcs/sources_1/new/ResultBinaryExp.txt","w+");
            $fclose(fpReBin);
        
            //Operand = {1'b0,{13{1'd0}},3'b110,6'b000011,9'b0000_0010_0};
            //OperandFractLutPart = {{17{1'b1}},{Operand[14:9]},{9{1'b0}}};
            //OperandFractTaylorPart = {{17{1'b1}},{6{1'b0}},{Operand[8:0]}};
        end
  
endmodule
