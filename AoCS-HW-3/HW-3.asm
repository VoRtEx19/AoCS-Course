.data
str0:	.asciz "Enter the number of elements [1, 10]: "
str1:	.asciz "\nEnter the elements:\n"
str2:	.asciz "\nSum of elements: "
str3: 	.asciz "\nSum overflow.\nElements summed: "
str4: 	.asciz "\nSum of even elements: "
str5: 	.asciz "\nSum of odd elemets: "
.align 2
array: .space 40
arrend:
.text
	la	t0 array
	li	a3 1
	li	a4 10
input_n:
	la	a0 str0
	li	a7 4
	ecall
	li	a7 5
	ecall
	blt	a0 a3 input_n
	bgt	a0 a4 input_n
	mv	t1 a0
	
	la	a0 str1
	li	a7 4
	ecall
	li	t2 1
	li	a4 2
	
fill:	
	li	a7 5
	ecall
	sw	a0 (t0)
	addi	t0 t0 4
	addi	t2 t2 1
	ble	t2 t1 fill
	

for:
	la	t0 array
	li	t2 0
	li	t3 0
	li	a5 0
sum:	
	lw	a0 (t0)
	beqz	a2 skip_even_and_odd
	andi	a1 a0 1
	bne	a1 t6 skip
skip_even_and_odd:
	beqz	a0 return
	xor	t4 t3 a0
	bgez	t4 overflow_warning
return:
	add	t3 t3 a0
	addi 	a5 a5 1
skip:
	addi	t2 t2 1
	addi	t0 t0 4
	blt	t2 t1 sum
	j output

overflow:
	la	a0 str3
	li	a7 4
	ecall
	mv	a0 t2
	beqz	a2 overflow_skip
	mv	a0 a5
overflow_skip:
	li	a7 1
	ecall

output:
	j check_line
end_check:
	li	a7 4
	ecall
	li	a7 1
	mv	a0 t3
	ecall
	j increase
	
overflow_warning:
	add	t5 t3 a0
	bgtz	a0 pos_overflow
	j neg_overflow

pos_overflow:
	bltz	t5 overflow
	j return

neg_overflow:
	bgtz	t5 overflow
	j return
	
check_line:
	beqz	a2 classic
	beq	a2 a3 even
	j odd

classic:
	la	a0 str2
	j end_check
even:
	la	a0 str4
	j end_check
odd:
	la	a0 str5
	j end_check
	
increase:
	addi 	a2 a2 1
	bgt	a2 a4 exit
	beq	a2 a3 for
	addi	t6 t6 1
	j for
	
exit:
	li	a7 10
	ecall
