.include "strncpy.s"

.eqv	BUF_SIZE 100

.data
input_str:
	.asciz "Enter the string: "
input_n:
	.asciz "Input n - number of symbols to by copied: "
output_str:
	.asciz "Copied string: "
buf:
	.space BUF_SIZE
buf2:
	.space BUF_SIZE
	
.text
.globl main
main:
	# request string
	la 	a0 input_str
	li	a7 4
	ecall
	# read string
	la	a0 buf
	li	a1 BUF_SIZE
	li	a7 8
	ecall
	# request n
	la	a0 input_n
	li	a7 4
	ecall
	li	a7 5
	ecall
	# save n
	mv	s0 a0
	# copy string	
	strncpy(buf2, buf, s0)
	# copy result
	la	a0 output_str
	li	a7 4
	ecall
	la	a0 buf2
	ecall
	# exit
	li	a7 10
	ecall