`include "../defines.vh"
module bitstest();
`include "../testinclude.vh"
initial $readmemh("bits.hex",Mem);

initial #100 $finish();
initial begin

values[0] = 4;
values[1] = 31;
values[2] =242;
values[3] =26;

end



endmodule 
