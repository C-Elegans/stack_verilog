cpu: cpu.v testbench.v tasks.v mem.hex defines.vh
	iverilog -g 2009 -o cpu cpu.v testbench.v 
	vvp cpu	
mem.hex:data
	dump data > mem.hex
data:asm.s
	stack_as asm.s data
	gobjcopy -I binary -O binary --reverse-bytes=2 data data

