`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/09/2018 02:39:33 PM
// Design Name: 
// Module Name: shifterOperands
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


module shifterOperands #(Word_length=32, fractional_bits=24)(
    input wire [Word_length-1:0] dividend,
    input wire [Word_length-1:0] divisor,
    output reg [Word_length-1:0] shiftedA = 0,
    output reg [Word_length-1:0] shiftedB = 0
    );

    reg [31:0] extendedDivisor = 0;
    reg [6:0] quantityOfShifts = 0;   
    always @*
    begin
        extendedDivisor[31:0] = divisor[Word_length-1:fractional_bits];
        casez(extendedDivisor)
            32'b1zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz:       
                quantityOfShifts = 32;
            32'bz1zzzzzzzzzzzzzzzzzzzzzzzzzzzzzz:
                quantityOfShifts = 31;
            32'bzz1zzzzzzzzzzzzzzzzzzzzzzzzzzzzz:
                quantityOfShifts = 30;                
            32'bzzz1zzzzzzzzzzzzzzzzzzzzzzzzzzzz:
                quantityOfShifts = 29;
            32'bzzzz1zzzzzzzzzzzzzzzzzzzzzzzzzzz:
                quantityOfShifts = 28;
            32'bzzzzz1zzzzzzzzzzzzzzzzzzzzzzzzzz:
                quantityOfShifts = 27;
            32'bzzzzzz1zzzzzzzzzzzzzzzzzzzzzzzzz:
                quantityOfShifts = 26;
            32'bzzzzzzz1zzzzzzzzzzzzzzzzzzzzzzzz:
                quantityOfShifts = 25;
            32'bzzzzzzzz1zzzzzzzzzzzzzzzzzzzzzzz:
                quantityOfShifts = 24;
            32'bzzzzzzzzz1zzzzzzzzzzzzzzzzzzzzzz:
                quantityOfShifts = 23;
            32'bzzzzzzzzzz1zzzzzzzzzzzzzzzzzzzzz:
                quantityOfShifts = 22;
            32'bzzzzzzzzzzz1zzzzzzzzzzzzzzzzzzzz:
                quantityOfShifts = 21;
            32'bzzzzzzzzzzzz1zzzzzzzzzzzzzzzzzzz:
                quantityOfShifts = 20;
            32'bzzzzzzzzzzzzz1zzzzzzzzzzzzzzzzzz:
                quantityOfShifts = 19;
            32'bzzzzzzzzzzzzzz1zzzzzzzzzzzzzzzzz:
                quantityOfShifts = 18;
            32'bzzzzzzzzzzzzzzz1zzzzzzzzzzzzzzzz:
                quantityOfShifts = 17;
            32'bzzzzzzzzzzzzzzzz1zzzzzzzzzzzzzzz:
                quantityOfShifts = 16;
            32'bzzzzzzzzzzzzzzzzz1zzzzzzzzzzzzzz:
                quantityOfShifts = 15;
            32'bzzzzzzzzzzzzzzzzzz1zzzzzzzzzzzzz:
                quantityOfShifts = 14;
            32'bzzzzzzzzzzzzzzzzzzz1zzzzzzzzzzzz:
                quantityOfShifts = 13;
            32'bzzzzzzzzzzzzzzzzzzzz1zzzzzzzzzzz:
                quantityOfShifts = 12;
            32'bzzzzzzzzzzzzzzzzzzzzz1zzzzzzzzzz:
                quantityOfShifts = 11;
            32'bzzzzzzzzzzzzzzzzzzzzzz1zzzzzzzzz:
                quantityOfShifts = 10;
            32'bzzzzzzzzzzzzzzzzzzzzzzz1zzzzzzzz:
                quantityOfShifts = 9;
            32'bzzzzzzzzzzzzzzzzzzzzzzzz1zzzzzzz:
                quantityOfShifts = 8;
            32'bzzzzzzzzzzzzzzzzzzzzzzzzz1zzzzzz:
                quantityOfShifts = 7;
            32'bzzzzzzzzzzzzzzzzzzzzzzzzzz1zzzzz:
                quantityOfShifts = 6;
            32'bzzzzzzzzzzzzzzzzzzzzzzzzzzz1zzzz:
                quantityOfShifts = 5;
            32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzz1zzz:
                quantityOfShifts = 4;
            32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzz1zz:
                quantityOfShifts = 3;
            32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz1z:
                quantityOfShifts = 2;
            32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz1:
                quantityOfShifts = 1;
            default:
                quantityOfShifts = 0;                                                
        endcase
        shiftedA = dividend >> quantityOfShifts;
        shiftedB = divisor >> quantityOfShifts;        
    end
 /*
 always @(*)
    begin
        if(start == 1)
         begin
             shiftedA = dividend >> quantityOfShifts;
             shiftedB = divisor >> quantityOfShifts;
         end
        else
         begin
             shiftedA = shiftedA;
             shiftedB = shiftedB;     
         end   
    end 
*/
endmodule
