`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2018 06:39:54 PM
// Design Name: 
// Module Name: Test_Multiplier
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


module Test_Multiplier(

    );
    
parameter Q = 24;
parameter N = 32;

reg [N-1:0]	i_multiplicand;
reg [N-1:0]	i_multiplier;
wire [N-1:0]	o_result;
wire ovr;

Multiplier #(.Q(24),.N(32)) mult
	(
	 i_multiplicand,
	 i_multiplier,
	 o_result,
	 ovr
	 );
	 
    initial
     begin
         //---Same sign
         #50;
         assign i_multiplicand = {1'b0,8'd1,23'd0};
         assign i_multiplier   = {1'b0,8'd1,23'd0};
         #50;
     end
    
endmodule
