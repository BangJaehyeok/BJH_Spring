package com.human.app;

public class Booklist {
	private int roomcode;
	private String roomname;
	private String typename;
	private int howmany;
	private int howmuch;
	public Booklist() {
	}
	private String bookingdate1;
	private String bookingdate2;
	public Booklist(int roomcode, String roomname, String typename, int howmany, int howmuch, String bookingdate1,
			String bookingdate2) {
		this.roomcode = roomcode;
		this.roomname = roomname;
		this.typename = typename;
		this.howmany = howmany;
		this.howmuch = howmuch;
		this.bookingdate1 = bookingdate1;
		this.bookingdate2 = bookingdate2;
	}
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
	public String getBookingdate1() {
		return bookingdate1;
	}
	public void setBookingdate1(String bookingdate1) {
		this.bookingdate1 = bookingdate1;
	}
	public String getBookingdate2() {
		return bookingdate2;
	}
	public void setBookingdate2(String bookingdate2) {
		this.bookingdate2 = bookingdate2;
	}
}
