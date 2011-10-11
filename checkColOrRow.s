.msg:
	.string	"%d\n"
.text

.global main

main:
	push	%ebp
	movl	%esp, %ebp
	push	$4					#row = 4, col = 36
	push	$5 					#col number (2. operand)
	push	$6 					#value to be tested (1. operand)
	call	checkColOrRow
	push	%eax
	push	$.msg
	call	printf
	addl	$20, %esp
	leave
	ret

checkColOrRow:
	push 	%ebp
	movl	%esp, %ebp
	cmp		$4, 16(%ebp)
	je		.l1
	movl	$4, %eax
	jmp 	.l2
.l1:
	movl	$36, %eax
.l2:	
	mull	12(%ebp)	
	movl	$board, %edx
	addl	%eax, %edx
	movl	$8, %eax	#(9)
	movl	8(%ebp), %ebx
.loop: 				
	cmpl	%ebx, (%edx)
	je		.false
	addl	16(%ebp), %edx
	subl	$1, %eax
	jnz		.loop
	jmp		.escape
.false:
	movl	$1, %eax
.escape:
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
	
