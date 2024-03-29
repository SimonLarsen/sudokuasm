#include <stdio.h>
#include <stdlib.h>

void printBoard();
void readstdin();
void solve(int,int);
int checkRow(int,int);
int checkCol(int,int);
int checkBox(int,int,int);

int board[81];

void main(){
	readstdin();
	solve(0,0);
	printf("Unsolvable sudoku");
}

void solve(int inrow, int incol){
	int row,col;

	row = inrow;
	col = incol;

	if(row > 8){
		row = 0;
		col = col+1;
	}

	if(col > 8){
		printBoard();
		exit(0);
	}

	int value;
	if(board[row+col*9] == 0){
		for(value = 1; value <= 9; ++value){
			if(try(row,col,value) == 0){
				board[row+col*9] = value;
				solve(row+1,col);
				board[row+col*9] = 0;
			}
		}
	}
	else{
		solve(row+1,col);
	}
}

int try(int row, int col, int value){
	if(checkRow(row,value) == 1){
		return 1;
	}
	if(checkCol(col,value) == 1){
		return 1;
	}
	if(checkBox(row,col,value) == 1){
		return 1;
	}
	return 0;
}

int checkRow(int row, int value){
	int i;
	for(i = 0; i < 9; ++i) {
		if(board[row+i*9] == value){
			return 1;
		}
	}
	return 0;
}

int checkCol(int col, int value){
	int i;
	for(i = 0; i < 9; ++i) {
		if(board[i+col*9] == value){
			return 1;
		}
	}
	return 0;
}

int checkBox(int row, int col, int value){
	int startx = row/3;
	startx = startx*3;

	int starty = col/3;
	starty = starty*3;

	int ix,iy;
	for(iy = 0; iy < 3; ++iy){
		for(ix = 0; ix < 3; ++ix){
			if(board[startx+ix+(starty+iy)*9] == value){
				return 1;
			}
		}
	}
	return 0;
}

void printBoard(){
	int ix,iy;
	for(iy = 0; iy < 9; ++iy){
		for(ix = 0; ix < 9; ++ix){
			printf("%d ",board[ix+iy*9]);
		}
		printf("\n");
	}
}

void readstdin(){
	int i,c;
	for(i = 0; i < 81; i++) {
		c = getchar() - '0';
		board[i] = c;
	}
}
