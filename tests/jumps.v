`include "../defines.vh"
module jumptest();
`include "../testinclude.vh"
initial $readmemh("jumps.hex",Mem);

initial #1000 $finish();
initial begin

end



endmodule 
