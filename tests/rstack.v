`include "../defines.vh"
module rstacktest();
`include "../testinclude.vh"
initial $readmemh("rstack.hex",Mem);
initial $readmemh("rstack.val",values);
initial #100 $finish();
initial begin


end

endmodule 
