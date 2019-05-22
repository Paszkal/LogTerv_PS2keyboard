`timescale 1ns / 1ps

module topmodule(
	input CLK,		//board clock signal
	input PS2_CLK,		//keyboard clock signal
	input PS2_DATA,	
	output [7:0] LED,	//keyboard data signal
	output [6:0] SEG,	
	output [3:0] DISP
    );
Keyboard Keyboard_top (
							.CLK(CLK),
							.PS2_CLK(PS2_CLK), 
							.PS2_DATA(PS2_DATA),
							.SEG(SEG),
							.DISP(DISP),
							.LED(LED)
							);
endmodule
