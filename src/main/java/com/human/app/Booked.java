package com.human.app;

public class Booked {
	private int bookcode;
	private int roomcode;
	private String roomname;
	private String typename;
	private int howmany;
	private int bookingpeople;
	private String bookingdate1;
	private String bookingdate2;
	private int roompriceall;
	private String bookingname;
	private String mobile;
	
	public int getBookcode() {
		return bookcode;
	}

	public void setBookcode(int bookcode) {
		this.bookcode = bookcode;
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

	public int getBookingpeople() {
		return bookingpeople;
	}

	public void setBookingpeople(int bookingpeople) {
		this.bookingpeople = bookingpeople;
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

	public int getRoompriceall() {
		return roompriceall;
	}

	public void setRoompriceall(int roompriceall) {
		this.roompriceall = roompriceall;
	}

	public String getBookingname() {
		return bookingname;
	}

	public void setBookingname(String bookingname) {
		this.bookingname = bookingname;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public Booked() {
	}

	public Booked(int bookcode, int roomcode, String roomname, String typename, int howmany, int bookingpeople,
			String bookingdate1, String bookingdate2, int roompriceall, String bookingname, String mobile) {
		this.bookcode = bookcode;
		this.roomcode = roomcode;
		this.roomname = roomname;
		this.typename = typename;
		this.howmany = howmany;
		this.bookingpeople = bookingpeople;
		this.bookingdate1 = bookingdate1;
		this.bookingdate2 = bookingdate2;
		this.roompriceall = roompriceall;
		this.bookingname = bookingname;
		this.mobile = mobile;
	}
	
}
