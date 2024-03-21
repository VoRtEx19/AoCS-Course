.data
success:	.asciz "\nProgram finished successfully. All tests passed."
fail:		.asciz "\nProgram failed current test - "
.align 2
A:	.space 40
B:	.space 40
.text

# Test 1 - Classic
	la	s0 A
	la	s1 B
	li 	s2 10
	
	# adding data to array
	li	a0 1
	sw	a0 (s0)
	addi	s0 s0 4
	li	a0 2
	sw	a0 (s0)
	addi	s0 s0 4
	li	a0 3
	sw	a0 (s0)
	addi	s0 s0 4
	li	a0 4
	sw	a0 (s0)
	addi	s0 s0 4
	li	a0 5
	sw	a0 (s0)
	addi	s0 s0 4
	li	a0 6
	sw	a0 (s0)
	addi	s0 s0 4
	li	a0 7
	sw	a0 (s0)
	addi	s0 s0 4
	li	a0 8
	sw	a0 (s0)
	addi	s0 s0 4
	li	a0 9
	sw	a0 (s0)
	addi	s0 s0 4
	li	a0 10
	sw	a0 (s0)
	addi	s0 s0 4
	
	# generating array
	la	s0 A
	li	s2 10
	addi	sp sp -12	# saving arguments on stack:
	sw	s2 8(sp)	# - size
	sw	s0 4(sp)	# - source
	sw	s1 (sp)	# - destination
	jal	generate3	# calling function that generates B basaed on A with arguments on stack
	lw	s3 (sp)	# return value exception code, saved on stack
	addi	sp sp 4	# "0" - all good, no exception
	bnez	s3 exit
	
	# checking generated data
	la	s0 B
	lw	a0 (s0)
	li	a1 3
	bne	a0 a1 failed
	addi	s0 s0 4
	lw	a0 (s0)
	li	a1 5
	bne	a0 a1 failed
	addi	s0 s0 4
	lw	a0 (s0)
	li	a1 7
	bne	a0 a1 failed
	addi	s0 s0 4
	lw	a0 (s0)
	li	a1 9
	bne	a0 a1 failed
	addi	s0 s0 4
	lw	a0 (s0)
	li	a1 11
	bne	a0 a1 failed
	addi	s0 s0 4
	lw	a0 (s0)
	li	a1 13
	bne	a0 a1 failed
	addi	s0 s0 4
	lw	a0 (s0)
	li	a1 15
	bne	a0 a1 failed
	addi	s0 s0 4
	lw	a0 (s0)
	li	a1 17
	bne	a0 a1 failed
	addi	s0 s0 4
	lw	a0 (s0)
	li	a1 19
	bne	a0 a1 failed
	addi	s0 s0 4
	
# Test 2 - Negative numbers too
	la	s0 A
	la	s1 B
	li 	s2 8
	
	# adding data to array
	li	a0 -1
	sw	a0 (s0)
	addi	s0 s0 4
	li	a0 -7
	sw	a0 (s0)
	addi	s0 s0 4
	li	a0 9
	sw	a0 (s0)
	addi	s0 s0 4
	li	a0 0
	sw	a0 (s0)
	addi	s0 s0 4
	li	a0 24
	sw	a0 (s0)
	addi	s0 s0 4
	li	a0 -11
	sw	a0 (s0)
	addi	s0 s0 4
	li	a0 19
	sw	a0 (s0)
	addi	s0 s0 4
	li	a0 -19
	sw	a0 (s0)
	addi	s0 s0 4
	
	# generating array
	la	s0 A
	li	s2 10
	addi	sp sp -12	# saving arguments on stack:
	sw	s2 8(sp)	# - size
	sw	s0 4(sp)	# - source
	sw	s1 (sp)	# - destination
	jal	generate3	# calling function that generates B basaed on A with arguments on stack
	lw	s3 (sp)	# return value exception code, saved on stack
	addi	sp sp 4	# "0" - all good, no exception
	bnez	s3 exit
	
	# checking generated data
	la	s0 B
	lw	a0 (s0)
	li	a1 -8
	bne	a0 a1 failed
	addi	s0 s0 4
	lw	a0 (s0)
	li	a1 2
	bne	a0 a1 failed
	addi	s0 s0 4
	lw	a0 (s0)
	li	a1 9
	bne	a0 a1 failed
	addi	s0 s0 4
	lw	a0 (s0)
	li	a1 24
	bne	a0 a1 failed
	addi	s0 s0 4
	lw	a0 (s0)
	li	a1 13
	bne	a0 a1 failed
	addi	s0 s0 4
	lw	a0 (s0)
	li	a1 8
	bne	a0 a1 failed
	addi	s0 s0 4
	lw	a0 (s0)
	li	a1 0
	bne	a0 a1 failed
	addi	s0 s0 4
	
# Test 3 - Positive Overflow
	la	s0 A
	la	s1 B
	li 	s2 8
	
	# adding data to array
	li	a0 2000000000
	sw	a0 (s0)
	addi	s0 s0 4
	li	a0 1000000000
	sw	a0 (s0)
	addi	s0 s0 4
	
	# generating array
	la	s0 A
	li	s2 2
	addi	sp sp -12	# saving arguments on stack:
	sw	s2 8(sp)	# - size
	sw	s0 4(sp)	# - source
	sw	s1 (sp)	# - destination
	jal	generate3	# calling function that generates B basaed on A with arguments on stack
	lw	s3 (sp)	# return value exception code, saved on stack
	addi	sp sp 4	# "0" - all good, no exception
	beqz	s3 failed
	
# Test 4 - Negative Overflow
	la	s0 A
	la	s1 B
	li 	s2 8
	
	# adding data to array
	li	a0 -2000000000
	sw	a0 (s0)
	addi	s0 s0 4
	li	a0 -1000000000
	sw	a0 (s0)
	addi	s0 s0 4
	
	# generating array
	la	s0 A
	li	s2 2
	addi	sp sp -12	# saving arguments on stack:
	sw	s2 8(sp)	# - size
	sw	s0 4(sp)	# - source
	sw	s1 (sp)	# - destination
	jal	generate3	# calling function that generates B basaed on A with arguments on stack
	lw	s3 (sp)	# return value exception code, saved on stack
	addi	sp sp 4	# "0" - all good, no exception
	beqz	s3 failed
# If all is good	
	la	a0 success
	li	a7 4
	ecall
	b exit
failed:
	la	a0 fail
	li	a7 4
	ecall
exit:
	li	a7 10
	ecall
	
.include "generator.s"