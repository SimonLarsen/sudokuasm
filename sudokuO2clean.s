.nomsg:
	.string	"%d,"
.errormsg:
	.string	"Unsolvable sudoku"

.text

.globl	main
main:
	pushl	%ebp
	movl	%esp, %ebp
	andl	$-16, %esp
	subl	$16, %esp
	movl	$0, 4(%esp)
	movl	$0, (%esp)
	call	solve
	movl	$.errormsg, (%esp)
	call	printf
	leave
	ret

checkRow:
	pushl	%ebx
	movl	8(%esp), %eax
	movl	12(%esp), %ebx
	leal	(%eax,%eax,8), %ecx
	xorl	%eax, %eax
.L3:
	leal	(%eax,%ecx), %edx
	cmpl	%ebx, board(,%edx,4)
	je	.L4
	addl	$1, %eax
	cmpl	$9, %eax
	jne	.L3
	xorb	%al, %al
	popl	%ebx
	ret
.L4:
	movl	$1, %eax
	popl	%ebx
	ret
checkCol:
	movl	4(%esp), %ecx
	xorl	%eax, %eax
	movl	8(%esp), %edx
.L9:
	cmpl	%edx, board(%eax,%ecx,4)
	je	.L10
	addl	$36, %eax
	cmpl	$324, %eax
	jne	.L9
	xorw	%ax, %ax
	ret
.L10:
	movl	$1, %eax
	ret
checkBox:
	pushl	%ebp
	pushl	%edi
	movl	$1431655766, %edi
	pushl	%esi
	pushl	%ebx
	movl	20(%esp), %esi
	movl	24(%esp), %ebp
	movl	28(%esp), %ecx
	movl	%esi, %eax
	imull	%edi
	movl	%ebp, %eax
	sarl	$31, %ebp
	sarl	$31, %esi
	movl	%edx, %ebx
	imull	%edi
	subl	%esi, %ebx
	subl	%ebp, %edx
	leal	(%edx,%edx,2), %eax
	leal	(%eax,%eax,8), %edx
	leal	(%ebx,%ebx,2), %eax
	xorl	%ebx, %ebx
	addl	%eax, %edx
	sall	$2, %edx
.L13:
	xorl	%eax, %eax
.L15:
	cmpl	%ecx, board(%edx,%eax,4)
	je	.L16
	addl	$1, %eax
	cmpl	$3, %eax
	jne	.L15
	addl	$1, %ebx
	addl	$36, %edx
	cmpl	$3, %ebx
	jne	.L13
	popl	%ebx
	xorl	%eax, %eax
	popl	%esi
	popl	%edi
	popl	%ebp
	ret
.L16:
	popl	%ebx
	movl	$1, %eax
	popl	%esi
	popl	%edi
	popl	%ebp
	ret

try:
	pushl	%edi
	xorl	%eax, %eax
	pushl	%esi
	pushl	%ebx
	subl	$12, %esp
	movl	32(%esp), %edi
	movl	28(%esp), %esi
	movl	36(%esp), %edx
	leal	(%edi,%edi,8), %ebx
	.p2align 4,,7
	.p2align 3
.L21:
	leal	(%eax,%ebx), %ecx
	cmpl	board(,%ecx,4), %edx
	je	.L25
	addl	$1, %eax
	cmpl	$9, %eax
	jne	.L21
	xorb	%al, %al
	.p2align 4,,7
	.p2align 3
.L22:
	cmpl	board(%eax,%esi,4), %edx
	je	.L25
	addl	$36, %eax
	cmpl	$324, %eax
	jne	.L22
	movl	%edi, 4(%esp)
	movl	%esi, (%esp)
	movl	%edx, 8(%esp)
	call	checkBox
	cmpl	$1, %eax
	sete	%al
	addl	$12, %esp
	popl	%ebx
	movzbl	%al, %eax
	popl	%esi
	popl	%edi
	ret
	.p2align 4,,7
	.p2align 3
.L25:
	addl	$12, %esp
	movl	$1, %eax
	popl	%ebx
	popl	%esi
	popl	%edi
	ret

printBoard:
	pushl	%esi
	xorl	%esi, %esi
	pushl	%ebx
	subl	$20, %esp
	.p2align 4,,7
	.p2align 3
.L30:
	xorl	%ebx, %ebx
	.p2align 4,,7
	.p2align 3
.L31:
	leal	(%esi,%ebx), %eax
	addl	$1, %ebx
	movl	board(,%eax,4), %eax
	movl	$.nomsg, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	cmpl	$9, %ebx
	jne	.L31
	addl	$9, %esi
	movl	$10, (%esp)
	call	putchar
	cmpl	$81, %esi
	jne	.L30
	addl	$20, %esp
	popl	%ebx
	popl	%esi
	ret
solve:
	pushl	%ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$44, %esp
	movl	64(%esp), %esi
	movl	68(%esp), %ebx
	jmp	.L41
	.p2align 4,,7
	.p2align 3
.L37:
	addl	$1, %esi
.L41:
	cmpl	$8, %esi
	jle	.L35
	addl	$1, %ebx
	xorl	%esi, %esi
.L35:
	cmpl	$8, %ebx
	jg	.L45
	leal	(%ebx,%ebx,8), %edi
	addl	%esi, %edi
	movl	board(,%edi,4), %eax
	testl	%eax, %eax
	jne	.L37
	leal	1(%esi), %eax
	movl	$1, %ebp
	movl	%eax, 28(%esp)
	jmp	.L39
.L38:
	addl	$1, %ebp
	cmpl	$10, %ebp
	je	.L46
.L39:
	movl	%ebp, 8(%esp)
	movl	%ebx, 4(%esp)
	movl	%esi, (%esp)
	call	try
	testl	%eax, %eax
	jne	.L38
	movl	28(%esp), %eax
	movl	%ebp, board(,%edi,4)
	addl	$1, %ebp
	movl	%ebx, 4(%esp)
	movl	%eax, (%esp)
	call	solve
	cmpl	$10, %ebp
	movl	$0, board(,%edi,4)
	jne	.L39
.L46:
	addl	$44, %esp
	popl	%ebx
	popl	%esi
	popl	%edi
	popl	%ebp
	ret
.L45:
	call	printBoard
	movl	$0, (%esp)
	call	exit

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
