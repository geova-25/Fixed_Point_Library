`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/21/2018 05:15:12 PM
// Design Name: 
// Module Name: Reg_2_32Bits
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


module Reg_2_32Bits #(parameter Word_length = 32, fractional_bits = 15) (
    input clk,
    input [Word_length-1:0] Entry_1,
    input [Word_length-1:0] Entry_2,
    output reg [Word_length-1:0] Out_1,
    output reg [Word_length-1:0] Out_2
    );
    
    always @(posedge clk)
    begin
        Out_1 <= Entry_1;
        Out_2 <= Entry_2;        
    end
endmodule
