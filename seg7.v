`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/15/2018 08:44:27 AM
// Design Name: 
// Module Name: seg7
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


module seg7(
    input clk,
    input rst,
    
    input [4:0] dig0,
    input [4:0] dig1,
    input [4:0] dig2,
    input [4:0] dig3,
    
    output reg [3:0] disp,
    output reg [7:0] seg
);

reg [16:0] cntr_div;
always @ (posedge clk)
if (rst)
    cntr_div <= 0;
else if (cntr_div[16])
    cntr_div <= 0;
else
    cntr_div <= cntr_div + 1; 

wire ce;
assign ce = cntr_div[16];

reg [3:0] disp_shr;
reg [1:0] disp_cntr;
always @ (posedge clk)
if (rst)
begin
    disp_shr  <= 4'b0001;
    disp_cntr <= 2'b0;
end
else if (ce)
begin
    disp_shr  <= {disp_shr[2:0], disp_shr[3]};
    disp_cntr <= disp_cntr + 1; 
end

reg [4:0] mux;
always @ ( * )
case (disp_cntr)
    2'b00: mux <= dig0;
    2'b01: mux <= dig1;
    2'b10: mux <= dig2;
    2'b11: mux <= dig3;
endcase

// 7-segment encoding
//      0
//     ---
//  5 |   | 1
//     --- <--6
//  4 |   | 2
//     ---
//      3
reg [6:0] seg_val;
always @(mux)
case (mux)
    5'b10000 : seg_val = 7'b1111111;   //
    5'b10001 : seg_val = 7'b0111111;   // -
    5'b00001 : seg_val = 7'b1111001;   // 1
    5'b00010 : seg_val = 7'b0100100;   // 2
    5'b00011 : seg_val = 7'b0110000;   // 3
    5'b00100 : seg_val = 7'b0011001;   // 4
    5'b00101 : seg_val = 7'b0010010;   // 5
    5'b00110 : seg_val = 7'b0000010;   // 6
    5'b00111 : seg_val = 7'b1111000;   // 7
    5'b01000 : seg_val = 7'b0000000;   // 8
    5'b01001 : seg_val = 7'b0010000;   // 9
    5'b01010 : seg_val = 7'b0001000;   // A
    5'b01011 : seg_val = 7'b0000011;   // b
    5'b01100 : seg_val = 7'b1000110;   // C
    5'b01101 : seg_val = 7'b0100001;   // d
    5'b01110 : seg_val = 7'b0000110;   // E
    5'b01111 : seg_val = 7'b0001110;   // F
    default  : seg_val = 7'b1000000;   // 0
endcase

always @ (posedge clk)
begin
    disp      <= disp_shr;
    seg[6:0]  <= ~seg_val;
    if (disp_cntr==1)
        seg[7] <= 1'b1;
    else
        seg[7] <= 1'b0;
end

endmodule
