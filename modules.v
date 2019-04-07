/*
FPGA Atributes
	FPGA native clk: 100MHz
	define clk as system clock (wire)
	define rst as system interrupt /  reset (wire)
	PMOD port names: (should be defined properly later)
		PMOD_GND, PMOD_VDD, PMOD_DATA (normal single line I/O), PMOD_CLK (normal single line I/O)

*/

/*
Keyboard Attributes
	keyboard clk: 10kHz-16,7kHz, SERIAL comunication (1 bit data channel)
	each byte should be sent in a 11 bit packet to the keyboard:
	1 start bit (0), 8 data bit (LSB first), 1 parity bit (odd), 1 stop bit (1)
	each byte should be sent in a 12 bit packet from the keyboard
	1 start bit (0), 8 data bit (LSB first), 1 parity bit (odd), 1 stop bit (1), 1 ACK bit
*/


//TODO define ports for the kb_data (single line serial), and kb_clk


//main clock: 10kHZ trigger for 1us
	module main_counter(
		input clk, rst,
		output out
	);
				
		reg cntr [20:0];
						
		always @ (posedge clk,rst)
		begin
			if(rst)
				cntr<=0;
			if (out)
				cntr<=0;
			else
				cntr<= cntr+1;
		end
		
		assign out<=(cntr==9999);
	endmodule
	
//unpacking module
	module unpack_kb_msg (
		input kb_clk, //keyboard clock
		input kb_data, //keyboards data stream 
		input rst, //system reset
		output out [7:0] //the raw data ready for decoding
	 );
	 
	 reg [7:0] data; //raw data from the keyboard stripped from the packet
	 reg [7:0] data_done;
	 reg [3:0] counter; //to count incoming bits
	 reg internal_it;
	
	 
	 always @ (posedge kb_clk, rst)
	 begin 
		if(rst)
			begin
				data<=0;
				counter<=0;
				internal_it<=0;
			end
		else if(counter==0) //start bit
		else if(counter==9) //parity bit
			if(data[counter]==((data_done[0]^data_done[1])^(data_done[2]^data_done[3])^(data_done[4]^data_done[5])^(data_done[6]^data_done[7]))) //parity check
				internal_it<=1; //delete data if parity check fails
		else if(counter==10) //stop bit
			internal_it<=~internal_it;
		else if(counter==11) //ACK 
			counter<=0;
			internal_it<=0;
		else
			begin
				data[counter]<=kb_data;
			end
		counter<=counter+1;
	 end
	 
	 always @ (internal_it)
		data_done<=data;
	 
	 assign out<=data_done;
	endmodule
	
//packing module
	module pack_kb_msg (
		input enable_send,
		input kb_clk,
		input rst,
		input data [7:0],
		output packet [10:0]
	);
	
	reg internal_it;
	reg [10:0]temp;
	
	always @ (clk, rst)
	begin 
		if(rst)
			temp<=0;
		else
			temp[0]<=0;
			temp[9]<=1;
			temp[10]<=~((data_done[0]^data_done[1])^(data_done[2]^data_done[3])^(data_done[4]^data_done[5])^(data_done[6]^data_done[7]))
			temp[8:1]<=data[7:0];
	end
	
	assign packet<= (enable_send) ? temp : 0;
	endmodule
	
	
//TODO implement bit-by-bit streaming instead of packet based masseges (needed?)
	
//TODO request_transfer module (send and recieve seperately: basically an interrupt to the keyboard)

//TODO forward_packet module (send the pocket to the port)>>> this might not be needed if we can define ports directly
	
//TODO polling module (check keybouard state and evaluate it:should the fpga send or recieve anything)




	

	

