`include "../defines.vh"
module addtest();
`include "../testinclude.vh"
initial $readmemh("add.hex",Mem);

initial #1000 $finish();
initial begin
#26 `assert (led_in == 4);
#22 `assert (led_in == 17);
end


endmodule 
