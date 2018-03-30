`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 03/29/2018 12:41:57 AM
// Design Name:
// Module Name: Test_Shifter
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


module Test_Shifter(
    );

    parameter Word_length_local = 32;
    parameter fractional_bits__local = 24;

    reg [Word_length_local-1:0] Shift_Dvd_In;
    reg [Word_length_local-1:0] Shift_Dvr_In;
    reg [Word_length_local-1:0] Shift_Dvd_Out;
    reg [Word_length_local-1:0] Shift_Dvr_Out;
    reg clk = 0;
    reg ready = 0;

    shifter #(.Word_length(Word_length_local), .fractional_bits(fractional_bits__local)) SHF (
        clk,
        Shift_Dvd_In,
        Shift_Dvr_In,
        Shift_Dvd_Out,
        Shift_Dvr_Out,
        ready
        );

    reg [Word_length_local-1:0] dvd_aux = 0;
    reg [Word_length_local-1:0] dvs_aux = 0;

    initial
      begin
        #50;
          clk = 0;
        #50;
          clk = 1;
          dvs_aux = {8'd200,24'b0};
          dvd_aux = 1;
          dvs_aux[Word_length_local-1] = 1'b0; //'
          dvd_aux[Word_length_local-1] = 1'b0; //'
          assign Shift_Dvr_In = dvs_aux;
          assign Shift_Dvd_In = dvd_aux;
        #50;
          clk = 0;
        #50;
          clk = 1;
          /*
          dvs_aux = 1;
          dvd_aux = 1;
          dvs_aux[Word_length_local-1] = 1'b0; //'
          dvd_aux[Word_length_local-1] = 1'b0; //'
          assign Shift_Dvr_In = dvs_aux;
          assign Shift_Dvd_In = dvd_aux;
          */
        #50;
          clk = 0;
        #50;
          clk = 1;
          /*
          dvs_aux = 400;
          dvd_aux = 1;
          dvs_aux[Word_length_local-1] = 1'b0; //'
          dvd_aux[Word_length_local-1] = 1'b0; //'
          assign Shift_Dvr_In = dvs_aux;
          assign Shift_Dvd_In = dvd_aux;
          */
        #50;
          clk = 0;
        #50;
          clk = 1;
        #50;
          clk = 0;
        #50;
          clk = 1;
          /*
          dvs_aux = 400;
          dvd_aux = 1;
          dvs_aux[Word_length_local-1] = 1'b0; //'
          dvd_aux[Word_length_local-1] = 1'b0; //'
          assign Shift_Dvr_In = dvs_aux;
          assign Shift_Dvd_In = dvd_aux;
          */
        #50;
      end

endmodule
