`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 03/28/2018 05:07:51 PM
// Design Name:
// Module Name: Test_FPDivider
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

module Test_FPDivider();

    parameter Word_length_local = 32;
    parameter fractional_bits__local = 24;
    reg clk = 0;
    reg [Word_length_local-1:0] dividend = 0;
    reg [Word_length_local -1:0] divisor = 0;
    wire [Word_length_local-1:0] result;
    wire ready;

   
    fixed_point_divider #(.Word_length(Word_length_local),.fractional_bits(fractional_bits__local)) FPD(
        clk,
        divisor,  //M
        dividend, //Q
        result,
        ready
    );

    

    always
      #25 clk = !clk;

    initial
      begin
      #5;
        assign dividend = {1'b0,7'd0,1'b1,23'd0};
        assign divisor  = {1'b1,7'd7,24'd0};
      #250;
        assign dividend = {1'b0,7'd8,24'd0};
        assign divisor  = {1'b0,7'd9,24'd0};
      #300;
        assign dividend = {1'b1,7'd3,24'd0};
        assign divisor  = {1'b0,7'd27,24'd0};
        
   
        //assign dividend = {1'b0,7'd0,3'b101,21'd0};
        //assign divisor  = {1'b0,7'd0,3'b111,21'd0};
                
      end

endmodule
