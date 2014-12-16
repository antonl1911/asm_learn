	#This is a simple "Hello World!" program
	.section	.rodata	#read only data section
str:	.string	"Hello World!\n"
	########
	.text	#the beginning of the code
.globl	main	#the label "main" is used to state the initial point of this program
	.type	main, @function	# the label "main" representing the beginning of a function
main:	# the main function:
	pushl	%ebp	#save the old frame pointer
	movl	%esp,	%ebp	#create the new frame pointer

	pushl	$str	#the string is the only parameter passed to the printf function.
	call	printf	#calling to printf AFTER we put its parameters in the stack.

	#return from printf:
	movl	$0,	%eax	#return value is zero (just like in c - we tell the OS that this program finished successfully)
	movl	%ebp,	%esp	#restore the old stack pointer - release all used memory.
	popl	%ebp	#restore old frame pointer (the caller function frame)
	ret	#return to caller function (OS)
