`include "../defines.vh"
module rstacktest();
`include "../testinclude.vh"
initial $readmemh("rstack.hex",Mem);

initial #100 $finish();
initial begin
values[0] = 2;
values[1] = 1;

end

endmodule 
