`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 03/28/2018 12:27:37 PM
// Design Name:
// Module Name: Sign_Detector
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


module Sign_Detector #(parameter Word_length = 32)(
    input [Word_length-1:0] Op_A_SD_In,
    input [Word_length-1:0] Op_B_SD_In,
    output reg [Word_length-1:0] Op_A_SD_Out,
    output reg [Word_length-1:0] Op_B_SD_Out,
    output reg sign
    );

    reg [Word_length-1:0] Reg_Op_A_SD_In, Reg_Op_B_SD_In;
    wire [Word_length-1:0] complemented_number_A, complemented_number_B;

    Two_Complement #(.Word_length(Word_length)) TC1(Op_A_SD_In,complemented_number_A);
    Two_Complement #(.Word_length(Word_length)) TC2(Op_B_SD_In,complemented_number_B);


    always @*
        begin
            sign = Op_A_SD_In[Word_length-1] ^ Op_B_SD_In[Word_length-1];
            Reg_Op_A_SD_In = Op_A_SD_In;
            Reg_Op_B_SD_In = Op_B_SD_In;

            if(Reg_Op_A_SD_In[Word_length-1] == 1'b1)
                begin
                    Op_A_SD_Out = complemented_number_A;
                end
            else
                begin
                    Op_A_SD_Out = Reg_Op_A_SD_In;
                end
            if(Reg_Op_B_SD_In[Word_length-1] == 1'b1)
                begin
                    Op_B_SD_Out = complemented_number_B;
                end
            else
                begin
                    Op_B_SD_Out = Reg_Op_B_SD_In;
                end
        end

endmodule
