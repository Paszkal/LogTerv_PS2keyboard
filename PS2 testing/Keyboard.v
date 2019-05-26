`timescale 1ns / 1ps
module Keyboard(
   input CLK,	// fpga clock
   input PS2_CLK,	// billenty�zet clock
   input PS2_DATA, //bej�v� adat
   output reg [3:0] DISP,
   output reg [6:0] SEG,	
   output reg [7:0] LED, // debug-ra kell
   output transfer_finish,
   output [10:0] code_out
   );
   
   
   // Fontosabb gombok
	wire [7:0] FIRST = 8'h16; //#1 gomb
	//Ezekb�l az egyik k�d j�n ha bootol a billenty�zet, nagy probl�ma nincs bel�le
	wire [7:0] ERROR =8'hFC; //ha hiba van -> itt resetelni kell
	wire [7:0] OKAY  =8'hAA; // minden ok�s 
	wire [7:0] EXTENDED = 8'hE0;	
	wire [7:0] RELEASED = 8'hF0;
   
	reg waiting;				// 1-ha m�g v�rja az adatokat
	reg [11:0] count_reading;   // sz�molja mennyi id� telt el
	reg last_state;			    //clock state t�rol�
	reg errors;				    // hiba flag
	reg [10:0] code;			// bej�v� adat
	reg packet_recieved;		 // ha megj�tt a 11 bit ->1
	reg [3:0]counter;		     // eddig megkapott bitek sz�ma
	reg TRIGGER = 0;			// lassabb �rajel
	reg [7:0]down_cntr = 0;		
	initial begin
		last_state = 1;		
		errors = 0;		
		code = 0;
		counter = 0;			
		SEG = 0;
		LED =0;
		waiting = 0;
		count_reading = 0;
		DISP =4'b1000;
	end

     // �rajel leoszt�s
     always@(posedge CLK)
     TRIGGER<=PS2_CLK;
     
	// sz�molja a bej�v� biteket
	always @(posedge CLK) begin	
		if (TRIGGER) begin
			if (waiting)				
				count_reading <= count_reading + 1;	
			else 						
				count_reading <= 0;			
		end
	end


	always @(posedge CLK) begin	
	// ha a be�llitott �rajel 
	if (TRIGGER) begin
	    //ha a billenty�zet clockja megv�ltozott						
		if (PS2_CLK != last_state) begin			
			if (!PS2_CLK) begin				
				waiting <= 1;				
				errors <= 0;				
				code[10:0] <= {PS2_DATA, code[10:1]};	// �j adat shiftel�se
				counter <= counter + 1;		
			end
		end
		//ha megj�tt a 11 bit
		else if (counter == 11) begin				
			counter <= 0;
			waiting <= 0;					
			packet_recieved <= 1;					
			//parity bitnek az ellen�rz�se
			if (!code[10] || code[0] || !(code[1]^code[2]^code[3]^code[4]
				^code[5]^code[6]^code[7]^code[8]
				^code[9]))
				errors <= 1;
			else 
				errors <= 0;
		end	
		// ha m�g nem j�tt meg a 11 bit
		else  begin						
			packet_recieved <= 0;			
			if (counter < 11 && count_reading >= 4000) begin	
				counter <= 0;				
				waiting <= 0;				
			end
		end
	//clock state ment�se
	last_state <= PS2_CLK;					
	end
	end
	
		assign transfer_finish=packet_recieved;
		assign code_out=code;
	
	always @(posedge CLK) begin
if (TRIGGER) begin
  if (packet_recieved) begin
    	LED <= code[8:1];
	    if(code[8:1] == EXTENDED|| code[8:1] == RELEASED)  SEG <= SEG;
	    else
	    begin
		if(code[8:5] == 4'h0)   SEG <= 0;
		else if(code[8:5] == 4'h1)  SEG <= 7'b0000110; //7'b1111001
		else if(code[8:5]  == 4'h2) SEG <=7'b1011011;  //7'b0100100
        else if(code[8:5]  == 4'h3) SEG <=7'b1001111;  //7'b0110000
        else if(code[8:5] == 4'h4) SEG <= 7'b1100110;  //7'b0011001;
        else if (code[8:5] == 4'h5) SEG <= 7'b1101101; //7'b0010010;
        else if (code[8:5] == 4'h6) SEG <= 7'b1111101;
        else if (code[8:5]== 4'h7) SEG <= 7'b0000111;
        else if (code[8:5]  == 4'h8) SEG <= 7'b1111111; 
        else if (code[8:5] == 4'h9) SEG <= 7'b1101111;
        else if (code[8:5] == 4'hA) SEG <= 7'b1110111;
        else if (code[8:5] == 4'hB) SEG <=7'b1111100;
        else if (code[8:5] == 4'hC) SEG <=7'b0111001; 
        else if (code[8:5] == 4'hD) SEG <=7'b011110;
        else if (code[8:5]  == 4'hE) SEG <=7'b1111001;
        else if (code[8:5] == 4'hF) SEG <=7'b1110001;
        end

 end
 end
	end

endmodule





