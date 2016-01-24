`include "../defines.vh"
module stacktest();
`include "../testinclude.vh"
initial $readmemh("stack.hex",Mem);

initial #100 $finish();
initial begin

values[0] = 1;
values[1] = 2;
values[2] = 3;
values[3] = 3;
values[4] = 2;
values[5] = 1;
values[6] = 3;
values[7] = 2;
end


endmodule 
