`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/20/2018 09:33:54 AM
// Design Name: 
// Module Name: Add_stage
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


module Add_stage #(parameter Word_length = 32, fractional_bits = 15)(
    //input clk,
    input sign,
    input [Word_length-1:0] fint,
    input [Word_length-1:0] ffract,
    input [Word_length-1:0] ffractx1,
    input [Word_length-1:0] ffractx2,
    //input [Word_length-1:0] ffractx3,
    //input [Word_length-1:0] ffractx4,
    output reg [Word_length-1:0] ffract_x_fpoly,
    output reg [Word_length-1:0] fintOut
    );
    
    //reg [Word_length-1:0] ffractx2Aux;
    //reg [Word_length-1:0] ffractx3Aux;
    //reg [Word_length-1:0] ffractx4Aux;
    
    localparam c3 = 32'b00000000000000000001010101010100;
    localparam c4 = 32'b00000000000000000000010110000000;
    
    //always @(posedge clk)

    always @(*)
    begin
        fintOut = fint;        
        //ffract_x_fpoly = ffract_x_fpoly +  (({{32'b0}, ffractx3} * c3) >> fractional_bits);
        //ffract_x_fpoly = ffract_x_fpoly + (({{32'b0}, ffractx4} * c4) >> fractional_bits);  
        if(sign == 1'b1)                
            ffract_x_fpoly = ffract - ffractx1 + (ffractx2 >> 1);
        else
            ffract_x_fpoly = ffract + ffractx1 + (ffractx2 >> 1);
        //ffract_x_fpoly = ffract; 
        
    
    /*
        ffractx2Aux = ffractx2 >> 1;
        ffractx3Aux = ({{32'b0}, ffractx3} * c3) >> fractional_bits;
        ffractx4Aux = ({{32'b0}, ffractx4} * c4) >> fractional_bits;                    
        ffract_x_fpoly = ffract + ffractx1 + ffractx2 >> 1 + ffractx3Aux + ffractx4Aux;  
        fintOut = fint;
    */
    end
    
endmodule
