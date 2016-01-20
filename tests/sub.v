`include "../defines.vh"
module addtest();
`include "../testinclude.vh"
initial $readmemh("sub.hex",Mem);

initial #1000 $finish();
initial begin
#25 `assert (led_in == 2);
#39 `assert (led_in == 7);
end


endmodule 
