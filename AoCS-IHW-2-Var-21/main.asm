.include "input_output_lib/input.s"
.include "input_output_lib/output.s"
.include "float_lib/Nilakantha.s"
.text
main:
	# printstr func prints the given string. Welcome!
	printstr("Welcome to \"Pi calculation via Nilakantha row\".\nThis program was made as solution to IHW-2 task by Lev Svetlichnyi\n")
	
	# This is used for repeated work of program
repeat:
	# Ask for user's choice - printstr (see above)
	printstr("Would you like to test it manually or automatically?[1 for manually, 2 for automatically, any other number for exit]\n")
	# readnum func reads a number from console, the argument is the destination register to save number
	readnum(s0)
	# check the choice
	li	a0 1
	beq	s0 a0 manual
	li	a0 2
	beq	s0 a0 auto
	j exit
	
manual:
	# ask user for choice
	printstr("The calculation will be executed manually.\n")
	printstr("There are multiple options:\n")
	printstr("1. Enter the required precision\n")
	printstr("2. Let program work by default with set precision 0.05%\n")
	printstr("0. Back to main menu\n")
	printstr("[Enter 1, 2, or 0 (any other number will be considered a 0)]\n")
	# read choice
	readnum(s0)
	# check the choice
	li	a0 1
	beq	a0 s0 m_prec
	li	a0 2
	beq	a0 s0 default
	j repeat
	
	# here user chose precision
m_prec:
	# they enter number of decimal places
	printstr("Enter number of decimal places: ")
	# input
	readnum(s0)
	# 20 is a lot for assembler, it works so long then
	li	s1 20
	bgt	s0 s1 too_much
	# this func is the func that calculates Pi with Nilakantha's row
	# the arg is precision
	# if it is <= 0 then precision is default as in the task
	calculatePi(s0)
	# return to ask again
	j manual
	# if too much notify user about it and try again
too_much:
	printstr("\nToo much! Try less or equal 20\n")
	j m_prec
	
	# if default, start func (see above or in float/Nilikantha.s) with default prec
default:
	mv	s0 zero
	calculatePi(s0)
	j manual
	
	# if auto, do both default and all other precisions taht dont work too long
auto:
	printstr("Default\n")
	calculatePi(zero)
	
	li	s0 1
	li	s1 20
for:
	printstr("Precision ")
	printnum(s0)
	printstr("\n")
	calculatePi(s0)
	addi s0 s0 1
	blt	s0 s1 for
	j repeat

	# exit the program
exit:
	li	a7 10
	ecall
