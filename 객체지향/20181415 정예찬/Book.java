package com.encore.book;

public class Book {
	private String title;//책의 제목
	private String author;//책의 저자
	private String publisher;//책의 출판사
	private String desc; // description. 간단한 설명
	
	public Book() {};
	
	public Book(String title, String author, String publisher,String desc) {
		super();
		this.title = title;
		this.author = author;
		this.publisher = publisher;
		this.desc = desc;
	}
	
	public String getTitle() {//책 제목을 가져오는 메서드
		return title;
	}

	public void setTitle(String title) {// 책 제목을 설정하는 메서드
		this.title = title;
	}

	public String getAuthor() {// 책 저자를 받아오는 메서드
		return author;
	}

	public void setAuthor(String author) {// 책 저자를 설정하는 메서드
		this.author = author;
	}

	public String getPublisher() {//책 출판사를 가져오는 메서드
		return publisher;
	}

	public void setPublisher(String publisher) {//책 출판사를 설정하는 메서드
		this.publisher = publisher;
	}

	public String getDesc() {// 책 리뷰를 가져오는 메서드
		return desc;
	}

	public void setDesc(String desc) {// 책 리뷰를 설정하는 메서드
		this.desc = desc;
	}

	public String toString() {//책 제목 저자 출판사 리뷰를 문자열로 만들어주는 부분
		return title+", "+author+", "+publisher+", "+desc;
	}
	
}