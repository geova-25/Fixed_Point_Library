`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/20/2018 09:40:04 AM
// Design Name: 
// Module Name: Write_Stage
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


module Write_Stage #(parameter Word_length = 32, fractional_bits = 15) (
    //input clk,
    input [Word_length-1:0] fint,
    input [Word_length-1:0] ffract_x_fpoly,
    output reg [Word_length-1:0] Result
    );
    
    //always @(posedge clk)
    always @(*)
    begin
        Result = ({{32'b0}, ffract_x_fpoly} * fint) >> fractional_bits;
    end
    
endmodule
