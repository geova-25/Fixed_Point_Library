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
    
    reg [5:0] address = 0;
    reg [Word_length-1:0] intValue = 0;
    reg [Word_length-1:0] fractValue1 = 0;
    reg [Word_length-1:0] fractValue2 = 0;
    reg [Word_length-1:0] fractValue3 = 0;
    reg [Word_length-1:0] fractValue4 = 0;    
    integer i = 0;
    
    /*
    Int_LUT #(.Word_length(32), .fractional_bits(24), .typeS(0)) int_LUT (
            .address(address),
            .value(intValue)
    );
    
    */
    
    
    Fract_LUT #(.Word_length(32), .typeS(1)) fract_LUT1 (
        .address(address),
        .value(fractValue1) 
        );
        
    Fract_LUT #(.Word_length(32), .typeS(2)) fract_LUT2 (
        .address(address),
        .value(fractValue2) 
        );
            
    Fract_LUT #(.Word_length(32), .typeS(3)) fract_LUT3 (
        .address(address),
        .value(fractValue3) 
        );
    Fract_LUT #(.Word_length(32), .typeS(4)) fract_LUT4 (
        .address(address),
        .value(fractValue4) 
        );
    
    initial 
        begin
             for (i = 0; i < 64; i = i + 1) 
                begin
                     #25;
                     address = i;
                     $display("%d : %b",address, fractValue1);
                     $display("%d : %b",address, fractValue2);
                     $display("%d : %b",address, fractValue3);
                     $display("%d : %b",address, fractValue4);
                end
                    
        end
    
endmodule
