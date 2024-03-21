.include "input_output/read_number.s"
.include "input_output/read_array.s"
.include "input_output/write_array.s"

.data
A_str:	.asciz "\nFirst array input:\n"
B_str: 	.asciz "\nGenerated array according to rule:\n"
.align 2
# arrays A and B
array_A:	.space 40
array_B:	.space 40
.text
main:
	li	s1 2		# setting boundaries for input
	li	s2 10
	# macro: reads number within boundaries and saves it to given register (read more in macros/read_number) 
	read_number(s0, s1, s2)
	
	# loading array "pointers"
	la	s1 array_A
	la	s2 array_B
	# macro: reads array of given size and saves it in given address (read more in macros/read_array) 
	read_array(s1, s0)
	
	addi	sp sp -12	# saving arguments on stack:
	sw	s0 8(sp)	# - size
	sw	s1 4(sp)	# - source
	sw	s2 (sp)	# - destination
	jal	generate3	# calling function that generates B basaed on A with arguments on stack
	lw	s3 (sp)	# return value exception code, saved on stack
	addi	sp sp 4	# "0" - all good, no exception
	bnez	s3 exit	# "1" - overflow while counting -> program should be ended
	# if overflow occured during B generation, program ends here
	
	la	s3 A_str	# providing func with necessary string
	# macro: writes string and array of given size
	write_array(s3, s1, s0)
	addi	s0 s0 -1	# setting size to size of B (it is 1 element less than A)
	la	s3 B_str	# providing func with necessary string
	# macro: writes string and array of given size
	write_array(s3, s2, s0)

exit:
	li	a7 10	# exit program
	ecall
	
.include "generator.s"