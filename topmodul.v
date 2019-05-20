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
module topmodule(
	input RST,
	input CLK,		//board clock signal
	input PS2_CLK,		//keyboard clock signal
	input PS2_DATA,	
	output [7:0] LED,	//keyboard data signal
	output [6:0] SEG,	
	output [3:0] DISP
    );
	reg [4:0] data_in;
	reg [4:0] placeholder1;
	reg [4:0] placeholder2;
	reg [4:0] placeholder3;
	reg [3:0] temp;
	reg [7:0] led_temp;
	
	always@(posedge CLK)
	begin
		if(RST)
		begin
			data_in<=5'b10000;
			placeholder1<=5'b10000;
			placeholder2<=5'b10000;
			placeholder3<=5'b10000;
		end
		else
			data_in<=5'b00000+led_temp[7:4];
	end
	
	
Keyboard Keyboard_top (
	.CLK(CLK),
	.RST(RST),
	.PS2_CLK(PS2_CLK), 
	.PS2_DATA(PS2_DATA),
	//.SEG(SEG),
	.DISP(temp),
	.LED(led_temp)
);
	
7seg 7seg_top(	
	.clk(CLK),
	.rst(RST),
	
	.dig0(data_in),
	.dig1(placehodler1),
	.dig2(placeholder2),
	.dig3(placeholder3),
	
	.disp(DISP),
	.seg(SEG)
);
	
assign LED=led_temp;
	
endmodule
