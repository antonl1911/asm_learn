	.file	"func_select.c"
	.section	.rodata
	.align 4
.LC0:
	.string	"first pstring length %d, second pstring length: %d\n"
.LC1:
	.string	"length: %d, string: %s\n"
.LC2:
	.string	"%d"
.LC3:
	.string	"compare result: %d\n"
.LC4:
	.string	"invalid option!"
	.text
	.globl	run_func
	.type	run_func, @function
run_func:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$36, %esp
	movl	12(%ebp), %eax
	movl	%eax, -28(%ebp)
	movl	16(%ebp), %eax
	movl	%eax, -32(%ebp)
	movl	%gs:20, %eax
	movl	%eax, -12(%ebp)
	xorl	%eax, %eax
	movl	8(%ebp), %eax
	subl	$50, %eax
	cmpl	$4, %eax
	ja	.L2
	movl	.L4(,%eax,4), %eax
	jmp	*%eax
	.section	.rodata
	.align 4
	.align 4
.L4:
	.long	.L3
	.long	.L5
	.long	.L6
	.long	.L7
	.long	.L8
	.text
.L3:
	subl	$12, %esp
	pushl	-32(%ebp)
	call	pstrlen
	addl	$16, %esp
	movsbl	%al, %ebx
	subl	$12, %esp
	pushl	-28(%ebp)
	call	pstrlen
	addl	$16, %esp
	movsbl	%al, %eax
	subl	$4, %esp
	pushl	%ebx
	pushl	%eax
	pushl	$.LC0
	call	printf
	addl	$16, %esp
	jmp	.L1
.L5:
	subl	$8, %esp
	pushl	-32(%ebp)
	pushl	-28(%ebp)
	call	pstrcpy
	addl	$16, %esp
	movl	-28(%ebp), %eax
	leal	1(%eax), %ebx
	subl	$12, %esp
	pushl	-28(%ebp)
	call	pstrlen
	addl	$16, %esp
	movsbl	%al, %eax
	subl	$4, %esp
	pushl	%ebx
	pushl	%eax
	pushl	$.LC1
	call	printf
	addl	$16, %esp
	jmp	.L1
.L6:
	subl	$8, %esp
	leal	-20(%ebp), %eax
	pushl	%eax
	pushl	$.LC2
	call	__isoc99_scanf
	addl	$16, %esp
	subl	$8, %esp
	leal	-16(%ebp), %eax
	pushl	%eax
	pushl	$.LC2
	call	__isoc99_scanf
	addl	$16, %esp
	movl	-16(%ebp), %eax
	movsbl	%al, %edx
	movl	-20(%ebp), %eax
	movsbl	%al, %eax
	pushl	%edx
	pushl	%eax
	pushl	-32(%ebp)
	pushl	-28(%ebp)
	call	pstrijcpy
	addl	$16, %esp
	movl	-28(%ebp), %eax
	leal	1(%eax), %ebx
	subl	$12, %esp
	pushl	-28(%ebp)
	call	pstrlen
	addl	$16, %esp
	movsbl	%al, %eax
	subl	$4, %esp
	pushl	%ebx
	pushl	%eax
	pushl	$.LC1
	call	printf
	addl	$16, %esp
	jmp	.L1
.L7:
	subl	$8, %esp
	pushl	-32(%ebp)
	pushl	-28(%ebp)
	call	pstrcmp
	addl	$16, %esp
	subl	$8, %esp
	pushl	%eax
	pushl	$.LC3
	call	printf
	addl	$16, %esp
	jmp	.L1
.L8:
	subl	$8, %esp
	leal	-20(%ebp), %eax
	pushl	%eax
	pushl	$.LC2
	call	__isoc99_scanf
	addl	$16, %esp
	subl	$8, %esp
	leal	-16(%ebp), %eax
	pushl	%eax
	pushl	$.LC2
	call	__isoc99_scanf
	addl	$16, %esp
	movl	-16(%ebp), %eax
	movsbl	%al, %edx
	movl	-20(%ebp), %eax
	movsbl	%al, %eax
	pushl	%edx
	pushl	%eax
	pushl	-32(%ebp)
	pushl	-28(%ebp)
	call	pstrijcmp
	addl	$16, %esp
	subl	$8, %esp
	pushl	%eax
	pushl	$.LC3
	call	printf
	addl	$16, %esp
	jmp	.L1
.L2:
	subl	$12, %esp
	pushl	$.LC4
	call	puts
	addl	$16, %esp
	nop
.L1:
	movl	-12(%ebp), %eax
	xorl	%gs:20, %eax
	je	.L10
	call	__stack_chk_fail
.L10:
	movl	-4(%ebp), %ebx
	leave
	ret
	.size	run_func, .-run_func
	.ident	"GCC: (Gentoo 4.9.2 p1.0, pie-0.6.1) 4.9.2"
	.section	.note.GNU-stack,"",@progbits
