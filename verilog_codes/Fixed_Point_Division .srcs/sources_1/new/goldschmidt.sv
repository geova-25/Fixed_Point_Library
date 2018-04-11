`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/02/2018 04:04:19 PM
// Design Name: 
// Module Name: goldschmidt
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


module goldschmidt #(Word_length = 32, fractional_bits = 24)(
    input clk,
    input go,
    input [Word_length-1:0] dvdIn,
    input [Word_length-1:0] dvrIn,
    input [Word_length-1:0] fIn,
    input [Word_length-1:0] f_x_dvr,
    input [Word_length-1:0] f_x_dvd,
    output reg [Word_length-1:0] dvdAux = 0,
    output reg [Word_length-1:0] dvrAux = 0,
    output reg [Word_length-1:0] result = 0,
    output reg [Word_length-1:0] fAux = 0,
    output reg readyToGo = 0
    );
    
    reg signal = 0;
    reg counter = 0;
    wire [Word_length - 1:fractional_bits] two = 2;
    wire [Word_length - 1:fractional_bits] one = 1;
    wire [fractional_bits-1:0] fractional_ones = {fractional_bits{1'b1}};
    wire [fractional_bits - 1:0] cero = 0;
    
    always @(posedge clk)
      begin
        if(f_x_dvr[fractional_bits-1:0] == fractional_ones )
        //if(counter == 5)
          begin
            //result = dvd;
            result = f_x_dvd;
            counter = 1;
            signal = 1; 
            readyToGo = 1;
            dvdAux = dvdIn;
            dvrAux = dvrIn;
          end
        else if(counter == 0 && go == 1)
            begin
                signal = 1;
                dvdAux = dvdIn;
                dvrAux = dvrIn;
                fAux = fIn;
                counter = counter + 1;
                readyToGo = 0;
            end
        else if(signal == 1)
          begin
            dvdAux = f_x_dvd;
            dvrAux = f_x_dvr;
            fAux = {two,cero} - dvrAux; // '
            counter = counter + 1;
            readyToGo = 0;
          end
        else
        counter = 0;
    end
endmodule
