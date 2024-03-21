.data
	start: 	.asciz "Program started\n"
	out: 	.asciz "Max factorial that can be stored in a 32-bit word:"
	f_cycle:.asciz "\nFound by cycle:"
	f_rec:	.asciz "\nFound by recursion:"
.text
	la	a0 start# preparatory output
	li	a7 4
	ecall
	la	a0 out
	ecall
	la	a0 f_cycle
	ecall
	
	jal	subpr	# calling cycle subprogram
	li	a7 1
	ecall
	
	la	a0 f_rec
	li	a7 4
	ecall
	
	li	a0 1
	li	a1 1
	jal	rec	# calling recursion subprogram
	li	a7 1
	ecall
	
	li	a7 10	# exit
	ecall
	
#-----------------------------
	
subpr:	li 	t0 2
	li	t1 1
loop:	mulh	t2 t0 t1
	bnez	t2 break
	mul	t1 t1 t0
	addi	t0 t0 1
	b loop
break:	addi	t0 t0 -1
	mv	a0 t0
	ret

rec:	addi 	sp sp -4
	sw	ra (sp)
	
	addi	a0 a0 1
	mulh 	t0 a0 a1
	addi	a0 a0 -1
	bnez	t0 done
	addi 	a0 a0 1
	mul	a1 a0 a1
	jal	rec
	
done:	lw	ra (sp)
	addi	sp sp 4
	ret