# macro for reading a number from console
# arg - destination register
.macro readnum(%reg)
	li a7 5
	ecall
	mv	%reg a0
.end_macro
