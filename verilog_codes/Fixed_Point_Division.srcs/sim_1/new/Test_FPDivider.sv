`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 03/28/2018 05:07:51 PM
// Design Name:
// Module Name: Test_FPDivider
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

module Test_FPDivider();

    parameter Word_length_local = 32;
    parameter fractional_bits_local = 24;
    reg clk = 0;
    reg [Word_length_local-1:0] dividend = 0;
    reg [Word_length_local -1:0] divisor = 0;
    wire [Word_length_local-1:0] result;
    wire ready;
    reg firstTime = 0;
    reg [Word_length_local-1:0] testStringA;
    reg [Word_length_local-1:0] testStringB;
    int fdOpBin,fdReBin,scra,scrb,scwr;
    string opa,opb;
    
    fixed_point_divider #(.Word_length(Word_length_local),.fractional_bits(fractional_bits_local)) FPD(
        clk,
        divisor,  //M
        dividend, //Q
        result,
        ready
    );
    

/*
always
    begin 
    #50
    if(ready == 1)
        begin    
            if(firstTime == 0)
                begin
                    firstTime = 1;
                    fdOpBin = $fopen("/home/giovanni/xilinx_projects/Fixed_Point_Division/Fixed_Point_Division.srcs/sim_1/new/OperandsBinary.txt","r");                  
                    fdReBin = $fopen("/home/giovanni/xilinx_projects/Fixed_Point_Division/Fixed_Point_Division.srcs/sim_1/new/ResultBinary.txt","w+");                    
                    $fclose(fdReBin);
                end
            begin                  
                fdReBin = $fopen("/home/giovanni/xilinx_projects/Fixed_Point_Division/Fixed_Point_Division.srcs/sim_1/new/ResultBinary.txt","a+"); 
                $display("------------------------------------------------------------");
                $fwrite(fdReBin,"%b \n",result);
                scra = $fscanf(fdOpBin,"%b",testStringA);
                scrb = $fscanf(fdOpBin,"%b",testStringB);
                $display("%b",testStringA); 
                $display("%b",testStringB);
                divisor = testStringB;
                dividend = testStringA;
                $fclose(fdReBin);
                //$fclose(fdOpBin);
               
                //divisor[Word_length_local - 1] = $random%2;
                //dividend[Word_length_local - 1] = $random%2;
                //divisor[23:10] = $random%8000;
                //dividend[23:10] = $random%8000;
                //divisor[Word_length_local:fractional_bits_local] = $random%120;
                //dividend[Word_length_local:fractional_bits_local] = $random%120;
               
            end
        end
    end  
*/
    always
      #25 clk = !clk;
      
    initial
      begin
      #5;
        assign dividend = {1'b0,7'd8,24'd0};
        assign divisor  = {1'b0,7'd9,24'd0};
      /*
      #250;
        assign dividend = {1'b0,7'd8,24'd0};
        assign divisor  = {1'b0,7'd9,24'd0};
      #300;
        assign dividend = {1'b1,7'd3,24'd0};
        assign divisor  = {1'b0,7'd27,24'd0};
      #300;
        assign dividend = {1'b1,7'd1,24'd0};
        assign divisor  = {1'b1,7'd5,24'd0};        
     
        //assign dividend = {1'b0,7'd0,3'b101,21'd0};
        //assign divisor  = {1'b0,7'd0,3'b111,21'd0};
      */        
      end

endmodule
