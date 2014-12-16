	#This program shows a program with several functions:
	.data
	.align	4	# we want all data to be saved in an address that is divised with their size.
x:	.long	3	# value for our calculations.
y:	.long	5
z:	.long	10
	.section	.rodata
result:	.string	"(x+y)*z = %d\n"	#string for printf.
	#########################
	.text	#the beginning of the code.
	.globl	main
	.type	main, @function
main:
	pushl	%ebp	#save old FP.
	movl	%esp, %ebp	#set new FP.

	movl	$x,	%eax	#%eax is a pointer to x.
	pushl	4(%eax)	#pushing y - the second parameter for sum.
	pushl	(%eax)	#pushing x - the first parameter for sum.
	call	sum	#calling the function sum.

	#returning from sum: - %eax is holding (x+y).
	movl	$z,	%edx	#%edx is a pointer to z.
	pushl	(%edx)	#pushing z the second parameter for mult.
	pushl	%eax	#pushing (x+y) the first parameter for mult
	call	mult

	#returning from mult: - %eax is holding (x+y)*z.
	pushl	%eax	#pushing the results - the second parameter for printf.
	pushl	$result	#pushing the string the first parameter for printf.
	call	printf	#calling printf.

	#end of the main function:
	movl	$0,	%eax	#return value is zero.
	movl	%ebp,	%esp	#restore the old stack pointer - release all used memory.
	popl	%ebp	#restore old frame pointer (the caller function frame)
	ret	#return to caller function (OS)

	#this function gets two parameters and return their sum.
	.type	sum, @function
sum:
	pushl	%ebp	#save old FP
	movl	%esp, %ebp	#set new FP
	
	movl	8(%ebp),	%eax	#geting x - the first parameter.
	add	12(%ebp),	%eax	#adding y, the second parameter, to X.

	# result is already at %eax - the return value register.

	movl	%ebp,	%esp	#restore the old stack pointer - release all used memory.
	popl	%ebp	#restore old frame pointer (the caller function frame)
	ret	#return to caller function (main)
	
	#this function gets two parameters and return their product.
	.type	mult, @function
mult:
	pushl	%ebp	#save old FP
	movl	%esp, %ebp	#set new FP
	
	movl	8(%ebp),	%eax	#geting (x+y) - the first parameter.
	imull	12(%ebp),	%eax	#mult with z - the second parameter.

	# result is already at %eax - the return value register.

	movl	%ebp,	%esp	#restore the old stack pointer - release all used memory.
	popl	%ebp	#restore old frame pointer (the caller function frame)
	ret	#return to caller function (main)

