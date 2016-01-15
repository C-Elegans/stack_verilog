`define TOS stack[sp-1]
`define NOS stack[sp-2]

reg [15:0] stack[5:0];
reg [15:0] rstack[5:0];
reg [5:0] sp;
reg [5:0] rsp;
initial sp = 0;
initial rsp = 0;
task push;
input [15:0] val;
begin

stack[sp] <= val;
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
