	.file	"sudoku.c"
	.text
	.p2align 4,,15
	.globl	checkRow
	.type	checkRow, @function
checkRow:
.LFB21:
	.cfi_startproc
	pushl	%ebx
	.cfi_def_cfa_offset 8
	.cfi_offset 3, -8
	movl	8(%esp), %eax
	movl	12(%esp), %ebx
	leal	(%eax,%eax,8), %ecx
	xorl	%eax, %eax
	.p2align 4,,7
	.p2align 3
.L3:
	leal	(%eax,%ecx), %edx
	cmpl	%ebx, board(,%edx,4)
	je	.L4
	addl	$1, %eax
	cmpl	$9, %eax
	jne	.L3
	xorb	%al, %al
	popl	%ebx
	.cfi_remember_state
	.cfi_def_cfa_offset 4
	.cfi_restore 3
	ret
	.p2align 4,,7
	.p2align 3
.L4:
	.cfi_restore_state
	movl	$1, %eax
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE21:
	.size	checkRow, .-checkRow
	.p2align 4,,15
	.globl	checkCol
	.type	checkCol, @function
checkCol:
.LFB22:
	.cfi_startproc
	movl	4(%esp), %ecx
	xorl	%eax, %eax
	movl	8(%esp), %edx
	.p2align 4,,7
	.p2align 3
.L9:
	cmpl	%edx, board(%eax,%ecx,4)
	je	.L10
	addl	$36, %eax
	cmpl	$324, %eax
	jne	.L9
	xorw	%ax, %ax
	ret
	.p2align 4,,7
	.p2align 3
.L10:
	movl	$1, %eax
	ret
	.cfi_endproc
.LFE22:
	.size	checkCol, .-checkCol
	.p2align 4,,15
	.globl	checkBox
	.type	checkBox, @function
checkBox:
.LFB23:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	pushl	%edi
	.cfi_def_cfa_offset 12
	.cfi_offset 7, -12
	movl	$1431655766, %edi
	pushl	%esi
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushl	%ebx
	.cfi_def_cfa_offset 20
	.cfi_offset 3, -20
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
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	.cfi_restore 3
	xorl	%eax, %eax
	popl	%esi
	.cfi_def_cfa_offset 12
	.cfi_restore 6
	popl	%edi
	.cfi_def_cfa_offset 8
	.cfi_restore 7
	popl	%ebp
	.cfi_def_cfa_offset 4
	.cfi_restore 5
	ret
	.p2align 4,,7
	.p2align 3
.L16:
	.cfi_restore_state
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 16
	movl	$1, %eax
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 12
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 8
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE23:
	.size	checkBox, .-checkBox
	.p2align 4,,15
	.globl	try
	.type	try, @function
try:
.LFB20:
	.cfi_startproc
	pushl	%edi
	.cfi_def_cfa_offset 8
	.cfi_offset 7, -8
	xorl	%eax, %eax
	pushl	%esi
	.cfi_def_cfa_offset 12
	.cfi_offset 6, -12
	pushl	%ebx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	subl	$12, %esp
	.cfi_def_cfa_offset 28
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
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	popl	%ebx
	.cfi_def_cfa_offset 12
	.cfi_restore 3
	movzbl	%al, %eax
	popl	%esi
	.cfi_def_cfa_offset 8
	.cfi_restore 6
	popl	%edi
	.cfi_def_cfa_offset 4
	.cfi_restore 7
	ret
	.p2align 4,,7
	.p2align 3
.L25:
	.cfi_restore_state
	addl	$12, %esp
	.cfi_def_cfa_offset 16
	movl	$1, %eax
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 12
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 8
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE20:
	.size	try, .-try
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%d,"
	.text
	.p2align 4,,15
	.globl	printBoard
	.type	printBoard, @function
printBoard:
.LFB24:
	.cfi_startproc
	pushl	%esi
	.cfi_def_cfa_offset 8
	.cfi_offset 6, -8
	xorl	%esi, %esi
	pushl	%ebx
	.cfi_def_cfa_offset 12
	.cfi_offset 3, -12
	subl	$20, %esp
	.cfi_def_cfa_offset 32
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
	movl	$.LC0, (%esp)
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
	.cfi_def_cfa_offset 12
	popl	%ebx
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	popl	%esi
	.cfi_def_cfa_offset 4
	.cfi_restore 6
	ret
	.cfi_endproc
.LFE24:
	.size	printBoard, .-printBoard
	.p2align 4,,15
	.globl	solve
	.type	solve, @function
solve:
.LFB19:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	pushl	%edi
	.cfi_def_cfa_offset 12
	.cfi_offset 7, -12
	pushl	%esi
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushl	%ebx
	.cfi_def_cfa_offset 20
	.cfi_offset 3, -20
	subl	$44, %esp
	.cfi_def_cfa_offset 64
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
	.p2align 4,,7
	.p2align 3
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
	.cfi_remember_state
	.cfi_def_cfa_offset 20
	popl	%ebx
	.cfi_def_cfa_offset 16
	.cfi_restore 3
	popl	%esi
	.cfi_def_cfa_offset 12
	.cfi_restore 6
	popl	%edi
	.cfi_def_cfa_offset 8
	.cfi_restore 7
	popl	%ebp
	.cfi_def_cfa_offset 4
	.cfi_restore 5
	ret
.L45:
	.cfi_restore_state
	call	printBoard
	movl	$0, (%esp)
	call	exit
	.cfi_endproc
.LFE19:
	.size	solve, .-solve
	.section	.rodata.str1.1
.LC1:
	.string	"Unsolvable sudoku"
	.section	.text.startup,"ax",@progbits
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB18:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	andl	$-16, %esp
	subl	$16, %esp
	movl	$0, 4(%esp)
	movl	$0, (%esp)
	call	solve
	movl	$.LC1, (%esp)
	call	printf
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE18:
	.size	main, .-main
	.globl	board
	.data
	.align 32
	.type	board, @object
	.size	board, 324
board:
	.long	0
	.long	0
	.long	0
	.long	0
	.long	0
	.long	0
	.long	0
	.long	9
	.long	6
	.long	0
	.long	0
	.long	0
	.long	0
	.long	0
	.long	9
	.long	2
	.long	1
	.long	0
	.long	0
	.long	0
	.long	8
	.long	0
	.long	0
	.long	3
	.long	4
	.long	5
	.long	0
	.long	0
	.long	0
	.long	0
	.long	0
	.long	1
	.long	5
	.long	0
	.long	0
	.long	4
	.long	1
	.long	0
	.long	0
	.long	0
	.long	6
	.long	0
	.long	0
	.long	0
	.long	9
	.long	4
	.long	0
	.long	0
	.long	2
	.long	3
	.long	0
	.long	0
	.long	0
	.long	0
	.long	0
	.long	4
	.long	6
	.long	8
	.long	0
	.long	0
	.long	9
	.long	0
	.long	0
	.long	0
	.long	1
	.long	5
	.long	3
	.long	0
	.long	0
	.long	0
	.long	0
	.long	0
	.long	3
	.long	9
	.long	0
	.long	0
	.long	0
	.long	0
	.long	0
	.long	0
	.long	0
	.ident	"GCC: (GNU) 4.6.1 20110819 (prerelease)"
	.section	.note.GNU-stack,"",@progbits
