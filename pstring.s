	.section	.rodata
str_inv:
	.string	"invalid input!"
	.text
	.globl	pstrlen
	.type	pstrlen, @function
pstrlen:
	movl	4(%esp), 	%eax	# put address from stack to %eax
	movzbl	(%eax), 	%eax	# get lowest byte from value pointed by %eax and put it to eax, adding zeroes on the left
	ret
	.size	pstrlen, .-pstrlen
	.globl	pstrcpy
	.type	pstrcpy, @function
pstrcpy:
	subl	$12,		%esp
	movl	20(%esp),	%eax
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
	movl	16(%esp), 	%eax	# load parameters from stack
	movl	20(%esp), 	%esi
	movl	24(%esp), 	%edx
	movl	28(%esp), 	%ebx
	movzbl	(%esi), 	%edi	# 
	movl	%edi,		%ecx
	cmpb	(%eax), 	%cl		# compare dst->len with src->len
	jg		pstrijcpy_exit		# if src->len is greater then dst->len, return dst
	movsbl	%dl, 		%edx
	movsbl	%bl, 		%ebx
	cmpl	%ebx, 		%edx
	jg	len_update
	addl	$1, 		%ebx
loop_copy:
	movzbl	1(%esi,%edx), %ecx	# get char from src
	movb	%cl, 		1(%eax,%edx) # put char to dst
	addl	$1, 		%edx	# increment counter
	cmpl	%ebx, 		%edx
	jne	loop_copy
len_update:
	movl	%edi, 		%ebx
	movb	%bl,		(%eax)
pstrijcpy_exit:
	popl	%ebx
	popl	%esi
	popl	%edi
	ret
	.size	pstrijcpy, .-pstrijcpy
	.globl	pstrijcmp
	.type	pstrijcmp, @function
pstrijcmp:
	pushl	%ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$12, %esp
	movl	44(%esp), %esi
	movl	40(%esp), %ebx
	movl	32(%esp), %edi
	movl	36(%esp), %ebp
	movl	%esi, %eax
	cmpb	%al, %bl
	jg	.L35
.L18:
	movzbl	(%edi), %eax
	cmpb	%al, %bl
	jg	.L19
	cmpb	0(%ebp), %bl
	jg	.L19
.L20:
	movl	%esi, %edx
	cmpb	%dl, %al
	jl	.L21
	cmpb	0(%ebp), %dl
	jg	.L21
.L22:
	movsbl	%bl, %eax
	movl	%esi, %ebx
	movsbl	%bl, %edx
	cmpl	%edx, %eax
	jg	.L27
	movzbl	1(%ebp,%eax), %ebx
	cmpb	%bl, 1(%edi,%eax)
	jg	.L30
.L34:
	jl	.L31
	addl	$1, %eax
	cmpl	%edx, %eax
	jg	.L27
	movzbl	1(%ebp,%eax), %ecx
	cmpb	%cl, 1(%edi,%eax)
	jle	.L34
.L30:
	addl	$12, %esp
	movl	$1, %eax
	popl	%ebx
	popl	%esi
	popl	%edi
	popl	%ebp
	ret
.L21:
	subl	$12, %esp
	pushl	$str_inv
	call	puts
	addl	$16, %esp
	jmp	.L22
.L19:
	subl	$12, %esp
	pushl	$str_inv
	call	puts
	movzbl	(%edi), %eax
	addl	$16, %esp
	jmp	.L20
.L27:
	addl	$12, %esp
	xorl	%eax, %eax
	popl	%ebx
	popl	%esi
	popl	%edi
	popl	%ebp
	ret
.L31:
	addl	$12, %esp
	movl	$-1, %eax
	popl	%ebx
	popl	%esi
	popl	%edi
	popl	%ebp
	ret
.L35:
	subl	$12, %esp
	pushl	$str_inv
	call	puts
	addl	$16, %esp
	jmp	.L18
	.size	pstrijcmp, .-pstrijcmp
	.globl	pstrcmp
	.type	pstrcmp, @function
pstrcmp:
	subl	$12, %esp
	movl	16(%esp), %eax
	movsbl	(%eax), %edx
	pushl	%edx
	pushl	$0
	pushl	28(%esp)
	pushl	%eax
	call	pstrijcmp
	addl	$28, %esp
	ret
	.size	pstrcmp, .-pstrcmp
