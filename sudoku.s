.nomsg:
	.string	"%d "
.newline:
	.string "\n"

.text
.globl main

main:
	pushl	%ebp
	movl	%esp,%ebp
	call 	printBoard
	leave
	ret

solve: #(inrow, incol)

try: #(row, col, value)

checkRow: #(col, value)

checkCol: #(row, value)

checkBox: #(row, col, value)

.include "printBoard.s"

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
