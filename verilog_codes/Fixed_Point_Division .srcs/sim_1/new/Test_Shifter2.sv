`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/09/2018 06:53:59 PM
// Design Name: 
// Module Name: Test_Shifter2
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


module Test_Shifter2(

    );
    
    parameter Word_length = 32;
    parameter fractional_bits = 24;
    
    reg [Word_length-1:0] dividend = 0;
    reg [Word_length-1:0] divisor = 0;
    wire [Word_length-1:0] shiftedA;
    wire [Word_length-1:0] shiftedB;
    
 shifterOperands #(.Word_length(Word_length), .fractional_bits(fractional_bits)) sfop (
        dividend,
        divisor,
        shiftedA,
        shiftedB
        );   
        

initial 
    begin
        dividend = {8'd40,24'd0};
        divisor = {8'd111,24'd0};
        #200;
        #50
        dividend = {8'd70,24'd0};
        divisor = {8'd5,24'd0};
    end
    
endmodule
