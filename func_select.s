	.section	.rodata
str_twolen:
	.string	"first pstring length %d, second pstring length: %d\n"
str_outres:
	.string	"length: %d, string: %s\n"
str_scanf:
	.string	"%d"
str_cmpres:
	.string	"compare result: %d\n"
str_inval:
	.string	"invalid option!"
jump_table:
	.long	case_50
	.long	case_51
	.long	case_52
	.long	case_53
	.long	case_54
	.text
	.globl	run_func
	.type	run_func, @function
run_func:
	pushl	%esi				# callee save esi on stack
	pushl	%ebx				# callee save ebx on stack
	subl	$20,		%esp    # make space on stack
	movl	32(%esp),	%eax    # get first parameter (opt) from stack
	movl	36(%esp),	%ebx    # get second parameter (*p1) from stack
	movl	40(%esp),	%esi    # get third parameter (*p2) from stack
	subl	$50, 		%eax	# substract 50 from first parameter
	cmpl	$4, 		%eax    # compare eax with 4
	ja		case_default        # by default, goto case_default label
	jmp		*jump_table(,%eax,4)# else jump using jump table
case_50:
	subl	$12, 	%esp        # reserve space on stack for three variables
	pushl	%esi 
	call	pstrlen
	movl	%eax,	%esi
	movl	%ebx,	(%esp)
	call 	pstrlen
	movl	%esi,	%edx
	movsbl	%al, 	%eax
	movsbl	%dl, 	%esi
	pushl	%esi                # put third parameter on stack
	pushl	%eax                # put second parameter on stack
	pushl	$str_twolen         # put first parameter on stack
	call	printf
	addl	$12, 	%esp
	jmp		exit
case_51:
	subl	$8, 	%esp        # reserve space for two variables on stack
	pushl	%esi                # put pstrcpy params on stack
	pushl	%ebx
	call	pstrcpy
	movl	%ebx,   (%esp)
print_strlen:
    call	pstrlen             # call pstrlen
	addl	$1, 	%ebx
	movsbl	%al, 	%eax
	pushl	%ebx				# put printf params on stack and call it
	pushl	%eax
	pushl	$str_outres
	call	printf
	addl	$32, %esp
	jmp		exit
case_52:
	subl	$8, %esp
	leal	12(%esp), 	%eax
	pushl	%eax
	pushl	$str_scanf
	call	scanf
    popl    %ecx
    popl    %eax
	leal	16(%esp), 	%eax
	pushl	%eax
	pushl	$str_scanf
	call	scanf
	movsbl	24(%esp),   %eax
    pushl   %eax
	movsbl	24(%esp),   %eax
	pushl	%eax
    pushl   %esi
    pushl   %ebx
	call	pstrijcpy
	addl	$20,        %esp
    pushl   %ebx
    jmp     print_strlen 
case_53:
	subl	$8, 		%esp
	pushl	%esi
    pushl   %ebx
	call	pstrcmp
	addl	$12, 		%esp
print_compare:
	pushl	%eax				# eax contains pstrcmp result
	pushl	$str_cmpres
	call	printf
	addl	$16, 		%esp
    jmp     exit
case_54:
	subl	$8, %esp
	leal	12(%esp), 	%eax	# calculate address of 'i' pstrijcmp parameter and put to eax
	pushl	%eax
	pushl	$str_scanf
	call	scanf
	popl	%eax
	popl	%edx
	leal	16(%esp), 	%eax	# calculate address of 'j' pstrijcmp parameter and put to eax
	pushl	%eax
	pushl	$str_scanf
	call	scanf
	movsbl	24(%esp), 	%eax
	pushl	%eax
	movsbl	24(%esp), 	%eax
	pushl	%eax
	pushl	%esi
	pushl	%ebx
	call	pstrijcmp
	addl	$28, 		%esp
	jmp		print_compare
case_default:
	subl	$12, 		%esp
	pushl	$str_inval
	call	puts
	addl	$16, 		%esp
	nop
exit:
    addl    $20,        %esp    # return 20 bytes to stack
    popl    %ebx                # restore saved registers
    popl    %esi
	ret                         # return from function
.size       run_func,   .-run_func
