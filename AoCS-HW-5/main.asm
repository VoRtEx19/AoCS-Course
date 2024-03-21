.include "input.s"
.include "sum.s"
.include "output.s"

.data
	.align 2
array:
	.space 40
	
.text
main:
	read_number(s0, 1, 10)
	read_array(array, s0)
	
	sum_elements(array, s0, s1)
	
	write_number(s1)
	
	li	a7 10
	ecall