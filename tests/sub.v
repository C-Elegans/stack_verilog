`include "../defines.vh"
module addtest();
`include "../testinclude.vh"
initial $readmemh("sub.hex",Mem);

initial #1000 $finish();
initial begin

values[0] = 2;
values[1] = 7;
end


endmodule 
