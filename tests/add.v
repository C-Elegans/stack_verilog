`include "../defines.vh"
module addtest();
`include "../testinclude.vh"
initial $readmemh("add.hex",Mem);
initial $readmemh("add.val",values);
initial #1000 $finish();
initial begin

end


endmodule 
