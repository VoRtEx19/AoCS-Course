#===============================================================================
# Macro for finding number of IDs' occurences in given input file
# and output of found number in output file
#
# Argument %input_file: reg containing address of string with input file path
# Argument %output_file: reg containing address of string with output file path
# Argument %buffer: reg containing address of buffer to use
# Argument %buffer_size: immediate value of buffer size
#
# Returns: exodus code in a0
# 	0 - no errors occurred
#	1 - error while opening input file
#	2 - error while opening output file
#	3 - error while reading from input file
#
# ID - an ascii string that consists only of latin characters and numbers
#
# Requirement: include file_io.m
# Requirement: include string.m
#===============================================================================

.data
result_str:
	.ascii "Number of IDs: "
result_num:
	.space 10
	.align 2

.macro find_id_frequencies(%input_file, %output_file, %buffer, %buffer_size)
.text
	# saving everything
	push(a1)
	push(t0)
	push(t1)
	push(t2)
	push(t3)
	push(t4)
	push(t5)
	push(t6)
	push(s10)
	push(s11)
	
	# overall counter
	mv	s11, zero
	
	# open files
	open(%input_file, READ_ONLY)
	bltz	a0 error_open_input
	mv	t0, a0
	
	open(%output_file, WRITE_ONLY)
	bltz	a0 error_open_output
	mv	t1, a0
	
	mv	t2, %buffer
	mv	t5, t2
	
loop:
	# read into buffer
	read(t0, t2, BUFFER_SIZE)
	bltz	a0, error_read
	mv	s10, a0
	
	# count ids
	mv	t2, t5
	mv	t3, zero
	mv	t4, zero
	
counting_loop:
	lb	t6 (t2)
	li	a0 '0'
	blt	t6 a0 not_id_symbol
	li	a0 '9'
	ble	t6 a0 id_symbol
	li	a0 'A'
	blt	t6 a0 not_id_symbol
	li	a0 'Z'
	ble	t6 a0 id_symbol
	li	a0 'a'
	blt	t6 a0 not_id_symbol
	li	a0 'z'
	ble	t6 a0 id_symbol
	b not_id_symbol
	
id_symbol:
	addi	t4, t4, 1
	b end_loop
	
not_id_symbol:
	bgtz	t4, id_complete
	b end_loop
	
id_complete:
	mv	t4, zero
	addi	t3, t3, 1
	b end_loop
	
end_loop:
	addi	t2, t2, 1
	add	t6, t5, s10
	blt	t2, t6, counting_loop
	
	# added counted ids from buffer to overall counter (s11)
	add	s11, s11, t3
	
	# check if eof
	mv	t2, t5
	addi t2, t2, BUFFER_SIZE
	sub	t2, t2, s10
	beq	t2, t5, loop
	
	beqz	t4, skipmore
	addi	s11, s11, 1
	
skipmore:
	
	# saving result to string
	la	t2, result_str
	la	t3, result_num
	
	uint_to_str(s11, t3)
	
	# writing to file
	strlen(t2)
	mv	t3, a0
	write(t1, t2, t3)
	
	# all good
	li	a0, 0
	
	b exit
	
error_open_input:
	li	a0, 1
	b exit
error_open_output:
	li	a0, 2
	b exit
error_read:
	li	a0, 3
	b exit
exit:
	# closing files
	close(t0)
	close(t1)
	
	# reading everything from stack
	pop(s11)
	pop(s10)
	pop(t6)
	pop(t5)
	pop(t4)
	pop(t3)
	pop(t2)
	pop(t1)
	pop(t0)
	push(a1)
.end_macro
