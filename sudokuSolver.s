.msg:
	.string	"%d\n"
.nomsg:
	.string	"%d "
.newline:
	.string "\n"

.error:
	.string "Unsolvable sudoku\n"
.text

.global main

main:
	push	%ebp
	movl	%esp, %ebp
	push	$0
	push	$0
	call	solve			# solve(0,0)
	push	$.error
	call	printf			# print error message
	addl	$12, %esp		# restore stack
	leave
	ret

solve: #(row, col)
	push	%ebp
	movl	%esp, %ebp
	#call	printBoard
	subl	$4, %esp		# reserve space for index	- 12(%esp)	
	push	$1				# push value for counter to	- 8(%esp)
	push	12(%ebp)		# local copy of col 		- 4(%esp)
	push	8(%ebp)			# local copy of row 		- 0(%esp)
	cmpl	$9, 4(%esp)		# skip to next row if column > 8
	jne		.continue
	movl	$0, 4(%esp)		# col = 0
	addl	$1, (%esp)		# row = row+1
.continue:
	cmpl	$9, (%esp) 		# check row == 9, meaning all columns have been checked
	je		success			# sudoku solved! print result and exit program
	movl	$9,%eax			# a = 9
	mull	(%esp)			# a = row * 9
	addl	4(%esp), %eax	# a = row * 9 + col
	#shll	$2, %eax		# (col * 9 + row) * 4
	movl	%eax, 12(%esp)	# index = a
	cmpl	$0, board(,%eax,4) # skip cell if it contains a value
	jne		.skipCheck
.loop:
	push	8(%esp)			# value to be tested
	push	8(%esp)			# col number, 8 because we just subbed 4
	push	8(%esp)			# row number, 8 because we just subbed 8
	call	try				# try(row,col,value)
	addl	$12, %esp		# pop arguments from stack 
	cmpl	$0, %eax
	jne		.skipTry		# skip to next value if try returned false
	movl	12(%esp), %eax	# a = index
	movl	8(%esp), %ebx	# b = value
	movl	%ebx, board(,%eax,4) # board[row+col*9] = value
	movl	4(%esp), %eax	# a = col
	incl	%eax			# a = col+1
	push	%eax			# push col+1
	push	4(%esp)			# push row, 4(%esp) because we just pushed eax
	call	solve			# solve(row,col+1)
	addl	$8, %esp		# pop arguments
	movl	12(%esp), %eax	# a = index
	movl	$0, board(,%eax,4) # board[row+col*9] = 0
.skipTry:
	addl	$1, 8(%esp)		# increment value
	cmpl	$10, 8(%esp)	# check value <= 9
	jne		.loop					
	jmp		.done
.skipCheck:					# board[row+col*9] != 0
	movl	4(%esp), %eax	# a = col
	incl	%eax			# a = col+1
	push	%eax			# push col+1
	push	4(%esp)			# push row number, 4(%esp) because we pushed eax
	call	solve			# solve(row,col+1)
	addl	$8, %esp		# restore stack
.done:
	addl	$16, %esp		#restore stack
	leave
	ret

success:
	call	printBoard
	push 	$0
	call	exit

try: #(row, col, val)
	push	%ebp
	movl	%esp, %ebp
	push	$4			# offset = 4, check row
	push	8(%ebp)		# push row number
	push	16(%ebp)	# push value to be tested
	call	checkColOrRow
	addl	$12, %esp	# restore stack
	cmpl	$1, %eax	# 
	je		.false		# row check returned false
	push	$36			# offset = 36, check col
	push	12(%ebp)	# push col number
	push	16(%ebp)	# push value to be tested
	call	checkColOrRow
	addl	$12, %esp	# restore stack
	cmpl	$1, %eax
	je		.false		# column check return false
	push	16(%ebp)	# push value to be tested
	push	8(%ebp)		# push col number BYTTET OM PAA ROW OR COL
	push	12(%ebp)	# push row number
	call	checkBox
	addl	$12, %esp	# restore stack
.false:
	leave
	ret	# returns with return value of checkBox or 1, if jumped to here

checkColOrRow: #(val, row/col, offset)
	push 	%ebp
	movl	%esp, %ebp
	cmpl	$4, 16(%ebp)	# if offset == 4
	je		.rowInitOffset
	movl	$4, %eax		# a = 4
	jmp 	.calcOffset
.rowInitOffset:
	movl	$36, %eax		# a = 36
.calcOffset:	
	mull	12(%ebp)		# a = a*(row or col index)
	movl	$board, %edx	# d = address of board
	addl	%eax, %edx		# d = board+a
	movl	$9, %eax
.loop2: # for 8 downto 0
	movl	8(%ebp), %ebx
	cmpl	%ebx, (%edx)
	je		.false2
	addl	16(%ebp), %edx
	subl	$1, %eax
	jnz		.loop2
	jmp		.escape
.false2:
	movl	$1, %eax
.escape:
	leave
	ret	

checkBox: #(row,col,value)
	pushl	%ebp
	movl	%esp,%ebp
	movl	12(%esp),%eax	# a = col
	xorl	%edx,%edx		# d = 0
	movl	$3,%ebx			# b = 3
	divl	%ebx			# a = col/3
	movl	$9,%ebx			# b = 9
	mull	%ebx			# a = (col/3)*9
	movl	%eax,%ecx		# a -> c
	movl	8(%esp),%eax	# a = row
	movl	$3,%ebx			# b = 3
	divl	%ebx			# a = row/3
	addl	%ecx,%eax		# a = a+c
	mull	%ebx			# a = (a+c*3)
	shll	$2,%eax			# a = a << 2 = a*4
	addl	$board,%eax		# add board address to a
	movl	%eax,%edx		# a -> d - d now contains address of first cell in box
	movl	$9,%ebx			# b = outer loop
	movl	$3,%ecx			# c = inner loop
.loop3:
	movl	(%edx),%eax
	cmpl	%eax,16(%esp)
	je		.false3
	decl	%ecx			# c--
	jnz		.skip			
	addl	$24,%edx		# skip to start of next row in box
	movl	$3,%ecx			# restart inner loop
.skip:
	addl	$4,%edx			# move to next cell
	decl	%ebx			# d--
	jnz		.loop3
	xorl	%eax,%eax		# a = 0 = true
	jmp		.escape3
.false3:
	movl	$1,%eax			# a = 1 = false
.escape3:
	leave
	ret

printBoard: #()
	pushl	%ebp
	movl	%esp,%ebp
	pushl	$0			# newline?
	pushl	$board		# board[0]
	pushl	$0			# i = 0
.loop4:
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
	jne		.loop4
	addl	$12,%esp 	# pop i, board and newline
	pushl	$.newline
	call	printf
	addl	$4,%esp
	leave
	ret

.data
board:
	.long 0,0,8,1,0,0,5,0,0
	.long 9,6,0,0,8,0,0,0,0
	.long 0,5,0,0,3,6,0,9,8
	.long 0,0,7,0,6,9,0,1,2
	.long 0,0,6,8,0,7,3,0,0
	.long 8,1,0,4,5,0,6,0,0
	.long 4,2,0,6,7,0,0,8,0
	.long 0,0,0,0,4,0,0,6,3
	.long 0,0,5,0,0,8,7,0,0
