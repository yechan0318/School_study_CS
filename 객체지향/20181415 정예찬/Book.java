package com.encore.book;

public class Book {
	private String title;//å�� ����
	private String author;//å�� ����
	private String publisher;//å�� ���ǻ�
	private String desc; // description. ������ ����
	
	public Book() {};
	
	public Book(String title, String author, String publisher,String desc) {
		super();
		this.title = title;
		this.author = author;
		this.publisher = publisher;
		this.desc = desc;
	}
	
	public String getTitle() {//å ������ �������� �޼���
		return title;
	}

	public void setTitle(String title) {// å ������ �����ϴ� �޼���
		this.title = title;
	}

	public String getAuthor() {// å ���ڸ� �޾ƿ��� �޼���
		return author;
	}

	public void setAuthor(String author) {// å ���ڸ� �����ϴ� �޼���
		this.author = author;
	}

	public String getPublisher() {//å ���ǻ縦 �������� �޼���
		return publisher;
	}

	public void setPublisher(String publisher) {//å ���ǻ縦 �����ϴ� �޼���
		this.publisher = publisher;
	}

	public String getDesc() {// å ���並 �������� �޼���
		return desc;
	}

	public void setDesc(String desc) {// å ���並 �����ϴ� �޼���
		this.desc = desc;
	}

	public String toString() {//å ���� ���� ���ǻ� ���並 ���ڿ��� ������ִ� �κ�
		return title+", "+author+", "+publisher+", "+desc;
	}
	
}