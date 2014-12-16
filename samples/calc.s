	#This is a simple program that calculates stuff
	.data
a:	.long	1000
b:	.word	0x10
c:	.byte	3

	.section	.rodata	#read only data section
format1:	.string	"%d + 0x%x = %d\n"	#c+b
format2:	.string	"%ld*2^%d = %ld\n"	#a*2^c
	########
	.text	#the beginnig of the code
.globl	main	#the label "main" is used to state the initial point of this program
	.type	main, @function	# the label "main" representing the beginning of a function
main:	# the main function:
	pushl	%ebp	#save the old frame pointer
	movl	%esp,	%ebp	#create the new frame pointer
	pushl	%ebx	#saving a callee save register.
	
	movl	$b,	%eax	#geting the address of label "b"
	movl	$0,	%ecx	#making sure %ecx will have zero in all his bits.
	movw	(%eax),	%cx	#reading one word that start in this address (reading 0x10).
	movsbl	2(%eax), %ebx	#reading one byte (with sign extension) from 2 bytes after the label "b" (reading 3).
	#notice that "c" was saved in a "callee save register" - will survive the first call to printf.
	
	movl	%ecx,	%edx	#%edx = b
	addl	%ebx,	%edx	#%edx = b+c

	#pushing all the parameters for printf - from the last to the first (FIFO!)
	pushl	%edx	#pushing the sum
	pushl	%ecx	#pushing b
	pushl	%ebx	#pushing c	
	pushl	$format1	#the string is the first paramter passed to the printf function.
	call	printf	#calling to printf AFTER we put its parameters in the stack.

	#return from printf, start the 2nd calculation:
	#remmeber the values we had in %eax, %ecx and %edx are lost.
	movl	$a,	%eax	#geting the address of label "a"
	movl	(%eax),	%eax	#geting a (1000)
	movl	%eax,	%edx	#%edx = a
	movb	%bl,	%cl	#shift only works with numbers or %cl
	sall	%cl,	%edx	#%edx = a*2^c

	#pushing all the parameters for printf - from the last to the first (FIFO!)
	pushl	%edx	#pushing the result
	pushl	%ebx	#pushing c
	pushl	%eax	#pushing a
	pushl	$format2	#the string is the first paramter passed to the printf function.
	call	printf	#calling to printf AFTER we put its parameters in the stack.

	#return from printf 2nd time - end of program:
	movl	$0,	%eax	#return value is zero.
	movl	-4(%ebp),	%ebx	#restoring the save register (%ebx) value, for the caller function.
	movl	%ebp,	%esp	#restore the old stack pointer - release all used memory.
	popl	%ebp	#restore old frame pointer (the caller function frame)
	ret	#return to caller function (OS).
