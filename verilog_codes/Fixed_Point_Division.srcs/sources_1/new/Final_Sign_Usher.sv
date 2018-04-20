`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 03/28/2018 05:33:50 PM
// Design Name:
// Module Name: Final_Sign_Usher
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


module Final_Sign_Usher #(parameter Word_length = 32) (
    input wire clk,
    input wire [Word_length-1:0] Dividend,
    input wire sign,
    input wire changeFlag,
    output reg [Word_length-1:0] Result,
    output reg ready = 0
    );

    always @(posedge clk)
      begin
        if(sign == 1'b1 && changeFlag == 1) //'
            begin
                ready = 1;
                Result = ~Dividend + 1'b1; //'
            end
        else if(sign == 0 && changeFlag == 1)
            begin
                ready = 1;
                Result = Dividend;
            end
        else
            begin
                ready = 0;
                Result = Result;
            end
      end

endmodule   
