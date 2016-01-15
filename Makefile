cpu: cpu.v testbench.v tasks.v mem.hex defines.vh
	iverilog -g 2009 -o cpu cpu.v testbench.v 
	vvp cpu	
mem.hex:data_rev
	dump data_rev > mem.hex
data:asm.s
	stack_as asm.s data
data_rev:data
	gobjcopy -I binary -O binary --reverse-bytes=2 data data_rev
clean:
	rm cpu
	rm data
	rm mem.hex
