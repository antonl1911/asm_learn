	.section	.rodata         # read-only data section
str_twolen:
	.string	"first pstring length: %d, second pstring length: %d\n"
str_outres:
	.string	"length: %d, string: %s\n"
str_scanf:
	.string	"%d"
str_cmpres:
	.string	"compare result: %d\n"
str_inval:
	.string	"invalid option!\n"
jump_table:
	.long	case_50
	.long	case_51
	.long	case_52
	.long	case_53
	.long	case_54
	.text                       # the beginning of the code
	.globl	run_func            # global symbol name
	.type	run_func, @function # label run_func, representing the beginning of a function
run_func:                       # run_func code follows
	pushl	%esi				# callee save esi to stack
	pushl	%ebx				# callee save ebx to stack
	subl	$20,		%esp    # make space on stack
	movl	32(%esp),	%eax    # get first parameter (opt) from stack
	movl	36(%esp),	%ebx    # get second parameter (*p1) from stack
	movl	40(%esp),	%esi    # get third parameter (*p2) from stack
	subl	$50, 		%eax	# substract 50 from first parameter
	cmpl	$4, 		%eax    # compare eax with 4
	ja		case_default        # by default, goto case_default label
	jmp		*jump_table(,%eax,4)# else jump using jump table
case_50:                        # if 50 was entered by user
	subl	$12, 	    %esp    # reserve 12 bytes on stack
	pushl	%esi                # put *p2 to stack
	call	pstrlen             # call pstrlen (*p2)
	movl	%eax,	    %esi    # save pstrlen result to %esi
	movl	%ebx,	    (%esp)  # put *p1 to stack
	call 	pstrlen             # call pstrlen(*p1)
	pushl	%esi                # put third parameter to stack
	pushl	%eax                # put second parameter to stack
	pushl	$str_twolen         # put first parameter to stack
	call	printf              # print the results
	addl	$28, 	    %esp    # restore stack pointer: 12 (initial subl) + 16 (4 bytes x 4 pushl)
	jmp		exit
case_51:
	subl	$8, 	    %esp    # reserve 8 bytes on stack
	pushl	%esi                # put *p2 to stack
	pushl	%ebx                # put *p1 to stack 
	call	pstrcpy             # call pstrcpy
	movl	%ebx,       (%esp)  # save result on stack
print_strlen:
    call	pstrlen             # call pstrlen
	addl	$1, 	    %ebx    # move pointer from beginning p1 to p1->str
	pushl	%ebx				# put p1->str to stack
	pushl	%eax                # put pstrlen result to stack
	pushl	$str_outres         # put format string pointer str_outres to stack
	call	printf              # call printf(str_outres, %eax, %ebx);
	addl	$16,        %esp    # restore stack pointer: 16 is (4 bytes x 4 pushl) 
    pushl   %esi
    addl    $1,         %esi    # move pointer from beginning of p2 to p2->str
    call	pstrlen             # call pstrlen
	pushl	%esi				# put p1->str to stack
	pushl	%eax                # put pstrlen result to stack
	pushl	$str_outres         # put format string pointer str_outres to stack
	call	printf              # call printf(str_outres, %eax, %ebx);
	addl	$28,        %esp    # restore stack pointer: 8 (initial subl) + 20 (4 bytes x 4 pushl) 
	jmp		exit
case_52:
	subl	$8, %esp            # reserve 8 bytes on stack
	leal	12(%esp), 	%eax    # load address of local variable into %eax
	pushl	%eax                # put address on stack
	pushl	$str_scanf          # put format string address on stack
	call	scanf               # get 1st input from user
    popl    %ecx                # restore %ecx from stack
    popl    %eax                # restore %eax from stack
	leal	16(%esp), 	%eax    # load address of second local variable into %eax
	pushl	%eax                # put address on stack
	pushl	$str_scanf          # put format string address on stack
	call	scanf               # get 2nd input from user
	movsbl	24(%esp),   %eax    # load 2nd variable into %eax
    pushl   %eax                # put it on stack
	movsbl	24(%esp),   %eax    # load 1st variable address into %eax
	pushl	%eax                # put it on stack
    pushl   %esi                # put *p2 address on stack
    pushl   %ebx                # put *p1 address on stack 
	call	pstrijcpy           # call our function
	addl	$20,        %esp    # restore stack pointer after function call
    pushl   %ebx                # put *p1 address on stack
    jmp     print_strlen        # jump to common code shared between case_51 and case_52
case_53:
	subl	$8, 		%esp    # reserve 8 bytes on stack
	pushl	%esi				# put *p2 to stack 
    pushl   %ebx				# put *p1 to stack
	call	pstrcmp				# call pstrcmp(p1, p2)
	addl	$12, 		%esp	# restore stack pointer
print_compare:
	pushl	%eax				# eax contains pstr<ij>cmp result, put it to stack
	pushl	$str_cmpres			# put format string to stack
	call	printf				# print compare result
	addl	$12, 		%esp 	# restore stack
    jmp     exit				# return from function
case_54:
	subl	$8, %esp
	leal	12(%esp), 	%eax	# calculate address of 'i' pstrijcmp parameter and put to eax
	pushl	%eax				# put i address on stack
	pushl	$str_scanf			# put format string address on stack
	call	scanf				# get input from user
	popl	%eax				# restore %eax from stack
	popl	%edx				# restore %edx from stack
	leal	16(%esp), 	%eax	# calculate address of 'j' pstrijcmp parameter and put to eax
	pushl	%eax				# put j address to stack
	pushl	$str_scanf			# put format string address to stack
	call	scanf				# get j from user
	movsbl	24(%esp), 	%eax	# put j value to %eax
	pushl	%eax				# and put %eax to stack
	movsbl	24(%esp), 	%eax	# put i value to %eax
	pushl	%eax				# and put %eax on stack
	pushl	%esi				# put *p2 address on stack
	pushl	%ebx				# put *p1 address on stack
	call	pstrijcmp			# call pstrijcmp from pstring.s
	addl	$28, 		%esp	# restore stack value
	jmp		print_compare		# print result in common code
case_default:
	subl	$12, 		%esp	# reserve 12 bytes from stack pointer
	pushl	$str_inval			# put format string address to stack
	call	printf				# print it
	addl	$16, 		%esp	# restore stack pointer
exit:
    addl    $20,        %esp    # return 20 bytes to stack
    popl    %ebx                # restore saved registers: %ebx
    popl    %esi                # and %esi
	ret                         # return from function
.size       run_func,   .-run_func
