package test;

import java.util.Calendar;
import java.util.Scanner;

public class Cal {
	static Scanner sc = new Scanner(System.in);
	static void Cal(){	
		//달력
		Calendar cal = Calendar.getInstance();
		System.out.println("'연도'를 입력하세요.");
		int y = sc.nextInt();
		System.out.println(y+"년도");
		System.out.println("'월'을 입력하세요.");
		int m = sc.nextInt();
		System.out.println(m+"월");
		System.out.println("------------------------------------------------------");
		System.out.println("                     "+y+"년"+" "+m+"월");
		System.out.println("------------------------------------------------------");
		System.out.println("일\t월\t화\t수\t목\t금\t토");
		cal.set(y,m-1,1); //month는 0이 1월->-1해준다//입력받은 월의 1일로 세팅 
		int dayOfWeek = 0;
		int lastDate=cal.getActualMaximum(Calendar.DATE); //해당 월 마지막 날짜
		for(int i=1; i<=lastDate; i++){
			cal.set(y,m-1,i);
			dayOfWeek = cal.get(Calendar.DAY_OF_WEEK); //해당날짜의요일(1:일요일 ...7:토요일)
			if(i==1){//공백 추가해서 줄 맞추기
				for(int j=0; j<dayOfWeek-1; j++){
					//일;0<0(1-1)_0번*,월;0<1(2-1)_1번*,수;0<2(3-1)_2번*,목;0<3(4-1)_3번*,금;0<4(5-1)_4번*,토;0<5(6-1)_5번*
					System.out.print("\t");
				}
			}
			System.out.print(i+"\t");
			if(dayOfWeek==7){ //한 줄에 7일씩 출력
				System.out.println();
			}
		}
	}
}
