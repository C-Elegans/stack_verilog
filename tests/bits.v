`include "../defines.vh"
module bitstest();
`include "../testinclude.vh"
initial $readmemh("bits.hex",Mem);
initial $readmemh("bits.val",values);
initial #100 $finish();
initial begin

end



endmodule 
