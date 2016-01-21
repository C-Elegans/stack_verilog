

reg [15:0] Mem [256];
wire [15:0] address;
wire [15:0] data_in;
wire wr;
wire Lr;
reg [15:0] data;
reg clk;
wire [7:0] led_in;
int prevtime;
integer values[32];
reg [4:0] vp;
reg not_under_test;
initial begin
	clk = 0;
	prevtime = 0;
	vp = 0;
	not_under_test = 0;
end
cpu u0 (.clk(clk), 
		.address(address), 
		.data_in(data),
		.data_out(data_in),
		.wr(wr),
		.Lr(Lr),
		.LEDS(led_in));
always #1 begin 
	clk = !clk;
	data <= Mem[address];
	if(wr) begin 
		Mem[address] <= data_in;
		$display("wrote data %d, address: %d",data_in, address);
	end
	
	end
always @(posedge Lr) if(Lr) begin
		$display("%d, cycle %d",led_in, $time-prevtime);
		prevtime = $time;
		if(!not_under_test)`lassert(values[vp]);
	vp <= vp + 1;
	end
