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

    reg [31:0] divisor, dividend;
    wire [31:0] Q,R;
    parameter Word_length_local = 32;
    parameter fractional_bits__local = 24;
    fixed_point_divider #(.Word_length(Word_length_local),.fractional_bits(fractional_bits__local)) FPD(
        //input clk,
        divisor,  //M
        dividend, //Q
        Q,
        R
    );

    reg [Word_length_local-1:0] dvd_aux = 0;
    reg [Word_length_local-1:0] dvs_aux = 0;

    initial
      begin
        #50;
          dvs_aux = 400;
          dvd_aux = 1;
          dvs_aux[Word_length_local-1] = 1'b0; //'
          dvd_aux[Word_length_local-1] = 1'b0; //'
          assign divisor = dvs_aux;
          assign dividend = dvd_aux;
        #50;
          dvs_aux = 400;
          dvd_aux = 1;
          dvs_aux[Word_length_local-1] = 1'b0; //'
          dvd_aux[Word_length_local-1] = 1'b1; //'
          assign divisor = dvs_aux;
          assign dividend = dvd_aux;
        #50;
          dvs_aux = 400;
          dvd_aux = 1;
          dvs_aux[Word_length_local-1] = 1'b1; //'
          dvd_aux[Word_length_local-1] = 1'b0; //'
          assign divisor = dvs_aux;
          assign dividend = dvd_aux;
        #50;
          dvs_aux = 400;
          dvd_aux = 1;
          dvs_aux[Word_length_local-1] = 1'b1; //'
          dvd_aux[Word_length_local-1] = 1'b1; //'
          assign divisor = dvs_aux;
          assign dividend = dvd_aux;
        #50;
      end

endmodule
