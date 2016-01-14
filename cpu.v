`include "defines.vh"
module cpu(clk, address, data_in, data_out, LEDS);
	input clk;
	output reg [15:0] address;
	input [15:0] data_in;
	output [15:0] data_out;
	output [7:0] LEDS;
	`include "tasks.v"
	initial begin
	 address = 0;
	 state = 0;
	end
	reg [2:0] state;
	reg [15:0] instruction;
	reg [8:0] op;
	reg [15:0] temp1;
	reg [15:0] temp2;
	always @(posedge clk) begin
	case(state)
		`fetch: begin
			
			address <= address + 1;
			instruction <= data_in;
			op <= data_in[15:8];
			if(data_in === 16'bx && address != 0) $finish();
			if(data_in[15:13]) state <= `word_cycle1;
			else state <= `byte1_cycle1;
			end
		`word_cycle1: begin
			if(instruction[15]) begin
				push(instruction[14:0]); //push
				state <= 0;
			end
			else state <= 0; //call or jump
			end
		`byte1_cycle1: begin 
			case(op) 
			`OUT: begin
			
				pop(temp1);
				$display("%d",temp1);
			end
			`ADD:begin
				reg [15:0] temp;
				pop2push(`TOS + `NOS);
				
			end
			endcase
			state <= 0;
			end
		default: state <= 0;
			
	endcase
	
	end
endmodule
