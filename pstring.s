	.section	.rodata
str_inv:
	.string	"invalid input!"
	.text
	.globl	pstrlen
	.type	pstrlen, @function
pstrlen:
	movl	4(%esp), 	%eax	# put address from stack to %eax
	movzbl	(%eax), 	%eax	# get lowest byte pointed by %eax and put it to eax, adding zeroes on the left
	ret                         # return with result in %eax
	.size	pstrlen, .-pstrlen
	.globl	pstrcpy
	.type	pstrcpy, @function
pstrcpy:
	subl	$12,		%esp
	movl	20(%esp),	%eax    # get 
	movsbl	(%eax),		%edx	# put src->len to %edx
	pushl	%edx				# put 
	pushl	$0
	pushl	%eax
	pushl	28(%esp)
	call	pstrijcpy
	addl	$28,		%esp
	.size	pstrcpy, .-pstrcpy
	.globl	pstrijcpy
	.type	pstrijcpy, @function
pstrijcpy:
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	movl	28(%esp), 	%ebx    # j
	movl	24(%esp), 	%edx    # i
	movl	20(%esp), 	%esi    # src
	movl	16(%esp), 	%eax	# dst
	movzbl	(%esi), 	%edi	# copy src->len to %edi
	movl	%edi,		%ecx    # copy %edi to %ecx
	cmpb	(%eax), 	%cl		# compare dst->len with src->len
	jg		pstrijcpy_inv		# if src->len is greater then dst->len, print error mesage
	movsbl	%dl, 		%edx    #
	movsbl	%bl, 		%ebx    #
	cmpl	%ebx, 		%edx    # compare 
	jg	len_update
	addl	$1, 		%ebx
loop_copy:
	movzbl	1(%esi,%edx), %ecx	# get char from src
	movb	%cl, 		1(%eax,%edx) # put char to dst
	addl	$1, 		%edx	# increment counter
	cmpl	%ebx, 		%edx    # compare counter with j
	jne	loop_copy               # continue loop if counter < j
len_update:
	movl	%edi, 		%ebx    # restore %ebx from %edi
	movb	%bl,		(%eax)  # update len field (1 byte) in dst, which is returned in %eax 
    jmp     pstrijcpy_exit
pstrijcpy_inv:
	subl	$12,        %esp
	pushl	$str_inv
	call	printf
	addl	$16,        %esp
pstrijcpy_exit:
	popl	%ebx                # restore saved registers
	popl	%esi
	popl	%edi
	ret
	.size	pstrijcpy, .-pstrijcpy
	.globl	pstrijcmp
	.type	pstrijcmp, @function
pstrijcmp:
	pushl	%ebp                # callee save registers on stack
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$12,        %esp
	movl	44(%esp),   %ebx    # put j to %ebx
	movl	40(%esp),   %ecx    # put i to %ecx
	movl	36(%esp),   %edi    # put *pstr2 to %edi
	movl	32(%esp),   %esi    # put *pstr1 to %esi
	movsbl	%cl,        %ebp
	movsbl	(%esi),     %eax
	movsbl	(%edi),     %edx
	movsbl	%bl,        %ebx    # save 
	cmpb	%bl,        %cl     # compare 
	jg	print_inv               #
	cmpl	%ebp,       %eax    #
	jl	print_inv               #
	cmpl	%ebp,       %edx    #
	jl	print_inv               #
	cmpl	%ebx,       %eax    #
	jl	print_inv               #
	cmpl	%ebx,       %edx    #
	jl	print_inv               #
	movl	%ebp,       %eax    #
	jmp	cmp_more        
print_inv:
	subl	$12,        %esp
	pushl	$str_inv
	call	printf
	addl	$16,        %esp
	movl	$-2,        %eax    # put -2 as return result to %eax
    jmp     pstrijcmp_exit
cmp_more:
	cmpl	%ebx,       %ebp    # compare counter with j
	jg	    return_equal        # if loop is finished (counter > j), return 0
	movzbl	1(%edi,%ebp), %edx  # put 
	cmpb	%dl,   1(%esi,%ebp) # compare
	jg	    return_more         # return 1 as pstr1->str[cnt] > pstr2->str[cnt]
cmp_less:
	jl	    return_less         # return -1 as pstr1->str[cnt] < pstr2->str[cnt]
	addl	$1,         %eax    # increase counter
	cmpl	%ebx,       %eax    # compare counter with 
	jg	return_equal            # if loop is finished (counter > j), return 0
	movzbl	1(%edi,%eax), %ecx
	cmpb	%cl,   1(%esi,%eax)
	jle	cmp_less
return_more:
	movl	$1,         %eax    # return value is 1
    jmp     pstrijcmp_exit
return_equal:
	xorl	%eax,       %eax    # set %eax to zero
    jmp     pstrijcmp_exit
return_less:
	movl	$-1, %eax           # return value is -1
pstrijcmp_exit:    
    addl    $12,        %esp
	popl	%ebx
	popl	%esi
	popl	%edi
	popl	%ebp
	ret
	.globl	pstrcmp
	.type	pstrcmp, @function
pstrcmp:
	subl	$12,        %esp    # reserve space on stack
	movl	16(%esp),   %eax    # get pstr1 address
	movsbl	(%eax),     %edx    # copy lowest byte (len) value pointed by %eax to %edx
	pushl	%edx                # put it on stack
	pushl	$0                  # put 0 as third argument to stack
	pushl	28(%esp)            # put *pstr2 on stack
	pushl	%eax                # put *pstr1 on stack
	call	pstrijcmp           # call more general function
	addl	$28,        %esp    # restore stack pointer (12 bytes + 4 pushl * 4 bytes)
	ret
	.size	pstrcmp, .-pstrcmp
