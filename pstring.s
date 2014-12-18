	.section	.rodata
str_inv:
	.string	"invalid input!\n"
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
    pushl   %ebx
	subl	$8,		    %esp
	movl	20(%esp),	%edx    # get 
	movl	16(%esp),	%ebx    # get 
	movsbl	(%edx),		%eax	# put src->len to %eax
	cmpb	(%ebx), 	%al		# compare dst->len with src->len
	jg		pstrcpy_inv 		# if src->len is greater then dst->len, print error mesage
	pushl	%eax				# put 
	pushl	$0
	pushl	%edx
    pushl   %ebx
	call	pstrijcpy
	addl	$24,		%esp
    popl    %ebx
    ret
pstrcpy_inv:
    subl    $12,        %esp
    pushl   $str_inv
    call    printf
    addl    $24,        %esp
    movl    %ebx,       %eax
    popl    %ebx
    ret
	.size	pstrcpy, .-pstrcpy
	.globl	pstrijcpy
	.type	pstrijcpy, @function
pstrijcpy:
    pushl   %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
    subl    $28,        %esp
	movl	60(%esp), 	%ebx    # j
	movl	56(%esp), 	%edx    # i
	movl	52(%esp), 	%eax    # src
	movl	48(%esp), 	%esi	# dst
    movsbl  (%esi),     %ecx
	movzbl	(%eax), 	%edi	# copy src->len to %edi
	cmpb	%bl,        %dl
    movl    %ecx,       12(%esp)
    movl    %edi,       %ecx
    movsbl  %cl,        %ebp
	jg	    pstrijcpy_inv
    movl    12(%esp),   %ecx
    movsbl  %dl,        %edx
	cmpl	%edx, %ecx
	jl	pstrijcpy_inv
	cmpl	%edx, %ebp
	jl	pstrijcpy_inv
	movsbl	%bl, %ebx
	cmpl	%ebx, %ecx
	jl	pstrijcpy_inv
	cmpl	%ebx, %ebp
	jl	pstrijcpy_inv
	cmpl	%ebx, %edx
	jg	.L7
	addl	$1, %ebx
.L6:
	movzbl	1(%eax,%edx), %ecx
	movb	%cl, 1(%esi,%edx)
	addl	$1, %edx
	cmpl	%ebx, %edx
	jne	.L6
.L7:
	movl	%edi, %eax
	movb	%al, (%esi)
	addl	$28, %esp
	movl	%esi, %eax
	popl	%ebx
	popl	%esi
	popl	%edi
	popl	%ebp
	ret
pstrijcpy_inv:
	subl	$12, %esp
	pushl	$str_inv
	call	puts
	addl	$16, %esp
	movl	%esi, %eax
	addl	$28, %esp
	popl	%ebx
	popl	%esi
	popl	%edi
	popl	%ebp
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
	jg	pstrijcmp_inv           #
	cmpl	%ebp,       %eax    #
	jl	pstrijcmp_inv           #
	cmpl	%ebp,       %edx    #
	jl	pstrijcmp_inv           #
	cmpl	%ebx,       %eax    #
	jl	pstrijcmp_inv           #
	cmpl	%ebx,       %edx    #
	jl	pstrijcmp_inv           #
	movl	%ebp,       %eax    #
	jmp	cmp_more        
pstrijcmp_inv:
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
