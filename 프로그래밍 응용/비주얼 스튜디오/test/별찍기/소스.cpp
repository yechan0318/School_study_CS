#include<stdio.h>
int main(void)
{
	for (int i = 0; i < 10; i++) {
		for (int k = i; k <= 8; k++) {
			printf(" ");
		}
		for (int j = 0; j <= i; j++) {
			printf(" *");
		}
		printf("\n");
	}
	return 0;
}