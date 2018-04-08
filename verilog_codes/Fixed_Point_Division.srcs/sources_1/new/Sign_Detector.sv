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
// This module will detect the sign of the result with an xor and convert the operands to positive if necesary
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


module Sign_Detector #(parameter Word_length = 32)(
    input wire clk, 
    input wire takeNextOperands,   //This signal indicates if the sign detector is readdy to go.
    input wire [Word_length-1:0] Op_A_SD_In, //The operands from the start
    input wire [Word_length-1:0] Op_B_SD_In, 
    output reg [Word_length-1:0] Op_A_SD_Out  = 0, //The operands of the final
    output reg [Word_length-1:0] Op_B_SD_Out  = 0,
    output reg sign = 0, //Sign calculated
    output reg startShifting = 0 //Signal of startShifting when ended
    );

    wire [Word_length-1:0] complemented_number_A, complemented_number_B;
    reg  [Word_length-1:0] reg_A = 0;
    reg  [Word_length-1:0] reg_B = 0;
    reg  initialRegA = 1;
    reg  initialRegB = 1;
    
    //Combinational modules that sill calculate the cocmplemented values.
    
    Two_Complement #(.Word_length(Word_length)) TC1(Op_A_SD_In,complemented_number_A);
    Two_Complement #(.Word_length(Word_length)) TC2(Op_B_SD_In,complemented_number_B);

    always @(posedge clk)  //This combinational block will assign the inside operands to register to operate later and calculate the sign
        begin
            reg_A = Op_A_SD_In;
            reg_B = Op_B_SD_In;
            sign = reg_A[Word_length-1] ^ reg_B[Word_length-1]; //Calculate the sign with xor
        end

    always @(posedge clk) //This secuential block willdetermine which operands should be ussing the complemented or the non complemented
        begin            
            if(Op_A_SD_In[Word_length-1] == 1'b1 && (takeNextOperands == 1 || initialRegA == 1))  //If it is negative and the module has activated 
                begin
                    Op_A_SD_Out = complemented_number_A; //Assign complemented
                    startShifting = 1; //startShifting to activate shift
                    initialRegA = 0;
                end                       
            else if (Op_A_SD_In[Word_length-1] != 1'b1 && (takeNextOperands == 1 || initialRegA == 1)) //If it is not negative but it is active
                begin
                    Op_A_SD_Out = Op_A_SD_In; //Assign non complemented 
                    startShifting = 1; //startShifting to activate shift
                    initialRegA = 0;
                end
            else
                begin
                    Op_A_SD_Out = Op_A_SD_Out; //Continue the same
                    startShifting = 0; //startShifting to deactivate shift
                end                
        end
        
    //This block is exactly the same as the above but for operand B
        
    always @(posedge clk)
        begin
           if(Op_B_SD_In[Word_length-1] == 1'b1 && (takeNextOperands == 1 || initialRegB == 1))
             begin
                 Op_B_SD_Out = complemented_number_B;
                 initialRegB = 0;
             end
         else if(Op_B_SD_In[Word_length-1] != 1'b1 && (takeNextOperands == 1 || initialRegB == 1))
             begin
                 Op_B_SD_Out = Op_B_SD_In;
                 initialRegB = 0;
             end
         else
             begin                    
                 Op_B_SD_Out = Op_B_SD_Out;
             end            
        end

endmodule
