`define TOS stack[sp-1]
`define NOS stack[sp-2]
`define ROS stack[sp-3]


`define RTOS rstack[rsp-1]

reg [15:0] stack[5:0];
reg [15:0] rstack[5:0];
reg [5:0] sp;
reg [5:0] rsp;
int i;
initial sp = 1;
initial rsp = 1;
task print_stack; 
begin
for(int i=0;i<sp;i++) $display("stack[%d]: %d",i,stack[i]);
end
endtask
task push;
input [15:0] val;
	begin
	//$display("push %d  sp: %d",val,sp);
	stack[sp] = val;
	sp = sp + 1;
	end
endtask

task pop;
	output [15:0] val;
	begin
	sp = sp - 1;
	val = stack[sp];
	end
endtask
task popn;
	begin
	sp <= sp -1;
	end
endtask

task pop2push;
	input [15:0] val;
	begin
	sp = sp - 2;
	push(val);
	end
endtask

task rpush;
	input [15:0] val;
	begin
	rstack[rsp] <= val;
	rsp = rsp + 1;
	end
endtask

task rpop;
	output [15:0] val;
	begin
	rsp = rsp - 1;
	val = rstack[rsp];
	end
endtask
