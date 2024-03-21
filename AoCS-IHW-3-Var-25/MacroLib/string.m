#===============================================================================
# Macro file for string processing
# Require: include stack.m
#===============================================================================

.eqv UINT_LENGTH 10

#-------------------------------------------------------------------------------
# Macro for finding length of asciz string
# Argument %str: register containing address to string
# Returns: length of string in a0
.macro strlen(%str)
.text
	push(a1)
	push(a2)
	
	mv	a0, %str
	li	a2, '\0'
	
loop:
	lb	a1, (a0)
	beq	a1, a2, break
	addi	a0, a0, 1
	b loop

break:
	sub	a0, a0, %str
	
	pop(a2)
	pop(a1)
.end_macro

#-------------------------------------------------------------------------------
# Macro for replacing first met char
# Argument %str: register containing address to string
# Argument %char: immediate character to be trimmed from the end
.macro replace_char(%str, %char)
.text
	push(a0)
	push(a1)
	push(a2)
	
	li  a2, %char
    mv  a0, %str
loop:
    lb	a1, (a0)
    beq a2, a1, replace
    addi	a0, a0, 1
    b   loop
replace:
    sb  zero (a0)
    
   	pop(a2)
	pop(a1)
	pop(a0)
.end_macro

#-------------------------------------------------------------------------------
# Macro for saving uint as asciz string
# Argument %uint: register containing number to be saved
# Argument %str: register containing address to string
.macro uint_to_str(%uint, %str)
.text
	push(t0)
	push(t1)
	push(t2)
	push(t3)
	push(t4)
	push(t5)
	
	mv	t0, %str
	mv	t5, %str
	mv	t1, %uint
	mv	t2, zero
	li	t3, 10
	
	# find length of uint
len_loop:
	div t1, t1, t3
	addi	t2, t2, 1
	bgtz	t1, len_loop
	
	# save %uint to %str
	mv	t1, %uint
	add	t0, t0, t2
	
store_loop:
	addi	t0, t0, -1
	rem	t4, t1, t3
	addi	t4, t4, '0'
	sb	t4, (t0)
	div	t1, t1, t3
	bgt	t0, t5, store_loop
	
	# add null terminants
	mv	t0, t5
	addi	t1, t0, UINT_LENGTH
	add t0, t0, t2
	li	t3, '\0'
	
add_nulls:
	bge	t0, t1 end
	sb	t3, (t0)
	addi	t0, t0, 1
	b add_nulls
	
end:
	pop(t5)
	pop(t4)
	pop(t3)
	pop(t2)
	pop(t1)
	pop(t0)
.end_macro
