.data
minus_one:.double -1
one:		.double 1
two:		.double 2
three:	.double 3
four:		.double 4
ten:		.double 10
def_prec:	.double 0.0005

.text

# macro for calculating Pi
# argument %prec - number of decimal spaces
# if %prec <= 0 - program counts with default relative precision 0.05%
.macro calculatePi(%prec)
	fld	fs0 three t0	# sum of the row and the value of pi
	fld	fs1 two t0		# n in the Nilakantha row
	fld	fs2 one t0	# sign of the current element
	fld	fs3 one t0	# just 1
	fld	fs5 minus_one t0 # just -1
	fld	fs6 two t0	# just 2
	
	blez %prec default
	calculatePrecision(%prec, fs4)	# find 10^(-prec-1)
	j loop
	
default:
	fld 	fs4 def_prec t0	# default relative precision 0.05%
	
loop:
	fld		ft0 four t0	# a_n = 4
	fmul.d	ft0 ft0 fs2	# a_n *= sign
	fmv.d	ft1 fs1		# ft1 = n
	fadd.d	ft2 ft1 fs3	# ft2 = n + 1
	fmul.d	ft1 ft1 ft2	# ft1 = n(n+1)
	fadd.d	ft2 ft2 fs3	# ft2 = n + 2
	fmul.d	ft1 ft1 ft2	# ft1 = n(n+1)(n+2)
	fdiv.d	ft0 ft0 ft1	# a_n = 4 sign / n(n+1)(n+2)
	fadd.d	fs1 fs1 fs6	# n += 2
	fmul.d	fs2 fs2 fs5	# sign = -sign
	# a_n is found
	# if absolute precision:
	blez	%prec relative
	fadd.d	fs0 fs0 ft0	# res += a_n
	fabs.d	ft0 ft0
	flt.d		t0 ft0 fs4	# a_n < prec?
	beqz	t0 loop
	
relative:
	fdiv.d	ft1 ft0 fs0	# check = a_n / prev_sum
	fabs.d	ft1 ft1		# check = |check| 
	fadd.d	fs0 fs0 ft0	# res += a_n
	flt.d		t0 ft1 fs4		# check < prec?
	beqz t0 loop
	
	printstr("Result: ")		# result output
	printfloat(fs0)
	printstr("\n")
.end_macro

# this macro calculates precision from number of decimal spaces
# basically, it counts p = 10^(-k-1)
# arg %in - k, number of decimal spaces
# arg %out - p, required precision in double
.macro calculatePrecision(%in, %out)
	mv	t1 %in
	fld	ft0 one t0
	fld	ft1 ten t0
	fld	%out one t0
loop:
	fmul.d ft0 ft0 ft1
	addi t1 t1 -1
	bgtz t1 loop
	
	fdiv.d %out %out ft0
.end_macro
