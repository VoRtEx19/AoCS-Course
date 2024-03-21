#===============================================================================
# Macros for file work
# Requirement: include stack.m
#===============================================================================
.eqv READ_ONLY	0	# read only mode
.eqv WRITE_ONLY	1	# write only mode
.eqv APPEND	    9	# append mode
#-------------------------------------------------------------------------------
# Macro for opening file
# Argument %file_name: register containing address to string with file address
# Argument %mode: immediate mode code (see eqv above)
# Returns: file descriptor in a0 or -1 if error opening file occurred
.macro open(%file_name, %mode)
.text
	push(a1)
	push(a7)
	
    li   	a7 1024
    mv      a0 %file_name
    li   	a1 %mode
    ecall
    
    pop(a7)
    pop(a1)
.end_macro

#-------------------------------------------------------------------------------
# Macro for reading file into buffer
# Argument %file_desc: register containing file descriptor
# Argument %buffer:	register containing address to buffer
# Argument %size: immediate value of size to read
# Returns: length read or -1 if error
.macro read(%file_desc, %buffer, %size)
.text
	push(a1)
	push(a2)
	push(a7)
	
    li   a7, 63
    mv   a0, %file_desc
    mv   a1, %buffer
    li   a2, %size
    ecall
    
    pop(a7)
    pop(a2)
    pop(a1)
.end_macro

#-------------------------------------------------------------------------------
# Macro for writing given string to file
# Argument %file_desc: register containing file descriptor
# Argument %str: register containing asciz string
# Argument %len: len of str to write
.macro write(%file_desc, %str, %len)
.text
	push(a1)
	push(a2)
	push(a7)
	
    li  a7, 64
    mv  a0, %file_desc
    mv	a1, %str
    mv	a2, %len
    ecall
    
    pop(a7)
    pop(a2)
    pop(a1)
.end_macro

#-------------------------------------------------------------------------------
# Macro for closing file
# Argument %file_desc: register containing file descriptor
.macro close(%file_desc)
.text
	push(a0)
	push(a7)
	
    li  a7, 57
    mv  a0, %file_desc
    ecall
    
    pop(a7)
    pop(a0)
.end_macro
