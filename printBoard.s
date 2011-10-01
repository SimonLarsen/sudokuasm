printBoard: #()
	pushl	%ebp
	movl	%esp,%ebp
	pushl	$0			# newline?
	pushl	$board		# board[0]
	pushl	$0			# i = 0
.loop:
	movl	4(%esp),%ebx
	pushl	(%ebx)		# push board[i*4]
	pushl	$.nomsg
	call	printf
	addl	$8,%esp		# pop arguments to printf
	addl	$1,8(%esp)	# newline++
	cmpl	$9,8(%esp)	# print newline if newline % 9 == 0
	jne		.nonewline
	movl	$0,8(%esp)	# newline = 0
	pushl	$10			# push \n
	call	putchar
	addl	$4,%esp		# pop \n
.nonewline:
	addl	$1,(%esp)	# i++
	addl	$4,4(%esp)	# board[i*4]
	cmpl	$81,(%esp) 	# while i != 81
	jne		.loop
	addl	$12,%esp 	# pop i, board and newline
	leave
	ret
