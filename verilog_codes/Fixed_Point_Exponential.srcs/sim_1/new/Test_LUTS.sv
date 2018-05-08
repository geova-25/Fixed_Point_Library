`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/07/2018 02:15:54 PM
// Design Name: 
// Module Name: Test_LUTS
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


module Test_LUTS(

    );
    
    localparam Word_length = 32;
    localparam fractional_bits = 24;
    
    reg [Word_length-1:0] address = 0;
    reg [Word_length-1:0] intValue = 0;
    reg [Word_length-1:0] fractValue = 0;    
    integer i = 0;
    
    Int_LUT #(.Word_length(32), .fractional_bits(24)) int_LUT (
            .address(address),
            .value(intValue)
    );
    
    
    Fract_LUT #(.Word_length(32)) fract_LUT (
        .address(address),
        .value(fractValue) 
        );
    
    initial 
        begin
             for (i = 5; i < 64; i = i + 1) 
                begin
                     #25;
                     address = i;
                     $display("%d : %b",address, fractValue);
                end
                    
        end
    
endmodule
