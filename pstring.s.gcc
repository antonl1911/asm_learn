	.file	"pstring.c"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB0:
	.text
.LHOTB0:
	.p2align 4,,15
	.globl	pstrlen
	.type	pstrlen, @function
pstrlen:
	movl	4(%esp), %eax
	movzbl	(%eax), %eax
	ret
	.size	pstrlen, .-pstrlen
	.section	.text.unlikely
.LCOLDE0:
	.text
.LHOTE0:
	.section	.text.unlikely
.LCOLDB1:
	.text
.LHOTB1:
	.p2align 4,,15
	.globl	pstrcpy
	.type	pstrcpy, @function
pstrcpy:
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	movl	20(%esp), %ebx
	movl	16(%esp), %eax
	movzbl	(%ebx), %edi
	movl	%edi, %ecx
	cmpb	(%eax), %cl
	jg	.L3
	testb	%cl, %cl
	js	.L6
	movl	%edi, %ecx
	xorl	%edx, %edx
	movsbl	%cl, %esi
	addl	$1, %esi
	.p2align 4,,10
	.p2align 3
.L5:
	movzbl	1(%ebx,%edx), %ecx
	movb	%cl, 1(%eax,%edx)
	addl	$1, %edx
	cmpl	%esi, %edx
	jne	.L5
.L6:
	movl	%edi, %ebx
	movb	%bl, (%eax)
.L3:
	popl	%ebx
	popl	%esi
	popl	%edi
	ret
	.size	pstrcpy, .-pstrcpy
	.section	.text.unlikely
.LCOLDE1:
	.text
.LHOTE1:
	.section	.text.unlikely
.LCOLDB2:
	.text
.LHOTB2:
	.p2align 4,,15
	.globl	pstrijcpy
	.type	pstrijcpy, @function
pstrijcpy:
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	movl	20(%esp), %esi
	movl	16(%esp), %eax
	movl	24(%esp), %edx
	movl	28(%esp), %ebx
	movzbl	(%esi), %edi
	movl	%edi, %ecx
	cmpb	(%eax), %cl
	jg	.L11
	movsbl	%dl, %edx
	movsbl	%bl, %ebx
	cmpl	%ebx, %edx
	jg	.L14
	addl	$1, %ebx
	.p2align 4,,10
	.p2align 3
.L13:
	movzbl	1(%esi,%edx), %ecx
	movb	%cl, 1(%eax,%edx)
	addl	$1, %edx
	cmpl	%ebx, %edx
	jne	.L13
.L14:
	movl	%edi, %ebx
	movb	%bl, (%eax)
.L11:
	popl	%ebx
	popl	%esi
	popl	%edi
	ret
	.size	pstrijcpy, .-pstrijcpy
	.section	.text.unlikely
.LCOLDE2:
	.text
.LHOTE2:
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC3:
	.string	"invalid input!"
	.section	.text.unlikely
.LCOLDB4:
	.text
.LHOTB4:
	.p2align 4,,15
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
	.p2align 4,,10
	.p2align 3
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
	.p2align 4,,10
	.p2align 3
.L21:
	subl	$12, %esp
	pushl	$.LC3
	call	puts
	addl	$16, %esp
	jmp	.L22
	.p2align 4,,10
	.p2align 3
.L19:
	subl	$12, %esp
	pushl	$.LC3
	call	puts
	movzbl	(%edi), %eax
	addl	$16, %esp
	jmp	.L20
	.p2align 4,,10
	.p2align 3
.L27:
	addl	$12, %esp
	xorl	%eax, %eax
	popl	%ebx
	popl	%esi
	popl	%edi
	popl	%ebp
	ret
	.p2align 4,,10
	.p2align 3
.L31:
	addl	$12, %esp
	movl	$-1, %eax
	popl	%ebx
	popl	%esi
	popl	%edi
	popl	%ebp
	ret
	.p2align 4,,10
	.p2align 3
.L35:
	subl	$12, %esp
	pushl	$.LC3
	call	puts
	addl	$16, %esp
	jmp	.L18
	.size	pstrijcmp, .-pstrijcmp
	.section	.text.unlikely
.LCOLDE4:
	.text
.LHOTE4:
	.section	.text.unlikely
.LCOLDB5:
	.text
.LHOTB5:
	.p2align 4,,15
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
	.section	.text.unlikely
.LCOLDE5:
	.text
.LHOTE5:
	.ident	"GCC: (Gentoo 4.9.2 p1.0, pie-0.6.1) 4.9.2"
	.section	.note.GNU-stack,"",@progbits
