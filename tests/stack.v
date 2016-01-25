`include "../defines.vh"
module stacktest();
`include "../testinclude.vh"
initial $readmemh("stack.hex",Mem);
initial $readmemh("stack.val",values);
initial #100 $finish();



endmodule 
