`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 02/14/2018 05:42:44 PM
// Design Name:
// Module Name: simtestAdd
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


module testAdder(
    );

    reg [15:0] op1;
    reg [15:0] op2;
    wire [15:0] out;
    
    //Create a testAdd module
    Adder Adder(op1,op2,out);


    initial
    begin
        //---Same sign
        #50;
        assign op1 = {1'b0,15'd3000};
        assign op2 = {1'b0,15'd110};
        #50;
        assign op1 = {1'b0,15'd3000};
        assign op2 = {1'b0,15'd20000};
        #50;
        assign op1 = {1'b0,15'd1350};
        assign op2 = {1'b0,15'd0};
        #50;
        assign op1 = {1'b0,15'd0};
        assign op2 = {1'b0,15'd0};
        //----op1 negative sign
        #50
        assign op1 = {1'b1,15'd1111};
        assign op2 = {1'b0,15'd11};
        #50
        assign op1 = {1'b1,15'd30};
        assign op2 = {1'b0,15'd2345};
        #50
        assign op1 = {1'b1,15'd2345};
        assign op2 = {1'b0,15'd2345};
        #50        
        assign op1 = {1'b1,15'd1356};
        assign op2 = {1'b0,15'd0};
        //----op2 negative sign
        #50
        assign op1 = {1'b0,15'd12501};
        assign op2 = {1'b1,15'd27500};
        #50
        assign op1 = {1'b0,15'd40500};
        assign op2 = {1'b1,15'd45022};
        #50
        assign op1 = {1'b0,15'd0};
        assign op2 = {1'b1,15'd9002};
        //-----both negative sign
        #50
        assign op1 = {1'b1,15'd3000};
        assign op2 = {1'b1,15'd110};
        #50
        assign op1 = {1'b1,15'd3000};
        assign op2 = {1'b1,15'd110};
    end
endmodule
