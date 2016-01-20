`define fetch 0
`define word_cycle1 1
`define word_cycle1 2
`define byte_cycle1 3
`define byte_cycle2 4



`define NOP 0
`define ADD 1
`define SUB 2
`define OUT 3
`define IN 4
`define DUP 5
`define DROP 6
`define SWAP 7
`define ROT 8
`define RET 9
`define LT 10
`define EQ 11
`define GT 12
`define NEG 13
`define RPUSH 14
`define RPOP 15
`define RCP 16
`define AND 17
`define OR 18
`define XOR 19
`define LSHIFT 20
`define RSHIFT 21
`define MUL 22
`define MEMFETCH 23
`define STORE 24

`define JUMP 32
`define CALL 64
`define CJUMP 96
`define PUSH 128

`define assert(condition) if(condition === 0) begin $error("Assertion failed");$fatal(0,-1); end
`define lassert(value) if(led_in !== value) begin $error("Assertion failed");$fatal(0,-1); end
