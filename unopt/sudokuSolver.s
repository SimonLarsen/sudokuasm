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
	call	readstdin		# read sudoku from stdin
	push	$0
	push	$0
	call	solve			# solve(0,0)
	push	$.error			# if solve returned it means we failed to solve the sudoku
	call	printf			# print error message
	addl	$12, %esp		# restore stack
	leave
	ret

solve: #(row, col)
	push	%ebp
	movl	%esp, %ebp
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
	movl	%eax, 12(%esp)	# index = a
	cmpl	$0, board(,%eax,4) # skip cell if it contains a value
	jne		.skipCheck
	push	8(%esp)			# value to be tested
	push	8(%esp)			# col number, 8 because we just subbed 4
	push	8(%esp)			# row number, 8 because we just subbed 8
.loopSolve:
	call	try				# try(row,col,value), NOTE: These arguments are on stack for entire loop
	cmpl	$0, %eax
	jne		.skipTry		# skip to next value if try returned false
	movl	24(%esp), %eax	# a = index
	movl	8(%esp), %ebx	# b = value
	movl	%ebx, board(,%eax,4) # board[row+col*9] = value
	movl	4(%esp), %eax	# a = col
	incl	%eax			# a = col+1
	push	%eax			# push col+1
	push	4(%esp)			# push row, 4(%esp) because we just pushed eax
	call	solve			# solve(row,col+1)
	addl	$8, %esp		# pop arguments
	movl	24(%esp), %eax	# a = index
	movl	$0, board(,%eax,4) # board[row+col*9] = 0
.skipTry:
	addl	$1, 8(%esp)		# increment value
	cmpl	$10, 8(%esp)	# check value <= 9
	jne		.loopSolve
	addl	$12, %esp		# Remove row,col,value from stack
	jmp		.doneSolve
.skipCheck:					# board[row+col*9] != 0
	movl	4(%esp), %eax	# a = col
	incl	%eax			# a = col+1
	push	%eax			# push col+1
	push	4(%esp)			# push row number, 4(%esp) because we pushed eax
	call	solve			# solve(row,col+1)
	addl	$8, %esp		# restore stack
.doneSolve:
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
	push	16(%ebp)		# push value to be tested
	push	8(%ebp)			# push row number
	call	checkRow
	addl	$8, %esp		# restore stack
	cmpl	$1, %eax
	je		.tryFalse		# row check returned false
	push	16(%ebp)		# push value to be tested
	push	12(%ebp)		# push col number
	call	checkCol
	addl	$8, %esp		# restore stack
	cmpl	$1, %eax
	je		.tryFalse		# column check return false
	push	16(%ebp)		# push value to be tested
	push	8(%ebp)			# push col number BYTTET OM PAA ROW OR COL
	push	12(%ebp)		# push row number
	call	checkBox
	addl	$12, %esp		# restore stack
.tryFalse:
	leave
	ret	# returns with return value of checkBox or 1, if jumped to here

checkRow: #(row, val)
	push	%ebp
	movl	%esp,%ebp
	movl	$36, %eax		# a = 36
	mull	8(%esp)			# a = row*36
	addl	$board,%eax 	# a = board + row*36
	movl	$0,%ecx			# c = 0, use for counter
	movl	12(%esp), %ebx	# b = val
.loopRow:
	cmpl	%ebx, (%eax)	# is current cell == val?
	je		.falseRow		# then jump to falseRow
	addl	$4,%eax			# add 4 to address
	incl	%ecx			# increment counter
	cmpl	$9,%ecx			# loop while c < 9
	jne		.loopRow
	xorl	%eax,%eax		# a = 0, return true
	jmp		.doneRow
.falseRow:
	movl	$1,%eax			# a = 1, return false
.doneRow:
	leave
	ret

checkCol: #(col, val)
	push	%ebp
	movl	%esp,%ebp
	movl	8(%esp), %ecx 	# c = col
	shll	$2,%ecx			# c = col*4
	addl	$board,%ecx		# c = board + col*4
	movl	$0,%eax			# a = 0, use for counter
	movl	12(%esp), %ebx	# b = val
.loopCol:
	cmpl	%ebx, (%ecx)	# is current cell == val?
	je		.falseCol		# then jump to falseCol	
	addl	$36,%ecx		# c = c+9*4
	incl	%eax			# a++
	cmpl	$9,%eax			# loop while a < 9
	jne		.loopCol
	jmp		.doneCol
.falseCol:
	movl	$1,%eax			# a = 1, return false
.doneCol:
	xorl	%eax,%eax		# a = 0, return true
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
	mull	%ebx			# a = (a+c)*3
	shll	$2,%eax			# a = a << 2 = a*4
	addl	$board,%eax		# add board address to a
	movl	%eax,%edx		# a -> d - d now contains address of first cell in box
	movl	$9,%ebx			# b = outer loop
	movl	$3,%ecx			# c = inner loop
.loopBox:
	movl	(%edx),%eax
	cmpl	%eax,16(%esp)
	je		.falseBox
	decl	%ecx			# c--
	jnz		.skipBox
	addl	$24,%edx		# skip to start of next row in box
	movl	$3,%ecx			# restart inner loop
.skipBox:
	addl	$4,%edx			# move to next cell
	decl	%ebx			# d--
	jnz		.loopBox
	xorl	%eax,%eax		# a = 0 = true
	jmp		.escapeBox
.falseBox:
	movl	$1,%eax			# a = 1 = false
.escapeBox:
	leave
	ret

printBoard: #()
	pushl	%ebp
	movl	%esp,%ebp
	pushl	$0			# newline?
	pushl	$board		# board[0]
	pushl	$0			# i = 0
.printLoop:
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
	jne		.printLoop
	addl	$12,%esp 	# pop i, board and newline
	pushl	$.newline
	call	printf
	addl	$4,%esp
	leave
	ret

readstdin:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	$0			# counter from 0 to 80
	.readLoop:
	call	getchar		# call getchar()
	subl	$48,%eax	# subtract ascii value of '0' to get numeric value
	movl	(%esp), %ebx # move counter into b
	movl	%eax, board(,%ebx,4) # write read value to board
	addl	$1, (%esp)	# increment counter
	cmpl	$81, (%esp) # is counter 81?
	jne		.readLoop
	addl	$4,%esp		# pop counter from stack
	leave
	ret

.data
board: # 81 long
	.long	0,0,0,0,0,0,0,0,0
	.long	0,0,0,0,0,0,0,0,0
	.long	0,0,0,0,0,0,0,0,0
	.long	0,0,0,0,0,0,0,0,0
	.long	0,0,0,0,0,0,0,0,0
	.long	0,0,0,0,0,0,0,0,0
	.long	0,0,0,0,0,0,0,0,0
	.long	0,0,0,0,0,0,0,0,0
	.long	0,0,0,0,0,0,0,0,0
