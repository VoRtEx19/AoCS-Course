.data
input_a:	.asciz "\nEnter array elements on separate lines:\n"

# macro: reads array of given size and saves it in given address
# 1st argument: destination address
# 2nd argument: size of array to be saved
.macro read_array (%dest, %size)	
	la	a0 input_a	# requesting array input
	li	a7 4		
	ecall
	mv	t0 %dest		# saving array address locally
	mv	t1 zero
loop:
	li	a7 5			# element input
	ecall
	sw	a0 (t0)		# saving element
	addi	t0 t0 4		# moving index
	addi	t1 t1 1
	blt	t1 %size loop	# check if enough
.end_macro