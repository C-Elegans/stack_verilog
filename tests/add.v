`include "../defines.vh"
module addtest();
`include "../testinclude.vh"
initial $readmemh("add.hex",Mem);

initial #1000 $finish();
initial begin
values[0] = 4;
values[1] =17;
end


endmodule 
