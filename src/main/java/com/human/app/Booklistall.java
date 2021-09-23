package com.human.app;

public class Booklistall {
	private int roomcode;
	private String roomname;
	private String typename;
	private int howmany;
	private int howmuch;
	private String bookdate1;
	private String bookdate2;
	public int getRoomcode() {
		return roomcode;
	}
	public void setRoomcode(int roomcode) {
		this.roomcode = roomcode;
	}
	public String getRoomname() {
		return roomname;
	}
	public void setRoomname(String roomname) {
		this.roomname = roomname;
	}
	public String getTypename() {
		return typename;
	}
	public void setTypename(String typename) {
		this.typename = typename;
	}
	public int getHowmany() {
		return howmany;
	}
	public void setHowmany(int howmany) {
		this.howmany = howmany;
	}
	public int getHowmuch() {
		return howmuch;
	}
	public void setHowmuch(int howmuch) {
		this.howmuch = howmuch;
	}
	public String getBookdate1() {
		return bookdate1;
	}
	public void setBookdate1(String bookdate1) {
		this.bookdate1 = bookdate1;
	}
	public String getBookdate2() {
		return bookdate2;
	}
	public void setBookdate2(String bookdate2) {
		this.bookdate2 = bookdate2;
	}
	public Booklistall() {
	}
	public Booklistall(int roomcode, String roomname, String typename, int howmany, int howmuch, String bookdate1,
			String bookdate2) {
		this.roomcode = roomcode;
		this.roomname = roomname;
		this.typename = typename;
		this.howmany = howmany;
		this.howmuch = howmuch;
		this.bookdate1 = bookdate1;
		this.bookdate2 = bookdate2;
	}
	
}
