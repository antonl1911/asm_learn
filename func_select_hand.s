	.section	.rodata
str_twolen:
	.string	"first pstring length %d, second pstring length: %d\n"
str_outres:
	.string	"length: %d, string: %s\n"
str_scanf:
	.string	"%d"
str_compres:
	.string	"compare result: %d\n"
str_invalid:
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

	pushl	%ebp				# save frame pointer on stack
	movl	%esp, 		%ebp
	pushl	%ebx				# callee save ebx on stack
	subl	$36, 		%esp 	# get 36 bytes from stack
	movl	12(%ebp), 	%eax
	movl	%eax, 		-28(%ebp)
	movl	16(%ebp), 	%eax	# put 2nd argument to eax
	movl	%eax, 	-32(%ebp)
	movl	%gs:20, 	%eax
	movl	%eax, 		-12(%ebp)
	xorl	%eax, 		%eax
	movl	8(%ebp), 	%eax	# put 1st argument to eax
	subl	$50, 		%eax	# substract 50 from first parameter
	cmpl	$4, 		%eax
	ja		case_default
	movl	jump_table(,%eax,4), %eax
	jmp		*%eax				# jump to address from table
case_50:
	subl	$12, 	%esp
	pushl	-32(%ebp)
	call	pstrlen
	addl	$16, 	%esp
	movsbl	%al, 	%ebx
	subl	$12, 	%esp
	pushl	-28(%ebp)
	call	pstrlen
	addl	$16, 	%esp
	movsbl	%al, 	%eax
	subl	$4, 	%esp
	pushl	%ebx
	pushl	%eax
	pushl	$str_twolen
	call	printf
	addl	$16, 	%esp
	jmp		exit
case_51:
	subl	$8, 	%esp
	pushl	-32(%ebp)
	pushl	-28(%ebp)
	call	pstrcpy
	addl	$16, 	%esp
	movl	-28(%ebp), %eax
	leal	1(%eax), %ebx
	subl	$12, 	%esp
	pushl	-28(%ebp)
	call	pstrlen
	addl	$16, 	%esp
	movsbl	%al, 	%eax
	subl	$4, 	%esp
	pushl	%ebx				# put printf params on stack and call it
	pushl	%eax
	pushl	$str_outres
	call	printf
	addl	$16, %esp
	jmp		exit
case_52:
	subl	$8, %esp
	leal	-20(%ebp), 	%eax
	pushl	%eax
	pushl	$str_scanf
	call	scanf
	addl	$16, %esp
	subl	$8, %esp
	leal	-16(%ebp), 	%eax
	pushl	%eax
	pushl	$str_scanf
	call	scanf
	addl	$16, %esp
	movl	-16(%ebp), 	%eax
	movsbl	%al, %edx
	movl	-20(%ebp), 	%eax
	movsbl	%al, %eax
	pushl	%edx
	pushl	%eax
	pushl	-32(%ebp)
	pushl	-28(%ebp)
	call	pstrijcpy
	addl	$16, %esp
	movl	-28(%ebp), 	%eax
	leal	1(%eax), 	%ebx
	subl	$12, 		%esp
	pushl	-28(%ebp)
	call	pstrlen
	addl	$16, 		%esp
	movsbl	%al, 		%eax
	subl	$4, 		%esp
	pushl	%ebx
	pushl	%eax
	pushl	$str_outres
	call	printf
	addl	$16, 		%esp
	jmp		exit
case_53:
	subl	$8, 		%esp
	pushl	-32(%ebp)			# push pointers to pstr1, pstr2 on stack
	pushl	-28(%ebp)
	call	pstrcmp
	addl	$16, 		%esp
	subl	$8, 		%esp
	pushl	%eax				# eax contains pstrcmp result
	pushl	$str_compres
	call	printf
	addl	$16, 		%esp
	jmp		exit
case_54:
	subl	$8, %esp
	leal	-20(%ebp), 	%eax	# calculate address of 'i' pstrijcmp parameter and put to eax
	pushl	%eax
	pushl	$str_scanf
	call	scanf
	addl	$16, 		%esp
	subl	$8, 		%esp
	leal	-16(%ebp), 	%eax	# calculate address of 'j' pstrijcmp parameter and put to eax
	pushl	%eax
	pushl	$str_scanf
	call	scanf
	addl	$16, %esp
	movl	-16(%ebp), 	%eax
	movsbl	%al, %edx
	movl	-20(%ebp), 	%eax
	movsbl	%al, %eax
	pushl	%edx
	pushl	%eax
	pushl	-32(%ebp)
	pushl	-28(%ebp)
	call	pstrijcmp
	addl	$16, %esp
	subl	$8, %esp
	pushl	%eax
	pushl	$str_compres
	call	printf
	addl	$16, 		%esp
	jmp		exit
case_default:
	subl	$12, 		%esp
	pushl	$str_invalid
	call	puts
	addl	$16, 		%esp
	nop
exit:
	movl	-4(%ebp),	%ebx
	leave
	ret
