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
    input wire clk, 
    input wire takeNextOperands,
    input wire [Word_length-1:0] Op_A_SD_In,
    input wire [Word_length-1:0] Op_B_SD_In,
    output reg [Word_length-1:0] Op_A_SD_Out  = 0,
    output reg [Word_length-1:0] Op_B_SD_Out  = 0,
    output reg sign = 0,
    output reg startShifting = 0
    );

    wire [Word_length-1:0] complemented_number_A, complemented_number_B;
    reg  [Word_length-1:0] reg_A = 0;
    reg  [Word_length-1:0] reg_B = 0;
    Two_Complement #(.Word_length(Word_length)) TC1(Op_A_SD_In,complemented_number_A);
    Two_Complement #(.Word_length(Word_length)) TC2(Op_B_SD_In,complemented_number_B);

    always @*
        begin
            reg_A = Op_A_SD_In;
            reg_B = Op_B_SD_In;
            sign = reg_A[Word_length-1] ^ reg_B[Word_length-1]; 
        end

    always @(posedge clk)
        begin            
            if(Op_A_SD_In[Word_length-1] == 1'b1 && takeNextOperands == 1)
                begin
                    Op_A_SD_Out = complemented_number_A;
                    startShifting = 1;
                end                       
            else if (Op_A_SD_In[Word_length-1] != 1'b1 && takeNextOperands == 1)
                begin
                    Op_A_SD_Out = Op_A_SD_In;
                    startShifting = 1;
                end
            else
                begin
                    Op_A_SD_Out = Op_A_SD_Out;
                    startShifting = 0;
                end                
        end
        
    always @(posedge clk)
        begin
           if(Op_B_SD_In[Word_length-1] == 1'b1 && takeNextOperands == 1)
             begin
                 Op_B_SD_Out = complemented_number_B;
             end
         else if(Op_B_SD_In[Word_length-1] != 1'b1 && takeNextOperands == 1)
             begin
                 Op_B_SD_Out = Op_B_SD_In;
             end
         else
             begin                    
                 Op_B_SD_Out = Op_B_SD_Out;
             end            
        end

endmodule
