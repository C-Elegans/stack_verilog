`include "defines.vh"
module cpu(clk, address, data_in, data_out, LEDS);
	input clk;
	output reg [15:0] address;
	input [15:0] data_in;
	output [15:0] data_out;
	output [7:0] LEDS;
	`include "tasks.v"
	
	reg [2:0] state;
	reg [15:0] instruction;
	reg [8:0] op;
	reg [15:0] temp1;
	reg [15:0] temp2;
	reg cycle;
	initial begin
	 address = 0;
	 state = 0;
	 cycle = 0;
	end
	always @(posedge clk) begin
	case(state)
		`fetch: begin
			cycle <= 0;
			address <= address + 1;
			instruction <= data_in;
			op <= data_in[15:8];
			if(data_in === 16'bx && address != 0) $finish();
			if(data_in[15:13]) state <= `word_cycle1;
			else state <= `byte_cycle1;
			end
		`word_cycle1: begin
			if(instruction[15]) begin
				push(instruction[14:0]); //push
				state <= 0;
			end
			else state <= 0; //call or jump
			end
		`byte_cycle1: begin 
		
			case(op) 
			`OUT: begin
			
				pop(temp1);
				$display("%d",temp1);
			end
			`ADD:pop2push(`TOS + `NOS);
			`SUB:pop2push(`NOS - `TOS);
			`DUP:push(`TOS);
			`SWAP:begin
				reg [15:0] temp;
				temp = `TOS;
				`TOS = `NOS;
				`NOS = temp;
			end
			endcase
			if(cycle)
			state <= 0;
			else begin
			op <= instruction[7:0];
			cycle <= 1;
			end
			end
		default: state <= 0;
			
	endcase
	
	end
endmodule
