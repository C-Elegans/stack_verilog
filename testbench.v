module testbench();
reg [15:0] Mem [10:0];
wire [15:0] address;
reg [15:0] data;
reg clk;
initial $readmemh("mem.hex",Mem);
initial begin
	clk = 0;
end
cpu u0 (.clk(clk), 
		.address(address), 
		.data_in(data));

always #1 begin 
	clk = !clk;
	data <= Mem[address];
	end
initial #500 $finish();

endmodule 
