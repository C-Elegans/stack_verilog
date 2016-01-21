`include "../defines.vh"
module rstacktest();
`include "../testinclude.vh"
initial $readmemh("rstack.hex",Mem);

initial #100 $finish();
initial begin
#36 `lassert(2);
#2 `lassert(1);

end

endmodule 
