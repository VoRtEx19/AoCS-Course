.data
overf_count:
	.string "Oveflow has occured.\nElements added: "

.macro sum_elements(%src, %size, %out)
	la	t0 %src
	mv	t1 zero
loop:
	lw	a0 (t0)
	xor	t2 a0 %out
	bgez	t2 achtung
back:
	add	%out	%out a0
	addi	t1 t1 1
	addi t0 t0 4
	blt	t1 %size loop
	j exit
	
achtung:
	add	t2 a0 %out
	bgtz	a0 pos_overf
	bltz	a0 neg_overf
	j 	back
	
pos_overf:
	bltz	t2 overf
	j back

neg_overf:
	bgtz	t2 overf
	j back
	
overf:
	la	a0 overf_count
	li	a7 4
	ecall
	mv	a0 t1
	li	a7 1
	ecall
exit:
.end_macro