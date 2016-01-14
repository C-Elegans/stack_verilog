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
	always @(posedge clk) begin
	case(state)
		0: begin
			
			address <= address + 1;
			instruction <= data_in;
			if(data_in === 16'bx && address != 0) $finish();
			if(data_in[15:13]) state <= 1;
			else state <= 3;
			end
		1: begin
			push(instruction[14:0]);
			state <= 0;
			end
		3: begin 
		reg [15:0] temp;
		pop(temp);
		
		state <= 0;
		end
		default: state <= 0;
			
	endcase
	
	end
endmodule
