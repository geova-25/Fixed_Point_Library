`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 03/30/2018 07:17:21 PM
// Design Name:
// Module Name: Multiply_Loop
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


module Multiply_Loop #(Word_length = 32,fractional_bits = 24) (
    input wire clk,
    input wire [Word_length-1:0] dvr,
    input wire [Word_length-1:0] dvd,
    //input wire [Word_length-1:0] f,
    input wire signIn,
    output reg signOut,
    output reg [Word_length-1:0] result,
    output reg readyToGo = 0,
    //output reg [Word_length-1:0] result_f_x_dvd,
    output reg [2*Word_length-1:0] dvdAux = 0,
    output reg [2*Word_length-1:0] dvrAux = 0 
    );

    reg go = 1;
    //reg [Word_length-1:0] dvdAux = 0;
    //reg [Word_length-1:0] dvrAux = 0;
    //reg [Word_length-1:0] fAux = 0;
    //reg [2*Word_length-1:0] resultAux = 0;
    reg [Word_length-1:0] two = {{(Word_length-fractional_bits-2){1'b0}},{2'b10},{fractional_bits{1'b0}}};
    //parameter [Word_length - 1- fractional_bits:0] one = 1;
    //parameter [fractional_bits-1:0] fractional_ones = {fractional_bits{1'b1}};
    //parameter [fractional_bits - 1:0] cero = 0;
    //wire [Word_length-1:0] result_f_x_dvd;
    //wire [Word_length-1:0] result_f_x_dvr;
    //wire ovr_f_x_dvr, ovr_f_x_dvd;
    reg [3:0] counter = 0;
    reg signal = 0;

    /*
   Multiplier #(.Q(fractional_bits),.N(Word_length)) multDVDF
      (
       fAux,
       dvrAux,
       result_f_x_dvr,
       ovr_f_x_dvr
       );

    Multiplier #(.Q(fractional_bits),.N(Word_length)) multDVSF
      (
       fAux,
       dvdAux,
       result_f_x_dvd,
       ovr_f_x_dvd
       );
    */
    always @(posedge clk)  //This secuential block will do the goldschmidt algorithm for division
      begin

        if(dvrAux[fractional_bits+fractional_bits-1:fractional_bits] == {fractional_bits{1'b1}} )  //If the divisor is all ones in the fractional part then ir is ready to end        
          begin
            result = dvdAux[Word_length-1+fractional_bits:fractional_bits]; // The result is assign from the last multiplication
            counter = 0;             // The counter is assigned to one because to avoid one cicle when assign the next one immediately
            signal = 0;              // Signal in one because we will jump one cicle
            readyToGo = 1;           // Signal that the algorithm ended
            dvdAux = 0;
            dvrAux = 0;
          end
        else if(counter == 0 && go == 1) //This is for the first time that the algoritm takes a value
            begin
                signal = 1;
                dvdAux[Word_length-1+fractional_bits:fractional_bits] = dvd;
                dvrAux[Word_length-1+fractional_bits:fractional_bits] = dvr;
                //dvrAux = dvr * dvr;
                //dvdAux = dvd * dvr;
                signOut = signIn;
                counter = counter + 1;
                readyToGo = 0;
            end
        else if(signal == 1 && counter == 1)           //When signal is one and non of above is satisfy
              begin
                //resultAux = dvdAux * fAux;   // Assign the value to be the last multiplicacion of both dvd and dvr
                dvdAux = dvdAux[Word_length-1+fractional_bits:fractional_bits] * dvrAux[Word_length-1+fractional_bits:fractional_bits];
                //resultAux = dvrAux * fAux;     
                dvrAux = dvrAux[Word_length-1+fractional_bits:fractional_bits] * dvrAux[Word_length-1+fractional_bits:fractional_bits];
                //fAux = {two,cero} - dvrAux;// Calculate the new aproximation
                counter = counter + 1;     //Add one to counter
                readyToGo = 0;             //No ready
              end            
        else if(signal == 1 && counter > 1)           //When signal is one and non of above is satisfy
          begin
            //resultAux = dvdAux * fAux;   // Assign the value to be the last multiplicacion of both dvd and dvr
            dvdAux = dvdAux[Word_length-1+fractional_bits:fractional_bits] * (two - dvrAux[Word_length-1+fractional_bits:fractional_bits]);
            //resultAux = dvrAux * fAux;     
            dvrAux = dvrAux[Word_length-1+fractional_bits:fractional_bits] * (two - dvrAux[Word_length-1+fractional_bits:fractional_bits]);
            //fAux = {two,cero} - dvrAux;// Calculate the new aproximation
            counter = counter + 1;     //Add one to counter
            readyToGo = 0;             //No ready
          end
        else
            counter = 0;               // Otherwise counter is maintained in cero
      end

endmodule
