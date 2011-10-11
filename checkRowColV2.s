.msg:
	.string "%d\n"

.text

.global main

main:
	push	%ebp
	movl	%esp, %ebp
	push	$2				#ændring af offset pr. iteration (4 hvis row, 36 hvis col) (3.argument)
	push	$2 				#row/col number (2. argument)
	push	$3 				#value to be tested (1. argument)		
	call	checkRowCol
	push	%eax
	push 	$.msg
	call	printf
	addl	$20, %esp
	leave
	ret



checkRowCol:				#tester row og col på én gang. Reducerer køretid med (potentielt) faktor n
	push 	%ebp
	movl	%esp, %ebp
	movl	$board, %esi
	movl	$board, %ecx
	movl	$36, %eax
	mull	16(%ebp)
	addl	%eax, %esi
	movl	$4, %eax
	mull	12(%ebp)
	addl	%eax, %ecx
	movl	$9, %eax
.loop:
	movl	8(%ebp), %ebx
	cmpl	%ebx, %esi
	je		.false
	cmpl	%ebx, %ecx
	je		.false
	subl	$1, %eax
	addl	$4, %esi
	addl	$36, %ecx
	cmpl	$0, %eax
	jne		.loop
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
