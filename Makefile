OS := $(shell uname)
COPY=objcopy
ifeq ($(OS),Darwin)
	COPY=gobjcopy
endif

cpu: cpu.v testbench.v tasks.v mem.hex defines.vh
	iverilog -g 2009 -o cpu cpu.v testbench.v 
	vvp cpu	
mem.hex:data_rev
	dump data_rev > mem.hex
data:main.f
	forthc main.f data
data_rev:data
	$(COPY) -I binary -O binary --reverse-bytes=2 data data_rev
clean:
	rm cpu
	rm data
	rm mem.hex
