#include <stdio.h> 
int main(void) { 
	int number; printf("16진수 정수 입력 : "); 
	scanf_s("%x",&number); 
	printf("16진수 %x 는 ", number);
	printf("10진수로 %d입니다",number); 
	 return 0;
}
