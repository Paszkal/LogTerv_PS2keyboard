`timescale 1ns / 1ps
module topmodule(
	input CLK,		// fpga clock jele
	input PS2_CLK,		//billentyûzet clock jele
	input PS2_DATA,	
	output [7:0] LED,	//debug-ra kimenet
	output [6:0] SEG,	
	output [3:0] DISP,
	output transfer_finish,
	output code_out
    );
Keyboard TestingKeyboard (
							.CLK(CLK),
							.PS2_CLK(PS2_CLK), 
							.PS2_DATA(PS2_DATA),
							.SEG(SEG),
							.DISP(DISP),
							.LED(LED),
							.transfer_finish(transfer_finish),
							.code_out(code_out)
							);
endmodule
