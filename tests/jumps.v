`include "../defines.vh"
module jumptest();
`include "../testinclude.vh"
initial $readmemh("jumps.hex",Mem);

initial #1000 $finish();
initial begin
#56 `lassert(1);
#98 `lassert(2);
#98 `lassert(3);
#98 `lassert(4);
#98 `lassert(5);
#98 `lassert(6);
#60 `lassert(10);
#28 `lassert(50);
end

endmodule 
