#===============================================================================
# Macro library for input/output/file work/stack saving/loading
# Require: include stack.m
#===============================================================================

#-------------------------------------------------------------------------------
# Macro printing a string into console
# Argument %str: hardcoded string to be output
.macro printstr(%str)
.data
string:
	.asciz	%str
	.align 2
.text
	push(a0)
	push(a7)
	
	la	a0, string
	li	a7, 4
	ecall

	pop(a7)
	pop(a0)	
.end_macro

#-------------------------------------------------------------------------------
# Macro printing a string from register into console
# Argument %str: reg containing address to string to be output
.macro printstrreg(%str)
.text
	push(a0)
	push(a7)
	
	mv	a0, %str
	li	a7, 4
	ecall

	pop(a7)
	pop(a0)	
.end_macro
#-------------------------------------------------------------------------------
# Macro for reading a string from console
# Returns: string address in a0
.macro readstr
.eqv BUFFER 200
.data
string:
	.space BUFFER
.text
	push(a1)
	push(a7)
	
	la	a0, string
	li	a1, BUFFER
	li	a7, 8
	ecall
	
	pop(a7)
	pop(a1)
	
	la	a0, string
.end_macro

#-------------------------------------------------------------------------------
# Macro for getting choice from user (yes/no/cancel)
# Argument %str: string with request
# Returns: result 1/2/0 in a0
.macro getchoice(%str)
.data
string:
	.asciz	%str
	.align 2
.text
	push(a7)
	
	la	a0 string
	li	a7 50
	ecall

	pop(a7)
.end_macro
