`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/30/2018 10:23:57 AM
// Design Name: 
// Module Name: Int_LUT
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

module Int_LUT #(parameter Word_length = 32, fractional_bits = 15, typeS = 1)(
    input wire [Word_length-fractional_bits-1:0] address,
    output reg [Word_length-1:0] value
    );
            
    localparam maxIntegerAvailable = 15;
    reg [Word_length-1:0] LUT [0:maxIntegerAvailable];   
    integer f;
    
    always @(*)
        begin
            if(address[Word_length-fractional_bits-1] == 1'b1 || address > maxIntegerAvailable)
                begin
                    value = {{Word_length-fractional_bits-1{1'b0}},{1'b1},{fractional_bits{1'b0}}};
                end
            else
                begin
                    value = LUT[address];
                end      
        end
    
    initial
     begin
        if(typeS == 1)
            $readmemb("/home/giovanni/xilinx_projects/Fixed_Point_Exponential/Fixed_Point_Exponential.srcs/sources_1/new/binaryIntegerLUTPositive.data", LUT);
        else
            $readmemb("/home/giovanni/xilinx_projects/Fixed_Point_Exponential/Fixed_Point_Exponential.srcs/sources_1/new/binaryIntegerLUTNegative.data", LUT);            
    end
     
endmodule