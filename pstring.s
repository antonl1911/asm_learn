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
	pushl	%esi				# callee save %esi on stack
    pushl   %ebx                # callee save %ebx on stack
	subl	$4,		    %esp    # reserve 4 bytes from stack
	movl	20(%esp),	%esi    # get src from stack
	movl	16(%esp),	%ebx    # get dst from stack
	movzbl	(%esi),		%eax	# put src->len to %eax
	cmpb	(%ebx), 	%al		# compare dst->len with src->len
	jg		pstrcpy_inv 		# if src->len is greater then dst->len, print error mesage
	subl	$1,			%eax
	movsbl	%al,		%eax
	pushl	%eax				# put src->len on stack as end position
	pushl	$0                  # put 0 on stack as start position
	pushl	%esi                # put src on stack
    pushl   %ebx                # put dst on stack
	call	pstrijcpy           # use more general function
    movsbl  (%esi),     %eax    # put src->len to %eax
    movb    %al,        (%ebx)  # put src->len to dst->len
	movb	$0,		1(%ebx,%eax)# null-terminate dst
    jmp     pstrcpy_exit
pstrcpy_inv:
    subl    $12,        %esp    # reserve 12 bytes on stack
    pushl   $str_inv            # push invalid input msg address on stack
    call    printf              # print message
pstrcpy_exit:
    addl    $20,        %esp    # restore stack pointer value
    movl    %ebx,       %eax    # set *dst as return value
    popl    %ebx                # callee restore %ebx
    popl    %esi                # callee restore %esi
    ret
	.size	pstrcpy, .-pstrcpy
	.globl	pstrijcpy
	.type	pstrijcpy, @function
pstrijcpy:
	pushl	%edi                # callee save registers
	pushl	%esi
	pushl	%ebx
	movl	28(%esp),   %ebx    # load parameters from stack, j
    movl	24(%esp),   %edx    # i
	movl	20(%esp),   %eax	# src
	movl	16(%esp),   %esi	# dst
	cmpb	%bl,        %dl     # compare j with i
	movzbl	(%esi),     %ecx    # load pstr1->len into %ecx
	movzbl	(%eax),     %edi    # load pstr2->len into %edi
	jg		pstrijcpy_inv       # if j > i, print invalid message
	movsbl	%dl,        %edx    # set higher bytes of %edx to 0xF (for correct comparison)
	cmpl	%edx,       %ecx    # compare i with pstr1->len
	jle		pstrijcpy_inv       # if i > pstr1->len, print invalid message
	cmpl	%edx,       %edi    # compare i with pstr2->len
	jle		pstrijcpy_inv       # if i > pstr2->len, print invalid message
	movsbl	%bl,        %ebx    
	cmpl	%ebx,       %ecx    # if j > pstr1->len,
	jle		pstrijcpy_inv       # print invalid message
	cmpl	%ebx,       %edi    # if j > pstr2->len
	jle		pstrijcpy_inv       # print invalid message
	cmpl	%ebx,       %edx    # if counter > j,
	jg		pstrijcpy_exit      # go to exit
	addl	$1,         %ebx    # %ebx now is j+1
pstrijcpy_loop:
	movzbl	1(%eax,%edx),%ecx   # get 1 byte from src[counter]
	movb	%cl,    1(%esi,%edx)# and put it to dst[counter] 
	addl	$1,         %edx	# increase counter
	cmpl	%ebx,       %edx	# compare if counter equals j+1
	jne	    pstrijcpy_loop		# if counter still less than j+1, run another round
	movl	%esi,       %eax	# put *dst to %eax
	popl	%ebx				# calee restore registers
	popl	%esi
	popl	%edi
	ret
pstrijcpy_inv:
	subl	$12,        %esp	# reserve 12 bytes on stack
	pushl	$str_inv			# put format string on stack
	call	printf
	addl	$16,        %esp	# restore stack pointer
pstrijcpy_exit:
	movl	%esi,       %eax    # put dst to %eax
	popl	%ebx				# restore registers
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
	subl	$12,        %esp    # reserve 12 bytes on stack
	movl	44(%esp),   %ebx    # put j to %ebx
	movl	40(%esp),   %ecx    # put i to %ecx
	movl	36(%esp),   %edi    # put *pstr2 to %edi
	movl	32(%esp),   %esi    # put *pstr1 to %esi
	movsbl	%cl,        %ebp
	movsbl	(%esi),     %eax
	movsbl	(%edi),     %edx
	movsbl	%bl,        %ebx    # comparison as in pstrijcpy
	cmpb	%bl,        %cl     # 
	jg		pstrijcmp_inv       #
	cmpl	%ebp,       %eax    #
	jle		pstrijcmp_inv       #
	cmpl	%ebp,       %edx    #
	jle		pstrijcmp_inv       #
	cmpl	%ebx,       %eax    #
	jle		pstrijcmp_inv       #
	cmpl	%ebx,       %edx    #
	jle		pstrijcmp_inv       #
	movl	%ebp,       %eax    #
	jmp	loop_start        
pstrijcmp_inv:
	subl	$12,        %esp
	pushl	$str_inv
	call	printf
	addl	$16,        %esp
	movl	$-2,        %eax    # put -2 as return result to %eax
    jmp     pstrijcmp_exit
loop_start:
	cmpl	%ebx,       %ebp    # compare counter with j
	jg	    return_equal        # if loop is finished (counter > j), return 0
	movzbl	1(%edi,%ebp), %edx  # put pstr2[counter] to %edx
	cmpb	%dl,   1(%esi,%ebp) # compare lowest byte of %edx with pstr1[counter]
	jg	    return_more         # return 1 as pstr1->str[cnt] > pstr2->str[cnt]
pstrijcmp_loop:
	jl	    return_less         # return -1 as pstr1->str[cnt] < pstr2->str[cnt]
	addl	$1,         %eax    # increase counter
	cmpl	%ebx,       %eax    # compare counter with j
	jg		return_equal            # if loop is finished (counter > j), return 0
	movzbl	1(%edi,%eax), %ecx	# put pstr2[counter] to %ecx
	cmpb	%cl,   1(%esi,%eax)	# compare it with pstr1[counter]
	jle		pstrijcmp_loop			# continue the loop if less or equal
return_more:
	movl	$1,         %eax    # return value is 1
    jmp     pstrijcmp_exit		# leave the function
return_equal:
	xorl	%eax,       %eax    # set %eax to zero
    jmp     pstrijcmp_exit		# leave the function
return_less:
	movl	$-1, %eax           # return value is -1
pstrijcmp_exit:    
    addl    $12,        %esp	# restore stack pointer
	popl	%ebx				# restore saved registers
	popl	%esi
	popl	%edi
	popl	%ebp
	ret
	.globl	pstrcmp
	.type	pstrcmp, @function
pstrcmp:
	pushl	%ebx
	movl	$1,			%eax
	subl	$8,         %esp    # reserve space on stack
	movl	20(%esp),   %ebx    # get pstr2 address
	movl	16(%esp),   %ecx    # get pstr1 address
	movsbl	(%ecx),     %edx    # copy lowest byte (len) value pointed by %ecx to %edx
	cmpb	(%ebx),		%dl		# compare lengths
	jg		ret_more			#
	jl		ret_less
	subl	$1,			%edx
	movsbl	%dl,		%edx
	pushl	%edx                # put it on stack
	pushl	$0                  # put 0 as third argument to stack
	pushl	%ebx            	# put *pstr2 on stack
	pushl	%ecx                # put *pstr1 on stack
	call	pstrijcmp           # call more general function
	addl	$16,        %esp    # restore stack pointer
ret_more:
	addl	$8,			%esp
	popl	%ebx
	ret
ret_less:
	movl	$-1,		%eax
	jmp		ret_more
	.size	pstrcmp, .-pstrcmp
