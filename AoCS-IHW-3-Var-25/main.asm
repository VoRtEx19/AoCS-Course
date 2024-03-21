.include	"MacroLib/stack.m"
.include	"MacroLib/console_io.m"
.include	"MacroLib/file_io.m"
.include	"MacroLib/string.m"
.include	"MacroLib/sys_calls.m"

.include	"find_id_frequencies.s"
.include	"test.s"

.eqv	BUFFER_SIZE 512

.globl main
main:
	# start of the program
	printstr("Welcome to IHW-3's program: \"Symbol string processing\"!\n")
	
	# allocating memory for buffer
	allocate(BUFFER_SIZE)
	mv	s0, a0
	
menu:
	# ask user whether to run program manually or automatically or exit
	# arguments: query, possible answer values (3 types: 0, 1, 2), out result
	getchoice("Would you like to test it manually, run it automatically, or close it?[yes/no/cancel]: ")
	
	# if equal zero -> manually
	beqz	a0 manually
	
	# if equal 1  -> automatically
	addi	a0 a0 -1
	beqz	a0 automatically
	
	# if equal 2 -> exit
	b	exit

manually:
	# run manually
	# ask for input path
	printstr("Enter the input path: ")
	readstr
	mv	s1, a0
	replace_char(s1, '\n')
	
	# ask for output path
	printstr("Enter the output path: ")
	readstr
	mv	s2, a0
	replace_char(s2, '\n')
	
	# process the data with given files
	find_id_frequencies(s1, s2, s0, BUFFER_SIZE)
	
	# process return code
	beqz	a0, success
	addi	a0, a0, -1
	beqz	a0, error_input
	addi	a0, a0, -1
	beqz	a0, error_output
	b	error_reading
	
success:
	printstr("All done\n")
	b menu
error_input:
	printstr("Error opening input file\n")
	b menu
error_output:
	printstr("Error opening output file\n")
	b menu
error_reading:
	printstr("Error reading input file\n")
	b menu
	
	
automatically:
	# run automatically (imported tests)
	test(s0, BUFFER_SIZE)
	
	# return to menu
	b menu
	
exit:
	system_exit
