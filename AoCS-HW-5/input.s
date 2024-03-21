.data
input_str:
	.asciz "Enter the number of elements ["
to_str:
	.asciz " to "
bracket_str:
	.asciz "]: "
array_str:
	.asciz "Enter array elements one at a time:\n"
	
.macro print_str(%min, %max)
	la	a0 input_str
	li	a7 4
	ecall
	li	a0 %min
	li	a7 1
	ecall
	la	a0 to_str
	li 	a7 4
	ecall
	li	a0 %max
	li	a7 1
	ecall
	la	a0 bracket_str
	li	a7 4
	ecall
.end_macro

.macro read_number(%dest, %min, %max)
	li	t0 %min
	li	t1 %max
	
loop:
	print_str(%min, %max)
	li	a7 5
	ecall
	blt	a0 t0 loop
	bgt	a0 t1 loop
	
	mv	%dest a0
.end_macro

.macro read_array(%dest, %size)
	la	t0 %dest
	mv	t1 zero
	la	a0 array_str
	li	a7 4
	ecall
	li	a7 5
loop:
	ecall
	sw	a0 (t0)
	addi	t0 t0 4
	addi	t1 t1 1
	blt	t1 %size loop
.end_macro