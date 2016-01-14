`define TOS stack[sp-1]
`define NOS stack[sp-2]

reg [15:0] stack[5:0];
reg [5:0] sp;
initial sp = 0;
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

//for(int i=0;i<=sp;i++)
//$display("stack[%d] = %x",i,stack[i]);

end
endtask
task pop2push;
input [15:0] val;
begin
sp = sp - 2;
push(val);
end
endtask
