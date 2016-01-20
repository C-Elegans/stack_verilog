module testbench();
`include "testinclude.vh"
initial $readmemh("mem.hex",Mem);
initial #500 $finish();

endmodule 
