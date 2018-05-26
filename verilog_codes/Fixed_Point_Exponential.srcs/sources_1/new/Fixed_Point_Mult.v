`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/25/2018 04:26:22 PM
// Design Name: 
// Module Name: Fixed_Point_Mult
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

module Fixed_Point_Mult #(
	//Parameterized values
	parameter Word_length = 32,
	parameter fractional_bits = 15
	)
	(
	 input			[Word_length-1:0]	i_multiplicand,
	 input			[Word_length-1:0]	i_multiplier,
	 output			[Word_length-1:0]	o_result
	 );
	 
	 //	The underlying assumption, here, is that both fixed-point values are of the same length (N,Q)
	 //		Because of this, the results will be of length N+N = 2N bits....
	 //		This also simplifies the hand-back of results, as the binimal point 
	 //		will always be in the same location...
	
	reg [2*Word_length-1:0]	r_result;		//	Multiplication by 2 values of N bits requires a 
											//		register that is N+N = 2N deep...
	reg [Word_length-1:0]		r_RetVal;
	
//--------------------------------------------------------------------------------
	assign o_result = r_RetVal;	//	Only handing back the same number of bits as we received...
											//		with fixed point in same location...
	
//---------------------------------------------------------------------------------
	always @(i_multiplicand, i_multiplier)	begin						//	Do the multiply any time the inputs change
		r_result <= i_multiplicand[Word_length-2:0] * i_multiplier[Word_length-2:0];	//	Removing the sign bits from the multiply - that 
																					//		would introduce *big* errors	
		end
	
		//	This always block will throw a warning, as it uses a & b, but only acts on changes in result...
	always @(*) begin													//	Any time the result changes, we need to recompute the sign bit,
		r_RetVal[Word_length-1] <= i_multiplicand[Word_length-1] ^ i_multiplier[Word_length-1];	//		which is the XOR of the input sign bits...  (you do the truth table...)
		r_RetVal[Word_length-2:0] <= r_result[Word_length-2+fractional_bits:fractional_bits];								//	And we also need to push the proper N bits of result up to 
		end

endmodule