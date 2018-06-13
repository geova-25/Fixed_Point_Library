`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/30/2018 10:23:57 AM
// Design Name: 
// Module Name: Fract_LUT
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


module Fract_LUT #(parameter Word_length = 32, typeS = 1)(
    input wire [5:0] address,
    output reg [Word_length-1:0] value 
    );
    
    reg [Word_length-1:0] LUT [0:63];  
    
    always @*
        begin
            value = LUT[address];
        end
    
    initial
         begin
            if(typeS == 1)
                $readmemb("/home/giovanni/xilinx_projects/Fixed_Point_Exponential/Fixed_Point_Exponential.srcs/sources_1/new/binaryFractionalLUTPositive.data", LUT);
            else if(typeS == 2)
                $readmemb("/home/giovanni/xilinx_projects/Fixed_Point_Exponential/Fixed_Point_Exponential.srcs/sources_1/new/binaryFractionalLUTNegative.data", LUT);
            else if(typeS == 3)
                $readmemb("/home/giovanni/xilinx_projects/Fixed_Point_Exponential/Fixed_Point_Exponential.srcs/sources_1/new/binaryFractionalLUTPositive2.data", LUT);
            else if(typeS == 4)
                $readmemb("/home/giovanni/xilinx_projects/Fixed_Point_Exponential/Fixed_Point_Exponential.srcs/sources_1/new/binaryFractionalLUTNegative2.data", LUT);                                                
        end 
 
endmodule