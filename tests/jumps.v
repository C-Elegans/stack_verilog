`include "../defines.vh"
module jumptest();
`include "../testinclude.vh"
initial $readmemh("jumps.hex",Mem);


initial #1000 $finish();
initial begin
vp = 0;
values[0] = 1;
values[1] = 2;
values[2] =3;
values[3] =4;
values[4]=5;
values[5]=6;

values[6]=50;

end



endmodule 
