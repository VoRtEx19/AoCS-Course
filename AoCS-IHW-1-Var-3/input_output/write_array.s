.data
n_line:	.asciz "\n"
space:	.asciz " "
#macro: writes string and array of given size (to avoid repetition in the other macro in this file)
# 1st argument: string corresponding to array
# 2nd argument: array address to be put out
# 3rd argument: size of the array
.macro write_array(%str, %arr, %size)	
	mv	a0 %str		# string to output
	li	a7 4
	ecall
	mv	t0 %arr		# loading array A start address
	mv	t1 zero
	
loop:
	lw	a0 (t0)		# loading array element
	li	a7 1
	ecall
	la	a0 space		# spacing
	li	a7 4
	ecall
	addi	t0 t0 4		# increasing counter
	addi	t1 t1 1
	blt	t1 %size loop
.end_macro