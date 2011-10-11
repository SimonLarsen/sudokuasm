	.file	"sudoku.c"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%d "
	.text
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
	subl	$92, %esp
	.cfi_def_cfa_offset 112
	movl	112(%esp), %ebx
	movl	116(%esp), %esi
	jmp	.L11
	.p2align 4,,7
	.p2align 3
.L4:
	addl	$1, %ebx
.L11:
	cmpl	$8, %ebx
	jle	.L2
	addl	$1, %esi
	xorl	%ebx, %ebx
.L2:
	cmpl	$8, %esi
	jg	.L20
	leal	(%esi,%esi,8), %edi
	leal	(%edi,%ebx), %ebp
	movl	board(,%ebp,4), %eax
	testl	%eax, %eax
	jne	.L4
	movl	%edi, 28(%esp)
	movl	$1431655766, %edi
	movl	%edi, %eax
	imull	%ebx
	movl	%ebx, %eax
	sarl	$31, %eax
	subl	%eax, %edx
	movl	%edi, %eax
	leal	(%edx,%edx,2), %ecx
	imull	%esi
	movl	%esi, %eax
	sarl	$31, %eax
	subl	%eax, %edx
	leal	(%edx,%edx,2), %eax
	leal	(%eax,%eax,8), %edx
	leal	(%ecx,%edx), %edi
	movl	%edi, 56(%esp)
	leal	1(%ecx), %edi
	movl	%edi, 40(%esp)
	addl	%edx, %edi
	movl	%edi, 76(%esp)
	leal	2(%ecx), %edi
	addl	%edi, %edx
	movl	%edx, 44(%esp)
	leal	9(%eax,%eax,8), %edx
	movl	%edi, 36(%esp)
	leal	(%ecx,%edx), %edi
	movl	%edi, 48(%esp)
	movl	40(%esp), %edi
	leal	18(%eax,%eax,8), %eax
	addl	%eax, %ecx
	movl	%ecx, 64(%esp)
	addl	%edx, %edi
	addl	36(%esp), %edx
	movl	%edi, 52(%esp)
	leal	1(%ebx), %edi
	movl	%edx, 60(%esp)
	movl	40(%esp), %edx
	movl	%esi, 40(%esp)
	movl	76(%esp), %esi
	addl	%eax, %edx
	addl	36(%esp), %eax
	movl	%edi, 36(%esp)
	movl	28(%esp), %edi
	movl	%edx, 68(%esp)
	movl	%eax, 72(%esp)
	movl	$1, %eax
	.p2align 4,,7
	.p2align 3
.L5:
	cmpl	board(,%ebx,4), %eax
	je	.L6
	cmpl	board+36(,%ebx,4), %eax
	je	.L6
	cmpl	board+72(,%ebx,4), %eax
	je	.L6
	cmpl	board+108(,%ebx,4), %eax
	je	.L6
	cmpl	board+144(,%ebx,4), %eax
	je	.L6
	cmpl	board+180(,%ebx,4), %eax
	je	.L6
	cmpl	board+216(,%ebx,4), %eax
	je	.L6
	cmpl	board+252(,%ebx,4), %eax
	je	.L6
	cmpl	board+288(,%ebx,4), %eax
	je	.L6
	cmpl	board(,%edi,4), %eax
	je	.L6
	cmpl	board+4(,%edi,4), %eax
	je	.L6
	cmpl	board+8(,%edi,4), %eax
	je	.L6
	cmpl	board+12(,%edi,4), %eax
	je	.L6
	cmpl	board+16(,%edi,4), %eax
	je	.L6
	cmpl	board+20(,%edi,4), %eax
	je	.L6
	cmpl	board+24(,%edi,4), %eax
	je	.L6
	cmpl	board+28(,%edi,4), %eax
	je	.L6
	cmpl	board+32(,%edi,4), %eax
	je	.L6
	movl	56(%esp), %edx
	cmpl	board(,%edx,4), %eax
	je	.L6
	cmpl	board(,%esi,4), %eax
	je	.L6
	movl	44(%esp), %edx
	cmpl	board(,%edx,4), %eax
	je	.L6
	movl	48(%esp), %edx
	cmpl	board(,%edx,4), %eax
	je	.L6
	movl	52(%esp), %edx
	cmpl	board(,%edx,4), %eax
	je	.L6
	movl	60(%esp), %edx
	cmpl	board(,%edx,4), %eax
	je	.L6
	movl	64(%esp), %edx
	cmpl	board(,%edx,4), %eax
	je	.L6
	movl	68(%esp), %edx
	cmpl	board(,%edx,4), %eax
	je	.L6
	movl	72(%esp), %edx
	cmpl	board(,%edx,4), %eax
	je	.L6
	movl	40(%esp), %edx
	movl	%eax, board(,%ebp,4)
	movl	%eax, 32(%esp)
	movl	%edx, 4(%esp)
	movl	36(%esp), %edx
	movl	%edx, (%esp)
	call	solve
	movl	32(%esp), %eax
	movl	$0, board(,%ebp,4)
.L6:
	addl	$1, %eax
	cmpl	$10, %eax
	jne	.L5
	addl	$92, %esp
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
.L20:
	.cfi_restore_state
	movl	board, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+4, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+8, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+12, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+16, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+20, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+24, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+28, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+32, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	$10, (%esp)
	call	putchar
	movl	board+36, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+40, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+44, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+48, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+52, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+56, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+60, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+64, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+68, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	$10, (%esp)
	call	putchar
	movl	board+72, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+76, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+80, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+84, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+88, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+92, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+96, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+100, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+104, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	$10, (%esp)
	call	putchar
	movl	board+108, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+112, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+116, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+120, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+124, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+128, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+132, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+136, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+140, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	$10, (%esp)
	call	putchar
	movl	board+144, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+148, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+152, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+156, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+160, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+164, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+168, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+172, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+176, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	$10, (%esp)
	call	putchar
	movl	board+180, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+184, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+188, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+192, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+196, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+200, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+204, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+208, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+212, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	$10, (%esp)
	call	putchar
	movl	board+216, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+220, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+224, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+228, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+232, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+236, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+240, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+244, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+248, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	$10, (%esp)
	call	putchar
	movl	board+252, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+256, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+260, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+264, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+268, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+272, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+276, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+280, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+284, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	$10, (%esp)
	call	putchar
	movl	board+288, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+292, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+296, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+300, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+304, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+308, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+312, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+316, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+320, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	$10, (%esp)
	call	putchar
	movl	$0, (%esp)
	call	exit
	.cfi_endproc
.LFE19:
	.size	solve, .-solve
	.p2align 4,,15
	.globl	try
	.type	try, @function
try:
.LFB20:
	.cfi_startproc
	subl	$20, %esp
	.cfi_def_cfa_offset 24
	movl	%ebx, 4(%esp)
	movl	24(%esp), %ebx
	.cfi_offset 3, -20
	movl	32(%esp), %ecx
	movl	%esi, 8(%esp)
	movl	$1, %esi
	.cfi_offset 6, -16
	movl	%edi, 12(%esp)
	movl	28(%esp), %edi
	.cfi_offset 7, -12
	cmpl	board(,%ebx,4), %ecx
	movl	%ebp, 16(%esp)
	je	.L22
	.cfi_offset 5, -8
	cmpl	board+36(,%ebx,4), %ecx
	je	.L22
	cmpl	board+72(,%ebx,4), %ecx
	je	.L22
	cmpl	board+108(,%ebx,4), %ecx
	je	.L22
	cmpl	board+144(,%ebx,4), %ecx
	je	.L22
	cmpl	board+180(,%ebx,4), %ecx
	je	.L22
	cmpl	board+216(,%ebx,4), %ecx
	je	.L22
	cmpl	board+252(,%ebx,4), %ecx
	je	.L22
	cmpl	board+288(,%ebx,4), %ecx
	je	.L22
	leal	(%edi,%edi,8), %eax
	cmpl	board(,%eax,4), %ecx
	je	.L22
	cmpl	board+4(,%eax,4), %ecx
	je	.L22
	cmpl	board+8(,%eax,4), %ecx
	je	.L22
	cmpl	board+12(,%eax,4), %ecx
	je	.L22
	cmpl	board+16(,%eax,4), %ecx
	je	.L22
	cmpl	board+20(,%eax,4), %ecx
	je	.L22
	cmpl	board+24(,%eax,4), %ecx
	je	.L22
	cmpl	board+28(,%eax,4), %ecx
	je	.L22
	cmpl	board+32(,%eax,4), %ecx
	je	.L22
	movl	%ebx, %eax
	movl	$1431655766, %ebp
	imull	%ebp
	movl	%edi, %eax
	sarl	$31, %ebx
	sarl	$31, %edi
	subl	%ebx, %edx
	leal	(%edx,%edx,2), %ebx
	imull	%ebp
	subl	%edi, %edx
	leal	(%edx,%edx,2), %eax
	leal	(%eax,%eax,8), %edi
	leal	(%ebx,%edi), %edx
	cmpl	board(,%edx,4), %ecx
	je	.L22
	leal	1(%ebx), %edx
	leal	(%edi,%edx), %ebp
	cmpl	board(,%ebp,4), %ecx
	je	.L22
	leal	2(%ebx), %esi
	addl	%esi, %edi
	cmpl	board(,%edi,4), %ecx
	movl	%esi, (%esp)
	movl	$1, %esi
	je	.L22
	leal	9(%eax,%eax,8), %edi
	leal	(%ebx,%edi), %ebp
	cmpl	board(,%ebp,4), %ecx
	je	.L22
	leal	(%edx,%edi), %ebp
	cmpl	board(,%ebp,4), %ecx
	je	.L22
	addl	(%esp), %edi
	cmpl	board(,%edi,4), %ecx
	je	.L22
	leal	18(%eax,%eax,8), %eax
	addl	%eax, %ebx
	cmpl	board(,%ebx,4), %ecx
	je	.L22
	addl	%eax, %edx
	cmpl	board(,%edx,4), %ecx
	je	.L22
	addl	(%esp), %eax
	cmpl	board(,%eax,4), %ecx
	sete	%al
	movzbl	%al, %eax
	movl	%eax, %esi
.L22:
	movl	%esi, %eax
	movl	4(%esp), %ebx
	movl	8(%esp), %esi
	movl	12(%esp), %edi
	movl	16(%esp), %ebp
	addl	$20, %esp
	.cfi_def_cfa_offset 4
	.cfi_restore 5
	.cfi_restore 7
	.cfi_restore 6
	.cfi_restore 3
	ret
	.cfi_endproc
.LFE20:
	.size	try, .-try
	.p2align 4,,15
	.globl	checkRow
	.type	checkRow, @function
checkRow:
.LFB21:
	.cfi_startproc
	movl	4(%esp), %ecx
	movl	$1, %eax
	movl	8(%esp), %edx
	cmpl	%edx, board(,%ecx,4)
	je	.L54
	cmpl	%edx, board+36(,%ecx,4)
	je	.L54
	cmpl	%edx, board+72(,%ecx,4)
	je	.L54
	cmpl	%edx, board+108(,%ecx,4)
	je	.L54
	cmpl	%edx, board+144(,%ecx,4)
	je	.L54
	cmpl	%edx, board+180(,%ecx,4)
	je	.L54
	cmpl	%edx, board+216(,%ecx,4)
	je	.L54
	cmpl	%edx, board+252(,%ecx,4)
	je	.L54
	xorl	%eax, %eax
	cmpl	%edx, board+288(,%ecx,4)
	sete	%al
.L54:
	rep
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
	movl	4(%esp), %eax
	movl	8(%esp), %edx
	leal	(%eax,%eax,8), %ecx
	movl	$1, %eax
	cmpl	%edx, board(,%ecx,4)
	je	.L64
	cmpl	%edx, board+4(,%ecx,4)
	je	.L64
	cmpl	%edx, board+8(,%ecx,4)
	je	.L64
	cmpl	%edx, board+12(,%ecx,4)
	je	.L64
	cmpl	%edx, board+16(,%ecx,4)
	je	.L64
	cmpl	%edx, board+20(,%ecx,4)
	je	.L64
	cmpl	%edx, board+24(,%ecx,4)
	je	.L64
	cmpl	%edx, board+28(,%ecx,4)
	je	.L64
	xorl	%eax, %eax
	cmpl	%edx, board+32(,%ecx,4)
	sete	%al
.L64:
	rep
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
	subl	$20, %esp
	.cfi_def_cfa_offset 24
	movl	%ebx, 4(%esp)
	movl	24(%esp), %ebx
	.cfi_offset 3, -20
	movl	%esi, 8(%esp)
	movl	$1431655766, %esi
	.cfi_offset 6, -16
	movl	32(%esp), %ecx
	movl	%edi, 12(%esp)
	movl	28(%esp), %edi
	.cfi_offset 7, -12
	movl	%ebp, 16(%esp)
	movl	%ebx, %eax
	imull	%esi
	sarl	$31, %ebx
	movl	%edi, %eax
	sarl	$31, %edi
	subl	%ebx, %edx
	leal	(%edx,%edx,2), %ebx
	imull	%esi
	movl	$1, %eax
	subl	%edi, %edx
	leal	(%edx,%edx,2), %edx
	leal	(%edx,%edx,8), %edi
	leal	(%ebx,%edi), %esi
	cmpl	%ecx, board(,%esi,4)
	je	.L74
	.cfi_offset 5, -8
	leal	1(%ebx), %esi
	leal	(%edi,%esi), %ebp
	cmpl	%ecx, board(,%ebp,4)
	je	.L74
	leal	2(%ebx), %ebp
	addl	%ebp, %edi
	cmpl	%ecx, board(,%edi,4)
	movl	%ebp, (%esp)
	je	.L74
	leal	9(%edx,%edx,8), %edi
	leal	(%ebx,%edi), %ebp
	cmpl	%ecx, board(,%ebp,4)
	je	.L74
	leal	(%esi,%edi), %ebp
	cmpl	%ecx, board(,%ebp,4)
	je	.L74
	addl	(%esp), %edi
	cmpl	%ecx, board(,%edi,4)
	je	.L74
	leal	18(%edx,%edx,8), %edx
	addl	%edx, %ebx
	cmpl	%ecx, board(,%ebx,4)
	je	.L74
	addl	%edx, %esi
	cmpl	%ecx, board(,%esi,4)
	je	.L74
	addl	(%esp), %edx
	xorl	%eax, %eax
	cmpl	board(,%edx,4), %ecx
	sete	%al
.L74:
	movl	4(%esp), %ebx
	movl	8(%esp), %esi
	movl	12(%esp), %edi
	movl	16(%esp), %ebp
	addl	$20, %esp
	.cfi_def_cfa_offset 4
	.cfi_restore 5
	.cfi_restore 7
	.cfi_restore 6
	.cfi_restore 3
	ret
	.cfi_endproc
.LFE23:
	.size	checkBox, .-checkBox
	.p2align 4,,15
	.globl	printBoard
	.type	printBoard, @function
printBoard:
.LFB24:
	.cfi_startproc
	subl	$28, %esp
	.cfi_def_cfa_offset 32
	movl	board, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+4, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+8, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+12, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+16, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+20, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+24, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+28, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+32, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	$10, (%esp)
	call	putchar
	movl	board+36, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+40, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+44, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+48, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+52, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+56, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+60, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+64, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+68, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	$10, (%esp)
	call	putchar
	movl	board+72, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+76, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+80, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+84, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+88, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+92, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+96, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+100, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+104, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	$10, (%esp)
	call	putchar
	movl	board+108, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+112, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+116, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+120, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+124, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+128, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+132, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+136, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+140, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	$10, (%esp)
	call	putchar
	movl	board+144, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+148, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+152, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+156, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+160, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+164, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+168, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+172, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+176, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	$10, (%esp)
	call	putchar
	movl	board+180, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+184, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+188, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+192, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+196, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+200, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+204, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+208, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+212, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	$10, (%esp)
	call	putchar
	movl	board+216, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+220, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+224, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+228, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+232, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+236, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+240, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+244, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+248, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	$10, (%esp)
	call	putchar
	movl	board+252, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+256, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+260, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+264, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+268, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+272, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+276, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+280, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+284, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	$10, (%esp)
	call	putchar
	movl	board+288, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+292, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+296, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+300, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+304, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+308, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+312, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+316, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	board+320, %eax
	movl	$.LC0, (%esp)
	movl	%eax, 4(%esp)
	call	printf
	movl	$10, (%esp)
	call	putchar
	addl	$28, %esp
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE24:
	.size	printBoard, .-printBoard
	.p2align 4,,15
	.globl	readstdin
	.type	readstdin, @function
readstdin:
.LFB25:
	.cfi_startproc
	pushl	%ebx
	.cfi_def_cfa_offset 8
	.cfi_offset 3, -8
	xorl	%ebx, %ebx
	subl	$24, %esp
	.cfi_def_cfa_offset 32
	.p2align 4,,7
	.p2align 3
.L85:
	movl	stdin, %eax
	movl	%eax, (%esp)
	call	_IO_getc
	subl	$48, %eax
	movl	%eax, board(,%ebx,4)
	addl	$1, %ebx
	cmpl	$81, %ebx
	jne	.L85
	addl	$24, %esp
	.cfi_def_cfa_offset 8
	popl	%ebx
	.cfi_def_cfa_offset 4
	.cfi_restore 3
	ret
	.cfi_endproc
.LFE25:
	.size	readstdin, .-readstdin
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
	call	readstdin
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
	.comm	board,324,32
	.ident	"GCC: (GNU) 4.6.1 20110819 (prerelease)"
	.section	.note.GNU-stack,"",@progbits
