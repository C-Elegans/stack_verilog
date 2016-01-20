OS := $(shell uname)
COPY=objcopy
ifeq ($(OS),Darwin)
	COPY=gobjcopy
endif
TESTS = add.test sub.test stack.test bits.test
all: $(TESTS)
	

%.test: %.v %.hex ../testinclude.vh ../cpu.v
	iverilog -g 2012 -g assertions -g verilog-ams -Wall -I ../ -o $@  ../cpu.v $<
	vvp $@	
%.hex:%.or
	dump $< > $@
	
%.o:%.f
	forthc -i $< -o $@ -q
%.or:%.o
	$(COPY) -I binary -O binary --reverse-bytes=2 $< $@

clean:
	-rm *.o *.or *.hex *.test
