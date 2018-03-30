`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 03/28/2018 08:57:15 PM
// Design Name:
// Module Name: shifter
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


module shifter #(Word_length = 32, fractional_bits = 24) (
    input clk,
    input reg [Word_length-1:0] Shift_Dvd_In,
    input reg [Word_length-1:0] Shift_Dvr_In,
    output reg [Word_length-1:0] Shift_Dvd_Out,
    output reg [Word_length-1:0] Shift_Dvr_Out,
    output reg ready
    );
    reg counter = 0;
    reg [Word_length-2:0] Shift_Dvd_In_Aux = 0;
    reg [Word_length-2:0] Shift_Dvr_In_Aux = 0;

    always @(posedge clk)
      begin
        if(counter == 0)
          begin
            Shift_Dvr_Out = Shift_Dvr_In[Word_length-2:0];
            Shift_Dvd_Out = Shift_Dvd_In[Word_length-2:0];
            counter = 1'b1; //'
          end
        else
          begin
            Shift_Dvr_Out = Shift_Dvr_Out;
            Shift_Dvd_Out = Shift_Dvd_Out;
          end

        if(Shift_Dvr_Out[Word_length-2:fractional_bits] == 0)
          begin
            ready = 1'b1;//'
            counter = 0;
          end
        else
          begin
            Shift_Dvr_Out = Shift_Dvr_Out >> 2;
            Shift_Dvd_Out = Shift_Dvd_Out >> 2;
            ready = 1'b0; //'
          end
      end

endmodule
