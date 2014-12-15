	.file	"pstring.c"
	.section	.rodata
.LC0:
	.string	"invalid input!\n"
	.data
	.align 4
	.type	errinput, @object
	.size	errinput, 4
errinput:
	.long	.LC0
	.text
	.globl	pstrlen
	.type	pstrlen, @function
pstrlen:
.LFB0:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	call	mcount
	movl	8(%ebp), %eax
	movzbl	(%eax), %eax
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	pstrlen, .-pstrlen
	.globl	pstrcpy
	.type	pstrcpy, @function
pstrcpy:
.LFB1:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$16, %esp
	call	mcount
	movl	12(%ebp), %eax
	movzbl	(%eax), %edx
	movl	8(%ebp), %eax
	movzbl	(%eax), %eax
	cmpb	%al, %dl
	jle	.L4
	movl	8(%ebp), %eax
	jmp	.L5
.L4:
	movl	$0, -4(%ebp)
	jmp	.L6
.L7:
	movl	12(%ebp), %edx
	movl	-4(%ebp), %eax
	addl	%edx, %eax
	movzbl	1(%eax), %eax
	movl	8(%ebp), %ecx
	movl	-4(%ebp), %edx
	addl	%ecx, %edx
	movb	%al, 1(%edx)
	addl	$1, -4(%ebp)
.L6:
	movl	12(%ebp), %eax
	movzbl	(%eax), %eax
	movsbl	%al, %eax
	cmpl	-4(%ebp), %eax
	jg	.L7
	movl	12(%ebp), %eax
	movzbl	(%eax), %edx
	movl	8(%ebp), %eax
	movb	%dl, (%eax)
	movl	8(%ebp), %eax
.L5:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE1:
	.size	pstrcpy, .-pstrcpy
	.globl	pstrijcpy
	.type	pstrijcpy, @function
pstrijcpy:
.LFB2:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
	call	mcount
	movl	16(%ebp), %edx
	movl	20(%ebp), %eax
	movb	%dl, -4(%ebp)
	movb	%al, -8(%ebp)
	movl	12(%ebp), %eax
	movzbl	(%eax), %edx
	movl	8(%ebp), %eax
	movzbl	(%eax), %eax
	cmpb	%al, %dl
	jle	.L9
	movl	8(%ebp), %eax
	jmp	.L10
.L9:
	movb	$0, -4(%ebp)
	jmp	.L11
.L12:
	movsbl	-4(%ebp), %eax
	movsbl	-4(%ebp), %edx
	movl	12(%ebp), %ecx
	movzbl	1(%ecx,%edx), %ecx
	movl	8(%ebp), %edx
	movb	%cl, 1(%edx,%eax)
	movzbl	-4(%ebp), %eax
	addl	$1, %eax
	movb	%al, -4(%ebp)
.L11:
	movl	12(%ebp), %eax
	movzbl	(%eax), %eax
	cmpb	-4(%ebp), %al
	jg	.L12
	movl	12(%ebp), %eax
	movzbl	(%eax), %edx
	movl	8(%ebp), %eax
	movb	%dl, (%eax)
	movl	8(%ebp), %eax
.L10:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE2:
	.size	pstrijcpy, .-pstrijcpy
	.globl	pstrcmp
	.type	pstrcmp, @function
pstrcmp:
.LFB3:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$16, %esp
	call	mcount
	movl	8(%ebp), %eax
	movzbl	(%eax), %edx
	movl	12(%ebp), %eax
	movzbl	(%eax), %eax
	cmpb	%al, %dl
	jle	.L14
	movl	$1, %eax
	jmp	.L15
.L14:
	movl	8(%ebp), %eax
	movzbl	(%eax), %edx
	movl	12(%ebp), %eax
	movzbl	(%eax), %eax
	cmpb	%al, %dl
	jge	.L16
	movl	$-1, %eax
	jmp	.L15
.L16:
	movl	$0, -4(%ebp)
	jmp	.L17
.L20:
	movl	8(%ebp), %edx
	movl	-4(%ebp), %eax
	addl	%edx, %eax
	movzbl	1(%eax), %edx
	movl	12(%ebp), %ecx
	movl	-4(%ebp), %eax
	addl	%ecx, %eax
	movzbl	1(%eax), %eax
	cmpb	%al, %dl
	jle	.L18
	movl	$1, %eax
	jmp	.L15
.L18:
	movl	8(%ebp), %edx
	movl	-4(%ebp), %eax
	addl	%edx, %eax
	movzbl	1(%eax), %edx
	movl	12(%ebp), %ecx
	movl	-4(%ebp), %eax
	addl	%ecx, %eax
	movzbl	1(%eax), %eax
	cmpb	%al, %dl
	jge	.L19
	movl	$-1, %eax
	jmp	.L15
.L19:
	addl	$1, -4(%ebp)
.L17:
	movl	8(%ebp), %eax
	movzbl	(%eax), %eax
	movsbl	%al, %eax
	cmpl	-4(%ebp), %eax
	jg	.L20
	movl	$0, %eax
.L15:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE3:
	.size	pstrcmp, .-pstrcmp
	.section	.rodata
.LC1:
	.string	"%s"
	.text
	.globl	pstrijcmp
	.type	pstrijcmp, @function
pstrijcmp:
.LFB4:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	call	mcount
	movl	16(%ebp), %edx
	movl	20(%ebp), %eax
	movb	%dl, -28(%ebp)
	movb	%al, -32(%ebp)
	movzbl	-28(%ebp), %eax
	cmpb	-32(%ebp), %al
	jle	.L22
	movl	errinput, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$.LC1
	call	printf
	addl	$16, %esp
.L22:
	movl	8(%ebp), %eax
	movzbl	(%eax), %eax
	cmpb	-28(%ebp), %al
	jl	.L23
	movl	12(%ebp), %eax
	movzbl	(%eax), %eax
	cmpb	-28(%ebp), %al
	jge	.L24
.L23:
	movl	errinput, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$.LC1
	call	printf
	addl	$16, %esp
.L24:
	movl	8(%ebp), %eax
	movzbl	(%eax), %eax
	cmpb	-32(%ebp), %al
	jl	.L25
	movl	12(%ebp), %eax
	movzbl	(%eax), %eax
	cmpb	-32(%ebp), %al
	jge	.L26
.L25:
	movl	errinput, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$.LC1
	call	printf
	addl	$16, %esp
.L26:
	movsbl	-28(%ebp), %eax
	movl	%eax, -12(%ebp)
	jmp	.L27
.L31:
	movl	8(%ebp), %edx
	movl	-12(%ebp), %eax
	addl	%edx, %eax
	movzbl	1(%eax), %edx
	movl	12(%ebp), %ecx
	movl	-12(%ebp), %eax
	addl	%ecx, %eax
	movzbl	1(%eax), %eax
	cmpb	%al, %dl
	jle	.L28
	movl	$1, %eax
	jmp	.L29
.L28:
	movl	8(%ebp), %edx
	movl	-12(%ebp), %eax
	addl	%edx, %eax
	movzbl	1(%eax), %edx
	movl	12(%ebp), %ecx
	movl	-12(%ebp), %eax
	addl	%ecx, %eax
	movzbl	1(%eax), %eax
	cmpb	%al, %dl
	jge	.L30
	movl	$-1, %eax
	jmp	.L29
.L30:
	addl	$1, -12(%ebp)
.L27:
	movsbl	-32(%ebp), %eax
	cmpl	-12(%ebp), %eax
	jge	.L31
	movl	$0, %eax
.L29:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE4:
	.size	pstrijcmp, .-pstrijcmp
	.ident	"GCC: (Gentoo 4.9.1 p1.0, pie-0.6.0) 4.9.1"
	.section	.note.GNU-stack,"",@progbits
