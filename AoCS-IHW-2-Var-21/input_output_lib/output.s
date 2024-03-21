# macro to output string
# arg - string to be displayed on screen
.macro printstr(%str)
.data
str:
	.asciz %str
.text
	la	a0 str
	li	a7 4
	ecall
.end_macro

# macro for printing a float
# arg - src register
.macro printfloat(%float)
	fmv.d	fa0 %float
	li	a7 3
	ecall
.end_macro

# macro for printing a number
# arg - src register
.macro printnum(%num)
	mv	a0 %num
	li	a7 1
	ecall
.end_macro
