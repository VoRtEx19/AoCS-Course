.data
overf:	.asciz "\nOverflow occured while adding elements: "
space_g:	.asciz " "
.text
generate3:
	lw	t0 4(sp)		# loading array addresses from stack
	lw	t1 (sp)
	addi	sp sp 8
	li	t2 1			# adding counter
	
loop_g:
	lw	t3 (t0)		# loading A_i, A_{i+1}
	lw	t4 4(t0)
	xor	t5 t3 t4		# check for overflow
	bgez t5 overflow_warning
	
return:				# come back here if check is false
	add	t3 t3 t4		# adding them
	sw	t3 (t1)		# saving the result to B_{i}
	
	addi	t0 t0 4		# moving counters
	addi	t1 t1 4
	addi	t2 t2 1
	lw	t3 (sp)		#loading array size
	blt	t2 t3 loop_g	# if not the end -> back to loop
	addi	sp sp 4		# popping the stack because we no longer need size
	ret
	
overflow_warning:		# determining the sign of possible oveflow
	add 	t5 t3 t4
	bgtz	t3 pos_overflow
	bltz	t3 neg_overflow
	b return

pos_overflow:			# if pos + pos = neg -> overflow
	bltz	t5 overflow
	b return

neg_overflow:			# if neg + neg = pos -> overflow
	bgtz	t5 overflow
	b return
	
overflow:
	la	a0 overf		# notification output
	li	a7 4
	ecall
	mv	a0 t3		# showing which numbers caused overflow
	li	a7 1			# first number
	ecall
	la	a0 space_g	# separating them
	li	a7 4
	ecall
	mv	a0 t4		# second number
	li	a7 1
	ecall
	sw	a7 (sp)		# saving info that there is exception on stack
	ret