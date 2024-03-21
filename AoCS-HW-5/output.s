.data
out_str:
	.string "\nSum of elements: "
.macro write_number(%n)
	la	a0 out_str
	li	a7 4
	ecall
	mv	a0 %n
	li	a7 1
	ecall
.end_macro