#===============================================================================
# Macros for other useful system calls
# Requirement: include stack.m
#===============================================================================

#-------------------------------------------------------------------------------
# Macro for allocating memory of given size
# Argument %size: immediate size of memory to be allocated
# Return: address to memory in a0 or -1 if %size is invalid
.macro allocate(%size)
.text	
	push(a7)
	
	li	a7, %size
	blez	a7, invalid_arg
	
    li a7, 9
    li a0, %size
    ecall
    
    b valid_arg
    
invalid_arg:
	li	a0, -1
	
valid_arg:
	pop(a7)
.end_macro

#-------------------------------------------------------------------------------
# Macro for ending program
.macro system_exit
    li a7, 10
    ecall
.end_macro

#-------------------------------------------------------------------------------
# Macro for maeking program sleep (in milliseconds)
# Argument %x: immediate time in milliseconds
.macro sleep(%x)
	blez	%x, invalid_arg
	
	push(a0)
	push(a7)
	
	li a0, %x
    li a7, 32
    ecall
    
    pop(a7)
    pop(a0)
    
invalid_arg:
.end_macro
