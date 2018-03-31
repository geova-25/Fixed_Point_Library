`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 02/25/2018 02:37:02 PM
// Design Name:
// Module Name: fixed_point_divider
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


module fixed_point_divider #(parameter Word_length = 32, fractional_bits = 24)(
    input clk,
    input wire [Word_length-1:0] divisor,
    input wire [Word_length-1:0] dividend,
    output wire [Word_length-1:0] Q,
    output reg [Word_length-1:0] shifted_dvd = 1,
    output reg [Word_length-1:0] shifted_dvr = 1,
    output wire [Word_length-1:0] dvdOut,
    output wire [Word_length-1:0] dvrOut,
    output wire [Word_length-1:0] fOut,
    output wire done,
    output reg [Word_length-1:0] dividendAux = 0,
    output reg [Word_length-1:0] divisorAux = 0
    );


    /*wire [Word_length-1:0] SDI_Dvd_Out;
    wire [Word_length-1:0] SDI_Dvr_Out;
    wire SDI_Sign_Out;

    Sign_Detector #(.Word_length(Word_length)) Sign_Detector(dividend,divisor,SDI_Dvd_Out,SDI_Dvr_Out,SDI_Sign_Out);

    wire [Word_length-1:0] Shift_Dvd_Out;
    wire [Word_length-1:0] Shift_Dvr_Out;

    shifter #(.Word_length(Word_length), .fractional_bits(fractional_bits)) SHF (
        clk,
        SDI_Dvd_Out ,
        SDI_Dvr_Out,
        Shift_Dvd_Out,
        Shift_Dvr_Out,
        readyShifting
        );

    //-----------------------------------------------
    //This Goes inside the multiplier
    always @(posedge readyShifting)
      begin
        shifted_dvd = {8'd60,24'd0};
        shifted_dvr = {8'd7,24'd0};
      end

  Multiply_Loop #(.Word_length(Word_length),.fractional_bits(fractional_bits)) ML (
                   clk,
                   readyShifting,
                   shifted_dvr,
                   shifted_dvd,
                   shifted_dvr,
                   Q,
                   done,
                   dvdOut,
                   dvrOut
           );
   */
   
   reg countShifts = 0;
   reg [3:0] numberOfShifts = 0;
   reg startCountingShifts = 0;
   reg startCountingShiftsAux = 0;
   reg doneCountingShifts = 0;
   reg done_counting = 0;
   

    always @(posedge clk)
        begin 
            if(divisorAux[Word_length - 1:fractional_bits] == 0)
                begin
                    shifted_dvd = dividendAux;
                    shifted_dvr = divisorAux;
                    doneCountingShifts = 1;
                end
            else
                begin
                    divisorAux = divisorAux >> 1;
                    dividendAux = dividendAux >> 1;
                    doneCountingShifts = 0;
                end
        end

    always @*
        begin
            dividendAux = dividend; //>> 3;//(Word_length - fractional_bits);
            divisorAux = divisor; //>> 3;//(Word_length - fractional_bits);
        end


  Multiply_Loop #(.Word_length(Word_length),.fractional_bits(fractional_bits)) ML (
                      clk,
                      doneCountingShifts, //'
                      shifted_dvr,
                      shifted_dvd,
                      shifted_dvr,
                      Q,
                      done,
                      dvdOut,
                      dvrOut,
                      fOut
              );

    //-----------------------------------------------


    //Final_Sign_Usher #(.Word_length(Word_length)) Final_Sign_Usher(shifted_dvd,SDI_Sign_Out,Q);

endmodule
