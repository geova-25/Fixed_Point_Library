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
    input wire go,
    input reg [Word_length-1:0] dvr,
    input reg [Word_length-1:0] dvd,
    input reg [Word_length-1:0] f,
    input wire signIn,
    output reg signOut = 0,
    output reg [Word_length-1:0] result = 0,
    output reg readyToGo = 0
    );


    reg [Word_length-1:0] dvdAux = 0;
    reg [Word_length-1:0] dvrAux = 0;
    reg [Word_length-1:0] fAux = 0;

    wire [Word_length - 1:fractional_bits] two = 2;
    wire [Word_length - 1:fractional_bits] one = 1;
    wire [fractional_bits-1:0] fractional_ones = {fractional_bits{1'b1}};
    wire [fractional_bits - 1:0] cero = 0;
    wire [Word_length-1:0] result_f_x_dvd;
    wire [Word_length-1:0] result_f_x_dvr;
    wire ovr_f_x_dvr, ovr_f_x_dvd;
    reg [3:0] counter = 0;
    reg signal = 0;
    reg finish = 0;
    reg [1:0] init = 0;
    
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
       
    always @(posedge clk)  //This secuential block will do the goldschmidt algorithm for division
      begin
        if(init == 0)
            begin
                init = init + 1;
                readyToGo = 1;
            end
        else if (init == 1)
            begin
                init = init + 1;
                readyToGo = 0;
            end
        else if((result_f_x_dvr[fractional_bits-1:0] == fractional_ones) && finish == 0)  //If the divisor is all ones in the fractional part then ir is ready to end
          begin
            result = result_f_x_dvd; // The result is assign from the last multiplication
            counter = 0;             // The counter is assigned to one because to avoid one cicle when assign the next one immediately 
            signal = 0;              // Signal in one because we will jump one cicle
            readyToGo = 1;           // Signal that the algorithm ended
            finish = 1;
          end
        else if(counter == 0 && go == 1) //This is for the first time that the algoritm takes a value
            begin
            signal = 1;
            dvdAux = dvd;
            dvrAux = dvr;
            signOut = signIn;
            fAux = f;
            counter = counter + 1;
            readyToGo = 0;
            end
        else if(signal == 1)           //When signal is one and non of above is satisfy
          begin
            dvdAux = result_f_x_dvd;   // Assign the value to be the last multiplicacion of both dvd and dvr
            dvrAux = result_f_x_dvr;
            fAux = {two,cero} - dvrAux;// Calculate the new aproximation
            counter = counter + 1;     //Add one to counter
            readyToGo = 0;             //No ready
            finish = 0;
          end
        else
            begin 
            if (finish == 1)
                begin
                    readyToGo = 0;             //No ready
                    counter = counter;
                    finish = 0;
                    dvdAux = 1;
                    dvrAux = 1;
                end
            else       
                begin
                    readyToGo = readyToGo;         
                    counter = 0;               // Otherwise counter is maintained in cero
                    finish = finish;
                    dvdAux = dvdAux;
                    dvrAux = dvrAux;                    
                end
            end
      end

endmodule
