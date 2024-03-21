#===============================================================================
# Macros for testing the subprogram
# Argument %buffer: register containing address to buffer
# Argument %buffer_size: immediate length of buffer
# Requirements: include find_id_frequencies.s
# Requirements: include MacroLib\console_io.m
#===============================================================================

.macro test(%buffer, %buffer_size)
.data
test1:
	.asciz "Test on short data: "
test2:
	.asciz "Test on long data: "
test3:
	.asciz "Test on enormous data: "
input:
	.asciz	"AoCS-IHW-3 Var 25/test_input/input.txt"
output:
	.asciz	"AoCS-IHW-3 Var 25/test_output/output.txt"
long_input:
	.asciz	"AoCS-IHW-3 Var 25/test_input/long_input.txt"
long_output:
	.asciz	"AoCS-IHW-3 Var 25/test_output/long_output.txt"
enormous_input:
	.asciz	"AoCS-IHW-3 Var 25/test_input/enormous_input.txt"
enormous_output:
	.asciz	"AoCS-IHW-3 Var 25/test_output/enormous_output.txt"
	.align 2
test_array:
	.space 12
input_array:
	.space 12
output_array:
	.space 12
.text
	push(t0)
	push(t1)
	push(t2)
	push(t3)
	push(t4)
	push(t5)
	push(t6)

	mv	t5, %buffer
	mv	t6, zero
	
	# saving addresses for strings to arrays
	la	t0, test_array
	la	t1, input_array
	la	t2, output_array
	
	la	t3, test1
	sw	t3, (t0)
	la	t3, test2
	sw	t3, 4(t0)
	la	t3, test3
	sw	t3, 8(t0)
	
	la	t3, input
	sw	t3, (t1)
	la	t3, long_input
	sw	t3, 4(t1)
	la	t3, enormous_input
	sw	t3, 8(t1)
	
	la	t3, output
	sw	t3, (t2)
	la	t3, long_output
	sw	t3, 4(t2)
	la	t3, enormous_output
	sw	t3, 8(t2)
	
loop:
	lw	t3, (t0)
	printstrreg(t3)
	lw	t3, (t1)
	lw	t4, (t2)
	find_id_frequencies(t3, t4, t5, %buffer_size)
	
	# process return code
	beqz	a0, success
	addi	a0, a0, -1
	beqz	a0, error_input
	addi	a0, a0, -1
	beqz	a0, error_output
	b	error_reading	
	
end_loop:
	addi	t0, t0, 4
	addi	t1, t1, 4
	addi	t2, t2, 4
	addi	t6, t6, 1
	li	a0, 3
	blt	t6, a0, loop
	b end
success:
	printstr("All done\n")
	b end_loop
error_input:
	printstr("Error opening input file\n")
	b end_loop
error_output:
	printstr("Error opening output file\n")
	b end_loop
error_reading:
	printstr("Error reading input file\n")
	b end_loop
end:
	pop(t6)
	pop(t5)
	pop(t4)
	pop(t3)
	pop(t2)
	pop(t1)
	pop(t0)
.end_macro
