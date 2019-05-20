`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:59:28 11/07/2014 
// Design Name: 
// Module Name:    wrapper 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module wrapper(
	input CLK,		//board clock signal
	input PS2_CLK,		//keyboard clock signal
	input PS2_DATA,	
	output [7:0] LED,	//keyboard data signal
	output [6:0] SEG,	
	output [3:0] DISP
    );
Keyboard TestingKeyboard (
							.CLK(CLK),
							.PS2_CLK(PS2_CLK), 
							.PS2_DATA(PS2_DATA),
							.SEG(SEG),
							.DISP(DISP),
							.LED(LED)
							);
endmodule
