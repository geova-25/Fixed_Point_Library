`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/26/2018 01:22:23 PM
// Design Name: 
// Module Name: Output_Reg
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


module Output_Reg#(parameter Word_length = 32, fractional_bits = 15) (
    input clk,
    input wire [Word_length-1:0] Result_Write,
    output reg [Word_length-1:0] Result = 0 
    );
    
    always @(posedge clk)
            Result = Result_Write;   
    
endmodule
