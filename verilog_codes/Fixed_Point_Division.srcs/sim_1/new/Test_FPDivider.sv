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

    localparam Word_length_local = 32;
    localparam fractional_bits_local = 24;
    reg clk = 0;
    reg active = 0;
    reg [Word_length_local-1:0] dividend = 0;
    reg [Word_length_local -1:0] divisor = 0;
    wire [Word_length_local-1:0] result;
    wire [2*Word_length_local-1:0] dvdAux;
    wire [2*Word_length_local-1:0] dvrAux;
    wire ready, processing;
    reg changeActive = 0;
    reg [5:0] counter = 0;
    reg [1:0] first_clock = 1;
    reg firstTime = 1;
    reg [3:0] lastTime = 0;
    reg [Word_length_local-1:0] testStringA=0;
    reg [Word_length_local-1:0] testStringB=0;
    reg [Word_length_local-1:0] two = {{(Word_length_local-fractional_bits_local-2){1'b0}},{2'b10},{fractional_bits_local{1'b0}}};
    reg [1:0] counterResult = 0;
    int fdOpBin,fdReBin, fdClk,scra,scrb,scwr;
    string opa,opb;
    

    
    fixed_point_divider #(.Word_length(Word_length_local),.fractional_bits(fractional_bits_local)) FPD(
        .clk(clk),
        .rst_n(),
        .active(active),
        .divisor(divisor),  //M
        .dividend(dividend), //Q
        .result(result),
        .dvdAux(),
        .dvrAux(),
        .ready(ready),
        .processing(processing)
    );
    

always @(posedge clk)
    begin
        counter = counter + 1;
        if(first_clock == 1)
            begin
                fdOpBin = $fopen("/home/giovanni/xilinx_projects/Fixed_Point_Division/Fixed_Point_Division.srcs/sim_1/new/OperandsBinary.txt","r");                  
                fdReBin = $fopen("/home/giovanni/xilinx_projects/Fixed_Point_Division/Fixed_Point_Division.srcs/sim_1/new/ResultBinary.txt","w+");
                fdClk = $fopen("/home/giovanni/xilinx_projects/Fixed_Point_Division/Fixed_Point_Division.srcs/sim_1/new/ResultClocks.txt","w+");
                scra = $fscanf(fdOpBin,"%b",testStringA);
                scrb = $fscanf(fdOpBin,"%b",testStringB);
                divisor = testStringB;
                dividend = testStringA;   
                first_clock = 2;
            end
        else if (first_clock == 2)
            begin
                active = 1;
                first_clock = 0;
                counter = 0;
            end
        else if(ready == 1)
        begin   
            $display("------------------------------------------------------------");
            fdReBin = $fopen("/home/giovanni/xilinx_projects/Fixed_Point_Division/Fixed_Point_Division.srcs/sim_1/new/ResultBinary.txt","a+");
            fdClk = $fopen("/home/giovanni/xilinx_projects/Fixed_Point_Division/Fixed_Point_Division.srcs/sim_1/new/ResultClocks.txt","a+");                
            if(firstTime == 1)
                begin
                    firstTime = 0;
                    scra = $fscanf(fdOpBin,"%b",testStringA);
                    scrb = $fscanf(fdOpBin,"%b",testStringB);
                    divisor = testStringB;
                    dividend = testStringA;                                    
                    $fclose(fdReBin);
                    counter = 0;
                end
            else
                begin                                          
                    scra = $fscanf(fdOpBin,"%b",testStringA);
                    scrb = $fscanf(fdOpBin,"%b",testStringB);
                    $display("scra: %d",scra); 
                    $display("scrb: %d",scrb);
                    if((scra != -1 || scrb != -1) || lastTime != 4)
                        begin
                            lastTime = lastTime + 1;
                            $display("result2: %d",result);
                            $fwrite(fdReBin,"%b \n",result);
                            $display("counter: %d: ", counter);
                            $fwrite(fdClk,"%d \n",counter);
                            counter = 0;                              
                            divisor = testStringB;
                            dividend = testStringA;
                        end
                    else
                        begin
                            divisor = divisor;
                            dividend = dividend;
                        end
                    $fclose(fdReBin);
                    $fclose(fdClk);
                   
                   
                end
        end
    end  

    always
      #25 clk = !clk;
      
    initial
      begin
      //#5;
       dividend = 0;
       divisor  = 0;
      end

endmodule
