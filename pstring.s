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
    pushl   %ebx                # callee save %ebx on stack
	subl	$8,		    %esp    # reserve 8 bytes from stack
	movl	20(%esp),	%esi    # get src from stack
	movl	16(%esp),	%ebx    # get dst from stack
	movsbl	(%esi),		%eax	# put src->len to %eax
	cmpb	(%ebx), 	%al		# compare dst->len with src->len
	jg		pstrcpy_inv 		# if src->len is greater then dst->len, print error mesage
	pushl	%eax				# put src->len on stack as end position
	pushl	$0                  # put 0 on stack as start position
	pushl	%esi                # put src on stack
    pushl   %ebx                # put dst on stack
	call	pstrijcpy           # use more general function
    movzbl  (%esi),     %eax    # put src->len to %eax
    movb    %al,        (%ebx)  # put src->len to dst->len
    jmp     pstrcpy_exit
pstrcpy_inv:
    subl    $12,        %esp    # reserve 12 bytes on stack
    pushl   $str_inv            # push invalid input msg address on stack
    call    printf              # print message
pstrcpy_exit:
    addl    $20,        %esp    # restore stack pointer value
    movl    %ebx,       %eax    # set *dst as return value
    popl    %ebx                # callee restore %ebx
    ret
	.size	pstrcpy, .-pstrcpy
	.globl	pstrijcpy
	.type	pstrijcpy, @function
pstrijcpy:
	pushl	%edi                # callee save registers
	pushl	%esi
	pushl	%ebx
	movl	28(%esp),   %ebx    # load parameters from stack
    movl	24(%esp),   %edx    
	movl	20(%esp),   %eax
	movl	16(%esp),   %esi
	movsbl	(%esi),     %ecx    # load pstr1->len into %ecx
	movsbl	(%eax),     %edi    # load pstr2->len into %edi
	cmpb	%bl,        %dl     # compare j with i
	jg	pstrijcpy_inv           # if j > i, print invalid message
	movsbl	%dl,        %edx    # set higher bytes of %edx to 0xF (for correct comparison)
	cmpl	%edx,       %ecx    # compare i with pstr1->len
	jl	pstrijcpy_inv           # if i > pstr1->len, print invalid message
	cmpl	%edx,       %edi    # compare i with pstr2->len
	jl	pstrijcpy_inv           # if i > pstr2->len, print invalid message
	movsbl	%bl,        %ebx    
	cmpl	%ebx,       %ecx    # if j > pstr1->len,
	jl	pstrijcpy_inv           # print invalid message
	cmpl	%ebx,       %edi    # if j > pstr2->len
	jl	pstrijcpy_inv           # print invalid message
	cmpl	%ebx,       %edx    # if counter > j,
	jg	pstrijcpy_exit          # go to exit
	addl	$1,         %ebx    # 
pstrijcpy_loop:
	movzbl	1(%eax,%edx),%ecx
	movb	%cl,    1(%esi,%edx)
	addl	$1,         %edx
	cmpl	%ebx,       %edx
	jne	    pstrijcpy_loop
	movl	%esi,       %eax
	popl	%ebx
	popl	%esi
	popl	%edi
	ret
pstrijcpy_inv:
	subl	$12,        %esp
	pushl	$str_inv
	call	printf
	addl	$16,        %esp
pstrijcpy_exit:
	movl	%esi,       %eax    # put dst to %eax
	popl	%ebx
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
	subl	$12,        %esp    # 
	movl	44(%esp),   %ebx    # put j to %ebx
	movl	40(%esp),   %ecx    # put i to %ecx
	movl	36(%esp),   %edi    # put *pstr2 to %edi
	movl	32(%esp),   %esi    # put *pstr1 to %esi
	movsbl	%cl,        %ebp
	movsbl	(%esi),     %eax
	movsbl	(%edi),     %edx
	movsbl	%bl,        %ebx    # comparison as in pstrijcpy
	cmpb	%bl,        %cl     # 
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
