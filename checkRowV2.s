.msg:
	.string "%d\n"

.text

.global main

main:
	push	%ebp
	movl	%esp, %ebp
	push	$3 		#row number (2. argument)
	push	$4 		#value to be tested (1. argument)
	call	checkRow
	push	%eax
	push 	$.msg
	call	printf
	addl	$8, %esp
	leave
	ret

checkRow:
	push 	%ebp
	movl	%esp, %ebp
	movl	$9, %eax
	mull	12(%ebp)
	movl	%eax, %ecx
	movl	$36, %eax	
.loop: 				
	movl	8(%ebp), %ebx
	cmpl	%ebx, board(%eax, %ecx, 4)	#index = %eax + %ecx * 4	
	je	.false
	subl	$4, %eax 	
	cmpl	$0, %eax	
	jne	.loop
	jmp	.escape	
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
