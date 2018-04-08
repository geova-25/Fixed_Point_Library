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
    input reg [Word_length-1:0] Dividend,
    input reg sign,
    input wire ready,
    output reg [Word_length-1:0] Result
    );

    always @*
      begin
        if(sign == 1'b1 && ready) //'
          begin
            Result = ~Dividend + 1'b1; //'
          end
        else if(sign == 1'b0 && ready)
          begin
            Result = Dividend;
          end
        else
            Result = Result;
      end

endmodule
