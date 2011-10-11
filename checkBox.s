.nomsg:
	.string "%d\n"

.text
.globl main
main:
	pushl	%ebp
	movl	%esp,%ebp
	pushl	$8	# value
	pushl	$1  # col
	pushl	$8  # row
	call	checkBox
	addl	$12,%esp
	pushl	%eax
	pushl	$.nomsg
	call	printf
	addl	$8,%esp
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
.loop:
	movl	(%edx),%eax
	cmpl	%eax,16(%esp)
	je		.false
	decl	%ecx			# c--
	jnz		.skip			
	addl	$24,%edx		# skip to start of next row in box
	movl	$3,%ecx			# restart inner loop
.skip:
	addl	$4,%edx			# move to next cell
	decl	%ebx			# d--
	jnz		.loop
	xorl	%eax,%eax		# a = 0 = true
	jmp		.escape
.false:
	movl	$1,%eax			# a = 1 = false
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
