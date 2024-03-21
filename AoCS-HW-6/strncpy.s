.macro strncpy(%dest, %src, %n)
	mv	t0 zero		# conter
	la	t1 %dest		# destination
	la	t2 %src		# source
	mv	t5 zero		# flag for encountering \0
	li	t6 '\0'		# just stoing \0
loop:
	bge	t0 %n exit	# break form the cycle
	beqz	t5 loadbyte	# if not encountered \0, do usual copy
	sb	t6 (t1)		# if encountered \0, save \0
	b next			# increment
loadbyte:
	lb	t3 (t2)		# load next byte
	bnez	t3 storebyte	# if regular byte (non-\0), copy it
	li	t5 1			# if \0, set flag to True
storebyte:
	sb	t3 (t1)		# whether equal to \0 or not, it should be stored
next:
	addi	t0 t0 1		# counter++
	addi	t1 t1 1		# dest_pointer++
	addi	t2 t2 1		# src_pointer++
	b loop
exit:

.end_macro