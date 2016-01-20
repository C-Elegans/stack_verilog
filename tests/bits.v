`include "../defines.vh"
module bitstest();
`include "../testinclude.vh"
initial $readmemh("bits.hex",Mem);

initial #100 $finish();
initial begin
#26 `lassert(4);
#14 `lassert(31);
#10	`lassert(242);
#14 `lassert(26);
end



endmodule 
