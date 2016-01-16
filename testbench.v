module testbench();
reg [15:0] Mem [10:0];
wire [15:0] address;
wire [15:0] data_in;
wire wr;
reg [15:0] data;
reg clk;
initial $readmemh("mem.hex",Mem);
initial begin
	clk = 0;
end
cpu u0 (.clk(clk), 
		.address(address), 
		.data_in(data),
		.data_out(data_in),
		.wr(wr));

always #1 begin 
	clk = !clk;
	data <= Mem[address];
	if(wr) begin 
		Mem[address] <= data_in;
		$display("wrote data %d, address: %d",data_in, address);
	end
	end
initial #500 $finish();

endmodule 
