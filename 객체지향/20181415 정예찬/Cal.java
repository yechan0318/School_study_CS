package test;

import java.util.Calendar;
import java.util.Scanner;

public class Cal {
	static Scanner sc = new Scanner(System.in);
	static void Cal(){	
		//�޷�
		Calendar cal = Calendar.getInstance();
		System.out.println("'����'�� �Է��ϼ���.");
		int y = sc.nextInt();
		System.out.println(y+"�⵵");
		System.out.println("'��'�� �Է��ϼ���.");
		int m = sc.nextInt();
		System.out.println(m+"��");
		System.out.println("------------------------------------------------------");
		System.out.println("                     "+y+"��"+" "+m+"��");
		System.out.println("------------------------------------------------------");
		System.out.println("��\t��\tȭ\t��\t��\t��\t��");
		cal.set(y,m-1,1); //month�� 0�� 1��->-1���ش�//�Է¹��� ���� 1�Ϸ� ���� 
		int dayOfWeek = 0;
		int lastDate=cal.getActualMaximum(Calendar.DATE); //�ش� �� ������ ��¥
		for(int i=1; i<=lastDate; i++){
			cal.set(y,m-1,i);
			dayOfWeek = cal.get(Calendar.DAY_OF_WEEK); //�ش糯¥�ǿ���(1:�Ͽ��� ...7:�����)
			if(i==1){//���� �߰��ؼ� �� ���߱�
				for(int j=0; j<dayOfWeek-1; j++){
					//��;0<0(1-1)_0��*,��;0<1(2-1)_1��*,��;0<2(3-1)_2��*,��;0<3(4-1)_3��*,��;0<4(5-1)_4��*,��;0<5(6-1)_5��*
					System.out.print("\t");
				}
			}
			System.out.print(i+"\t");
			if(dayOfWeek==7){ //�� �ٿ� 7�Ͼ� ���
				System.out.println();
			}
		}
	}
}
