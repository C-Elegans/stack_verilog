module testbench();
`include "testinclude.vh"
initial $readmemh("mem.hex",Mem);
initial #500 $finish();
initial #1 not_under_test = 1;
endmodule 
