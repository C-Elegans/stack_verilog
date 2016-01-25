OS := $(shell uname)
COPY=objcopy
ifeq ($(OS),Darwin)
	COPY=gobjcopy
endif
TESTS = add.test sub.test stack.test bits.test jumps.test
all: $(TESTS)
	

%.test: %.v %.hex %.val ../testinclude.vh ../cpu.v
	iverilog -g 2012 -g assertions -g verilog-ams -Wall -I ../ -o $@  ../cpu.v $<
	vvp $@	
	rm $@
%.hex:%.or
	dump $< > $@
%.d: %.f
	gforth -e "`cat $< ` BYE" |dec2byte> $@
%.val: %.d
	echo -e "obase=16; `cat $<`" | tr ' ' '\n'| bc | tail -n +2> $@
	
%.o:%.f
	forthc -i $< -o $@ -q
%.or:%.o
	$(COPY) -I binary -O binary --reverse-bytes=2 $< $@

clean:
	-rm *.o *.or *.hex *.test *.d *.val
