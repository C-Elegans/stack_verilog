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
	reg [15:0] ip;
	
	initial begin
	 ip = 0;
	 state = 0;
	end
	always @(posedge clk) begin
	//$display("instruction: %x, ip: %x",instruction,ip);
	case(state)
		
		`fetch: begin
			
			instruction <= data_in;
			op <= data_in[15:8];
			if(data_in === 16'bx && address != 0) $finish();
			if(data_in[15:13]) state <= `word_cycle1;
			else state <= `byte_cycle1;
			
			end
		`word_cycle1: begin
			//$display("instruction %x",instruction);
			//print_stack;
			ip <= ip + 2;
			if(instruction[15]) begin
				push(instruction[14:0]); //push
				state <= 0;
			end
			else if(instruction[14:13] == 1) begin //jump
				reg [15:0] temp;
				temp = {{3{instruction[12]}},instruction[12:0]};
				//$display("offset %x, ip: %d", temp, ip+temp);
				
				ip <= ip + temp +2;
				
				state <= 0;
			end
			else if(instruction[14:13] == 2) begin//call
				reg [15:0] temp;
				temp = {{3{instruction[12]}},instruction[12:0]};
				rpush(ip+2);
				ip <= ip + temp + 2;
				state <= 0;
			end
			else state <= 0; //call or jump
			end
		`byte_cycle1: begin 
			ip <= ip + 1;
			//$display("instruction %x, cycle: %d",instruction, ip[0]);
			//print_stack;
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
			//`ROT:
			`RET: begin
				rpop(ip);
			
			end
			endcase
			if(ip[0])
			state <= 0;
			else begin
			op <= instruction[7:0];
			end
			end
		default: state <= 0;
			
	endcase
	
	end
	assign address[14:0] = ip[15:1];
	assign address[15] = 0;
endmodule
