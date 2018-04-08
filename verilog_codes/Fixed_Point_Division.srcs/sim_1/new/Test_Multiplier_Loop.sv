`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 03/30/2018 07:45:05 PM
// Design Name:
// Module Name: Test_Multiplier_Loop
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


module Test_Multiplier_Loop (
    );

    parameter Word_length = 32;
    parameter fractional_bits = 24;

    reg clk = 0;
    reg [Word_length-1:0] dvd = {1'b0,7'd0,6'b110101,18'b0}; //';
    reg [Word_length-1:0] dvr = {1'b0,7'd0,6'b111101,18'b0}; //'
    reg [Word_length-1:0] f;
    reg [Word_length-1:0] result;
    reg done, signIN, signOut;
    reg go = 0;

Multiply_Loop #(.Word_length(Word_length),.fractional_bits(fractional_bits)) ML (
        clk,
        go,
        dvr,
        dvd,
        f,
        signIN,
        signOut,
        result,
        done
);

always #50 clk = ~clk;

always
    begin
        #500 
        if(done == 1)
            begin
                //dvr = {1'b0,7'd0,6'b100001,18'b0}; //'
                //dvd = {1'b0,7'd0,6'b111111,18'b0}; //';
                dvr[23:22] = dvr[23:22] + 1;
                dvd[23:22] = dvd[23:22] + 1;
                f   = dvr;
                go = 1;
                #100
                go = 0;
            end
    end
    
 

  initial
    begin
    #50
    dvr = {1'b0,7'd0,6'b111101,18'b0}; //';
    dvd = {1'b0,7'd0,6'b110101,18'b0}; //';
    f   = dvr;
    go = 1;
    #100
      go = 0;
    end


endmodule
