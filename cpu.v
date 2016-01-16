`include "defines.vh"
module cpu(clk, address, data_in, data_out, LEDS, wr);
	input clk;
	output reg [15:0] address;
	input [15:0] data_in;
	output reg [15:0] data_out;
	output [7:0] LEDS;
	output reg wr;
	`include "tasks.v"
	
	reg [2:0] state;
	reg [15:0] instruction;
	reg [8:0] op;
	reg [15:0] temp1;
	reg [15:0] temp2;
	reg [15:0] ip;
	reg extra_cycle;
	
	initial begin
	 ip = 0;
	 state = 0;
	 extra_cycle = 0;
	 wr = 0;
	end
	always @(posedge clk) begin
	//$display("instruction: %x, ip: %x",instruction,ip);
	case(state)
		
		`fetch: begin
			extra_cycle = 0;
			address[14:0] = ip[15:1];
			address[15] = 0;
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
			else begin //cjump
				reg [15:0] temp;
				pop(temp);
				if(temp == 0) begin
					temp = {{3{instruction[12]}},instruction[12:0]};
					ip <= ip + temp +2;
				end
				state <= 0; //call or jump
			end
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
				`TOS <= `NOS;
				`NOS <= `TOS;
			end
			`ROT: begin
				
				`TOS <= `ROS;
				`ROS <= `NOS;
				`NOS <= `TOS;
			end
			`RET: begin
				rpop(ip);
			
			end
			`LT: begin
				reg result;
				result = `NOS < `TOS;
				sp = sp - 2;
				push({16{result}});
			end
			`GT: begin
				reg result;
				result = `NOS > `TOS;
				sp = sp - 2;
				push({16{result}});
			end
			`EQ: begin
				reg result;
				result = `NOS == `TOS;
				sp = sp - 2;
				push({16{result}});
			end
			`NEG: `TOS <= ~`TOS;
			`RPUSH: begin
				rpush(`TOS);
				sp = sp - 1;
			end
			`RPOP: begin
				sp = sp + 1;
				rpop(`TOS);
			end
			`RCP: push(`RTOS);
			`AND: pop2push(`TOS & `NOS);
			`OR: pop2push(`TOS | `NOS);
			`XOR: pop2push(`TOS ^ `NOS);
			`LSHIFT: pop2push(`NOS << `TOS);
			`RSHIFT: pop2push(`NOS >> `TOS);
			`MUL: pop2push(`TOS * `NOS);
			`MEMFETCH: begin
				reg [15:0] temp3;
				extra_cycle = 1;
				
				pop(temp3);
				address = {1'b0,temp3[15:1]};
			end
			`STORE:begin
				reg [15:0] temp3;
				extra_cycle = 1;
				wr = 1;
				
				pop(temp3);
				address = {1'b0,temp3[15:1]};
				pop(data_out);
			end
			endcase
			if(extra_cycle) state = `byte_cycle2;
			else
				if(ip[0])
				state <= 0;
				else begin
				op <= instruction[7:0];
				end
			end
			
		`byte_cycle2:begin
			
			extra_cycle = 0;
			
			address[14:0] = ip[15:1];
			address[15] = 0;
			case(op)
				`MEMFETCH: push(data_in);
				`STORE: wr <= 0;
			endcase
			if(!ip[0])
				state <= 0;
			else begin
				op <= instruction[7:0];
				state <= `byte_cycle1;
				$display("next_byte");
			end
			
		end
		default: state <= 0;
			
	endcase
	
	end
	
endmodule
