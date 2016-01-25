`include "../defines.vh"
module addtest();
`include "../testinclude.vh"
initial $readmemh("sub.hex",Mem);
initial $readmemh("sub.val",values);
initial #1000 $finish();



endmodule 
