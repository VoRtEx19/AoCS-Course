.data 
input:	.asciz "Input number of elements ["
to:		.asciz " to "
bracket:	.asciz "]: "
wrong:	.asciz "Wrong input. Try again.\n"

# macro: writes the string with two numbers in it (to avoid repetition in the other macro in this file)
# 1st argument: 1st number
# 2nd argument: 2nd number
.macro print_str (%min, %max)
	la	a0 input
	li	a7 4
	ecall
	mv	a0 %min
	li	a7 1
	ecall
	la	a0 to
	li	a7 4
	ecall
	mv	a0 %max
	li	a7 1
	ecall
	la	a0 bracket
	li	a7 4
	ecall
.end_macro

# macro: reads number within boundaries and saves it to given register (to avoid repetition in the other macro in this file)
# 1st argument: register to save the number
# 2nd argument: min value of number to be read
# 3rd argument: max value of number to be read
.macro read_number(%reg, %min, %max)
loop:
	print_str(%min, %max)

	li	a7 5			# n input
	ecall
	
	blt	a0 %min again	# branching if input is incorrect
	bgt	a0 %max again
	b end			# if input is correct, finish program
	
again:
	la	a0 wrong		# indicate that input was incorrect
	li	a7 4
	ecall
	b 	loop			# return to loop: try again
end:
	mv	%reg a0
.end_macro