reg [15:0] stack[5:0];
reg [5:0] sp;
initial sp = 0;
task push;
input [15:0] val;
begin
$display("PUSH, sp: %d",sp);
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
$display("return %d sp: %d",val,sp);
end
endtask
