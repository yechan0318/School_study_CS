#include <stdio.h>

int main()
{
	int c = 0;//조건문을 체크할 변수
	int user = 0;//최대값을 받기위한변수
	int sosu = 0;//소수의 개수를 파악하기위한변수
	printf("소수를 구할 최대 숫자 입력: ");
	scanf_s("%d", &user);
	
	for (int n = 2; n <= user; n++)
	{//1을 제외하고 최대까지 체크하기 위한 범위
		for (int div = 2; div < n; div++)
		{//최대값까지만 체크하기 위해서
			if (n % div == 0) {//나누어서 떨어지면 소수가 아님으로 체크변수를 1로 바꾼다.
				c = 1;
				break;
			}
		}
		if (!c)//위에 c변수가 1이 아니라면 소수임으로 해당하는 값을 출력하고 소수개수를 위한 변수의 값을 1증가시킨다
		{
			printf("%d ", n);
			sosu++;
		}
		c = 0;
	}
	printf("\n");
	printf("1부터 %d까지의 소수는%d개 입니다\n", user, sosu);
	return 0;
}