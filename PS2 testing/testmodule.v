`timescale 1ns / 1ps

module TestingKeyboard;

	// Inputs
	reg CLK;
	reg PS2_CLK;
	reg PS2_DATA;

	// Outputs
	wire [7:0] LED;	//keyboard data signal
    wire [6:0] SEG;    
    wire [3:0] DISP;
    wire transfer_finish;
    wire code_out;


	// Instantiate the Unit Under Test (UUT)
	Keyboard uut (
	.CLK(CLK),
    .PS2_CLK(PS2_CLK), 
    .PS2_DATA(PS2_DATA),
    .SEG(SEG),
    .DISP(DISP),
    .LED(LED),
    .transfer_finish(transfer_finish),
    .code_out(code_out)
	);


	
	initial begin
		// Initialize Inputs
		CLK = 1;
		PS2_CLK = 1;
		PS2_DATA = 1;

		// Wait 100 ns for global reset to finish
		#100;
		
		#45 PS2_DATA = 0; //START 0
        #5 PS2_CLK = 0;
        #50 PS2_CLK = 1;
        
        #45 PS2_DATA = 1; //1
        #5 PS2_CLK = 0;
        #50 PS2_CLK = 1;
        
        #45 PS2_DATA = 0; //2
        #5 PS2_CLK = 0;
        #50 PS2_CLK = 1;

        #45 PS2_DATA = 1; //3
        #5 PS2_CLK = 0;
        #50 PS2_CLK = 1;
        
        #45 PS2_DATA = 0; //4
        #5 PS2_CLK = 0;
        #50 PS2_CLK = 1;
        
        #45 PS2_DATA = 1; //5
        #5 PS2_CLK = 0;
        #50 PS2_CLK = 1;

        #45 PS2_DATA = 1; //6
        #5 PS2_CLK = 0;
        #50 PS2_CLK = 1;
        
        #45 PS2_DATA = 1; //7
        #5 PS2_CLK = 0;
        #50 PS2_CLK = 1;
        
        #45 PS2_DATA = 0; //8
        #5 PS2_CLK = 0;
        #50 PS2_CLK = 1;
        
        #45 PS2_DATA = 0; //PARITY 9
        #5 PS2_CLK = 0;
        #50 PS2_CLK = 1;
        
        #45 PS2_DATA = 1;// STOP 10
        #5 PS2_CLK = 0;
        #50 PS2_CLK = 1;
        
        #45 PS2_DATA = 0; //START 0
        #5 PS2_CLK = 0;
        #50 PS2_CLK = 1;
        
        #45 PS2_DATA = 0; //1
        #5 PS2_CLK = 0;
        #50 PS2_CLK = 1;
        
        #45 PS2_DATA = 0; //2
        #5 PS2_CLK = 0;
        #50 PS2_CLK = 1;

        #45 PS2_DATA = 0; //3
        #5 PS2_CLK = 0;
        #50 PS2_CLK = 1;
        
        #45 PS2_DATA = 0; //4
        #5 PS2_CLK = 0;
        #50 PS2_CLK = 1;
        
        #45 PS2_DATA = 1; //5
        #5 PS2_CLK = 0;
        #50 PS2_CLK = 1;

        #45 PS2_DATA = 1; //6
        #5 PS2_CLK = 0;
        #50 PS2_CLK = 1;
        
        #45 PS2_DATA = 1; //7
        #5 PS2_CLK = 0;
        #50 PS2_CLK = 1;
        
        #45 PS2_DATA = 1; //8
        #5 PS2_CLK = 0;
        #50 PS2_CLK = 1;
        
        #45 PS2_DATA = 1; //PARITY 9
        #5 PS2_CLK = 0;
        #50 PS2_CLK = 1;
        
        #45 PS2_DATA = 1;// STOP 10
        #5 PS2_CLK = 0;
        #50 PS2_CLK = 1;
        
	//BRAKE CODE
	end
	
	always #1 CLK=~CLK;
	
      
endmodule

