	.file	"pstring.c"
	.text
	.globl	pstrlen
	.type	pstrlen, @function
pstrlen:
	pushl	%ebp
	movl	%esp, %ebp
	movl	8(%ebp), %eax
	movzbl	(%eax), %eax
	popl	%ebp
	ret
	.size	pstrlen, .-pstrlen
	.globl	pstrcpy
	.type	pstrcpy, @function
pstrcpy:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	12(%ebp), %eax
	movzbl	(%eax), %eax
	movsbl	%al, %eax
	pushl	%eax
	pushl	$0
	pushl	12(%ebp)
	pushl	8(%ebp)
	call	pstrijcpy
	addl	$16, %esp
	leave
	ret
	.size	pstrcpy, .-pstrcpy
	.globl	pstrijcpy
	.type	pstrijcpy, @function
pstrijcpy:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	16(%ebp), %edx
	movl	20(%ebp), %eax
	movb	%dl, -4(%ebp)
	movb	%al, -8(%ebp)
	movl	12(%ebp), %eax
	movzbl	(%eax), %edx
	movl	8(%ebp), %eax
	movzbl	(%eax), %eax
	cmpb	%al, %dl
	jle	.L6
	movl	8(%ebp), %eax
	jmp	.L7
.L6:
	movb	$0, -4(%ebp)
	jmp	.L8
.L9:
	movsbl	-4(%ebp), %eax
	movsbl	-4(%ebp), %edx
	movl	12(%ebp), %ecx
	movzbl	1(%ecx,%edx), %ecx
	movl	8(%ebp), %edx
	movb	%cl, 1(%edx,%eax)
	movzbl	-4(%ebp), %eax
	addl	$1, %eax
	movb	%al, -4(%ebp)
.L8:
	movl	12(%ebp), %eax
	movzbl	(%eax), %eax
	cmpb	-4(%ebp), %al
	jg	.L9
	movl	12(%ebp), %eax
	movzbl	(%eax), %edx
	movl	8(%ebp), %eax
	movb	%dl, (%eax)
	movl	8(%ebp), %eax
.L7:
	leave
	ret
	.size	pstrijcpy, .-pstrijcpy
	.globl	pstrcmp
	.type	pstrcmp, @function
pstrcmp:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	8(%ebp), %eax
	movzbl	(%eax), %eax
	movsbl	%al, %eax
	pushl	%eax
	pushl	$0
	pushl	12(%ebp)
	pushl	8(%ebp)
	call	pstrijcmp
	addl	$16, %esp
	leave
	ret
	.size	pstrcmp, .-pstrcmp
	.section	.rodata
.LC0:
	.string	"invalid input!"
	.text
	.globl	pstrijcmp
	.type	pstrijcmp, @function
pstrijcmp:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$40, %esp
	movl	16(%ebp), %edx
	movl	20(%ebp), %eax
	movb	%dl, -28(%ebp)
	movb	%al, -32(%ebp)
	movzbl	-28(%ebp), %eax
	cmpb	-32(%ebp), %al
	jle	.L13
	subl	$12, %esp
	pushl	$.LC0
	call	puts
	addl	$16, %esp
.L13:
	movl	8(%ebp), %eax
	movzbl	(%eax), %eax
	cmpb	-28(%ebp), %al
	jl	.L14
	movl	12(%ebp), %eax
	movzbl	(%eax), %eax
	cmpb	-28(%ebp), %al
	jge	.L15
.L14:
	subl	$12, %esp
	pushl	$.LC0
	call	puts
	addl	$16, %esp
.L15:
	movl	8(%ebp), %eax
	movzbl	(%eax), %eax
	cmpb	-32(%ebp), %al
	jl	.L16
	movl	12(%ebp), %eax
	movzbl	(%eax), %eax
	cmpb	-32(%ebp), %al
	jge	.L17
.L16:
	subl	$12, %esp
	pushl	$.LC0
	call	puts
	addl	$16, %esp
.L17:
	movsbl	-28(%ebp), %eax
	movl	%eax, -12(%ebp)
	jmp	.L18
.L22:
	movl	8(%ebp), %edx
	movl	-12(%ebp), %eax
	addl	%edx, %eax
	movzbl	1(%eax), %edx
	movl	12(%ebp), %ecx
	movl	-12(%ebp), %eax
	addl	%ecx, %eax
	movzbl	1(%eax), %eax
	cmpb	%al, %dl
	jle	.L19
	movl	$1, %eax
	jmp	.L20
.L19:
	movl	8(%ebp), %edx
	movl	-12(%ebp), %eax
	addl	%edx, %eax
	movzbl	1(%eax), %edx
	movl	12(%ebp), %ecx
	movl	-12(%ebp), %eax
	addl	%ecx, %eax
	movzbl	1(%eax), %eax
	cmpb	%al, %dl
	jge	.L21
	movl	$-1, %eax
	jmp	.L20
.L21:
	addl	$1, -12(%ebp)
.L18:
	movsbl	-32(%ebp), %eax
	cmpl	-12(%ebp), %eax
	jge	.L22
	movl	$0, %eax
.L20:
	leave
	ret
	.size	pstrijcmp, .-pstrijcmp
	.ident	"GCC: (Gentoo 4.9.2 p1.0, pie-0.6.1) 4.9.2"
	.section	.note.GNU-stack,"",@progbits
