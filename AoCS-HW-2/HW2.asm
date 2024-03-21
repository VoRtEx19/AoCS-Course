.data
	arg0: 	.asciz "Enter the divisible: "
	arg1: 	.asciz "Enter the divisor: "
	arg2:	.asciz "Quotient: "
	arg3:	.asciz "Remainder: "
	exc:	.asciz "You cannot divide by zero"
	ln: 	.asciz "\n"
.text
	la	a0, arg0	# a0 := address of "Enter the divisible"
	li	a7, 4		# command string output
	ecall
	li	a7, 5		# command int input
	ecall
	mv	t0, a0		# store the divisible
	
	la	a0, arg1	# a0 := address of "Enter the divisor"
	li	a7, 4		# command string output
	ecall
	li	a7, 5		# command int input
	ecall
	mv	t1, a0		# store the divisor
	
	la 	a0, ln		# new line
	li	a7, 4
	ecall
	
	beqz 	t1, exception	# check if divisor is equal zero, then move to exception
	li	t3, 1
	bgtz	t0, skip	# make divisible positive
	sub	t0, zero, t0
	sub	t3, zero, t3
	li	t4, 1
	skip:
	bgtz	t1, loop	# make divisor positive
	sub	t1, zero, t1
	sub	t3, zero, t3
	
	loop:
	blt 	t0, t1, result
	sub	t0, t0, t1
	add	t2, t2, t3
	bge	t0, t1, loop
	
	result:			# output results
	beqz 	t4, output
	sub	t0, zero, t0
	output:
	la	a0, arg2
	li	a7, 4
	ecall
	mv 	a0, t2
	li	a7, 1
	ecall
	
	la 	a0, ln		# new line
	li	a7, 4
	ecall
	
	la	a0, arg3
	li	a7, 4
	ecall
	mv 	a0, t0
	li	a7, 1
	ecall
	b	exit	
	
	exception:
	la	a0, exc
	li	a7, 4
	ecall
	
	exit:
	li	a7, 10
	ecall
	