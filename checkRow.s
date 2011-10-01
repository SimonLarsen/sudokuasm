
.text

.global main

main:
	push	%ebp
	movl	%esp, %ebp
	push	$7 #row number (2. operand)
	push	$3 #value to be tested (1. operand)
	call	checkRow
	addl	$8, %esp
	leave
	ret

checkRow:
	push 	%ebp
	movl	%esp, %ebp
	push	$board #4(%esp)
	push 	$0 #counter (%
	movl	$36, %eax #4*9	
	mull	12(%ebp) #9*y | (36*y)
	movl	4(%esp), %edx
	addl	%eax, %edx #offset board
.loop: #for i=0 to i=8
	movl	8(%ebp), %eax
	cmpl	%eax, (%edx) #sammenlign index i board med val
	je		.false

	addl	$1, (%esp) #increment counter
	addl	$4, %edx # +1 | (+4)
	movl	(%esp), %eax
	cmpl	$9, %eax #tjek counter < 9
	jne		.loop

	movl	$0, %eax #return true
	jmp		.escape	

.false:
	movl	$1, %eax #return false
.escape:
	addl	$8, %esp	
	leave
	ret	

.data
board:
	.long	0,4,0,0,0,0,0,9,0
	.long	0,9,7,1,0,8,2,3,0
	.long	8,0,2,0,0,0,5,0,7
	.long	0,0,0,3,8,4,0,0,0
	.long	0,0,0,0,5,0,0,0,0
	.long	0,0,0,6,1,2,0,0,0
	.long	6,0,4,0,0,0,3,0,9
	.long	0,1,3,4,0,5,6,8,0
	.long	0,2,0,0,0,0,0,4,0
